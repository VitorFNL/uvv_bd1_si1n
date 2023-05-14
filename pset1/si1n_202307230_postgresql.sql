-- Deletando o banco de dados se ele já existir

DROP DATABASE IF EXISTS lojas_uvv;

-- Deletando o usuario se ele já existir

DROP user IF EXISTS vitor;

-- Criando usuário

CREATE user vitor WITH
  SUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  ENCRYPTED PASSWORD '123'
 ;


-- Criando o banco de dados

CREATE DATABASE lojas_uvv WITH
	OWNER      = vitor
	TEMPLATE   = template0
	ENCODING   = 'utf8'
	LC_COLLATE = 'pt_BR.UTF-8'
    LC_CTYPE   = 'pt_BR.UTF-8'
;

-- Comentando o banco de dados lojas_uvv

COMMENT ON DATABASE lojas_uvv IS 'Esse banco de dados conterá os dados referentes à franquia hipotética lojas uvv';

-- Trocando para o banco de dados lojas_uvv com o usuário vitor

\c lojas_uvv vitor

-- Criando esquema

CREATE SCHEMA lojas_uvv_schema AUTHORIZATION vitor;

-- Setando o schema lojas_uvv_schema como padrão

SET search_path TO lojas_uvv_schema, public;



-- Criando as tabelas



-- TABELA PRODUTOS

-- Criando a sequência da tabela produtos

CREATE SEQUENCE lojas_uvv_schema.Produtos__produto_id__seq;

-- Criando a tabela produtos

CREATE TABLE lojas_uvv_schema.Produtos (
                produto_id                NUMERIC(38)  NOT NULL DEFAULT nextval('lojas_uvv_schema.Produtos__produto_id__seq'),
                nome                      VARCHAR(255) NOT NULL,
                preco_unitario            NUMERIC(10,2),
                detalhes                  BYTEA,
                imagem                    BYTEA,
                imagem_mime_type          VARCHAR(512),
                imagem_arquivo            VARCHAR(512),
                imagem_charset            VARCHAR(512),
                imagem_ultima_atualizacao DATE
);

-- Comentando a tabela produtos

COMMENT ON TABLE  lojas_uvv_schema.Produtos IS                            'Conterá os dados referentes aos produtos ofertados pelas lojas.';
COMMENT ON COLUMN lojas_uvv_schema.Produtos.produto_id IS                 'Identificador único dos produtos (PK dessa tabela). Os dados dessa linha serão preechidos pelo SGBD.';
COMMENT ON COLUMN lojas_uvv_schema.Produtos.nome IS                       'Receberá o nome do produto.';
COMMENT ON COLUMN lojas_uvv_schema.Produtos.preco_unitario IS             'Receberá o preço unitário do produto.';
COMMENT ON COLUMN lojas_uvv_schema.Produtos.detalhes IS                   'Receberá os detalhes do produto.';
COMMENT ON COLUMN lojas_uvv_schema.Produtos.imagem IS                     'Receberá o arquivo de imagem do produto.';
COMMENT ON COLUMN lojas_uvv_schema.Produtos.imagem_mime_type IS           'Receberá o mime type do arquivo da imagem.';
COMMENT ON COLUMN lojas_uvv_schema.Produtos.imagem_arquivo IS             'Receberá o código do arquivo de imagem do produto.';
COMMENT ON COLUMN lojas_uvv_schema.Produtos.imagem_charset IS             'Receberá o charset do arquivo de imagem do produto.';
COMMENT ON COLUMN lojas_uvv_schema.Produtos.imagem_ultima_atualizacao IS  'Receberá a data da última atualização da imagem do produto.';

-- Setando a sequência da tabela produtos

ALTER SEQUENCE lojas_uvv_schema.Produtos__produto_id__seq OWNED BY lojas_uvv_schema.Produtos.produto_id;

-- Criando a PK da tabela produtos

ALTER TABLE    lojas_uvv_schema.Produtos
ADD CONSTRAINT pk_produtos
PRIMARY KEY    (produto_id);


--------------------------------------


-- TABELA LOJAS

-- Criando a sequência da tabela lojas

