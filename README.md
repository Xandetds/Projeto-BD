# Projeto de Banco de Dados: Sistema de Streaming

[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Flask](https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white)](https://flask.palletsprojects.com/)
[![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)

📺 Sistema de banco de dados relacional para uma plataforma de streaming, inspirado em serviços como Netflix e Prime Video.

---

## 🧾 Descrição

Este projeto simula a estrutura de um sistema completo de streaming, com foco na modelagem e implementação prática de um banco de dados relacional.

A aplicação foi desenvolvida com **PostgreSQL** e integrada a um back-end em **Python + Flask**, com interface HTML básica para manipulação dos dados (CRUD).

---

## Funcionalidades do Sistema

- Cadastro de usuários, tipos de conteúdo e planos de assinatura  
- Registro de acessos e tempo assistido  
- Avaliações, favoritos e histórico de visualizações  
- Controle e gestão de assinaturas  

---

## Tecnologias Utilizadas

- **PostgreSQL** — Sistema de gerenciamento de banco de dados relacional  
- **SQL (DDL, DML)** — Linguagem de definição e manipulação de dados  
- **Python** — Linguagem de programação para o back-end  
- **Flask** — Microframework web para a construção da API e interface básica  

---

## Estrutura do Banco de Dados

O sistema é composto por 8 tabelas principais:

- `usuarios`  
- `tipos_conteudo`  
- `conteudos`  
- `acessos`  
- `planos`  
- `assinaturas`  
- `avaliacoes`  
- `favoritos`

![Diagrama do Modelo Físico do Sistema de Streaming](database/docs/Modelo_Físico.png)

---

## Estrutura do Repositório

<pre>
.
├── database/
│   ├── ddl/                # Criação de tabelas
│   ├── dml/                # Inserção de dados
│   ├── functions/          # Funções e procedures
│   ├── triggers/           # Triggers do banco
│   ├── views/              # Views personalizadas
│   └── docs/               # Diagramas e documentação
├── src/
│   └── python/
│       ├── templates/      # HTMLs do CRUD
│       ├── app.py          # Aplicação Flask
│       └── requirements.txt
└── README.md
</pre>

---

## 📈 Progresso do Projeto

### Fase 1: Estrutura Inicial
- Criação do modelo físico e estrutura SQL  
- Scripts de criação (`DDL`) e inserção (`DML`)  

### Fase 2: Objetos Avançados
- Funções, procedures, triggers, views e índices  
- Justificativas das implementações no código  

### Fase 3: CRUD com Flask
- Desenvolvimento de CRUD básico com interface HTML  
- Integração completa entre banco e aplicação  

---

## Como Configurar e Rodar

Siga estes passos para configurar e executar o projeto localmente:

1.  **Clone o Repositório:**
    ```bash
    git clone https://github.com/Xandetds/Projeto-BD.git
    ```
    Navegue até a pasta do projeto clonado:
    ```bash
    cd Projeto-BD
    ```

2.  **Configurar o Banco de Dados PostgreSQL:**
    * Abra o **pgAdmin** ou **DBeaver** (ou use o `psql` no terminal).
    * **Crie um novo banco de dados** chamado `sistema_streaming` (tudo minúsculo).
        * Exemplo SQL: `CREATE DATABASE sistema_streaming;`
    * **Conecte-se** a este novo banco de dados no seu cliente SQL.
    * **Execute o script de Definição de Dados (DDL):**
        * Abra o arquivo `database/ddl/create_tables.sql` e execute todo o seu conteúdo. (Este script já inclui a criação de tabelas, a coluna `visualizacoes` e os `CREATE INDEX`).
    * **Execute o script de Manipulação de Dados (DML):**
        * Abra o arquivo `database/dml/insert_data.sql` e execute todo o seu conteúdo para popular as tabelas com dados de exemplo.

3.  **Configurar e Rodar a Aplicação Python (Flask):**
    * Navegue até a pasta da aplicação Python:
        ```bash
        cd src/python
        ```
    * **Crie e ative o Ambiente Virtual:**
        ```bash
        python -m venv .venv
        .venv\Scripts\Activate.ps1   # Para PowerShell
        # ou source .venv/bin/activate # Para Git Bash/Linux
        ```
    * **Instale as Dependências:**
        ```bash
        pip install -r requirements.txt
        ```
    * **Execute a Aplicação Flask:**
        ```bash
        python app.py
        ```
    * Abra seu navegador e acesse: `http://127.0.0.1:5000/`
  
---

## Bugs e Lições Aprendidas

Problema:
Erro: relação 'public.usuarios' não existe ao rodar o Flask.

Causa:
O banco havia sido populado antes da aplicação estar pronta.

Solução:
Recriar o banco e executar os scripts novamente, garantindo consistência com a versão atual do app.

Lição:
Sempre trabalhar com um ambiente limpo após pausas ou mudanças estruturais no banco.
Isso evita conflito entre schema e aplicação.

---

## 👤 Autor

**Alexandre Tibes da Silva**  
Estudante de Engenharia de Software – UniSatc  
📧 [alexandretibes9@gmail.com](mailto:alexandretibes9@gmail.com)  
🔗 [linkedin.com/in/alexandre-tibes-2a79692b5](https://www.linkedin.com/in/alexandre-tibes-2a79692b5)
