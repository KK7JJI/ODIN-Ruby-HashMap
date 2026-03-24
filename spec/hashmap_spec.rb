require_relative '../lib/hashmap/hashmap'
require_relative '../lib/hashmap/linkedlist'

describe HashMap::HashMap do
  subject(:hm) { HashMap::HashMap.new }
  it '#length is 0 when hash is empty' do
    expect(hm.length).to be(0)
    expect(hm).to be_empty
  end

  describe '#to_a' do
    it 'returns [] when list is empty' do
      expect(hm.to_a).to eql([])
    end
    it 'returns key, value in array - single pair' do
      hm.set(key: 'A', value: 'Adam')
      expect(hm.to_a).to eql([%w[A Adam]])
    end
    let(:arr0) { [%w[A Adam], %w[Z Ziggy]] }
    it 'returns key, value in array - two pair' do
      arr0.each do |key, value|
        hm.set(key: key, value: value)
      end

      result = hm.to_a
      arr0.each do |pair|
        expect(result.include?(pair)).to eql(true)
      end
      result.each do |pair|
        expect(arr0.include?(pair)).to eql(true)
      end
    end
    let(:arr1) { (0..25).to_a.map { |i| [(i + 'A'.ord).chr, (i + 'A'.ord).chr * 5] } }
    let(:arr2) { (0..25).to_a.map { |i| [(i + 'a'.ord).chr, (i + 'a'.ord).chr * 5] } }
    it 'returns key, value in array - many pair' do
      arr = arr1 + arr2
      arr.each do |key, value|
        hm.set(key: key, value: value)
      end

      result = hm.to_a
      arr.each do |pair|
        expect(result.include?(pair)).to eql(true)
      end
      result.each do |pair|
        expect(arr.include?(pair)).to eql(true)
      end
    end
  end

  describe '#get(key)' do
    it 'returns nil on empty list' do
      expect(hm.get(key: 'test')).to be_nil
    end
    it 'returns nil when key not found' do
      hm.set(key: 'Happy', value: 'Happy Valley')
      expect(hm.get(key: 'test')).to be_nil
    end
    it 'returns value when key found single item' do
      hm.set(key: 'Happy', value: 'Happy Valley')
      expect(hm.get(key: 'Happy')).to eql('Happy Valley')
    end
    let(:arr1) { (0..25).to_a.map { |i| [(i + 'A'.ord).chr, (i + 'A'.ord).chr * 5] } }
    let(:arr2) { (0..25).to_a.map { |i| [(i + 'a'.ord).chr, (i + 'a'.ord).chr * 5] } }
    it 'finds individual keys and returns corresponding values' do
      arr = arr1 + arr2
      arr.each do |key, value|
        hm.set(key: key, value: value)
      end

      arr.each do |key, value|
        expect(hm.get(key: key)).to eql(value)
      end
      expect(hm.get(key: 'test')).to be_nil
    end
  end

  describe '#has(key)' do
    it 'returns false on empty list' do
      expect(hm.has?('test')).to eql(false)
    end
    it 'returns false when key not found' do
      hm.set(key: 'Happy', value: 'Happy Valley')
      expect(hm.has?('test')).to eql(false)
    end
    it 'returns true when key found single item' do
      hm.set(key: 'Happy', value: 'Happy Valley')
      expect(hm.has?('Happy')).to eql(true)
    end
    let(:arr1) { (0..25).to_a.map { |i| [(i + 'A'.ord).chr, (i + 'A'.ord).chr * 5] } }
    let(:arr2) { (0..25).to_a.map { |i| [(i + 'a'.ord).chr, (i + 'a'.ord).chr * 5] } }
    it 'checks individual keys and returns true if found' do
      arr = arr1 + arr2
      arr.each do |key, value|
        hm.set(key: key, value: value)
      end

      arr.each do |key, value|
        expect(hm.has?(key)).to eql(true)
      end
      expect(hm.has?('test')).to eql(false)
    end
  end

  describe '#remove(key)' do
    it 'returns nil when run against an empty list' do
      expect(hm.remove(key: 'test')).to be_nil
    end
    it 'returns nil when key is not found' do
      hm.set(key: 'L.', value: 'L. Arabia')
      expect(hm.remove(key: 'test')).to be_nil
    end

    it 'removes key,value pair when key is in hash.' do
      hm.set(key: 'L.', value: 'L. Arabia')
      expect(hm.remove(key: 'L.')).to eql('L. Arabia')
      expect(hm.has?('L.')).to eql(false)
    end

    let(:arr1) { (0..25).to_a.map { |i| [(i + 'A'.ord).chr, (i + 'A'.ord).chr * 5] } }
    let(:arr2) { (0..25).to_a.map { |i| [(i + 'a'.ord).chr, (i + 'a'.ord).chr * 5] } }
    it 'finds individual keys and returns corresponding values' do
      arr = arr1 + arr2
      arr.each do |key, value|
        hm.set(key: key, value: value)
      end

      arr.each do |key, value|
        expect(hm.has?(key)).to eql(true)
        expect(hm.remove(key: key)).to eql(value)
        expect(hm.has?(key)).to eql(false)
      end
      expect(hm).to be_empty
    end
  end
end
