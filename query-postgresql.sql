-- SQL例文(PostgreSQL)

-- レシピカテゴリの上位100件
select "Lcategory", count(*) as count from recipe_all group by "Lcategory" order by count DESC limit 100;

-- レシピ登録ユーザの上位20位
select "userID", count(*) as count from recipe_all group by "userID" order by count DESC limit 20;
-- あるユーザの登録レシピカテゴリ
select "Lcategory", count(*) as count from recipe_all where "userID" = '1580000101' group by "Lcategory" order by count DESC limit 100;
select "Lcategory", count(*) as count from recipe_all where "userID" = '1990000160' group by "Lcategory" order by count DESC limit 100;
select "Lcategory", count(*) as count from recipe_all where "userID" = '1580002407' group by "Lcategory" order by count DESC limit 100;

-- よく使われる量の表現
select volume, count(*) as count from recipe_material group by volume order by count DESC limit 100;

-- 使われる食材ランキング
select material, count(*) as count from recipe_material group by material order by count DESC limit 100;
-- 使われない食材ランキング
select material, count(*) as count from recipe_material group by material order by count ASC limit 100;

-- 中カテゴリ（パスタ）に登録されている小カテゴリ
select "Scategory", count(*) as count from recipe_all where "Mcategory" = 'パスタ' group by "Scategory" order by count DESC;

-- 食材数(重複を除いく)
select count(distinct material) from recipe_material;

-- レシピタイトルと食材、量を表示
SELECT recipe_all."recipeID", recipe_all."recipeTitle", recipe_material.material, recipe_material.volume
FROM recipe_all INNER JOIN recipe_material USING ("recipeID")
 where "Mcategory" = 'パスタ' limit 20;

-- レシピタイトルと食材、量を表示（集計表, ユーザ定義関数comma_join()関数を利用）
-- comma_joinは次のサイトからの流用です。 http://miau.s9.xrea.com/blog/?itemid=585
-- 3230.739 ms
SELECT recipe_all."recipeID", recipe_all."recipeTitle", 
CASE WHEN replace(comma_join(CASE WHEN recipe_material.material ~ '塩' OR recipe_material.material ~ 'しお' THEN recipe_material.volume ELSE '' END), ',', '')  = '適量' THEN 
'10'
	WHEN replace(comma_join(CASE WHEN recipe_material.material ~ '塩' OR recipe_material.material ~ 'しお' THEN recipe_material.volume ELSE '' END), ',', '')  != '' THEN 
		replace(comma_join(CASE WHEN recipe_material.material ~ '塩' OR recipe_material.material ~ 'しお' THEN recipe_material.volume ELSE '' END), ',', '')
	ELSE '0' END AS "塩",
CASE WHEN replace(comma_join(CASE WHEN recipe_material.material ~ '胡椒' OR recipe_material.material ~ 'こしょ' OR recipe_material.material ~ 'ぺっぱー' THEN recipe_material.volume ELSE '' END), ',', '')  != '' THEN 
		replace(comma_join(CASE WHEN recipe_material.material ~ '胡椒' OR recipe_material.material ~ 'こしょ' OR recipe_material.material ~ 'ぺっぱー' THEN recipe_material.volume ELSE '' END), ',', '')
	ELSE '0' END AS "胡椒",
CASE WHEN replace(comma_join(CASE WHEN recipe_material.material ~ '醤油' THEN recipe_material.volume ELSE '' END), ',', '')  != '' THEN 
		replace(comma_join(CASE WHEN recipe_material.material ~ '醤油' THEN recipe_material.volume ELSE '' END), ',', '')
	ELSE '0' END AS "醤油",
CASE WHEN replace(comma_join(CASE WHEN recipe_material.material ~ '牛乳' THEN recipe_material.volume ELSE '' END), ',', '')  != '' THEN 
		replace(comma_join(CASE WHEN recipe_material.material ~ '牛乳' THEN recipe_material.volume ELSE '' END), ',', '')
	ELSE '0' END AS "牛乳",
