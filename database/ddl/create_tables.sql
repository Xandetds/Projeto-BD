CREATE DATABASE sistema_streaming;
\c sistema_streaming;

CREATE TABLE usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL
);

CREATE TABLE tipos_conteudo (
    id_tipo SERIAL PRIMARY KEY,
    nome_tipo VARCHAR(50) NOT NULL,
    descricao VARCHAR(255)
);

CREATE TABLE conteudos (
    id_conteudo SERIAL PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descricao TEXT,
    duracao_min INT NOT NULL,
    data_lancamento DATE,
    id_tipo INT REFERENCES tipos_conteudo(id_tipo),
    visualizacoes INT DEFAULT 0 
);

CREATE TABLE acessos (
    id_acesso SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES usuarios(id_usuario),
    id_conteudo INT REFERENCES conteudos(id_conteudo),
    data_acesso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tempo_assistido_min INT
);

CREATE TABLE planos (
    id_plano SERIAL PRIMARY KEY,
    nome_plano VARCHAR(50) NOT NULL,
    preco_mensal DECIMAL(6,2) NOT NULL,
    limite_perfils INT,
    qualidade VARCHAR(20) -- Ex: HD, FullHD, 4K
);

CREATE TABLE assinaturas (
    id_assinatura SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES usuarios(id_usuario),
    id_plano INT REFERENCES planos(id_plano),
    data_inicio DATE NOT NULL,
    status VARCHAR(10) CHECK (status IN ('ativa', 'cancelada', 'pendente')) DEFAULT 'ativa'
);

CREATE TABLE avaliacoes (
    id_feedback SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES usuarios(id_usuario),
    id_conteudo INT REFERENCES conteudos(id_conteudo),
    nota SMALLINT CHECK (nota >= 1 AND nota <= 5),
    comentario varchar(1000),
    data_avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE favoritos (
    id_favorito SERIAL PRIMARY KEY,
    id_usuario INT REFERENCES usuarios(id_usuario),
    id_conteudo INT REFERENCES conteudos(id_conteudo),
    UNIQUE (id_usuario, id_conteudo) 
);

-- Índices para Otimização de Consultas foram colocados aqui para ao criar o banco, os índices já sejam criados.

-- Índice para busca rápida de usuários por email
CREATE INDEX idx_usuarios_email ON usuarios (email);

-- Índices em Chaves Estrangeiras para otimizar JOINs
CREATE INDEX idx_acessos_usuario_id ON acessos (id_usuario);
CREATE INDEX idx_acessos_conteudo_id ON acessos (id_conteudo);

CREATE INDEX idx_assinaturas_usuario_id ON assinaturas (id_usuario);
CREATE INDEX idx_assinaturas_plano_id ON assinaturas (id_plano);

CREATE INDEX idx_avaliacoes_usuario_id ON avaliacoes (id_usuario);
CREATE INDEX idx_avaliacoes_conteudo_id ON avaliacoes (id_conteudo);

CREATE INDEX idx_favoritos_usuario_id ON favoritos (id_usuario);
CREATE INDEX idx_favoritos_conteudo_id ON favoritos (id_conteudo);

CREATE INDEX idx_conteudos_id_tipo ON conteudos (id_tipo);

-- Outros índices úteis (ex: para buscas em títulos, ou ordenação)
-- CREATE INDEX idx_conteudos_titulo ON conteudos (titulo);
-- CREATE INDEX idx_conteudos_visualizacoes ON conteudos (visualizacoes DESC);