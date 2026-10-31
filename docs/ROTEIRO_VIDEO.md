# Roteiro do vídeo com falas — Sprint 4 (mínimo 720p, narrado, sem legendas)

> Leia as falas com naturalidade, não precisa decorar palavra por palavra. Deixe cada tela visível por 3–5 s.
> **Nunca exiba** `infra/.segredos.env`, a connection string ou o valor de `JWT_SECRET`.
> Comandos e JSONs para copiar: `COLINHA_VIDEO.md` (fora do repositório) e `json-crud/`.

## 0. Antes de gravar (checklist)

| Item | Onde conferir |
| :--- | :--- |
| Professor com acesso **Basic** | Organization settings → Users |
| `origin` aponta para o Azure Repos | `git remote -v` mostra `dev.azure.com` |
| Push funcionando sem pedir login | um push de teste antes de gravar |
| Banco abre no Editor de consultas | Portal → `PetHealthDb` → Query editor |
| Tabela vazia | `SELECT * FROM PETS;` |

Abas abertas, nesta ordem: **1** VS Code com o projeto · **2** Azure DevOps · **3** Portal Azure · **4** Swagger · **5** Editor de consultas do Azure SQL.

---

## Cena 1 — Apresentação (≈1 min)
**Tela:** Azure DevOps → Overview do projeto.

> "Olá, professor. Nós somos o grupo formado por Gabriel Costa Solano, RM 562325, Leandro Guarido, RM 561760, e Kaiky Pereira Rodrigues, RM 564578, da turma 2TDSPV. Esta é a nossa entrega da Sprint 4 de DevOps Tools e Cloud Computing."
>
> "A nossa solução é a PetHealthEcosystem API, desenvolvida em .NET 10 na disciplina de Advanced Business Development with .NET. Ela é o back-end de um ecossistema de saúde animal: cadastra os pets atendidos pela clínica, com raça, idade, tutor e se o animal precisa de cuidados pós-operatórios, com autenticação JWT e consultas com paginação e filtros."
>
> "A stack é: código versionado no Azure Repos, pipeline de CI/CD no Azure Pipelines em YAML, deploy no Azure Web App e banco de dados Azure SQL Database, que é um banco PaaS da Azure."

## Cena 2 — Diagrama de arquitetura (≈2 min)
**Tela:** `docs/arquitetura.svg` (pelo README no Azure Repos ou no GitHub).

> "Aqui está o diagrama da nossa arquitetura com o fluxo de CI/CD numerado."
>
> "Do lado esquerdo está o desenvolvedor, que altera o código na IDE e faz o push — passo 1. O push na branch master do Azure Repos dispara a pipeline automaticamente — passo 2."
>
> "Do passo 3 ao 7 é o CI: instalação do .NET 10, restore, build, execução dos testes automáticos e publicação do artefato no Azure DevOps."
>
> "Do passo 8 ao 11 é o CD: a pipeline baixa o artefato, configura as variáveis de ambiente que vêm de variáveis secretas e faz o deploy no Azure Web App."
>
> "No passo 12 o usuário final acessa a API pela internet, no 13 a API grava os dados no Azure SQL, e no 14 nós comprovamos cada operação com SELECT direto no banco. O professor também aparece como persona, com acesso Basic ao projeto."

## Cena 3 — Ferramentas (≈2 min)
**Tela:** VS Code → Azure DevOps → Portal → Editor de consultas.

> "Essas são as ferramentas que vamos usar. No VS Code está o código da API: o Program.cs, os controllers e os dois projetos de testes, unitários e de integração."
>
> "No Azure DevOps está o projeto 'Sprint 4 – Azure DevOps', privado, com Git e processo Scrum. Na descrição estão o professor e os integrantes. Aqui no Repos está o código, com o arquivo azure-pipelines.yml na raiz."
>
> "No Portal do Azure está o resource group rg-pethealth-564578 com o Web App, o plano de serviço e o servidor Azure SQL. E aqui no Editor de consultas do banco, a tabela PETS está vazia."
>
> *(rode `SELECT * FROM PETS;`)*

## Cena 4 — Configuração da pipeline (≈3 min)
**Tela:** Pipelines → `PetHealth-CI-CD` → Edit.

> "Essa é a nossa pipeline em YAML. No começo está o trigger na branch master: qualquer commit na master dispara a pipeline automaticamente."
>
> "Ela tem dois stages. O primeiro é o CI, que roda num agente Ubuntu. Ele instala o SDK do .NET 10, restaura as dependências, faz o build em Release, executa os testes automáticos e publica o resultado na aba Tests. Depois gera o publish da API, compacta em um zip e publica o artefato chamado app."
>
> "O segundo stage é o CD. Ele depende do CI: só roda depois que um novo artefato foi gerado com sucesso. Ele baixa o artefato, configura as variáveis de ambiente do Web App e faz o deploy usando a service connection MyAzureSubscription."
>
> *(clique em Variables)*
>
> "Aqui estão as variáveis da pipeline. A connection string do banco e a chave do JWT estão marcadas como secretas, com o cadeado. Elas não ficam no código e aparecem com asteriscos nos logs."

## Cena 5 — Alteração de código e push (≈1 min)
**Tela:** VS Code → `src/PetHealthEcosystem.Api/Program.cs` → rota `/wellcome`.

