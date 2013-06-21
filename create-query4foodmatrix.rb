#!/usr/bin/ruby
# -*- coding: utf-8 -*-

foodIDs = Array.new
while line = gets
  (recipeID, title, materialName, foodID, category, subcategory ) = line.split(",")
  
  foodIDs << foodID
end
puts 'SELECT recipe_selected."recipeID", recipe_selected."recipeTitle"'
foodIDs.sort.uniq.each{|id|
  puts ', volume_join(array_agg(CASE WHEN "foodID" = ' + id + ' THEN recipe_material.volume ELSE \'\' END))'
}
puts 'FROM recipe_selected inner join recipe_material USING ("recipeID")'
puts 'WHERE recipe_selected."materialName" = recipe_material.material GROUP BY recipe_selected."recipeID", recipe_selected."recipeTitle";'