CREATE SEQUENCE lojas_uvv_schema.Lojas__loja_id__seq;

-- Criando a tabela lojas

CREATE TABLE lojas_uvv_schema.Lojas (
                loja_id                 NUMERIC(38)  NOT NULL DEFAULT nextval('lojas_uvv_schema.Lojas__loja_id__seq'),
                nome                    VARCHAR(255) NOT NULL,
                endereco_web            VARCHAR(100),
                endereco_fisico         VARCHAR(512),
                latitude                NUMERIC,
                longitude               NUMERIC,
                logo                    BYTEA,
                logo_mime_type          VARCHAR(512),
                logo_arquivo            VARCHAR(512),
                logo_charset            VARCHAR(512),
                logo_ultima_atualizacao DATE
);

-- Comentando a tabela lojas

COMMENT ON TABLE  lojas_uvv_schema.Lojas IS                          'Conterá os dados referentes às lojas.';
COMMENT ON COLUMN lojas_uvv_schema.Lojas.loja_id IS                  'Identificador único das lojas (PK dessa tabela). Os dados dessa linha serão preechidos pelo SGBD.';
COMMENT ON COLUMN lojas_uvv_schema.Lojas.nome IS                     'Receberá o nome da loja.';
COMMENT ON COLUMN lojas_uvv_schema.Lojas.endereco_web IS             'Receberá o link do site da loja.';
COMMENT ON COLUMN lojas_uvv_schema.Lojas.endereco_fisico IS          'Receberá o endereço físico da loja.';
COMMENT ON COLUMN lojas_uvv_schema.Lojas.latitude IS                 'Receberá a latitude da loja.';
COMMENT ON COLUMN lojas_uvv_schema.Lojas.longitude IS                'Receberá a longitude da loja.';
COMMENT ON COLUMN lojas_uvv_schema.Lojas.logo IS                     'Receberá o arquivo do logo da loja.';
COMMENT ON COLUMN lojas_uvv_schema.Lojas.logo_mime_type IS           'Receberá o mime type do arquivo do logo.';
COMMENT ON COLUMN lojas_uvv_schema.Lojas.logo_arquivo IS             'Receberá o código do arquivo do logo.';
COMMENT ON COLUMN lojas_uvv_schema.Lojas.logo_charset IS             'Receberá o charset do logo.';
COMMENT ON COLUMN lojas_uvv_schema.Lojas.logo_ultima_atualizacao IS  'Receberá a data da última mudança no logo da loja.';

-- Setando a sequência da tabela lojas

ALTER SEQUENCE lojas_uvv_schema.Lojas__loja_id__seq OWNED BY lojas_uvv_schema.Lojas.loja_id;

-- Criando a PK da tabela lojas

ALTER TABLE    lojas_uvv_schema.Lojas
ADD CONSTRAINT pk_lojas
PRIMARY KEY    (loja_id);

-- Criando a check constraint da tabela lojas

ALTER TABLE    lojas_uvv_schema.Lojas
ADD CONSTRAINT cc_lojas__endereco_web
CHECK          (endereco_web LIKE 'www.%');


--------------------------------------


-- TABELA ESTOQUE

-- Criando a sequência da tabela Estoque

CREATE SEQUENCE lojas_uvv_schema.Estoque__estoque_id__seq;

-- Criando a tabela Estoque

CREATE TABLE lojas_uvv_schema.Estoque (
                estoque_id NUMERIC(38) NOT NULL DEFAULT nextval('lojas_uvv_schema.Estoque__estoque_id__seq'),
                loja_id    NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL
);

-- Comentando a tabela Estoque

COMMENT ON TABLE  lojas_uvv_schema.Estoque IS             'Conterá os dados referentes ao Estoque de produtos.';
COMMENT ON COLUMN lojas_uvv_schema.Estoque.estoque_id IS  'Identificador único dos Estoque (PK dessa tabela). Os dados dessa linha serão preechidos pelo SGBD.';
COMMENT ON COLUMN lojas_uvv_schema.Estoque.loja_id IS     'Identificador único das lojas (FK dessa tabela).';
COMMENT ON COLUMN lojas_uvv_schema.Estoque.produto_id IS  'Identificador único dos produtos (FK dessa tabela).';
COMMENT ON COLUMN lojas_uvv_schema.Estoque.quantidade IS  'Receberá a quantidade de produtos ainda em Estoque.';

