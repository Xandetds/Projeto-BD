-- View: view_media_avaliacoes_conteudo
-- Propósito: Calcula a média das notas de avaliação para cada conteúdo.

CREATE OR REPLACE VIEW view_media_avaliacoes_conteudo AS
SELECT
    c.conteudo_id,
    c.titulo,
    tc.nome_tipo AS tipo_de_conteudo,
    COALESCE(ROUND(AVG(a.nota), 2), 0) AS media_avaliacao, -- Média arredondada com 2 casas decimais
    COUNT(a.avaliacao_id) AS total_avaliacoes
FROM
    conteudos c
JOIN
    tipos_conteudo tc ON c.id_tipo = tc.id_tipo
LEFT JOIN -- Usamos LEFT JOIN para incluir conteúdos sem avaliações
    avaliacoes a ON c.conteudo_id = a.id_conteudo
GROUP BY
    c.conteudo_id, c.titulo, tc.nome_tipo
ORDER BY
    media_avaliacao DESC, total_avaliacoes DESC;

-- Exemplo de uso: SELECT * FROM view_media_avaliacoes_conteudo;