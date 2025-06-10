-- Procedimento: proc_atualizar_status_assinaturas
-- Atualiza o status de assinaturas expiradas para 'expirada'.

CREATE OR REPLACE PROCEDURE proc_atualizar_status_assinaturas()
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE assinaturas
    SET status = 'expirada'
    WHERE status IN ('ativa', 'pendente')
      AND data_fim IS NOT NULL
      AND data_fim < CURRENT_DATE;

    -- Opcional: RAISE NOTICE 'Status de assinaturas atualizado.';
END;
$$;

-- Exemplo de uso: CALL proc_atualizar_status_assinaturas();
