
DROP INDEX IF EXISTS Aluno_id_idx;
CREATE UNIQUE INDEX Aluno_id_idx ON Aluno (
    id
);

DROP INDEX IF EXISTS MatriculaPeriodo_id_idx;
CREATE UNIQUE INDEX MatriculaPeriodo_id_idx ON MatriculaPeriodo (
    id
);

DROP INDEX IF EXISTS Disciplina_id_idx;
CREATE UNIQUE INDEX Disciplina_id_idx ON Disciplina (
    id
);
