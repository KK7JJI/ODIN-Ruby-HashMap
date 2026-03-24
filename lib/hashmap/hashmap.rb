# frozen_string_literal: true

module HashMap
  class HashMap
    attr_accessor :length

    def initialize(hash_func: HashFuncs.new.method(:hash_func),
                   load_factor: 0.75,
                   capacity: 16)
      @hash_func = hash_func
      @load_factor = load_factor
      @length = 0
      @capacity = capacity
      @buckets = Array.new(capacity) { LinkedList.new }
    end

    def set(key: nil, value: nil)
      add_to_bucket(key: key, value: value)
      self.length += 1
    end

    def get(key: nil)
      return nil if empty?

      find_key_in_buckets(key: key)
    end

    def has?(key)
      return false unless get(key: key)

      true
    end

    def remove(key: nil)
      remove_key_from_hash(key: key)
    end

    def keys
      to_a.map { |key, _value| key }
    end

    def values
      to_a.map { |_key, value| value }
    end

    def entries
      to_a
    end

    def to_a
      result = []
      buckets.each do |bucket|
        bucket.to_a.each do |key, value|
          result << [key, value]
        end
      end
      result
    end

    def empty?
      return true if buckets.all? { |bucket| bucket.empty? }

      false
    end

    def to_s
      puts '==========================='
      puts "     length: #{length}"
      puts "   capacity: #{capacity}"
      puts "load factor: #{load_factor}"
      puts '==========================='
      puts 'buckets:'

      cnt = 0
      buckets.each do |bucket|
        puts "  bucket index #{cnt}"

        unless bucket.empty?
          bucket.to_a.each do |key, value|
            puts "    key #{key}, value #{value}"
          end
        end
        cnt += 1
      end
      puts ''
    end

    private

    attr_accessor :buckets
    attr_reader :hash_func, :capacity, :load_factor

    def hash(key: nil)
      raise NoMethodError, 'Hash function not defined' unless @hash_func

      hash_func.call(key: key) if @hash_func
    end

    def index(key: nil)
      hash(key: key) % capacity
    end

    def add_to_bucket(key: nil, value: nil)
      idx = index(key: key)
      raise IndexError if idx.negative? || idx >= @buckets.length

      buckets[idx].append(key: key, value: value)
    end

    def find_key_in_buckets(key: nil)
      buckets.each do |bucket|
        value = bucket.find(key: key)
        return value unless value.nil?
      end

      # return nil if key not found.
      nil
    end

    def remove_key_from_hash(key: nil)
      buckets.each do |bucket|
        value = bucket.find(key: key)
        bucket.remove(key: key) unless value.nil?
        return value unless value.nil?
      end

      # return nil if key not found.
      nil
    end
  end

  class HashFuncs
    def hash_func(key: nil)
      hash_code = 0
      prime_number = 31

      key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

      hash_code
    end
  end
end
