ALTER TABLE UnidadeOrganizacional 
    ADD COLUMN descricao TEXT;

UPDATE UnidadeOrganizacional SET descricao = 'Apodi' WHERE sigla = 'AP';
UPDATE UnidadeOrganizacional SET descricao = 'Caicó' WHERE sigla = 'CA';
UPDATE UnidadeOrganizacional SET descricao = 'Natal – Cidade Alta' WHERE sigla = 'CAL';
UPDATE UnidadeOrganizacional SET descricao = 'Canguaretama' WHERE sigla = 'CANG';
UPDATE UnidadeOrganizacional SET descricao = 'Ceará-Mirim' WHERE sigla = 'CM';
UPDATE UnidadeOrganizacional SET descricao = 'Currais Novos' WHERE sigla = 'CN';
UPDATE UnidadeOrganizacional SET descricao = 'Natal Central' WHERE sigla = 'CNAT';
UPDATE UnidadeOrganizacional SET descricao = 'Ipanguaçu' WHERE sigla = 'IP';
UPDATE UnidadeOrganizacional SET descricao = 'João Câmara' WHERE sigla = 'JC';
UPDATE UnidadeOrganizacional SET descricao = 'Macau' WHERE sigla = 'MC';
UPDATE UnidadeOrganizacional SET descricao = 'Mossoró' WHERE sigla = 'MO';
UPDATE UnidadeOrganizacional SET descricao = 'Nova Cruz' WHERE sigla = 'NC';
UPDATE UnidadeOrganizacional SET descricao = 'Parnamirim' WHERE sigla = 'PAR';
UPDATE UnidadeOrganizacional SET descricao = 'Pau dos Ferros' WHERE sigla = 'PF';
UPDATE UnidadeOrganizacional SET descricao = 'Santa Cruz' WHERE sigla = 'SC';
UPDATE UnidadeOrganizacional SET descricao = 'São Gonçalo do Amarante' WHERE sigla = 'SGA';
UPDATE UnidadeOrganizacional SET descricao = 'São Paulo do Potengi' WHERE sigla = 'SPP';
UPDATE UnidadeOrganizacional SET descricao = 'Natal – Zona Leste' WHERE sigla = 'ZL';
UPDATE UnidadeOrganizacional SET descricao = 'Natal – Zona Norte' WHERE sigla = 'ZN';
