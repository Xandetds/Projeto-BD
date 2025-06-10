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