# Roteiro do vídeo — Sprint 4 (mínimo 720p, narrado, sem legendas)

> Fale em voz alta o que está fazendo em todas as cenas. Deixe cada tela visível por 3–5 s.
> **Nunca exiba** `infra/.segredos.env`, a connection string ou o valor de `JWT_SECRET`.

## 0. Antes de gravar (checklist)

| Item | Onde conferir |
| :--- | :--- |
| Infra criada (RG, Azure SQL, Web App) | Portal → Resource groups → `rg-pethealth-564578` |
| Pipeline já rodou verde pelo menos uma vez | Azure DevOps → Pipelines |
| Professor com acesso **Basic** | Organization settings → Users |
| `git push` funcionando da sua máquina | `git remote -v` aponta para o Azure Repos |
| Banco com IP liberado no firewall | Editor de consultas do portal abre sem erro |

Abas abertas, nesta ordem: **1** VS Code com o projeto · **2** Azure DevOps (Repos/Pipelines) · **3** Portal Azure · **4** Swagger da API · **5** Editor de consultas do Azure SQL.

## Cena 1 — Apresentação (≈1 min)
Integrantes, turma, a solução (API PetHealthEcosystem .NET 10) e a stack: Azure Repos, Azure Pipelines, Azure Web App, Azure SQL.
Mostre o diagrama `docs/arquitetura.svg` e explique os números 1 a 14.

## Cena 2 — Ferramentas (≈2 min)
- VS Code com o código (`Program.cs`, `PetsController.cs`, testes).
- Azure DevOps: Overview do projeto (nome, descrição, Private, Scrum), Repos → Files.
- Portal Azure: Resource Group com o **Azure SQL** e o **Web App**.
- Banco: Editor de consultas → `SELECT * FROM PETS;`.

## Cena 3 — Configuração da pipeline (≈3 min)
Pipelines → Edit no `azure-pipelines.yml`. Explique:
- `trigger: master` (dispara a cada commit na master).
- Stage **CI**: UseDotNet, restore, build, **test**, publish, zip, **PublishPipelineArtifact**.
- Stage **CD**: `dependsOn: CI`, download do artefato, AzureAppServiceSettings, AzureWebApp.
- Botão **Variables**: `SQL_CONNECTION` e `JWT_SECRET` com cadeado (não clique para mostrar).

## Cena 4 — Alteração de código (≈1 min)
No VS Code, em `src/PetHealthEcosystem.Api/Program.cs`, altere a mensagem da rota `/wellcome`:
```csharp
app.MapGet("/wellcome", () => Results.Text("PetHealthEcosystem API - Sprint 4 DevOps - versão do vídeo"))
```
(Opcional: também o `Title` do Swagger.) Depois:
```bash
git add .
git commit -m "Altera mensagem da rota /wellcome"
git push origin master
```

## Cena 5 — CI automático (≈4 min)
Pipelines → a execução que **começou sozinha** ("Individual CI", commit do push).
Abra o stage **CI** e cada task, comentando o que faz. Ao final:
- Aba **Tests**: 39 testes passando.
- **Artefato** `app` publicado (link "1 published").

## Cena 6 — CD automático (≈3 min)
Stage **CD** iniciando sozinho após o CI. Abra cada step: download do artefato, configuração das variáveis (valores aparecem como `***`), deploy ("Successfully deployed").

## Cena 7 — Portal do Azure (≈2 min)
Resource Group → **Web App** (Overview, Deployment Center/Logs mostrando o deploy recente, Configuration com as variáveis) → **App Service Plan** → **SQL server / SQL database**.

## Cena 8 — Aplicação com a alteração (≈1 min)
Abra `https://pethealth-api-564578.azurewebsites.net/wellcome` e mostre a nova mensagem.

## Cena 9 — CRUD completo com evidência no banco (≈6 min)
No Swagger (`/swagger`), seguindo `json-crud/LEIA-ME.md`:
1. `POST /api/Auth/login` (admin) → copie o token → **Authorize** → `Bearer <token>`.
2. **Inserir**: `POST /api/Pets` → no Editor de consultas: `SELECT * FROM PETS;`
3. **Consultar**: `GET /api/Pets` e `GET /api/Pets/{id}` → `SELECT * FROM PETS WHERE Id = <id>;`
4. **Atualizar**: `PUT /api/Pets/{id}` → `SELECT * FROM PETS WHERE Id = <id>;` (mostre os campos alterados)
5. **Deletar**: `DELETE /api/Pets/{id}` → `SELECT * FROM PETS;` (registro sumiu)

## Cena 10 — Encerramento (≈30 s)
Recapitule: push na master → CI (build, testes, artefato) → CD (deploy no Web App) → CRUD persistido no Azure SQL.
