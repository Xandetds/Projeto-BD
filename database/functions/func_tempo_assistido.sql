CREATE OR REPLACE FUNCTION calcular_tempo_total_assistido_usuario(
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

