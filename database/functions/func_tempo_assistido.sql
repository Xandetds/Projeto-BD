-- Função: func_tempo_assistido
-- Propósito: Calcula o tempo total de conteúdo assistido por um usuário específico em minutos.

CREATE OR REPLACE FUNCTION func_tempo_assistido(
    p_usuario_id INT -- Parâmetro: O ID do usuário
)
RETURNS INT -- Retorna o tempo total assistido em minutos (INT)
LANGUAGE plpgsql -- Linguagem procedural do PostgreSQL
AS $$
DECLARE
    total_minutos INT; -- Variável para armazenar o resultado
BEGIN
    -- Soma o tempo_assistido_segundos da tabela acessos para o usuário fornecido
    -- e converte para minutos (dividindo por 60)
    SELECT COALESCE(SUM(tempo_assistido_segundos), 0) / 60
    INTO total_minutos
    FROM acessos
    WHERE usuario_id = p_usuario_id;

    RETURN total_minutos; -- Retorna o total de minutos assistidos
END;
$$;

-- Exemplo de como usar a função (pode testar no seu cliente SQL):
-- SELECT func_tempo_assistido(1); -- Substitua '1' pelo ID de um usuário existente
