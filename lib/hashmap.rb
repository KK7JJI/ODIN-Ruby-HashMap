# frozen_string_literal: true

require_relative 'hashmap/hashmap'

hash_func = lambda do |key|
  hash_code = 0
  prime_number = 31

  key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

  hash_code
end

hashmap = HashMap::HashMap.new(hash_func: hash_func)

puts hashmap.hash('a')

hashmap = HashMap::HashMap.new

puts hashmap.hash('a')