-- Setando a sequência da tabela Estoque

ALTER SEQUENCE lojas_uvv_schema.Estoque__estoque_id__seq OWNED BY lojas_uvv_schema.Estoque.estoque_id;

-- Criando a PK da tabela Estoque

ALTER TABLE    lojas_uvv_schema.Estoque
ADD CONSTRAINT pk_estoque
PRIMARY KEY    (estoque_id);

-- Criando as FK's da tabela Estoque

ALTER TABLE    lojas_uvv_schema.Estoque
ADD CONSTRAINT fk_lojas_estoque
FOREIGN KEY    (loja_id)
REFERENCES     lojas_uvv_schema.Lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE    lojas_uvv_schema.Estoque
ADD CONSTRAINT fk_produtos_estoque
FOREIGN KEY    (produto_id)
REFERENCES     lojas_uvv_schema.Produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


--------------------------------------


-- TABELA CLIENTES

-- Criando a sequência da tabela clientes

CREATE SEQUENCE lojas_uvv_schema.Clientes__cliente_id__seq;

-- Criando a tabela clientes

CREATE TABLE lojas_uvv_schema.Clientes (
                cliente_id NUMERIC(38)  NOT NULL DEFAULT nextval('lojas_uvv_schema.Clientes__cliente_id__seq'),
                email      VARCHAR(255) NOT NULL,
                nome       VARCHAR(255) NOT NULL,
                telefone1  VARCHAR(20),
                telefone2  VARCHAR(20),
                telefone3  VARCHAR(20)
);

-- Comentando a  tabela clientes

COMMENT ON TABLE  lojas_uvv_schema.Clientes IS             'Conterá os dados referentes aos clientes.';
COMMENT ON COLUMN lojas_uvv_schema.Clientes.cliente_id IS  'Identificador único dos clientes (PK dessa tabela). Os dados dessa linha serão preechidos pelo SGBD.';
COMMENT ON COLUMN lojas_uvv_schema.Clientes.email IS       'Receberá um email do cliente.';
COMMENT ON COLUMN lojas_uvv_schema.Clientes.nome IS        'Receberá o nome completo do cliente.';
COMMENT ON COLUMN lojas_uvv_schema.Clientes.telefone1 IS   'Receberá um número de telefone do cliente.';
COMMENT ON COLUMN lojas_uvv_schema.Clientes.telefone2 IS   'Receberá outro número de telefone do cliente.';
COMMENT ON COLUMN lojas_uvv_schema.Clientes.telefone3 IS   'Receberá um terceiro número telefone do cliente';

-- Setando a sequência da tabela clientes

ALTER SEQUENCE lojas_uvv_schema.Clientes__cliente_id__seq OWNED BY lojas_uvv_schema.Clientes.cliente_id;

-- Criando a PK da tabela clientes

ALTER TABLE    lojas_uvv_schema.Clientes
ADD CONSTRAINT pk_clientes
PRIMARY KEY    (cliente_id);

-- Criando a check constraint da tabela clientes

ALTER TABLE    lojas_uvv_schema.Clientes
ADD CONSTRAINT cc_clientes_email
CHECK          (email LIKE '%@%');


--------------------------------------


-- TABELA ENVIOS

-- Criando as sequências da tabela envios

CREATE SEQUENCE lojas_uvv_schema.Envios__envio_id__seq;

CREATE SEQUENCE lojas_uvv_schema.Envios__loja_id__seq;

CREATE SEQUENCE lojas_uvv_schema.Envios__cliente_id__seq;

-- Criando a tabela envios

