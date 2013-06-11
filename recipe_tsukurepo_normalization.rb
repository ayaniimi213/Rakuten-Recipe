#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require 'nkf'
opt = "-w -Z1 --no-best-fit-chars -x"

# 楽天レシピ
#(4).「つくったよ」レポート情報
#・レシピID    	：「つくったよ」レポートの所属レシピ
#・ユーザID			：「つくったよ」レポート投稿者
#・おすすめコメント
#・オーナーコメント
#・作成日時			：レポート登録年月日（フォーマット「yyyy/mm/dd」）

# PostgreSQLで取り込めなさそうな文字
replace_table = {"♪" => "<<おんぷ>>", "艸" => "", "♥" => "<<はーと>>", "〜" => "~"}
while line = gets
  line = NKF.nkf(opt, line)

# PostgreSQLで取り込む際は、怪しい文字を置換しておく
#  line.gsub!(/[♪艸♥〜]/, replace_table)

  line.gsub!(/\\/, "￥")
  line.gsub!(/"/, "”")
#  data = line.split("\t")
  puts line
end
