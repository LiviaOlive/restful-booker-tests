# 🤖 Automação de Testes de API com Robot Framework

![Framework](https://img.shields.io/badge/Framework-Robot-orange)
![Linguagem](https://img.shields.io/badge/Linguagem-Python-blue)

Este é um projeto de estudo focado na prática de automação de testes para APIs RESTful. Utilizando o **Robot Framework** e a biblioteca **RequestsLibrary**, foram criados testes automatizados para validar os principais endpoints da API de playground **[Restful-booker](https://restful-booker.herokuapp.com/)**.

## 🎯 Objetivo

O objetivo principal foi aplicar para estudo os conceitos de testes de API, desde a verificação de status até operações de CRUD (Create, Read, Update, Delete), incluindo a manipulação de tokens para autenticação.

## ✨ Funcionalidades Testadas

A suíte de testes cobre as seguintes funcionalidades da API Restful-booker:

-   **✔️ Health Check (`GET /ping`):** Garante que a API está online e respondendo.
-   **🔑 Autenticação (`POST /auth`):** Valida a geração de token com credenciais corretas e testa o acesso com credenciais inválidas.
-   **➕ Criação de Reservas (`POST /booking`):** Testa a criação de um novo registro de reserva com dados válidos.
-   **📄 Consulta de Reservas (`GET /booking`):** Valida a consulta da lista completa de reservas e a busca por um ID específico.
-   **🔄 Atualização Total (`PUT /booking/{id}`):** Testa a alteração completa de um registro de reserva, exigindo autenticação.
-   **✍️ Atualização Parcial (`PATCH /booking/{id}`):** Testa a alteração parcial de um registro, exigindo autenticação.
-   **❌ Exclusão de Reservas (`DELETE /booking/{id}`):** Valida a exclusão de uma reserva, exigindo autenticação.

## 🛠️ Tecnologias Utilizadas

* **Framework de Automação:** [Robot Framework](https://robotframework.org/)
* **Biblioteca de API:** [RequestsLibrary](https://robotframework.org/RequestsLibrary/)
* **Linguagem Base:** [Python](https://www.python.org/)
* **Controle de Versão:** [Git](https://git-scm.com/) & [GitHub](https://github.com/)
* **Editor:** [Visual Studio Code](https://code.visualstudio.com/)

## 🚀 Como Executar o Projeto

Siga os passos abaixo para executar a suíte de testes localmente.

### Pré-requisitos

* [Python 3.8+](https://www.python.org/downloads/)
* [Git](https://git-scm.com/downloads)

### Passos

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/LiviaOlive/restful-booker-tests.git](https://github.com/LiviaOlive/restful-booker-tests.git)
    cd restful-booker-tests
    ```

2.  **Instale as dependências do projeto:**
    ```bash
    pip install -r requirements.txt
    ```

3.  **Execute os testes:**
    ```bash
    robot tests/booking_tests.robot
    ```

4.  **Verifique os resultados:**
    Após a execução, os relatórios de teste (`log.html` e `report.html`) serão gerados na raiz do projeto. Abra-os em seu navegador para ver os resultados detalhados.

## 📂 Estrutura do Projeto

```
restful-booker-tests/
├── .gitignore          # Regras para ignorar arquivos no Git
├── README.md           # Documentação do projeto
├── requirements.txt    # Lista de dependências Python
├── resources/          # Keywords customizadas e reutilizáveis
│   └── api_keywords.resource
└── tests/              # Suítes e casos de teste
    └── booking_tests.robot
```
