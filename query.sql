-- SQL例文(SQLite)

-- レシピカテゴリの上位100件
select category, count(*) as count from recipe group by category order by count DESC limit 100;

-- レシピ登録ユーザの上位20位
select userID, count(*) as count from recipe group by userID order by count DESC limit 20;
-- あるユーザの登録レシピカテゴリ
select category, count(*) as count from recipe where userID = '1580000101' group by category order by count DESC limit 100;
select category, count(*) as count from recipe where userID = '1990000160' group by category order by count DESC limit 100;
select category, count(*) as count from recipe where userID = '1580002407' group by category order by count DESC limit 100;

-- よく使われる量の表現
select amount, count(*) as count from material group by amount order by count DESC limit 100;

-- 使われる食材ランキング
select materialName, count(*) as count from material group by materialName order by count DESC limit 100;
-- 使われない食材ランキング
select materialName, count(*) as count from material group by materialName order by count ASC limit 100;

-- 中カテゴリ（パスタ）に登録されている小カテゴリ
select subsubcategory, count(*) as count from recipe where subcategory = 'パスタ' group by subsubcategory order by count DESC;

-- 食材数(重複を除いく)
select count(distinct materialName) from material;

-- レシピタイトルと食材、量を表示
SELECT recipe.recipeID, recipe.title, material.materialName, material.amount
FROM recipe INNER JOIN material USING (recipeID)
 where subcategory = 'パスタ' limit 20;

-- レシピタイトルと食材、量を表示（集計表）、NULL表示はSqliteの設定で表示
.header ON
.nullvalue 0
SELECT recipe.recipeID, recipe.title, 
GROUP_CONCAT(CASE WHEN LIKE('%塩%', material.materialName) THEN material.amount END) AS '塩',
GROUP_CONCAT(CASE WHEN LIKE('%こしょ%', material.materialName) THEN material.amount END) AS 'こしょう',
GROUP_CONCAT(CASE WHEN LIKE('%しょうゆ%', material.materialName) THEN material.amount END) AS 'しょうゆ',
GROUP_CONCAT(CASE WHEN LIKE('%牛乳%', material.materialName) THEN material.amount END) AS '牛乳',
GROUP_CONCAT(CASE WHEN LIKE('%ちーず%', material.materialName) THEN material.amount END) AS 'ちーず',
GROUP_CONCAT(CASE WHEN LIKE('%納豆%', material.materialName) THEN material.amount END) AS '納豆',
GROUP_CONCAT(CASE WHEN LIKE('%まかろに%', material.materialName) THEN material.amount END) AS 'まかろに',
GROUP_CONCAT(CASE WHEN LIKE('%すぱげてぃ%', material.materialName) THEN material.amount END) AS 'すぱげてぃ'
FROM recipe INNER JOIN material USING (recipeID)
 where subcategory = 'パスタ' GROUP BY recipe.recipeID limit 20;

-- レシピタイトルと食材、量を表示（集計表）
.header ON
SELECT recipe.recipeID, recipe.title, 
COALESCE(GROUP_CONCAT(CASE WHEN LIKE('%塩%', material.materialName) OR LIKE('%しお%', material.materialName)THEN material.amount END), 0) AS '塩',
COALESCE(GROUP_CONCAT(CASE WHEN LIKE('%胡椒%', material.materialName) OR LIKE('%こしょ%', material.materialName) OR LIKE('%ぺっぱ%', material.materialName) THEN material.amount END), 0) AS 'こしょう',
COALESCE(GROUP_CONCAT(CASE WHEN LIKE('%醤油%', material.materialName) OR LIKE('%しょうゆ%', material.materialName) THEN material.amount END), 0) AS 'しょうゆ',
COALESCE(GROUP_CONCAT(CASE WHEN LIKE('%牛乳%', material.materialName) THEN material.amount END), 0) AS '牛乳',
COALESCE(GROUP_CONCAT(CASE WHEN LIKE('%ちーず%', material.materialName) THEN material.amount END), 0) AS 'ちーず',
COALESCE(GROUP_CONCAT(CASE WHEN LIKE('%納豆%', material.materialName) THEN material.amount END), 0) AS '納豆',
COALESCE(GROUP_CONCAT(CASE WHEN LIKE('%まかろに%', material.materialName) THEN material.amount END), 0) AS 'まかろに',
COALESCE(GROUP_CONCAT(CASE WHEN LIKE('%すぱげてぃ%', material.materialName) THEN material.amount END), 0) AS 'すぱげてぃ'
FROM recipe INNER JOIN material USING (recipeID)
 where subcategory = 'パスタ' GROUP BY recipe.recipeID limit 20;


-- 食材の表現と量を表示
select DISTINCT materialName, amount, count(*) as count from material group by materialName, amount having materialName = '醤油' order by materialName ASC limit 100;

-- レシピID順に100件分を取り出し、レシピ名と使っている材料を表示
select r.recipeID, r.title, material.materialName FROM (select * from recipe order by recipeID ASC limit 100) as r INNER JOIN  material using(recipeID) order by recipeID;

