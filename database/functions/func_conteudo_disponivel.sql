
CREATE OR REPLACE FUNCTION func_conteudo_disponivel(
    p_conteudo_id INT
)
RETURNS BOOLEAN
LANGUAGE plpgsql
AS $$
DECLARE
    is_active BOOLEAN;
BEGIN
    SELECT ativo
    INTO is_active
    FROM conteudos
    WHERE conteudo_id = p_conteudo_id;

    IF NOT FOUND OR is_active IS FALSE THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
END;
$$;

