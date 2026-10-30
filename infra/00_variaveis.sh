#!/bin/bash
# =====================================================================
# Variáveis comuns aos scripts de infraestrutura (PetHealthEcosystem - Sprint 4)
# Uso: os demais scripts fazem "source ./00_variaveis.sh"
#
# ANTES DE EXECUTAR (Cloud Shell - Bash ou Git Bash com Azure CLI):
#   az account show
#   az account list -o table
#   az account set --subscription "nome-da-assinatura-correta"
#
# SEGREDOS NÃO FICAM NESTE ARQUIVO. Opcionalmente defina no terminal:
#   export SQL_PASSWORD='SenhaForte@123'
#   export JWT_SECRET='uma-chave-com-no-minimo-32-caracteres-123'
# Se não definir, o script 02 gera valores aleatórios e salva em infra/.segredos.env
# (arquivo ignorado pelo Git).
# =====================================================================

RM="564578"                                   # ALTERE PARA SEU RM
LOCATION="eastus"                             # ALTERE conforme sua Policy (brazilsouth, eastus, ...)

RESOURCE_GROUP_NAME="rg-pethealth-$RM"

# Banco de dados em nuvem (Azure SQL Database - PaaS)
SQL_SERVER_NAME="sql-pethealth-db-$RM"        # FQDN: <nome>.database.windows.net
SQL_LOCATION="centralus"                      # eastus não aceita novos servidores Azure SQL na assinatura Students
SQL_DB_NAME="PetHealthDb"
SQL_ADMIN_USER="pethealthadmin"
SQL_SERVICE_OBJECTIVE="Basic"                 # Basic (5 DTU) é suficiente para a entrega

# Aplicação (Azure App Service Linux)
APP_SERVICE_PLAN="plan-pethealth-$RM"
WEBAPP_NAME="pethealth-api-$RM"               # URL: https://<WEBAPP_NAME>.azurewebsites.net
RUNTIME="DOTNETCORE:10.0"                     # confirme com: az webapp list-runtimes --os-type linux
SKU="B1"                                      # F1 (gratuito) também funciona se a assinatura permitir

# Carrega segredos gerados anteriormente, se existirem
SEGREDOS_FILE="$(dirname "${BASH_SOURCE[0]}")/.segredos.env"
if [ -f "$SEGREDOS_FILE" ]; then
  # shellcheck disable=SC1090
  source "$SEGREDOS_FILE"
fi

sql_connection_string() {
  echo "Server=tcp:$SQL_SERVER_NAME.database.windows.net,1433;Initial Catalog=$SQL_DB_NAME;Persist Security Info=False;User ID=$SQL_ADMIN_USER;Password=$SQL_PASSWORD;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}
