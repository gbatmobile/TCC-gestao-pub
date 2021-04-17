import json, os, sqlite3, glob, datetime

def loadFiles(fileNames):
    allData = []
    for fileName in fileNames:
        print ("Importando",fileName)
        fd = open(fileName, 'r', encoding='latin1')
        addNoDuplicatesv2 (fileName, allData, json.loads(fd.read()))
        fd.close()
    print (f"\tImportados: {len(allData)}")
    return allData


keys = {"Notas":None}

def addNoDuplicatesv2(fileName, allData, toInsert):
    print ("Verificando não duplicados em:", fileName)

    keyName = fileName[fileName.rfind('\\')+1:fileName.rfind(r'.')]
    key = keys.get(keyName, "id")

    if key:
        nodups = []
        for newData in toInsert:
            isDup = False
            for data in allData:
                if data[key] == newData[key]:
                    print ("Registo duplicado em ", fileName,
                            "chave:", key, "valor:", data[key])
                    isDup = True
                    break
            if not isDup:
                nodups.append(newData)
    else:
        nodups = toInsert
    allData += nodups
    return allData

defaultFieldTypes = {int: ['peso',
                           'ano_conclusao',
                           'tempo_sem_estudar',
                           'razao_ausencia_educacional_id',
                           'divisor',
                           'ensino_medio_conclusao',
                           'escola_ensino_medio_id'],
                     float: ['media',
                             'nota'],
                     str: ['data_cadastro',
                           'data',
                           'fim',
                           'cep',
                           'nome_escola_ensino_medio',
                           'data_ultima_atualizacao',
                           'codigo_curso_formacao_superior'],
                     datetime.datetime: []
                     }

def createTableInDB (dbConn, firstLine, tableName, parentKeys):
    dropStr = 'DROP TABLE IF EXISTS '+tableName
    dbConn.cursor().execute(dropStr)
    dbConn.commit()

    createStr = 'CREATE TABLE '+tableName+' ('
    for field in parentKeys:
        createStr += "\n\t"+field+' INTEGER,'

    for field in firstLine:
        typeField = type(firstLine[field])
        if typeField == int or (field in defaultFieldTypes[int]):
            createStr += '\n\t'+field+' INTEGER,'
        elif typeField == float or (field in defaultFieldTypes[float]):
            createStr += '\n\t'+field+' NUMERIC (20,5),'
        elif typeField == str or (field in defaultFieldTypes[str]):
            createStr += '\n\t'+field+' TEXT,'
        elif typeField == bool or (field in defaultFieldTypes[int]):
            createStr += '\n\t'+field+' BOOLEAN,'
        elif ((typeField == datetime.datetime) or
                          (field in defaultFieldTypes[datetime.datetime])):
            createStr += '\n\t'+field+' DATETIME,'
        elif typeField == list:
            firstElement = firstLine[field][0]
            if not(type(firstElement) == dict):
                firstElement = {'id': firstElement}

            createTableInDB (dbConn, firstElement,
                            tableName+"_"+field,
                            parentKeys[::] + [tableName+"_id"])
        else:
            print ("TIPO DE COLUNA NAO IDENTIFICADO:\n",
                    "\tTabela:", tableName,
                    "\n\tColuna:", field,
                    "\n\tTipo:",typeField)
            input("Verifique a coluna antes de prosseguir <ENT>")

    createStr = createStr[:-1]+'\n);'
    if DEBUG: print (createStr)
    dbConn.cursor().execute(createStr)
    dbConn.commit()

def insertDataInDB (dbConn, allData, tableName, parentValues):
    for data in allData:
        insertCmd    = 'INSERT INTO '+tableName+' ('
        insertValues = 'VALUES ('
        for field in parentValues:
            insertCmd    += field+','
            insertValues += str(parentValues[field])+','

        for field in data:
            if data[field] == None:
                insertCmd += field+','
                insertValues += 'NULL ,'
            else:
                typeField = type(data[field])
                if typeField in [int, float, bool]:
                    insertCmd += field+','
                    insertValues += str(data[field])+','
                elif typeField == str:
                    insertCmd += field+','
                    insertValues += "'"+data[field].replace("'", "''")+"',"