> "Agora vou fazer uma alteração no código para mostrar o CI/CD funcionando. Esta é a rota /wellcome, que hoje retorna 'PetHealthEcosystem API - Sprint 4 DevOps'. Vou alterar a mensagem para '... - Versao do Video'."
>
> *(altere, salve e rode no terminal: `git add .`, `git commit -m "Altera mensagem da rota /wellcome"`, `git push origin main:master`)*
>
> "Fiz o commit e o push para a branch master do Azure Repos. Eu não vou clicar em nada na pipeline: ela deve iniciar sozinha."

## Cena 6 — CI automático (≈4 min)
**Tela:** Pipelines → execução nova.

> "Aqui está a execução que começou automaticamente. Repare que o motivo é 'Individual CI' e o commit é o que acabei de enviar."
>
> *(abra o stage CI e clique em cada task)*
>
> "Primeiro ele faz o checkout do repositório. Depois instala o .NET SDK 10. Aqui restaura as dependências da API e dos testes. Aqui faz o build da API em Release."
>
> "Agora a etapa de testes automáticos: ela executa os testes unitários dos serviços e os testes de integração, que sobem a API em memória e testam o CRUD de pets, a autenticação e as rotas."
>
> "Depois ele faz o publish, compacta a aplicação em app.zip e publica o artefato no Azure DevOps."
>
> *(abra a aba Tests)*
>
> "Na aba Tests estão os resultados: 39 testes, todos passando, 22 unitários e 17 de integração."
>
> *(volte ao Summary e clique no artefato)*
>
> "E aqui está o artefato 'app' publicado, com o zip da aplicação."

## Cena 7 — CD automático (≈3 min)
**Tela:** stage CD da mesma execução.

> "Assim que o CI terminou e gerou o novo artefato, o stage de CD começou sozinho."
>
> *(clique em cada step)*
>
> "Primeiro ele baixa o artefato gerado pelo CI. Depois configura as variáveis de ambiente do Web App: o ambiente, a connection string do Azure SQL e a chave do JWT. Repare que os valores secretos aparecem como asteriscos."
>
> "Por último faz o deploy do zip no Azure Web App. Aqui está a mensagem de deploy concluído com sucesso."

## Cena 8 — Portal do Azure (≈2 min)
**Tela:** Portal → `rg-pethealth-564578`.

> "No Portal do Azure, dentro do resource group, estão os recursos da solução, criados por scripts Azure CLI que estão na pasta infra do repositório."
>
> *(abra o App Service)*
>
> "Este é o Web App pethealth-api-564578, rodando .NET 10 em Linux. No Deployment Center dá para ver o deploy que acabou de ser feito pela pipeline. E em Environment variables estão as variáveis que o CD configurou."
>
> *(abra o App Service plan e depois o SQL database)*
>
> "Este é o plano de serviço Linux B1. E este é o banco PetHealthDb no servidor Azure SQL, que é o nosso banco em nuvem no modelo PaaS."

## Cena 9 — Aplicação com a alteração (≈1 min)
**Tela:** `https://pethealth-api-564578.azurewebsites.net/wellcome`

> "Acessando a rota /wellcome no Web App, já aparece a nova mensagem, 'Versao do Video'. Isso comprova que a alteração passou pelo CI, gerou o artefato e foi publicada pelo CD."

## Cena 10 — CRUD com evidência no banco (≈6 min)
**Tela:** Swagger (`/swagger`) lado a lado com o Editor de consultas.

> "Agora vou fazer o CRUD completo pelo Swagger da aplicação publicada e mostrar cada operação no banco com SELECT."

**Login**
> "As operações de escrita exigem autenticação. Vou fazer login com o usuário admin, copiar o token JWT e informar no botão Authorize."

**Inserir**
> *(POST /api/Pets com o JSON do Thor)*
> "Vou cadastrar o pet Thor, um Golden Retriever de 4 anos. A API retornou 201 Created com o id X."
> *(SELECT * FROM PETS;)*
> "No banco, o registro do Thor foi inserido na tabela PETS."

**Consultar**
> *(GET /api/Pets e GET /api/Pets/{id})*
> "Agora a consulta: a listagem retorna o Thor com paginação e links HATEOAS, e a busca pelo id retorna os detalhes."
> *(SELECT * FROM PETS WHERE Id = X;)*
> "E no banco o mesmo registro."

**Atualizar**
> *(PUT /api/Pets/{id})*
> "Vou atualizar o Thor: a idade passa para 5 anos, o nome do tutor fica completo e ele passa a precisar de cuidados pós-operatórios. A API retornou 204 No Content."
> *(SELECT * FROM PETS WHERE Id = X;)*
> "No banco, a idade mudou de 4 para 5, o tutor foi atualizado e o campo NeedsPostOpCare passou para 1."

**Deletar**
> *(DELETE /api/Pets/{id})*
> "Por último, a exclusão, que exige o perfil Admin. A API retornou 204."
> *(SELECT * FROM PETS;)*
> "E no banco o registro não existe mais."

## Cena 11 — Encerramento (≈30 s)

> "Recapitulando: fizemos uma alteração no código e um push na master do Azure Repos. Isso disparou o CI, que compilou, executou os 39 testes e publicou o artefato. Em seguida o CD fez o deploy automático no Azure Web App, e a aplicação gravou e consultou os dados no Azure SQL, como mostramos com os SELECTs. Obrigado, professor."
