#!/bin/bash
# =====================================================================
# 02 - Cria o BANCO DE DADOS EM NUVEM: Azure SQL Database (PaaS)
#      Servidor lógico + banco + regras de firewall (serviços Azure e IP local)
# Execução:
#   chmod +x 02_criar-banco-azure-sql.sh && ./02_criar-banco-azure-sql.sh
# =====================================================================
set -e
DIR="$(dirname "${BASH_SOURCE[0]}")"
source "$DIR/00_variaveis.sh"

# Gera segredos aleatórios caso não tenham sido informados
if [ -z "$SQL_PASSWORD" ]; then
  # Política de senha do Azure SQL: maiúscula, minúscula, número e símbolo
  SQL_PASSWORD="Pet@$(openssl rand -hex 8)A1"
  GEROU_SEGREDOS=1
fi
if [ -z "$JWT_SECRET" ]; then
  JWT_SECRET="$(openssl rand -hex 32)"
  GEROU_SEGREDOS=1
fi
if [ -n "$GEROU_SEGREDOS" ]; then
  umask 077
  printf "SQL_PASSWORD='%s'\nJWT_SECRET='%s'\n" "$SQL_PASSWORD" "$JWT_SECRET" > "$DIR/.segredos.env"
  echo ">> Segredos gerados e salvos em infra/.segredos.env (NÃO versionar). Use-os nas variáveis secretas da Pipeline."
fi

echo ">> Criando servidor Azure SQL $SQL_SERVER_NAME"
az sql server create \
  --name "$SQL_SERVER_NAME" \
  --resource-group "$RESOURCE_GROUP_NAME" \
  --location "$SQL_LOCATION" \
  --admin-user "$SQL_ADMIN_USER" \
  --admin-password "$SQL_PASSWORD"

echo ">> Criando banco $SQL_DB_NAME ($SQL_SERVICE_OBJECTIVE)"
az sql db create \
  --resource-group "$RESOURCE_GROUP_NAME" \
  --server "$SQL_SERVER_NAME" \
  --name "$SQL_DB_NAME" \
  --service-objective "$SQL_SERVICE_OBJECTIVE" \
  --backup-storage-redundancy Local

echo ">> Liberando acesso dos serviços Azure (Web App) ao banco"
az sql server firewall-rule create \
  --resource-group "$RESOURCE_GROUP_NAME" \
  --server "$SQL_SERVER_NAME" \
  --name AllowAzureServices \
  --start-ip-address 0.0.0.0 \
  --end-ip-address 0.0.0.0

MEU_IP=$(curl -s https://api.ipify.org || true)
if [ -n "$MEU_IP" ]; then
  echo ">> Liberando o IP local $MEU_IP (consultas SELECT de evidência)"
  az sql server firewall-rule create \
    --resource-group "$RESOURCE_GROUP_NAME" \
    --server "$SQL_SERVER_NAME" \
    --name AllowMeuIp \
    --start-ip-address "$MEU_IP" \
    --end-ip-address "$MEU_IP"
fi

echo ""
echo ">> Azure SQL disponível em: $SQL_SERVER_NAME.database.windows.net,1433 (banco $SQL_DB_NAME)"
echo ">> Connection string (guarde em variável SECRETA da Pipeline - SQL_CONNECTION):"
echo "   Server=tcp:$SQL_SERVER_NAME.database.windows.net,1433;Initial Catalog=$SQL_DB_NAME;User ID=$SQL_ADMIN_USER;Password=<SQL_PASSWORD>;Encrypt=True;..."
echo ">> (a senha real está em infra/.segredos.env ou na variável SQL_PASSWORD)"