CREATE TABLE lojas_uvv_schema.Envios (
                envio_id         NUMERIC(38)  NOT NULL DEFAULT nextval('lojas_uvv_schema.Envios__envio_id__seq'),
                loja_id          NUMERIC(38)  NOT NULL DEFAULT nextval('lojas_uvv_schema.Envios__loja_id__seq'),
                cliente_id       NUMERIC(38)  NOT NULL DEFAULT nextval('lojas_uvv_schema.Envios__cliente_id__seq'),
                endereco_entrega VARCHAR(512) NOT NULL,
                status           VARCHAR(15)  NOT NULL
);

-- Comentando a tabela envios

COMMENT ON TABLE  lojas_uvv_schema.Envios IS                   'Conterá os dados referentes às entregas dos produtos.';
COMMENT ON COLUMN lojas_uvv_schema.Envios.envio_id IS          'Identificador único das entregas (PK dessa tabela). Os dados dessa linha serão preechidos pelo SGBD.';
COMMENT ON COLUMN lojas_uvv_schema.Envios.loja_id IS           'Identificador único das lojas (FK dessa tabela).';
COMMENT ON COLUMN lojas_uvv_schema.Envios.cliente_id IS        'Identificador único dos clientes (FK dessa tabela).';
COMMENT ON COLUMN lojas_uvv_schema.Envios.endereco_entrega IS  'Receberá o endereço em que o pedido será entregue.';
COMMENT ON COLUMN lojas_uvv_schema.Envios.status IS            'Receberá o status da entrega ex:"concluída".';

-- Setando as sequências da tabela envios

ALTER SEQUENCE lojas_uvv_schema.Envios__envio_id__seq   OWNED BY lojas_uvv_schema.Envios.envio_id;

ALTER SEQUENCE lojas_uvv_schema.Envios__loja_id__seq    OWNED BY lojas_uvv_schema.Envios.loja_id;

ALTER SEQUENCE lojas_uvv_schema.Envios__cliente_id__seq OWNED BY lojas_uvv_schema.Envios.cliente_id;

-- Criando a PK da tabela envios

ALTER TABLE    lojas_uvv_schema.Envios
ADD CONSTRAINT pk_envios
PRIMARY KEY    (envio_id);

-- Criando as FK's da tabela envios

ALTER TABLE    lojas_uvv_schema.Envios
ADD CONSTRAINT fk_lojas_envios
FOREIGN KEY    (loja_id)
REFERENCES     lojas_uvv_schema.Lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE    lojas_uvv_schema.Envios
ADD CONSTRAINT fk_clientes_envios
FOREIGN KEY    (cliente_id)
REFERENCES     lojas_uvv_schema.Clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


--------------------------------------


-- TABELA PEDIDOS

-- Criando a sequência da tabela pedidos

CREATE SEQUENCE lojas_uvv_schema.Pedidos__pedido_id__seq;

-- Criando a tabela pedidos

CREATE TABLE lojas_uvv_schema.Pedidos (
                pedido_id  NUMERIC(38) NOT NULL DEFAULT nextval('lojas_uvv_schema.Pedidos__pedido_id__seq'),
                data_hora  TIMESTAMP   NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status     VARCHAR(15) NOT NULL,
                loja_id    NUMERIC(38) NOT NULL
);

-- Comentando a tabela pedidos

COMMENT ON TABLE  lojas_uvv_schema.Pedidos IS            'Conterá os dados referentes às compras.';
COMMENT ON COLUMN lojas_uvv_schema.Pedidos.pedido_id IS  'Identificador único dos pedidos(PK dessa tabela). Os dados dessa linha serão preechidos pelo SGBD.';
COMMENT ON COLUMN lojas_uvv_schema.Pedidos.data_hora IS  'Receberá a data e a hora em que o pedido foi feito. Os dados dessa linha serão preenchidos pelo SGBD';
COMMENT ON COLUMN lojas_uvv_schema.Pedidos.cliente_id IS 'Identificador único do cliente (FK dessa tabela).';
COMMENT ON COLUMN lojas_uvv_schema.Pedidos.status IS     'Receberá o status do pedido ex:"pago"';
COMMENT ON COLUMN lojas_uvv_schema.Pedidos.loja_id IS    'Identificador único das lojas (FK dessa tabela).';

-- Setando a sequência da tabela 

ALTER SEQUENCE lojas_uvv_schema.Pedidos__pedido_id__seq OWNED BY lojas_uvv_schema.Pedidos.pedido_id;

