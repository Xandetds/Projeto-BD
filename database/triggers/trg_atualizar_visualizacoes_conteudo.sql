
CREATE OR REPLACE FUNCTION f_atualizar_visualizacoes_conteudo()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE conteudos
    SET visualizacoes = COALESCE(visualizacoes, 0) + 1
    WHERE conteudo_id = NEW.id_conteudo;

    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_atualizar_visualizacoes_conteudo
AFTER INSERT ON acessos
FOR EACH ROW
EXECUTE FUNCTION f_atualizar_visualizacoes_conteudo();

