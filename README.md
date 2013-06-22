Rakuten-Recipe
==============
楽天公開データに含まれる楽天レシピのデータをデータベースに取り込むためのスクリプト集。

情報学研究データリポジトリ 楽天データセット http://www.nii.ac.jp/cscenter/idr/rakuten/rakuten.html

■ 確認DB
----
- SQlite
- PostgreSQL

PostgreSQLはUTF-8のチェックが厳しいので、いくつかの文字が取り込めないようです。

■ 必要なライブラリ、ツール
----
- Ruby
- nkf
- sed

■ 手順
----
- 本プロジェクトをダウンロード

````bash
git clone https://github.com/ayaniimi213/Rakuten-Recipe.git
````

- Rubyが未インストールなら、install-ruby.mdを参考にインストールする。

- 楽天データセットから楽天レシピを入手

- normalization.shを使ってデータの正規化
 - recipe_all_20120705.txtの234685行目と280174行目を手動で修正

````bash
sh normalization.sh
vim 234685.txt
vim 280174.txt
````

- initialize-sqlite.sqlを使って、データベースに取り込み
 - initialize-sqlite.sqlはSQliteを想定して作成しています。
 - initialize-postgresql.sqlはPostgreSQLを想定して作成しています。

````bash
createdb recipe
psql recipe < initialize-postgresq.sql
````

- 他のデータベースの場合は、適宜読み替えて下さい。
- query-sqlite.sqlに書かれているサンプルSQLを使って、データが取り込めたか確認
 - query-sqlite.sqlはSQliteを想定して作成しています。
 - query-postgresql.sqlはPostgreSQLを想定して作成しています。

- 食品成分表2010を使ってレシピ毎の材料行列を作成
 - PostgreSQLの場合

````bash
ruby create-query4foodmatrix.rb rakuten_gram2-6_21.csv > query.sql
````
````bash
psql recipe < query.sql > result.csv
````
````bash
ruby comvert2complete-matrix.rb FoodCompositionTable_modified.csv result.csv > complete-matrix.csv
````