-- Criando a PK da tabela pedidos

ALTER TABLE    lojas_uvv_schema.Pedidos
ADD CONSTRAINT pk_pedidos
PRIMARY KEY    (pedido_id);

-- Criando as FK's da tabela pedidos

ALTER TABLE    lojas_uvv_schema.Pedidos
ADD CONSTRAINT fk_clientes_pedidos
FOREIGN KEY    (cliente_id)
REFERENCES     lojas_uvv_schema.Clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE    lojas_uvv_schema.Pedidos
ADD CONSTRAINT fk_lojas_pedidos
FOREIGN KEY    (loja_id)
REFERENCES     lojas_uvv_schema.Lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


--------------------------------------


-- TABELA PEDIDOS_ITENS

-- Crindo as sequências da tabela pedidos_itens

CREATE SEQUENCE lojas_uvv_schema.Pedidos_itens__pedido_id__seq;

CREATE SEQUENCE lojas_uvv_schema.Pedidos_itens__produto_id__seq;

-- Criando a tabela pedidos_itens

CREATE TABLE lojas_uvv_schema.Pedidos_itens (
                pedido_id       NUMERIC(38)   NOT NULL,
                produto_id      NUMERIC(38)   NOT NULL,
                numero_da_linha NUMERIC(38)   NOT NULL,
                preco_unitario  NUMERIC(10,2) NOT NULL,
                quantidade      NUMERIC(38)   NOT NULL,
                envio_id        NUMERIC(38)   NOT NULL
);

-- Comentando a tabela pedidos_itens

COMMENT ON TABLE  lojas_uvv_schema.Pedidos_itens IS                 'Conterá os dados referentes aos produtos do pedido.';
COMMENT ON COLUMN lojas_uvv_schema.Pedidos_itens.pedido_id IS       'Identificador único dos pedidos (PFK dessa tabela).';
COMMENT ON COLUMN lojas_uvv_schema.Pedidos_itens.produto_id IS      'Identificador único dos produtos (PFK dessa tabela).';
COMMENT ON COLUMN lojas_uvv_schema.Pedidos_itens.numero_da_linha IS 'Receberá o número da linha do produto pedido.';
COMMENT ON COLUMN lojas_uvv_schema.Pedidos_itens.preco_unitario IS  'Receberá o preço unitário de cada produto.';
COMMENT ON COLUMN lojas_uvv_schema.Pedidos_itens.quantidade IS      'Receberá a quantidade de produtos solicitados no pedido.';
COMMENT ON COLUMN lojas_uvv_schema.Pedidos_itens.envio_id IS        'Identificador único das entregas (FK dessa tabela).';

-- Setando as sequências da tabela pedidos_itens

ALTER SEQUENCE lojas_uvv_schema.Pedidos_itens__pedido_id__seq  OWNED BY lojas_uvv_schema.Pedidos_itens.pedido_id;

ALTER SEQUENCE lojas_uvv_schema.Pedidos_itens__produto_id__seq OWNED BY lojas_uvv_schema.Pedidos_itens.produto_id;

-- Criando as PK's da tabela pedidos_itens

ALTER TABLE    lojas_uvv_schema.Pedidos_itens
ADD CONSTRAINT pk_pedidos_itens
PRIMARY KEY    (pedido_id,produto_id);

-- Criando as FK's da tabela pedidos_itens

ALTER TABLE    lojas_uvv_schema.Pedidos_itens
ADD CONSTRAINT fk_pedidos__pedidos_itens
FOREIGN KEY    (pedido_id)
REFERENCES     lojas_uvv_schema.Pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE    lojas_uvv_schema.Pedidos_itens
ADD CONSTRAINT fk_produtos__pedidos_itens
FOREIGN KEY    (produto_id)
REFERENCES     lojas_uvv_schema.Produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE    lojas_uvv_schema.Pedidos_itens
ADD CONSTRAINT fk_envios__pedidos_itens
FOREIGN KEY    (envio_id)
REFERENCES     lojas_uvv_schema.Envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


--------------------------------------

