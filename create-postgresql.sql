-- Table: recipe_all

-- DROP TABLE recipe_all;

CREATE TABLE recipe_all
(
  "recipeID" integer,
  "userID" integer,
  "Lcategory" text,
  "Mcategory" text,
  "Scategory" text,
  "recipeTitle" text,
  "recipeKiccake" text,
  "recipeIntro" text,
  "recipePict" text,
  "recipeName" text,
  tag1 text,
  tag2 text,
  tag3 text,
  tag4 text,
  onepoint text,
  "cookTimeID" text,
  "DonnatokiID" text,
  "costID" text,
  people text,
  "recipeYMD" text
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
  material text,
  volume text
)
WITH (
  OIDS=FALSE
);
ALTER TABLE recipe_material
  OWNER TO postgres;


CREATE INDEX recipe_idx on recipe_all("recipeID");
CREATE INDEX material_idx on recipe_material("recipeID");
CREATE INDEX material_idx2 on recipe_material(material);
copy recipe_all from 'recipe_all_20120705_normalized.txt';
copy recipe_all from '234685.txt';
copy recipe_all from '280174.txt';
copy recipe_material from 'recipe_material_20120705_normalized.txt';

VACUUM VERBOSE ANALYZE;

