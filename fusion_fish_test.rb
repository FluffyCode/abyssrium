require 'bigdecimal' # for handling floats
require 'colorize'   # making output(s) easier to read

def limit_decimal(input)
  return BigDecimal.new((input).to_s).truncate(3).to_f
end

# Vitality/tap (in DL)
x = [3.073, 3.125, 3.176, 3.227, 3.278, 3.330]

# Vitality/sec (coral, in DJ)
y = [218.185, 221.822, 225.458, 229.049, 232.713, 236.367]

def calculate_percent_increase(array,type)
  array.each_with_index do |n,i|
    next if i==0 # skip first iteration

    puts "________________________________________"
    puts "After buying #{i} fish with a 30% bonus"

    puts "Original " + type + ": " + "#{array[0]}".green
    puts "Current "   + type + ": " + "#{n}".green

    # calculate difference
    difference = limit_decimal(n-array[0])
    puts "Difference: " + "#{difference}".green

    # calculate % increase
    increase = limit_decimal(difference/array[0]*100)

    puts "% increase: " + "#{increase}%".green + " (/#{i} = " + "#{limit_decimal(increase/i)}%".green + ")"

    # calculate correct 30% increase
    correct_increase = limit_decimal(array[0]*(0.3*i))

    puts "A #{30*i}% increase is actually: " + "#{correct_increase}".green
    puts "Current " + type + " should be: " + "#{limit_decimal(array[0]+correct_increase)}".green

    puts "" #empty space
  end
end

calculate_percent_increase(x,"Vitality/tap".cyan)
3.times { puts "" } #empty space
calculate_percent_increase(y,"Vitality/sec (coral)".cyan)
