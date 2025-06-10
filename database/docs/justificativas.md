# Justificativas dos Objetos Avançados de Banco de Dados

Este documento detalha a finalidade e a justificativa para a escolha e implementação de Functions/Procedures, Trigger, Views e Índices neste projeto de banco de dados para sistema de streaming.

---

## Functions/Procedures

### 1. `func_tempo_assistido(p_usuario_id INT)`

* **O que faz:** Calcula o tempo total (em minutos) que um usuário específico (`p_usuario_id`) assistiu a conteúdos na plataforma, agregando dados da tabela `acessos`.
* **Por que é útil:** Fornece rapidamente uma métrica de engajamento do usuário para relatórios ou perfis, simplificando consultas.
* **Por que uma Função:** Retorna um único valor, ideal para uso direto em consultas `SELECT` e expressões SQL, otimizando a reutilização de código.

### 2. `proc_atualizar_status_assinaturas()`

* **O que faz:** Verifica e atualiza o status de assinaturas expiradas (de 'ativa'/'pendente' para 'expirada') com base na `data_fim`.
* **Por que é útil:** Garante a consistência automática dos dados de assinatura, essencial para a gestão de acessos e cobranças.
* **Por que um Procedure:** Ideal para executar ações que modificam o estado do banco de dados (operação `UPDATE`), sem retornar um valor diretamente para uma consulta.

### 3. `func_conteudo_disponivel(p_conteudo_id INT)`

* **O que faz:** Verifica se um conteúdo específico (`p_conteudo_id`) está ativo e disponível na plataforma.
* **Por que é útil:** Garante que apenas conteúdos válidos e ativos sejam exibidos ou processados, evitando acesso a itens desativados.
* **Por que uma Função:** Retorna um valor booleano simples, perfeito para uso em condições ou para informar rapidamente a disponibilidade em qualquer consulta.

---

## Trigger

### 1. `trg_atualizar_visualizacoes_conteudo` (associado à função `f_atualizar_visualizacoes_conteudo`)

* **O que faz:** Acionado após cada inserção em `acessos`, incrementa o contador de visualizações (`visualizacoes`) do conteúdo relacionado na tabela `conteudos`.
* **Por que é útil:** Garante atualização automática e consistente das métricas de popularidade do conteúdo.
* **Por que um Trigger:** Ideal para automatizar ações no banco de dados em resposta a eventos específicos (INSERT, UPDATE, DELETE), mantendo a lógica encapsulada no nível do banco.

---

## Views

### 1. `view_conteudos_mais_populares`

* **O que faz:** Lista os conteúdos da plataforma, do mais para o menos visualizado, incluindo ID, título, tipo e total de visualizações.
* **Por que é útil:** Simplifica a obtenção rápida de métricas de popularidade para o frontend e relatórios, evitando consultas complexas repetidas.
* **Por que uma View:** Encapsula uma consulta complexa (JOIN e ordenação), criando uma "tabela virtual" que facilita o acesso e a reutilização dos dados.

### 2. `view_usuarios_ativos_por_plano`

* **O que faz:** Exibe informações detalhadas de usuários com assinaturas ativas, associando-os aos seus respectivos planos. Inclui dados do usuário, nome do plano e data de início da assinatura.
* **Por que é útil:** Facilita a consulta de base de assinantes segmentada por plano, útil para análise de clientes e marketing.
* **Por que uma View:** Simplifica o acesso a dados combinados de múltiplas tabelas (`usuarios`, `assinaturas`, `planos`), fornecendo uma visão consolidada e filtrada de usuários ativos.