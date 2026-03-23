# frozen_string_literal: true

module HashMap
  class HashMap
    attr_accessor :length
    attr_reader :hash_func

    def initialize(hash_func: HashFuncs.new.method(:hash_func))
      @hash_func = hash_func
      @length = 0
    end

    def hash(key)
      raise NoMethodError, 'Hash function not defined' unless @hash_func

      hash_func.call(key) if @hash_func
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
