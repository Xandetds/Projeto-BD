
CREATE OR REPLACE VIEW view_media_avaliacoes_conteudo AS
SELECT
    c.id_conteudo,
    c.titulo,
    tc.nome_tipo AS tipo_de_conteudo,
    COALESCE(ROUND(AVG(a.nota), 2), 0) AS media_avaliacao,
    COUNT(a.id_feedback) AS total_avaliacoes
FROM
    public.conteudos c
JOIN
    public.tipos_conteudo tc ON c.id_tipo = tc.id_tipo
LEFT JOIN
    public.avaliacoes a ON c.id_conteudo = a.id_conteudo
GROUP BY
    c.id_conteudo, c.titulo, tc.nome_tipo
ORDER BY
    media_avaliacao DESC, total_avaliacoes DESC;