CASE WHEN replace(comma_join(CASE WHEN recipe_material.material ~ 'チーズ' THEN recipe_material.volume ELSE '' END), ',', '')  != '' THEN 
		replace(comma_join(CASE WHEN recipe_material.material ~ 'チーズ' THEN recipe_material.volume ELSE '' END), ',', '')
	ELSE '0' END AS "チーズ",
CASE WHEN replace(comma_join(CASE WHEN recipe_material.material ~ '納豆' OR recipe_material.material ~ 'なっとう' THEN recipe_material.volume ELSE '' END), ',', '')  != '' THEN 
		replace(comma_join(CASE WHEN recipe_material.material ~ '納豆' OR recipe_material.material ~ 'なっとう' THEN recipe_material.volume ELSE '' END), ',', '')
	ELSE '0' END AS "納豆",
CASE WHEN replace(comma_join(CASE WHEN recipe_material.material ~ 'マカロニ' THEN recipe_material.volume ELSE '' END), ',', '')  != '' THEN 
		replace(comma_join(CASE WHEN recipe_material.material ~ 'マカロニ' THEN recipe_material.volume ELSE '' END), ',', '')
	ELSE '0' END AS "マカロニ",
CASE WHEN replace(comma_join(CASE WHEN recipe_material.material ~ 'スパゲティ' THEN recipe_material.volume ELSE '' END), ',', '')  != '' THEN 
		replace(comma_join(CASE WHEN recipe_material.material ~ 'スパゲティ' THEN recipe_material.volume ELSE '' END), ',', '')
	ELSE '0' END AS "スパゲティ"
FROM recipe_material INNER JOIN recipe_all USING ("recipeID")
 where "Mcategory" = 'パスタ' GROUP BY recipe_all."recipeID",recipe_all."recipeTitle"  limit 200;

-- レシピタイトルと食材、量を表示（集計表, array_to_string()関数を利用）
-- 1882.945 ms
SELECT recipe_all."recipeID", recipe_all."recipeTitle", 
CASE WHEN array_to_string(array_agg(CASE WHEN recipe_material.material ~ '塩' OR recipe_material.material ~ 'しお' THEN recipe_material.volume ELSE '' END), '') != '' THEN
		array_to_string(array_agg(CASE WHEN recipe_material.material ~ '塩' OR recipe_material.material ~ 'しお' THEN recipe_material.volume ELSE '' END), '')
	ELSE '0' END AS "塩",
CASE WHEN array_to_string(array_agg(CASE WHEN recipe_material.material ~ '胡椒' OR recipe_material.material ~ 'こしょ' OR recipe_material.material ~ 'ぺっぱー' THEN recipe_material.volume ELSE '' END), '') != '' THEN
		array_to_string(array_agg(CASE WHEN recipe_material.material ~ '胡椒' OR recipe_material.material ~ 'こしょ' OR recipe_material.material ~ 'ぺっぱー' THEN recipe_material.volume ELSE '' END), '')
	ELSE '0' END AS "胡椒",
CASE WHEN array_to_string(array_agg(CASE WHEN recipe_material.material ~ '醤油' OR recipe_material.material ~ 'しょうゆ' THEN recipe_material.volume ELSE '' END), '') != '' THEN
		array_to_string(array_agg(CASE WHEN recipe_material.material ~ '醤油' OR recipe_material.material ~ 'しょうゆ' THEN recipe_material.volume ELSE '' END), '')
	ELSE '0' END AS "醤油",
CASE WHEN array_to_string(array_agg(CASE WHEN recipe_material.material ~ '牛乳' THEN recipe_material.volume ELSE '' END), '') != '' THEN
		array_to_string(array_agg(CASE WHEN recipe_material.material ~ '牛乳' THEN recipe_material.volume ELSE '' END), '')
	ELSE '0' END AS "牛乳",
CASE WHEN array_to_string(array_agg(CASE WHEN recipe_material.material ~ 'ちーず' THEN recipe_material.volume ELSE '' END), '') != '' THEN
		array_to_string(array_agg(CASE WHEN recipe_material.material ~ 'ちーず' THEN recipe_material.volume ELSE '' END), '')
	ELSE '0' END AS "ちーず",
