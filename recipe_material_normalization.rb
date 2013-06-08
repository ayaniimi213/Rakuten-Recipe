#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require 'nkf'
opt = "-w -h -Z1"

#4.楽天レシピ：レシピ情報、レシピ画像
#
#(2).材料情報
#・レシピID
#・素材名
#・分量

while line = gets

  line = NKF.nkf(opt, line)

  line.gsub!(/\\/, "￥")
  line.gsub!(/"/, "”")
  line.gsub!(/  */, "")
  line.downcase!

  # 項目先頭の不要な文字の削除
  (id, name, amount) = line.split("\t", -1)
  name.gsub!(/^[#\*○●★☆\-ー]*/, "")
  name.gsub!(/^\(\w\)/, "")
  amount.gsub!(/^[#\*○●★☆\-ー]*/, "")

  name.gsub!(/^\(あれば\)/, "")

  # 項目を間違えているものを修正
  if name == "" and amount == "砂糖50g" then
    name = "砂糖"
    amount = "50g"
  end

  puts id + "\t" + name + "\t" + amount if name != ""

end