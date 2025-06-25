
CREATE OR REPLACE PROCEDURE proc_atualizar_status_assinaturas()
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE assinaturas
    SET status = 'expirada'
    WHERE status IN ('ativa', 'pendente')
      AND data_fim IS NOT NULL
      AND data_fim < CURRENT_DATE;

END;
$$;

