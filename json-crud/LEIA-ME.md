# Roteiro do CRUD (Swagger: https://pethealth-api-564578.azurewebsites.net/swagger)

| # | Operação | Endpoint | Corpo | Evidência no banco (Azure SQL) |
|---|---|---|---|---|
| 1 | Login (gera JWT) | `POST /api/Auth/login` | `01-login-admin.json` | - |
| 2 | **Inserir** | `POST /api/Pets` | `02-pets-POST.json` | `SELECT * FROM PETS;` |
| 3 | **Consultar** | `GET /api/Pets` e `GET /api/Pets/{id}` | - | `SELECT * FROM PETS WHERE Id = 1;` |
| 4 | **Atualizar** | `PUT /api/Pets/{id}` | `03-pets-PUT.json` (ajuste o `id`) | `SELECT * FROM PETS WHERE Id = 1;` |
| 5 | **Deletar** | `DELETE /api/Pets/{id}` | - | `SELECT * FROM PETS;` |

No Swagger, clique em **Authorize** e informe `Bearer <token>` (token retornado no passo 1).
POST/PUT exigem usuário autenticado e DELETE exige o perfil **Admin**.
