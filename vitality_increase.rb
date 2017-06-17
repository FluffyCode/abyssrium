require 'bigdecimal' # for handling floats

def evaluate_differences(array)
  puts "Differences between each Vitality cost and its preceding cost"

  puts "---------------------- + ----------------------" # header row

  array.each_with_index do |n,i|
    next if i==0 # skip over first value

    output_string = "" # set empty output_string

    # The difference between each Vitality cost and its preceding cost
    output_string << " #{(n - array[i-1])}".ljust(20)

    output_string << "   |   " # row divider

    # Difference, as above, but limited to 3 decimal places
    output_string << "#{(BigDecimal.new((n - array[i-1]).to_s).truncate(3).to_f)}".ljust(5)

    puts output_string
  end

  puts "" # empty space
end

def evaluate_percentage_differences(array)
  puts "Percentage increase between each Vitality cost and its preceding cost"

  puts "---------------------- + ----------------------" # header row

  array.each_with_index do |n,i|
    next if i==0  # skip over first value

    output_string = "" # set empty output_string

    # The percentage increase between each Vitality cost and its preceding cost
    output_string << "#{((n - array[i-1]) / array[i-1]) * 100} ".ljust(19)

    output_string << "%   |   " # row divider

    # Percentage increase, as above, but limited to 3 decimal places
    output_string << "#{BigDecimal.new((((n - array[i-1]) / array[i-1]) * 100).to_s).truncate(3).to_f}".ljust(6)

    output_string << "%"

    puts output_string
  end

  puts "" # empty space
end

def evaluate_all_the_things(array)
  evaluate_differences(array)

  evaluate_percentage_differences(array)

  # Get sum of all Vitality costs
  puts "Sum of all Vitality costs"
  @sum_of_values = BigDecimal.new((array.inject { |s,i| s+=i }).to_s).truncate(3).to_f
  puts @sum_of_values

  puts "" # empty space

  # Divide sum by first Vitality cost to get quotient
  # (what you would multiply the initial vitality increase by to get the sum, above)
  puts "#{BigDecimal.new((@sum_of_values / array[0]).to_s).truncate(3).to_f}"
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

evaluate_all_the_things(values1)
