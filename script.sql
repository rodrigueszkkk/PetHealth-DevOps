-- =====================================================================
-- PetHealthEcosystem - Azure SQL Database (PaaS)
-- A tabela PETS é criada automaticamente pela migração do EF Core
-- (InitialCreate) quando a API inicia no Azure Web App.
-- Execute no Portal do Azure > Banco SQL > Editor de consultas
-- ou com ./infra/04_consultar-banco.sh
-- =====================================================================

-- Estrutura (equivalente à migração InitialCreate)
-- CREATE TABLE PETS (
--     Id              INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
--     Name            NVARCHAR(100)     NOT NULL,
--     Breed           NVARCHAR(50)      NOT NULL,
--     Age             INT               NOT NULL,
--     TutorName       NVARCHAR(MAX)     NOT NULL,
--     NeedsPostOpCare BIT               NOT NULL
-- );

-- Evidências do CRUD
SELECT * FROM PETS ORDER BY Id;

SELECT * FROM PETS WHERE Id = 1;

-- Histórico das migrações aplicadas pela API
SELECT * FROM __EFMigrationsHistory;
