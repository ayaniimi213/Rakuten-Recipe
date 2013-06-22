-- Table: recipe_all

-- DROP TABLE recipe_all;

CREATE TABLE recipe_all
(
  "recipeID" integer NOT NULL,
  "userID" integer,
  "Lcategory" text,
  "Mcategory" text,
  "Scategory" text,
  "recipeTitle" text,
  "recipeTrigger" text,
  "recipeIntro" text,
  "recipePictureName" text,
  "recipeName" text,
  tag1 text,
  tag2 text,
  tag3 text,
  tag4 text,
  "pointInfo" text,
  "cookTimeID" text,
  "anyTimeID" text,
  "costID" text,
  "HowManyPeopleID" text,
  "recipeDate" text
)
WITH (
  OIDS=FALSE
);
ALTER TABLE recipe_all
  OWNER TO postgres;



-- Table: recipe_material

-- DROP TABLE recipe_material;

CREATE TABLE recipe_material
(
  "recipeID" integer,
  "materialName" text,
  volume text
)
WITH (
  OIDS=FALSE
);
ALTER TABLE recipe_material
  OWNER TO postgres;



-- Table: material_gram 

-- DROP TABLE material_gram; 

CREATE TABLE material_gram 
( 
 recipeid integer, 
 materialname text, 
 volume text, 
 gram double precision 
) 
WITH ( 
 OIDS=FALSE 
); 
ALTER TABLE material_gram 
 OWNER TO postgres; 

-- Table: recipe_selected

-- DROP TABLE recipe_selected;

CREATE TABLE recipe_selected
(
  "recipeID" integer NOT NULL,
  "recipeTitle" text,
  "materialName" text,
  "foodID" integer,
  "Lcategory" text,
  "Mcategory" text
)
WITH (
  OIDS=FALSE
);
ALTER TABLE recipe_selected
  OWNER TO postgres;


copy recipe_all from 'recipe_all_20120705_normalized.txt';
copy recipe_all from '234685.txt';
copy recipe_all from '280174.txt';
copy recipe_material from 'recipe_material_20120705_normalized.txt';
copy recipe_selected from 'rakuten100_6-20.csv' WITH CSV;

copy material_gram from 'rakuten_gram.txt';

CREATE INDEX recipe_idx on recipe_all("recipeID");
CREATE INDEX material_idx on recipe_material("recipeID");
CREATE INDEX material_idx2 on recipe_material("materialName");
CREATE INDEX material_gram_idx on recipe_material_gram("recipeID");
CREATE INDEX material_gram_idx2 on recipe_material_gram("materialName");

VACUUM VERBOSE ANALYZE;
