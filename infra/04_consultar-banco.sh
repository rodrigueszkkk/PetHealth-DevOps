#!/bin/bash
# =====================================================================
# 04 - Evidências no banco em nuvem: SELECT direto no Azure SQL (sqlcmd)
#      Também pode ser feito pelo Portal do Azure > Banco SQL > Editor de consultas.
# Execução:
#   chmod +x 04_consultar-banco.sh
#   ./04_consultar-banco.sh                       # SELECT * FROM PETS
#   ./04_consultar-banco.sh "SELECT COUNT(*) FROM PETS"
# =====================================================================
set -e
source "$(dirname "${BASH_SOURCE[0]}")/00_variaveis.sh"

QUERY="${1:-SELECT Id, Name, Breed, Age, TutorName, NeedsPostOpCare FROM PETS ORDER BY Id;}"

sqlcmd \
  -S "tcp:$SQL_SERVER_NAME.database.windows.net,1433" \
  -d "$SQL_DB_NAME" \
  -U "$SQL_ADMIN_USER" \
  -P "$SQL_PASSWORD" \
  -N -W \
  -Q "$QUERY"
