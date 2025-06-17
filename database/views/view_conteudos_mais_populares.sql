-- Propósito: Lista os conteúdos mais populares da plataforma, ordenados pelo número de visualizações.

CREATE OR REPLACE VIEW view_conteudos_mais_populares AS
SELECT
    c.id_conteudo,        
                          
    c.titulo,
    tc.nome_tipo AS tipo_de_conteudo,
    c.data_lancamento,    
    c.duracao_min,        
    c.visualizacoes      
FROM
    public.conteudos c    
JOIN
    public.tipos_conteudo tc ON c.id_tipo = tc.id_tipo 
ORDER BY
    c.visualizacoes DESC, c.titulo ASC;

-- Exemplo de uso: SELECT * FROM view_conteudos_mais_populares;