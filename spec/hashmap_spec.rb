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

  describe '#keys' do
    it 'returns [] on empty hash' do
      expect(hm.keys).to eql([])
    end
    it 'returns single element array when one key, value pair present' do
      hm.set(key: 'MO', value: 'Jefferson City')
      expect(hm.keys).to eql(['MO'])
    end

    let(:arr1) { (0..25).to_a.map { |i| [(i + 'A'.ord).chr, (i + 'A'.ord).chr * 5] } }
    let(:arr2) { (0..25).to_a.map { |i| [(i + 'a'.ord).chr, (i + 'a'.ord).chr * 5] } }
    it 'retrieves all keys in hash' do
      arr = arr1 + arr2
      arr.each do |key, value|
        hm.set(key: key, value: value)
      end

      result = hm.keys
      compare = arr.map { |key, _value| key }

      expect(result.all? { |key| compare.include?(key) }).to eql(true)
      expect(compare.all? { |key| result.include?(key) }).to eql(true)
    end
  end

  describe '#values' do
    it 'returns [] on empty hash' do
      expect(hm.values).to eql([])
    end
    it 'returns single element array when one key, value pair present' do
      hm.set(key: 'MO', value: 'Jefferson City')
      expect(hm.values).to eql(['Jefferson City'])
    end

    let(:arr1) { (0..25).to_a.map { |i| [(i + 'A'.ord).chr, (i + 'A'.ord).chr * 5] } }
    let(:arr2) { (0..25).to_a.map { |i| [(i + 'a'.ord).chr, (i + 'a'.ord).chr * 5] } }
    it 'retrieves all values in hash' do
      arr = arr1 + arr2
      arr.each do |key, value|
        hm.set(key: key, value: value)
      end

      result = hm.values
      compare = arr.map { |_key, value| value }

      expect(result.all? { |value| compare.include?(value) }).to eql(true)
      expect(compare.all? { |value| result.include?(value) }).to eql(true)
    end
  end

  describe '#entries' do
    it 'returns [] on empty hash' do
      expect(hm.entries).to eql([])
    end
    it 'returns single entry when one key, value pair present' do
      hm.set(key: 'MO', value: 'Jefferson City')
      expect(hm.entries).to eql([['MO', 'Jefferson City']])
    end

    let(:arr1) { (0..25).to_a.map { |i| [(i + 'A'.ord).chr, (i + 'A'.ord).chr * 5] } }
    let(:arr2) { (0..25).to_a.map { |i| [(i + 'a'.ord).chr, (i + 'a'.ord).chr * 5] } }
    it 'retrieves all entries in hash' do
      arr = arr1 + arr2
      arr.each do |key, value|
        hm.set(key: key, value: value)
      end

      result = hm.entries

      expect(result.all? { |entry| arr.include?(entry) }).to eql(true)
      expect(arr.all? { |entry| result.include?(entry) }).to eql(true)
    end
  end

  describe '#clear' do
    let(:arr1) { (0..25).to_a.map { |i| [(i + 'A'.ord).chr, (i + 'A'.ord).chr * 5] } }
    let(:arr2) { (0..25).to_a.map { |i| [(i + 'a'.ord).chr, (i + 'a'.ord).chr * 5] } }
    it 'retrieves all entries in hash' do
      arr = arr1 + arr2
      arr.each do |key, value|
        hm.set(key: key, value: value)
      end

      expect(hm.empty?).to eql(false)
      result = hm.clear
      expect(hm.empty?).to eql(true)
      expect(hm.length).to eql(0)
    end
  end

  describe '#length' do
    it 'initial length is 0' do
      expect(hm.length).to eql(0)
    end
    it 'increase length by 1 with each set(key, value)' do
      expect { hm.set(key: 'A', value: 'Adam') }.to change { hm.length }.by(1)
      expect { hm.set(key: 'B', value: 'Barclay') }.to change { hm.length }.by(1)
    end
    it 'decrease length by 1 with each remove(key)' do
      expect { hm.set(key: 'A', value: 'Adam') }.to change { hm.length }.by(1)
      expect { hm.set(key: 'B', value: 'Barclay') }.to change { hm.length }.by(1)
      expect { hm.remove(key: 'Z') }.to change { hm.length }.by(0)
      expect { hm.remove(key: 'A') }.to change { hm.length }.by(-1)
      expect { hm.remove(key: 'B') }.to change { hm.length }.by(-1)
      expect { hm.remove(key: 'Z') }.to change { hm.length }.by(0)

      expect(hm.length).to eql(0)
    end
  end
end
