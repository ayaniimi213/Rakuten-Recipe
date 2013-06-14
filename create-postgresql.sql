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



-- Table: recipe_material_gram

-- DROP TABLE recipe_material_gram;

CREATE TABLE recipe_material_gram
(
  "recipeID" integer,
  "materialName" text,
  volume text,
  gram integer
)
WITH (
  OIDS=FALSE
);
ALTER TABLE recipe_material_gram
  OWNER TO postgres;



copy recipe_all from 'recipe_all_20120705_normalized.txt';
copy recipe_all from '234685.txt';
copy recipe_all from '280174.txt';
copy recipe_material from 'recipe_material_20120705_normalized.txt';

CREATE INDEX recipe_idx on recipe_all("recipeID");
CREATE INDEX material_idx on recipe_material("recipeID");
CREATE INDEX material_idx2 on recipe_material("materialName");
CREATE INDEX material_gram_idx on recipe_material_gram("recipeID");
CREATE INDEX material_gram_idx2 on recipe_material_gram("materialName");

VACUUM VERBOSE ANALYZE;

