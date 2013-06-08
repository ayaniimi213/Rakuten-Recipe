Rakuten-Recipe
==============
楽天公開データに含まれる楽天レシピのデータをデータベースに取り込むためのスクリプト集。

情報学研究データリポジトリ 楽天データセット http://www.nii.ac.jp/cscenter/idr/rakuten/rakuten.html

■ 確認DB
- SQlite
- PostgreSQL

PostgreSQLはUTF-8のチェックが厳しいので、いくつかの文字が取り込めないようです。

■ 必要なライブラリ、ツール

- Ruby
- nkf
- sed

■ 手順

- 楽天データセットから楽天レシピを入手
- normalization.shを使ってデータの正規化
-- recipe_all_20120705.txtの234685行目と280174行目を手動で修正
- create.sqlを使って、データベースに取り込み
-- create.sqlはSQliteを想定して作成しています。他のデータベースの場合は、適宜読み替えて下さい。
- query.sqlに書かれているサンプルSQLを使って、データが取り込めたか確認

