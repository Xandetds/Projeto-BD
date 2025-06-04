INSERT INTO usuarios (nome, email, senha, data_nascimento) VALUES
('Ana Costa', 'ana.costa@email.com', 'senha123', '1995-06-15'),
('Bruno Lima', 'bruno.lima@email.com', '123abc', '1990-08-22'),
('Carla Souza', 'carla.souza@email.com', 'carla2024', '1992-03-10'),
('Daniel Rocha', 'daniel.rocha@email.com', 'senha321', '1988-12-01'),
('Eduarda Ramos', 'eduarda.r@email.com', 'eduramos', '2000-09-05'),
('Felipe Moreira', 'felipe.moreira@email.com', 'felipe99', '1999-07-20'),
('Gustavo Neves', 'gustavo.neves@email.com', 'gustavopass', '1996-04-11'),
('Helena Castro', 'helena.castro@email.com', 'castrohelena', '1993-10-30'),
('Igor Martins', 'igor.martins@email.com', 'martins123', '2001-01-25'),
('Juliana Ferreira', 'juliana.f@email.com', 'julipass', '1998-11-13');

INSERT INTO tipos_conteudo (nome_tipo, descricao) VALUES
('Filme', 'Conteúdo audiovisual de longa duração'),
('Série', 'Conteúdo dividido em episódios'),
('Documentário', 'Conteúdo informativo e factual'),
('Animação', 'Conteúdo animado para todas as idades'),
('Show', 'Gravação de apresentações ao vivo'),
('Reality Show', 'Programa de realidade com pessoas reais'),
('Esporte', 'Transmissão de eventos esportivos'),
('Curta-metragem', 'Filme de curta duração'),
('Infantil', 'Conteúdo voltado para crianças'),
('Clássico', 'Obras audiovisuais históricas ou marcantes');

INSERT INTO conteudos (titulo, descricao, duracao_min, data_lancamento, id_tipo) VALUES
('O Segredo da Floresta', 'Um suspense envolvente em uma floresta misteriosa.', 120, '2022-05-10', 1),
('Vida Selvagem', 'Documentário sobre os animais da savana africana.', 60, '2021-11-02', 3),
('A Jornada', 'Série sobre um grupo que tenta sobreviver após o apocalipse.', 45, '2023-01-15', 2),
('Show do Rock', 'Gravação do show da banda RockStars.', 90, '2020-09-20', 5),
('Pequenos Heróis', 'Animação sobre crianças com superpoderes.', 80, '2022-07-01', 4),
('Casa em Chamas', 'Reality show de reforma de casas abandonadas.', 50, '2021-08-18', 6),
('Final da Copa', 'Transmissão da final do campeonato mundial.', 120, '2022-12-18', 7),
('A Sombra do Tempo', 'Curta-metragem de ficção científica.', 25, '2023-03-30', 8),
('Contos do Arco-Íris', 'Animação infantil com lições de amizade.', 60, '2020-06-01', 9),
('Clássicos do Cinema', 'Coletânea de trechos de filmes clássicos remasterizados.', 100, '2019-10-10', 10);

INSERT INTO acessos (id_usuario, id_conteudo, data_acesso, tempo_assistido_min) VALUES
(1, 1, '2025-06-01 20:30:00', 90),
(2, 2, '2025-06-02 14:00:00', 60),
(3, 3, '2025-06-03 18:45:00', 45),
(4, 4, '2025-06-01 21:00:00', 85),
(5, 5, '2025-06-02 10:00:00', 80),
(6, 6, '2025-06-03 13:15:00', 50),
(7, 7, '2025-06-01 16:00:00', 120),
(8, 8, '2025-06-02 22:30:00', 25),
(9, 9, '2025-06-03 09:00:00', 60),
(10, 10, '2025-06-01 19:00:00', 100);

INSERT INTO planos (nome_plano, preco_mensal, limite_perfils, qualidade) VALUES
('Básico', 19.90, 1, 'HD'),
('Padrão', 29.90, 2, 'FullHD'),
('Premium', 39.90, 4, '4K'),
('Familiar', 49.90, 5, '4K'),
('Estudante', 14.90, 1, 'HD'),
('Mobile', 9.90, 1, 'SD'),
('Anual Premium', 399.00, 4, '4K'),
('Kids', 12.90, 2, 'HD'),
('Cinema+', 44.90, 3, 'FullHD'),
('Esportes', 34.90, 2, 'FullHD');

INSERT INTO assinaturas (id_usuario, id_plano, data_inicio, status) VALUES
(1, 3, '2024-01-01', 'ativa'),
(2, 2, '2024-03-10', 'ativa'),
(3, 1, '2023-11-20', 'cancelada'),
(4, 5, '2024-06-05', 'ativa'),
(5, 4, '2024-07-01', 'pendente'),
(6, 3, '2024-05-15', 'ativa'),
(7, 6, '2024-09-12', 'cancelada'),
(8, 2, '2023-12-20', 'ativa'),
(9, 7, '2024-02-01', 'ativa'),
(10, 9, '2024-10-25', 'ativa');

INSERT INTO avaliacoes (id_usuario, id_conteudo, nota, comentario) VALUES
(1, 1, 5, 'Excelente filme, adorei!'),
(2, 2, 4, 'Muito bom e educativo.'),
(3, 3, 3, 'Gostei, mas poderia ser mais dinâmico.'),
(4, 4, 5, 'Ótimo show, som perfeito!'),
(5, 5, 4, 'Meus filhos adoraram.'),
(6, 6, 3, 'Interessante, mas repetitivo.'),
(7, 7, 5, 'Amei rever o jogo da copa.'),
(8, 8, 4, 'Curta legal, visual bonito.'),
(9, 9, 5, 'As crianças assistiram várias vezes!'),
(10, 10, 3, 'Bom, mas prefiro filmes novos.');

INSERT INTO favoritos (id_usuario, id_conteudo) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);