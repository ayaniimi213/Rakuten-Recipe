#!/bin/sh

rm recipe_all_20120705_normalized.txt
rm recipe_material_20120705_normalized.txt

# 変な文字が入っているので、ココだけ切り出して編集
sed -n 234685p recipe_all_20120705.txt | nkf -w -Z1 --no-best-fit-chars -x > 234685.txt
sed -n 280174p recipe_all_20120705.txt | nkf -w -Z1 --no-best-fit-chars -x > 280174.txt

ruby recipe_all_normalization.rb recipe_all_20120705.txt | sed -e "234685d" | sed -e "280173d" > recipe_all_20120705_normalized.txt
ruby recipe_material_normalization.rb recipe_material_20120705.txt > recipe_material_20120705_normalized.txt

ruby recipe_tsukurepo_normalization.rb recipe_tsukurepo_20120705.txt > recipe_tsukurepo_20120705_normalized.txt