#                elif ((typeField == datetime.datetime) or
#                                  (field in defaultFieldTypes[datetime.datetime])):
#                    createStr += ' DATETIME,'
                elif (typeField == list):
                    if len(data[field]) > 0:
                        subTable = data[field]
                        if not(type(subTable[0]) == dict):
                            subTable = [{'id':element} for element in subTable]
                        newParentValues = dict(parentValues)
                        newParentValues[tableName+"_id"] = list(data.values())[0]
                        insertDataInDB (dbConn, subTable,
                                        tableName+"_"+field,
                                        newParentValues)
                else:
                    print (data)
                    print ("DADOS NAO INSERIDOS:\n",
                           "\tTabela:", tableName,
                           "\n\tColuna:", field,
                           "\n\tTipo:",typeField)
                    input("Verifique a coluna antes de prosseguir <ENT>")

        if len(data) > 0:
            insertCmd = insertCmd[:-1]+') '+insertValues[:-1]+')'
            if DEBUG: print (insertCmd)
            try:
                dbConn.cursor().execute(insertCmd)
            except Exception as e:
                print ("FALHA NA INSERÇÃO:", e)
                print ("")

def removeDuplicates(fileName, allData):
    print ("Removendo duplicatas em:", fileName, f"numero entradas: {len(allData)}")
    pos1 = 0
    dataLen = len(allData)
    toRem
    while pos1 < dataLen:
        pos2 = pos1+1
        while pos2 < dataLen:
            isDup = False
            for key in ["id", "codigo"]:
                if allData[pos1].get(key, 0) == allData[pos2].get(key, 1):
                    print ("Registo duplicado em ", fileName,
                            "chave:", key, "valor:", allData[pos1][key])
                    isDup = True
                    break
            if isDup:
                allData.pop(pos2)
                dataLen -= 1
            else:
                pos2 += 1
        pos1 += 1
    return allData

def groupFileNames(allFileNames):
    print ('Agrupando arquivos com dados similares')
    groups = {}
    for fullFileName in allFileNames:
        fileName = fullFileName[fullFileName.rfind('\\')+1:]
        if fileName in groups:
            groups[fileName].append(fullFileName)
        else:
            groups[fileName] = [fullFileName]
    if DEBUG: print ('Grupos:', groups)
    return groups

def createAllTablesInDB (dbConn, dirName):
    allFileNames = glob.iglob(dirName + '/**/*.json', recursive=True)
    groups = groupFileNames(allFileNames)
    for fileName in groups:
        print ('Processando ',groups[fileName])
        allData = loadFiles(groups[fileName])
#        allData = removeDuplicates(fileName, allData)
        if len(allData) > 0:
            tableName = fileName.split('.')[-2]
            createTableInDB(dbConn, allData[0], tableName, [])
            insertDataInDB (dbConn, allData, tableName, {})
            dbConn.commit()
        else:
            print ("Arquivo '"+fileName+"' está vazio!!")

def runScripts (dbConn, dirName):
    allFileNames = []
    for fileName in glob.iglob(dirName + '/*.sql'):
        allFileNames.append(fileName)

    for fileName in sorted(allFileNames):
        print ("Executando o script:", fileName)
        fd = open(fileName, 'r', encoding='latin1')
        for cmd in fd.read().split(';'):
            dbConn.cursor().execute(cmd)
        dbConn.commit()
        fd.close()


def prevsem(cur):
    sem  = int(cur[-1:])
    year = int(cur[:-1])
    if sem == 2:
        sem = 1
    else:
        year -= 1
        sem = 2
    return f"{year}{sem}"

DEBUG = False
dbConn = sqlite3.connect(r"tcc-data.sqlite")
dbConn.create_function("prevsem", 1, prevsem)
createAllTablesInDB (dbConn, r'..\..\Dados-alunos-Breno-DTI-v5\dados')
runScripts(dbConn, r'.\torun.sql')
dbConn.close()
print ('Importacao concluida')

