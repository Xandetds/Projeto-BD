Markdown

# Dicionário de Dados - Sistema de Streaming

Este documento detalha a estrutura das tabelas e colunas do banco de dados relacional do sistema de streaming, incluindo seus tipos de dados, restrições e propósitos.

---

## Tabela: `usuarios`

**Propósito:** Armazena informações sobre os usuários da plataforma de streaming.

| Coluna          | Tipo de Dados     | Restrições           | Descrição                                         |
| :-------------- | :---------------- | :------------------- | :------------------------------------------------ |
| `usuario_id`    | `SERIAL`          | `PK`, `NOT NULL`     | Identificador único do usuário.                   |
| `nome`          | `VARCHAR(100)`    | `NOT NULL`           | Nome completo do usuário.                         |
| `email`         | `VARCHAR(100)`    | `UNIQUE`, `NOT NULL` | Endereço de e-mail do usuário (usado para login). |
| `senha_hash`    | `VARCHAR(255)`    | `NOT NULL`           | Hash da senha do usuário.                         |
| `data_nascimento`| `DATE`           |                      | Data de nascimento do usuário.                    |
| `data_registro` | `DATE`            | `DEFAULT CURRENT_DATE` | Data em que o usuário foi registrado.             |
| `ativo`         | `BOOLEAN`         | `DEFAULT TRUE`       | Indica se a conta do usuário está ativa.          |

---

## Tabela: `tipos_conteudo`

**Propósito:** Classifica os diferentes tipos de conteúdo disponíveis no sistema (ex: Filme, Série, Música).

| Coluna            | Tipo de Dados    | Restrições           | Descrição                                     |
| :---------------- | :--------------- | :------------------- | :-------------------------------------------- |
| `tipo_conteudo_id`| `SERIAL`         | `PK`, `NOT NULL`     | Identificador único do tipo de conteúdo.      |
| `nome_tipo`       | `VARCHAR(50)`    | `UNIQUE`, `NOT NULL` | Nome do tipo de conteúdo (ex: 'Filme', 'Série').|
| `descricao`       | `VARCHAR(255)`   |                      | Breve descrição do tipo de conteúdo.          |

---

## Tabela: `conteudos`

**Propósito:** Contém os detalhes de todos os filmes, séries, músicas, etc., disponíveis na plataforma.

| Coluna          | Tipo de Dados    | Restrições           | Descrição                                         |
| :-------------- | :--------------- | :------------------- | :------------------------------------------------ |
| `conteudo_id`   | `SERIAL`         | `PK`, `NOT NULL`     | Identificador único do conteúdo.                  |
| `titulo`        | `VARCHAR(255)`   | `NOT NULL`           | Título do conteúdo.                               |
| `descricao`     | `TEXT`           |                      | Descrição detalhada do conteúdo.                  |
| `ano_lancamento`| `INT`            |                      | Ano de lançamento do conteúdo.                    |
| `duracao_minutos`| `INT`           | `NOT NULL`           | Duração total do conteúdo em minutos.             |
| `tipo_conteudo_id`| `INT`          | `FK`, `NOT NULL`     | ID do tipo de conteúdo (relaciona com `tipos_conteudo`).|
| `url_midia`     | `VARCHAR(255)`   | `UNIQUE`, `NOT NULL` | URL ou caminho para o arquivo de mídia do conteúdo.|
| `data_adicao`   | `DATE`           | `DEFAULT CURRENT_DATE` | Data em que o conteúdo foi adicionado à plataforma.|
| `ativo`         | `BOOLEAN`        | `DEFAULT TRUE`       | Indica se o conteúdo está ativo e disponível.      |

---

## Tabela: `acessos`

**Propósito:** Registra cada vez que um usuário acessa um conteúdo, incluindo detalhes do acesso.

| Coluna            | Tipo de Dados  | Restrições           | Descrição                                     |
| :---------------- | :------------- | :------------------- | :-------------------------------------------- |
| `acesso_id`       | `SERIAL`       | `PK`, `NOT NULL`     | Identificador único do acesso.                |
| `usuario_id`      | `INT`          | `FK`, `NOT NULL`     | ID do usuário que realizou o acesso.         |
| `conteudo_id`     | `INT`          | `FK`, `NOT NULL`     | ID do conteúdo acessado.                     |
| `data_hora_acesso`| `TIMESTAMP`    | `DEFAULT CURRENT_TIMESTAMP` | Data e hora exata do início do acesso.        |
| `tempo_assistido_segundos` | `INT` |                      | Tempo total assistido do conteúdo em segundos.|

