# Justificativas dos Objetos Avançados de Banco de Dados

Este documento detalha a finalidade e a justificativa para a escolha e implementação de Functions/Procedures, Trigger, Views e Índices neste projeto de banco de dados para sistema de streaming.

---

## Functions/Procedures

### 1. `func_tempo_assistido(p_usuario_id INT)`

* **O que faz:** Calcula o tempo total (em minutos) que um usuário específico (`p_usuario_id`) assistiu a conteúdos na plataforma, agregando dados da tabela `acessos`.
* **Por que é útil:** Fornece rapidamente uma métrica de engajamento do usuário para relatórios ou perfis, simplificando consultas.
* **Por que uma Função:** Retorna um único valor, ideal para uso direto em consultas `SELECT` e expressões SQL, otimizando a reutilização de código.