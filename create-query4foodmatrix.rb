#!/usr/bin/ruby
# -*- coding: utf-8 -*-

foodIDs = Array.new
while line = gets
  # data from 'rakuten_gram2-6_21.csv'
  line.strip!
  ( recipeid, materialname, volume, gram, foodnum ) = line.split(",")
  foodnum.gsub!(/"/, "")

  foodIDs << foodnum
end
puts 'SELECT recipeid'
foodIDs.sort.uniq.each{|id|
  puts ', volume_join(array_agg(CASE WHEN foodnum ~ \'' + id + '\' THEN gram ELSE null END)) AS "' + id + '"'
}
puts 'FROM material_gram'
puts 'GROUP BY recipeid;'
