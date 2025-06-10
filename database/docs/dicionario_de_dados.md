# Dicionário de Dados - Sistema de Streaming

Este documento detalha a estrutura das tabelas e colunas do banco de dados relacional do sistema de streaming, conforme definido no script SQL de criação.

---

## Tabela: `usuarios`

**Propósito:** Armazena informações dos usuários da plataforma de streaming.

| Coluna          | Tipo de Dados  | Restrições               | Descrição                                         |
| :-------------- | :------------- | :----------------------- | :------------------------------------------------ |
| `id_usuario`    | `SERIAL`       | `PRIMARY KEY`            | Identificador único do usuário.                   |
| `nome`          | `VARCHAR(100)` | `NOT NULL`               | Nome completo do usuário.                         |
| `email`         | `VARCHAR(100)` | `UNIQUE`, `NOT NULL`     | Endereço de e-mail do usuário, único para login.  |
| `senha`         | `VARCHAR(100)` | `NOT NULL`               | Senha do usuário.                                 |
| `data_nascimento`| `DATE`         | `NOT NULL`               | Data de nascimento do usuário.                    |

---

## Tabela: `tipos_conteudo`

**Propósito:** Classifica os tipos de conteúdo disponíveis (ex: Filme, Série, Música).

| Coluna            | Tipo de Dados  | Restrições           | Descrição                                     |
| :---------------- | :------------- | :------------------- | :-------------------------------------------- |
| `id_tipo`         | `SERIAL`       | `PRIMARY KEY`        | Identificador único do tipo de conteúdo.      |
| `nome_tipo`       | `VARCHAR(50)`  | `NOT NULL`           | Nome do tipo de conteúdo (ex: 'Filme', 'Série').|
| `descricao`       | `VARCHAR(255)` |                      | Breve descrição do tipo de conteúdo.          |

---

## Tabela: `conteudos`

**Propósito:** Detalhes de todos os conteúdos disponíveis para streaming.

| Coluna           | Tipo de Dados    | Restrições           | Descrição                                         |
| :--------------- | :--------------- | :------------------- | :------------------------------------------------ |
| `id_conteudo`    | `SERIAL`         | `PRIMARY KEY`        | Identificador único do conteúdo.                  |
| `titulo`         | `VARCHAR(100)`   | `NOT NULL`           | Título do conteúdo.                               |
| `descricao`      | `TEXT`           |                      | Descrição detalhada do conteúdo.                  |
| `duracao_min`    | `INT`            | `NOT NULL`           | Duração total do conteúdo em minutos.             |
| `data_lancamento`| `DATE`           |                      | Data de lançamento do conteúdo.                   |
| `id_tipo`        | `INT`            | `FOREIGN KEY`        | ID do tipo de conteúdo (referencia `tipos_conteudo`).|

---

## Tabela: `acessos`

**Propósito:** Registra cada vez que um usuário acessa um conteúdo.

| Coluna                | Tipo de Dados   | Restrições               | Descrição                                     |
| :-------------------- | :-------------- | :----------------------- | :-------------------------------------------- |
| `id_acesso`           | `SERIAL`        | `PRIMARY KEY`            | Identificador único do acesso.                |
| `id_usuario`          | `INT`           | `FOREIGN KEY`            | ID do usuário que realizou o acesso (referencia `usuarios`).|
| `id_conteudo`         | `INT`           | `FOREIGN KEY`            | ID do conteúdo acessado (referencia `conteudos`).|
| `data_acesso`         | `TIMESTAMP`     | `DEFAULT CURRENT_TIMESTAMP`| Data e hora exata do início do acesso.        |
| `tempo_assistido_min` | `INT`           |                          | Tempo total assistido do conteúdo em minutos. |

---

## Tabela: `planos`

**Propósito:** Define os diferentes planos de assinatura disponíveis.

| Coluna            | Tipo de Dados    | Restrições           | Descrição                                 |
| :---------------- | :--------------- | :------------------- | :---------------------------------------- |
| `id_plano`        | `SERIAL`         | `PRIMARY KEY`        | Identificador único do plano de assinatura. |
| `nome_plano`      | `VARCHAR(50)`    | `NOT NULL`           | Nome do plano (ex: 'Básico', 'Premium').  |
| `preco_mensal`    | `DECIMAL(6, 2)`  | `NOT NULL`           | Preço mensal do plano.                    |
| `limite_perfils`  | `INT`            |                      | Número máximo de perfis permitidos por plano.|
| `qualidade`       | `VARCHAR(20)`    |                      | Qualidade de vídeo associada ao plano (Ex: HD, FullHD, 4K).|

---

## Tabela: `assinaturas`

**Propósito:** Registra as assinaturas dos usuários aos planos.

| Coluna            | Tipo de Dados  | Restrições                                     | Descrição                                     |
| :---------------- | :------------- | :--------------------------------------------- | :-------------------------------------------- |
| `id_assinatura`   | `SERIAL`       | `PRIMARY KEY`                                  | Identificador único da assinatura.            |
| `id_usuario`      | `INT`          | `FOREIGN KEY`                                  | ID do usuário que possui a assinatura (referencia `usuarios`).|
| `id_plano`        | `INT`          | `FOREIGN KEY`                                  | ID do plano de assinatura (referencia `planos`).|
| `data_inicio`     | `DATE`         | `NOT NULL`                                     | Data de início da assinatura.                 |
| `status`          | `VARCHAR(10)`  | `CHECK (status IN ('ativa', 'cancelada', 'pendente'))`, `DEFAULT 'ativa'`| Status atual da assinatura.                   |

---

## Tabela: `avaliacoes`

**Propósito:** Armazena as avaliações de usuários para os conteúdos.

| Coluna            | Tipo de Dados  | Restrições                                   | Descrição                                     |
| :---------------- | :------------- | :------------------------------------------- | :-------------------------------------------- |
| `id_feedback`     | `SERIAL`       | `PRIMARY KEY`                                | Identificador único do feedback/avaliação.    |
| `id_usuario`      | `INT`          | `FOREIGN KEY`                                | ID do usuário que fez a avaliação (referencia `usuarios`).|
| `id_conteudo`     | `INT`          | `FOREIGN KEY`                                | ID do conteúdo avaliado (referencia `conteudos`).|
| `nota`            | `SMALLINT`     | `CHECK (nota >= 1 AND nota <= 5)`            | Nota atribuída ao conteúdo (entre 1 e 5).     |
| `comentario`      | `VARCHAR(1000)`|                                              | Comentário opcional do usuário.               |
| `data_avaliacao`  | `TIMESTAMP`    | `DEFAULT CURRENT_TIMESTAMP`                  | Data e hora em que a avaliação foi registrada.|

---

## Tabela: `favoritos`

**Propósito:** Registra os conteúdos que os usuários marcaram como favoritos.

| Coluna           | Tipo de Dados  | Restrições                  | Descrição                                     |
| :--------------- | :------------- | :-------------------------- | :-------------------------------------------- |
| `id_favorito`    | `SERIAL`       | `PRIMARY KEY`               | Identificador único do item favorito.         |
| `id_usuario`     | `INT`          | `FOREIGN KEY`               | ID do usuário que favoritou o conteúdo (referencia `usuarios`).|
| `id_conteudo`    | `INT`          | `FOREIGN KEY`               | ID do conteúdo favorito (referencia `conteudos`).|
| `(id_usuario, id_conteudo)` |      | `UNIQUE`                    | Garante que um usuário não possa favoritar o mesmo conteúdo mais de uma vez.|