require 'bigdecimal' # for handling floats

# Lonely Corallite
# 8500 -> 8525 | value: CF
values1 = [
  1.043,1.116,1.195,1.278,1.368,
  1.463,1.566,1.676,1.793,1.918,
  2.053,2.196,2.350,2.515,2.691,
  2.879,3.081,3.297,3.527,3.774,
  4.039,4.321,4.624,4.948,5.294
]

# Output the difference between each Vitality cost and its preceding cost
values1.each_with_index { |n,i| next if i==0 ; puts "#{n - values1[i-1]}" }

# Same as above, but limited to 3 decimal places
values1.each_with_index { |n,i| next if i==0 ; puts "#{BigDecimal.new((n - values1[i-1]).to_s).truncate(3).to_f}" }
