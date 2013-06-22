#!/usr/bin/ruby
# -*- coding: utf-8 -*-

require 'nkf'
opt = "-w -h -Z1"

if ARGV.size < 2
  puts "USAGE: " + __FILE__ + " " + "foodCompositionTableFile queryResultFile"
  exit
else
  foodCompositionTableFile = ARGV.shift
  queryResultFile = ARGV.shift
end

foodIDs = Array.new
File::open(foodCompositionTableFile){|f|
  while line = f.gets
  line = NKF.nkf(opt, line)
    foodID = (line.split(","))[2]
    
    foodIDs << foodID
  end
}
puts foodIDs.join(",")
foodIDs.shift

File::open(queryResultFile){|f|
isheader = true
  while line = f.gets
    if isheader == true then
      header = line.split("|").collect{|s| s.strip}
      isheader = false
    else
      data = line.split("|").collect{|s| s.strip}
      next if data.size == 1
      recipeID = data[0]
      print recipeID
      
      foodIDs.each{|foodID|
        i = header.index(foodID) 
        if i != nil then
          print "," + data[i]
        else
          print ",0.0"
        end
      }
      print "\n"
    end
  end
}
