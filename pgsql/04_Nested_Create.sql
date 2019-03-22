CREATE TABLE nested_category
(
    category_id serial,
    name character varying(20),
    lft integer NULL,
	rgt integer NULL,
	CONSTRAINT nested_category_pkey PRIMARY KEY (category_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

CREATE TABLE product
(
	product_id serial,
    name character varying(40),
    category_id integer NOT NULL,
	CONSTRAINT product_pkey PRIMARY KEY (product_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

INSERT INTO nested_category(name, lft, rgt) VALUES('ELECTRONICS',1,20),('TELEVISIONS',2,9),('TUBE',3,4),
 ('LCD',5,6),('PLASMA',7,8),('PORTABLE ELECTRONICS',10,19),('MP3 PLAYERS',11,14),('FLASH',12,13),
 ('CD PLAYERS',15,16),('2 WAY RADIOS',17,18);

INSERT INTO product(name, category_id) VALUES('20" TV',3),('36" TV',3),
('Super-LCD 42"',4),('Ultra-Plasma 62"',5),('Value Plasma 38"',5),
('Power-MP3 5gb',7),('Super-Player 1gb',8),('Porta CD',9),('CD To go!',9),
('Family Talk 360',10);
