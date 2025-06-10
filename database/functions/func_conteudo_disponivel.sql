-- Função: func_conteudo_disponivel
-- Propósito: Verifica se um conteúdo específico está ativo e disponível na plataforma.

CREATE OR REPLACE FUNCTION func_conteudo_disponivel(
    p_conteudo_id INT -- Parâmetro: O ID do conteúdo a ser verificado
)
RETURNS BOOLEAN -- Retorna TRUE se o conteúdo estiver ativo, FALSE caso contrário
LANGUAGE plpgsql
AS $$
DECLARE
    is_active BOOLEAN; -- Variável para armazenar o resultado
BEGIN
    -- Verifica se o conteúdo existe e está marcado como ativo
    SELECT ativo
    INTO is_active
    FROM conteudos
    WHERE conteudo_id = p_conteudo_id;

    -- Se não encontrar o conteúdo ou se não estiver ativo, retorna FALSE
    IF NOT FOUND OR is_active IS FALSE THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
END;
$$;

-- Exemplo de como usar a função (pode testar no seu cliente SQL):
-- SELECT func_conteudo_disponivel(1); -- Substitua '1' pelo ID de um conteúdo existente
-- SELECT func_conteudo_disponivel(999); -- Testar com um ID que não existe