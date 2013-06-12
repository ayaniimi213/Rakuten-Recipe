create table recipe (recipeID, userID, Category, SubCategory, SubSubCategory, title, motive, introduction, imageFile, menu, tag1, tag2, tag3, tag4, onepointInfomation, cookingTimeID, sceneID, costID, numberofPeople, releaseDate );
create table material (recipeID, materialName, amount );
create table process (recipeID, CookingOrder, CookingText);
create table tsukurepo (recipeID, userID, RecommendedComment, OwnerComment, CreationDate);

.separator \t
.import 'recipe_all_20120705_normalized.txt' recipe
.import '234685.txt' recipe
.import '280174.txt' recipe
.import 'recipe_material_20120705_normalized.txt' material 
.import 'recipe_process_20120705.txt' process
.import 'recipe_tsukurepo_20120705_normalized.txt' tsukurepo

BEGIN TRANSACTION;
CREATE INDEX recipe_idx on recipe(recipeID);
CREATE INDEX material_idx on material(recipeID);
CREATE INDEX material_idx2 on material(materialName);
CREATE INDEX process_idx on process(recipeID);
CREATE INDEX tsukurepo_idx on tsukurepo(recipeID);
END TRANSACTION;

VACUUM;
PRAGMA page_count;
PRAGMA cache_size; 
PRAGMA default_cache_size = 201000;
PRAGMA temp_store = MEMORY;