---

## Tabela: `planos`

**Propósito:** Define os diferentes planos de assinatura disponíveis para os usuários.

| Coluna                 | Tipo de Dados    | Restrições           | Descrição                                 |
| :--------------------- | :--------------- | :------------------- | :---------------------------------------- |
| `plano_id`             | `SERIAL`         | `PK`, `NOT NULL`     | Identificador único do plano de assinatura. |
| `nome_plano`           | `VARCHAR(50)`    | `UNIQUE`, `NOT NULL` | Nome do plano (ex: 'Básico', 'Premium').  |
| `valor`                | `DECIMAL(10, 2)` | `NOT NULL`           | Preço do plano.                           |
| `qualidade_video`      | `VARCHAR(50)`    |                      | Qualidade máxima de vídeo permitida pelo plano (ex: 'HD', '4K').|
| `num_telas_simultaneas`| `INT`            |                      | Número de telas que podem usar o plano simultaneamente.|
| `descricao`            | `TEXT`           |                      | Descrição detalhada dos benefícios do plano.|

---

## Tabela: `assinaturas`

**Propósito:** Registra as assinaturas ativas e históricas dos usuários aos planos.

| Coluna               | Tipo de Dados    | Restrições           | Descrição                                     |
| :------------------- | :--------------- | :------------------- | :-------------------------------------------- |
| `assinatura_id`      | `SERIAL`         | `PK`, `NOT NULL`     | Identificador único da assinatura.            |
| `usuario_id`         | `INT`            | `FK`, `NOT NULL`     | ID do usuário que possui a assinatura.        |
| `plano_id`           | `INT`            | `FK`, `NOT NULL`     | ID do plano de assinatura associado.          |
| `data_inicio`        | `DATE`           | `NOT NULL`           | Data de início da assinatura.                 |
| `data_fim`           | `DATE`           |                      | Data de término da assinatura (pode ser nulo para planos recorrentes).|
| `status_assinatura`  | `VARCHAR(20)`    | `DEFAULT 'Ativa'`    | Status atual da assinatura (ex: 'Ativa', 'Cancelada', 'Expirada').|

---

## Tabela: `avaliacoes`

**Propósito:** Armazena as avaliações e notas que os usuários dão aos conteúdos.

| Coluna              | Tipo de Dados  | Restrições           | Descrição                                     |
| :------------------ | :------------- | :------------------- | :-------------------------------------------- |
| `id_avaliacao`      | `SERIAL`       | `PK`, `NOT NULL`     | Identificador único da avaliação.             |
| `id_usuario`        | `INT`          | `FK`, `NOT NULL`     | ID do usuário que fez a avaliação.            |
| `id_conteudo`       | `INT`          | `FK`, `NOT NULL`     | ID do conteúdo avaliado.                     |
| `nota`              | `INT`          | `NOT NULL`           | Nota atribuída ao conteúdo (ex: 1 a 5).      |
| `comentario`        | `TEXT`         |                      | Comentário opcional do usuário sobre o conteúdo.|
| `data_avaliacao`    | `TIMESTAMP`    | `DEFAULT CURRENT_TIMESTAMP` | Data e hora em que a avaliação foi feita.   |

---

## Tabela: `favoritos`

**Propósito:** Registra os conteúdos que os usuários marcaram como favoritos.

| Coluna            | Tipo de Dados  | Restrições                  | Descrição                                     |
| :---------------- | :------------- | :-------------------------- | :-------------------------------------------- |
| `id_favorito`     | `SERIAL`       | `PK`, `NOT NULL`            | Identificador único do item favorito.         |
| `id_usuario`      | `INT`          | `FK`, `NOT NULL`            | ID do usuário que favoritou o conteúdo.       |
| `id_conteudo`     | `INT`          | `FK`, `NOT NULL`            | ID do conteúdo favorito.                     |
| `data_adicao`     | `TIMESTAMP`    | `DEFAULT CURRENT_TIMESTAMP` | Data e hora em que o conteúdo foi adicionado aos favoritos.|
| `(id_usuario, id_conteudo)` |      | `UNIQUE`                    | Garante que um usuário não possa favoritar o mesmo conteúdo mais de uma vez.|