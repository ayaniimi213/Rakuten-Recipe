create table recipe (recipeID, userID, Category, SubCategory, SubSubCategory, title, motive, introduction, imageFile, menu, tag1, tag2, tag3, tag4, onepointInfomation, cookingTimeID, sceneID, costID, numberofPeople, releaseDate );
create table material (recipeID, materialName, amount );
create table process (recipeID, CookingOrder, CookingText);
create table tsukurepo (recipeID, userID, RecommendedComment, OwnerComment, CreationDate);

.separator \t
.import 'recipe_all_20120705_normalized.txt' recipe
.import '234685.txt' recipe
.import '280174.txt' recipe
CREATE INDEX recipe_idx on recipe(recipeID);
.import 'recipe_material_20120705_normalized.txt' material 
CREATE INDEX material_idx on material(recipeID);
CREATE INDEX material_idx2 on material(materialName);
.import 'recipe_process_20120705.txt' process
CREATE INDEX process_idx on process(recipeID);
.import 'recipe_tsukurepo_20120705_normalized.txt' tsukurepo
CREATE INDEX tsukurepo_idx on tsukurepo(recipeID);

VACUUM;
PRAGMA page_count;
# 200578
PRAGMA cache_size; 
PRAGMA cache_size = 201000;
