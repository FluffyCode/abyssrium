require 'colorize'

# Vitality/tap (in DL)
x = [3.073, 3.125, 3.176, 3.227, 3.278, 3.330]

# Vitality/sec (coral, in DJ)
y = [218.185, 221.822, 225.458, 229.049, 232.713, 236.367]

def calculate_percent_increase(array,type)
  array.each_with_index do |n,i|
    next if i==0 # skip first iteration

    difference = n-array[i-1] # calculate difference

    puts "Original " + type.cyan + ": " + "#{array[i-1]}".green
    puts "Current"   + type.cyan + ": " + "#{n}".green

    puts "Difference: " + "#{difference}".green 
    puts "% increase: " + "#{difference/array[i-1]*100}".green # calculate % increase
    puts "" #empty space
  end
end

calculate_percent_increase(x,"Vitality/tap")
3.times { puts "" } #empty space
calculate_percent_increase(y,"Vitality/sec (coral)")
