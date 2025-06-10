-- Função: func_tempo_assistido
-- Retorna o tempo total assistido por um usuário (em minutos).

CREATE OR REPLACE FUNCTION func_tempo_assistido(
    p_usuario_id INT
)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    total_minutos INT;
BEGIN
    SELECT COALESCE(SUM(tempo_assistido_segundos), 0) / 60
    INTO total_minutos
    FROM acessos
    WHERE usuario_id = p_usuario_id;

    RETURN total_minutos;
END;
$$;

-- Exemplo de uso: SELECT func_tempo_assistido(1);
