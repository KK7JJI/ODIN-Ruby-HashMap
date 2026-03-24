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
      puts arr.inspect
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
end
