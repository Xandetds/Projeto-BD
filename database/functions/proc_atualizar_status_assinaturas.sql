-- Procedimento: proc_atualizar_status_assinaturas
-- Propósito: Atualiza o status de assinaturas expiradas para 'expirada'.

CREATE OR REPLACE PROCEDURE proc_atualizar_status_assinaturas()
LANGUAGE plpgsql -- Linguagem procedural do PostgreSQL
AS $$
BEGIN
    -- Atualiza o status para 'expirada' para assinaturas
    -- cuja data_fim já passou e que ainda estão 'ativa' ou 'pendente'.
    UPDATE assinaturas
    SET status = 'expirada'
    WHERE status IN ('ativa', 'pendente')
      AND data_fim IS NOT NULL
      AND data_fim < CURRENT_DATE;

    -- Opcional: Adicionar LOG ou mensagem de sucesso
    -- RAISE NOTICE 'Status de assinaturas atualizado.';
END;
$$;

-- Exemplo de como chamar a procedure (pode testar no seu cliente SQL):
-- CALL proc_atualizar_status_assinaturas();
