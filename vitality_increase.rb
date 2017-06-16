require 'bigdecimal' # for handling floats

def evaluate_all_the_things(array)
  # Output the difference between each Vitality cost and its preceding cost
  values1.each_with_index { |n,i| next if i==0 ; puts "#{n - values1[i-1]}" }

  # Same as above, but limited to 3 decimal places
  values1.each_with_index { |n,i| next if i==0 ; puts "#{BigDecimal.new((n - values1[i-1]).to_s).truncate(3).to_f}" }

  # Output the % increase between each Vitality cost and its predecessor
  values1.each_with_index { |n,i| next if i==0 ; puts "#{((n - values1[i-1]) / values1[i-1]) * 100}" }

  # Same as above, but limited to 3 decimal places
  values1.each_with_index { |n,i| next if i==0 ; puts "#{BigDecimal.new((((n - values1[i-1]) / values1[i-1]) * 100).to_s).truncate(3).to_f}" }

  # Get sum of all Vitality costs
  @sum_of_values = values1.inject { |s,i| s+=i }
  puts @sum_of_values

  # Divide sum by first Vitality cost to get quotient
  # (what you would multiply the initial vitality increase by to get the sum, above)
  puts "#{@sum_of_values / values1[0]}"
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
