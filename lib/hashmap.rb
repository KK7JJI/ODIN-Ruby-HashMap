# frozen_string_literal: true

require_relative 'hashmap/hashmap'
require_relative 'hashmap/linkedlist'

REWORDS = /[a-zA-Z]+/

hm = HashMap::HashMap.new

words = []
File.readlines('./hashmap/hashmap.rb').each do |line|
  line.scan(REWORDS).each do |word|
    hm.set(key: word, value: word.upcase)
  end
end

File.readlines('./hashmap/linkedlist.rb').each do |line|
  line.scan(REWORDS).each do |word|
    hm.set(key: word, value: word.upcase)
  end
end

puts hm.length

puts hm.has?('current')
puts hm.remove(key: 'current')
puts hm.has?('current')

puts hm.keys.inspect
puts hm.values.inspect
puts hm.entries.inspect