CASE WHEN array_to_string(array_agg(CASE WHEN recipe_material.material ~ '納豆' OR recipe_material.material ~ 'なっとう' THEN recipe_material.volume ELSE '' END), '') != '' THEN
		array_to_string(array_agg(CASE WHEN recipe_material.material ~ '納豆' OR recipe_material.material ~ 'なっとう' THEN recipe_material.volume ELSE '' END), '')
	ELSE '0' END AS "納豆",
CASE WHEN array_to_string(array_agg(CASE WHEN recipe_material.material ~ 'まかろに' THEN recipe_material.volume ELSE '' END), '') != '' THEN
		array_to_string(array_agg(CASE WHEN recipe_material.material ~ 'まかろに' THEN recipe_material.volume ELSE '' END), '')
	ELSE '0' END AS "まかろに",
CASE WHEN array_to_string(array_agg(CASE WHEN recipe_material.material ~ 'すぱげてぃ' THEN recipe_material.volume ELSE '' END), '') != '' THEN
		array_to_string(array_agg(CASE WHEN recipe_material.material ~ 'すぱげてぃ' THEN recipe_material.volume ELSE '' END), '')
	ELSE '0' END AS "すぱげてぃ"
FROM recipe_material INNER JOIN recipe_all USING ("recipeID")
 where "Mcategory" = 'パスタ' GROUP BY recipe_all."recipeID",recipe_all."recipeTitle"  limit 200;

-- レシピタイトルと食材、量を表示（集計表, ユーザ定義関数volume_join()関数を利用）
-- 1887.750 ms
DROP FUNCTION volume_join(anyarray);
CREATE FUNCTION volume_join(anyarray) RETURNS text AS $$
SELECT 
CASE WHEN array_to_string($1, '') != '' THEN
		array_to_string($1, '')
	ELSE '0.0' END;
$$ LANGUAGE SQL;

SELECT recipe_all."recipeID", recipe_all."recipeTitle", 
volume_join(array_agg(CASE WHEN recipe_material.material ~ '塩' OR recipe_material.material ~ 'しお' THEN recipe_material.volume ELSE '' END)) AS "塩",
volume_join(array_agg(CASE WHEN recipe_material.material ~ '胡椒' OR recipe_material.material ~ 'こしょ' OR recipe_material.material ~ 'ぺっぱー' THEN recipe_material.volume ELSE '' END)) AS "胡椒",
volume_join(array_agg(CASE WHEN recipe_material.material ~ '醤油' OR recipe_material.material ~ 'しょうゆ' THEN recipe_material.volume ELSE '' END)) AS "醤油",
volume_join(array_agg(CASE WHEN recipe_material.material ~ '牛乳' THEN recipe_material.volume ELSE '' END)) AS "牛乳",
volume_join(array_agg(CASE WHEN recipe_material.material ~ 'ちーず' THEN recipe_material.volume ELSE '' END)) AS "ちーず",
volume_join(array_agg(CASE WHEN recipe_material.material ~ '納豆' OR recipe_material.material ~ 'なっとう' THEN recipe_material.volume ELSE '' END)) AS "納豆",
volume_join(array_agg(CASE WHEN recipe_material.material ~ 'まかろに' THEN recipe_material.volume ELSE '' END)) AS "まかろに",
volume_join(array_agg(CASE WHEN recipe_material.material ~ 'すぱげてぃ' THEN recipe_material.volume ELSE '' END)) AS "すぱげてぃ"
FROM recipe_material INNER JOIN recipe_all USING ("recipeID")
 where "Mcategory" = 'パスタ' GROUP BY recipe_all."recipeID",recipe_all."recipeTitle"  limit 200;

-- 食材の表現と量を表示
select DISTINCT material, volume, count(*) as count from recipe_material group by material, volume having material = '醤油' order by material ASC limit 100;

-- レシピID順に100件分を取り出し、レシピ名と使っている材料を表示
select r."recipeID", r."recipeTitle", recipe_material.material FROM (select * from recipe_all order by "recipeID" ASC limit 100) as r INNER JOIN  recipe_material using("recipeID") order by "recipeID";



