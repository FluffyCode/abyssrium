require 'bigdecimal'  # for handling floats
require 'colorize'    # making output(s) easier to read
require 'table_print' # for simplifying table creation/output readability

class TableRow
  attr_accessor :cost, :difference, :trunc_diff, :percent_diff
end

def evaluate_all_the_things(array)
  evaluated_rows = [] # initialize empty array to hold TableRow objects

  # puts "Differences between each Vitality cost and its preceding cost"

  # spacer = "  |  ".blue

  # puts "" # empty space

  # puts "            Vitality difference         " + spacer + "% increase   "
  # puts "-------------------------- + ------------ + --------------".blue # header row

  array.each_with_index do |n,i|
    this_row = TableRow.new # initialize new TableRow object for the current row

    if i==0 # for the first iteration, assign Vitality cost only
      this_row.cost = "#{n}"
      evaluated_rows << this_row
      next
    end

    this_row.cost = "#{n}" # assign Vitality cost

    difference = n - array[i-1] # calculate difference

    # The difference between each Vitality cost and its preceding cost
    this_row.difference = "#{difference}"

    # Difference, as above, but limited to 3 decimal places
    this_row.trunc_diff = "#{(BigDecimal.new((difference).to_s).truncate(3).to_f)}"

    percent_increase = ((n - array[i-1]) / array[i-1]) * 100 # calculate percentage change

    # The percentage increase between each Vitality cost and its preceding cost, limited to 3 decimal places
    this_row.percent_diff = "#{BigDecimal.new((percent_increase).to_s).truncate(3).to_f}"

    evaluated_rows << this_row
  end

  tp evaluated_rows

  puts "" # empty space

  # Get sum of all Vitality costs
  @sum_of_values = BigDecimal.new((array.inject { |s,i| s+=i }).to_s).truncate(3).to_f
  puts "Sum of all Vitality costs: " + "#{@sum_of_values}".green

  puts "" # empty space

  # Divide sum by first Vitality cost to get quotient
  # (what you would multiply the initial vitality increase by to get the sum, above)
  quotient = "#{BigDecimal.new((@sum_of_values / array[0]).to_s).truncate(3).to_f}x".green
  puts "The sum is a #{quotient} increase of the initial amount of " + "#{array[0]}".green
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





# I'm already 10 [Lonely Corallite] levels ahead (8985) because of acquiring 10 levels from the daily mission.
# It'll take 186.096 CJ vitality to get to next level (8986).
186.096*63.283 # => 11776.713168

# That's approx. 11776.713 CJ (or 11.776 CK) to get 25 levels...
# ...but remember, I'm not starting at 8975. I'm already 10 levels ahead.

# The cost of the remaining 15 levels are:
values3 = [
  186.096,199.122,213.061,227.975,243.934,
  261.009,279.280,298.829,319.747,342.130,
  366.079,391.704,419.124,448.462,479.855
]

# And the sum ends up being: 4676.406



evaluate_all_the_things(values1)
evaluate_all_the_things(values2)
evaluate_all_the_things(values3)
