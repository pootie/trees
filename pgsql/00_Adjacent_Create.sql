CREATE TABLE category
(
    category_id serial,
    name character varying(20),
    parent integer NULL,
	CONSTRAINT category_pkey PRIMARY KEY (category_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

INSERT INTO category(name, parent) VALUES('ELECTRONICS',NULL),('TELEVISIONS',1),('TUBE',2),
        ('LCD',2),('PLASMA',2),('PORTABLE ELECTRONICS',1),('MP3 PLAYERS',6),('FLASH',7),
        ('CD PLAYERS',6),('2 WAY RADIOS',6);