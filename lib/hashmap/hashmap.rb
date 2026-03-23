# frozen_string_literal: true

module HashMap
  class HashMap
    attr_accessor :length
    attr_reader :hash_func

    def initialize(hash_func: HashFuncs.new.method(:hash_func),
                   load_factor: 0.75,
                   capacity: 16)
      @hash_func = hash_func
      @load_factor = load_factor
      @length = 0
      @buckets = []
      @capacity = capacity
    end

    def hash(key)
      raise NoMethodError, 'Hash function not defined' unless @hash_func

      hash_func.call(key) if @hash_func
    end

    def add_to_bucket(value, index)
      raise IndexError if index.negative? || index >= @buckets.length
    end
  end

  class HashFuncs
    def hash_func(key)
      hash_code = 0
      prime_number = 31

      key.each_char { |char| hash_code = (prime_number * hash_code) + char.ord }

      hash_code
    end
  end
end
