require 'bigdecimal'     # for handling floats
require 'colorize'       # making output(s) easier to read
require 'terminal-table' # for simplifying table creation/output readability

def calculate_quotient(sum, initial_value)
  return "#{BigDecimal.new((sum / initial_value).to_s).truncate(3).to_f}x".green
end

def evaluate_all_the_things(array, initial_level)
  level = initial_level # initialize level to hold incrementing levels
  initial_value = 0     # initialize initial_value to hold initial value (will be assigned later)
  evaluated_rows = []   # initialize empty array to hold TableRow objects
  running_sum = 0       # initialize running_sum for values

  array.each_with_index do |n,i|
    this_row = [] # initialize new TableRow object for the current row

    if i==0 # for the first iteration only...
      this_row << "#{level} -> #{level += 1}".cyan  # add initial level increase
      this_row << "#{n}".green                      # add Vitality cost
      initial_value = n                             # assign the initial value to initial_value
      running_sum += n                              # increment running sum
      3.times { this_row << "" }                    # add 3 empty spaces
      evaluated_rows << this_row                    # add this_row to evaluated_rows
      next
    end

    # Add level increase
    this_row << "#{level} -> #{level += 1}".cyan

    # Add Vitality cost
    this_row << "#{n}".green

    # Add running sum, limited to 3 decimal places
    this_row << "#{(BigDecimal.new((running_sum += n).to_s).truncate(3).to_f)}".green

    # Add running quotient, limited to 3 decimal places
    this_row << calculate_quotient(running_sum, initial_value)

    # Calculate percentage change
    percent_increase = ((n - array[i-1]) / array[i-1]) * 100

    # The percentage increase between each Vitality cost and its preceding cost, limited to 3 decimal places
    this_row << "#{BigDecimal.new((percent_increase).to_s).truncate(3).to_f} %".green

    # Add this_row to evaluated_rows
    evaluated_rows << this_row
  end

  # Build table from evaluated_rows
  table = Terminal::Table.new headings: ["level".cyan,"cost".cyan,"running cost".cyan,"running quotient".cyan,"% increase".cyan],
    rows: evaluated_rows
  table.style = { padding_left: 2, padding_right: 2, border_x: "-".blue, border_y: "|".blue, border_i: "+".blue }

  puts table # output table

  puts "" # empty space

  # Get sum of all Vitality costs
  @sum_of_values = BigDecimal.new((array.inject { |s,i| s+=i }).to_s).truncate(3).to_f
  puts "Sum of all Vitality costs: " + "#{@sum_of_values}".green

  puts "" # empty space

  # Divide sum by first Vitality cost to get quotient
  # (what you would multiply the initial vitality increase by to get the sum, above)
  quotient = calculate_quotient(@sum_of_values, array[0])
  puts "The sum is a #{quotient} increase of the initial amount of " + "#{array[0]}".green

  puts "" # empty space

  # Determine the cost of the first/last [10/15]/[15/10] levels
  first_ten     = BigDecimal.new((array[0..9].inject{ |s,i| s+=i }).to_s).truncate(3).to_f
  last_fifteen  = BigDecimal.new((array[10..-1].inject{ |s,i| s+=i }).to_s).truncate(3).to_f

  first_fifteen = BigDecimal.new((array[0..14].inject{ |s,i| s+=i }).to_s).truncate(3).to_f
  last_ten      = BigDecimal.new((array[15..-1].inject{ |s,i| s+=i }).to_s).truncate(3).to_f

  puts "Sum of first 10: " + "#{first_ten}".green + " | Sum of last 15: " + "#{last_fifteen}".green
  puts "Sum of first 15: " + "#{first_fifteen}".green + " | Sum of last 10: " + "#{last_ten}".green

  difference = BigDecimal.new((last_fifteen - first_fifteen).to_s).truncate(3).to_f
  puts "Difference between buying first 15 versus buying last 15: " + "#{difference}".green
end

# Lonely Corallite
# 8500 -> 8525 | value: CF
values1 = [
  1.043,1.116,1.195,1.278,1.368,
  1.463,1.566,1.676,1.793,1.918,
  2.053,2.196,2.350,2.515,2.691,
  2.879,3.081,3.297,3.527,3.774,
  4.039,4.321,4.624,4.948,5.294
]

# Lonely Corallite
# 8950 -> 8975 | value: CJ
values2 = [
  17.430,18.650,19.955,21.352,22.847,
  24.446,26.158,27.989,29.948,32.044,
  34.288,36.688,39.256,42.004,44.944,
  48.090,51.457,55.059,58.913,63.037,
  67.449,72.171,77.223,82.628,88.412
]

# Lonely Corallite
# 8985 -> 9000 | value: CJ
# Getting 10 free levels, then buying the remaining 15
values3 = [
  186.096,199.122,213.061,227.975,243.934,
  261.009,279.280,298.829,319.747,342.130,
  366.079,391.704,419.124,448.462,479.855
]

# Lonely Corallite
# 9125 -> 9140 | value: CL
# Buying 15 levels, then getting the remaining 10 free
values4_partial = [
  2.418,2.587,2.768,2.962,3.169,
  3.391,3.628,3.882,4.154,4.445,
  4.756,5.089,5.445,5.827,6.235
]
# This was rather excessive and unnecessary.
# Any 15 levels will cost ~25.12x the initial increase cost.

# Lonely Corallite
# 9125 -> 9150 | value: CL
values4_full = [
  2.418,2.587,2.768,2.962,3.169,
  3.391,3.628,3.882,4.154,4.445,
  4.756,5.089,5.445,5.827,6.235,
  6.671,7.138,7.638,8.172,8.744,
  9.357,10.012,10.712,11.462,12.265
]



evaluate_all_the_things(values1,8500)
3.times { puts "" }
evaluate_all_the_things(values2,8950)
3.times { puts "" }
evaluate_all_the_things(values3,8985)
3.times { puts "" }
evaluate_all_the_things(values4_partial,9125)
3.times { puts "" }
evaluate_all_the_things(values4_full,9125)
