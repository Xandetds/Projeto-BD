-- Propósito: Lista usuários com assinaturas ativas, agrupados por plano, incluindo detalhes do plano e do usuário.

CREATE OR REPLACE VIEW view_usuarios_ativos_por_plano AS
SELECT
    u.id_usuario,
    u.nome AS nome_usuario,
    u.email,
    p.nome_plano,
    p.valor AS valor_plano,
    a.data_inicio AS data_inicio_assinatura
FROM
    usuarios u
JOIN
    assinaturas a ON u.id_usuario = a.id_usuario
JOIN
    planos p ON a.id_plano = p.id_plano
WHERE
    a.status = 'ativa'; -- Filtra apenas assinaturas ativas

-- Exemplo de uso: SELECT * FROM view_usuarios_ativos_por_plano;