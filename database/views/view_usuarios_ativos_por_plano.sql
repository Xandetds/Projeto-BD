
CREATE OR REPLACE VIEW view_usuarios_ativos_por_plano AS
SELECT
    u.id_usuario,
    u.nome AS nome_usuario,
    u.email,
    p.nome_plano,
    p.preco_mensal AS valor_plano,
    a.data_inicio AS data_inicio_assinatura
FROM
    public.usuarios u
JOIN
    public.assinaturas a ON u.id_usuario = a.id_usuario
JOIN
    public.planos p ON a.id_plano = p.id_plano
WHERE
    a.status = 'ativa';

