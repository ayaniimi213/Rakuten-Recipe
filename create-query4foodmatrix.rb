#!/usr/bin/ruby
# -*- coding: utf-8 -*-

foodIDs = Array.new
while line = gets
  # data from 'rakuten100_6-20.csv'
#  (recipeID, title, materialName, foodID, category, subcategory ) = line.split(",")
  # data from 'FoodCompositionTable_modified.csv'
  foodID = (line.split(","))[2]

  foodIDs << foodID
end
puts 'SELECT recipe_selected."recipeID", recipe_selected."recipeTitle"'
foodIDs.sort.uniq.each{|id|
  puts ', volume_join(array_agg(CASE WHEN "foodID" = ' + id + ' THEN recipe_material.volume ELSE \'\' END))'
}
puts 'FROM recipe_selected inner join recipe_material USING ("recipeID")'
puts 'WHERE recipe_selected."materialName" = recipe_material.material GROUP BY recipe_selected."recipeID", recipe_selected."recipeTitle";'
