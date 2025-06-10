-- Função auxiliar para Trigger: f_atualizar_visualizacoes_conteudo
-- Incrementa o contador de visualizações de um conteúdo.
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

-- Trigger: trg_atualizar_visualizacoes_conteudo
-- Dispara a função f_atualizar_visualizacoes_conteudo após INSERT em acessos.
CREATE TRIGGER trg_atualizar_visualizacoes_conteudo
AFTER INSERT ON acessos
FOR EACH ROW
EXECUTE FUNCTION f_atualizar_visualizacoes_conteudo();

-- IMPORTANTE: Adicione a coluna 'visualizacoes' (INT DEFAULT 0) à tabela 'conteudos' antes de criar o trigger.
-- Exemplo: ALTER TABLE conteudos ADD COLUMN visualizacoes INT DEFAULT 0;
