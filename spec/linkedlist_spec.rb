require_relative '../lib/hashmap/linkedlist'

describe HashMap::LinkedList do
  subject(:ll) { HashMap::LinkedList.new }
  describe '#to_a' do
    it 'empty list = []' do
      expect(ll.to_a).to eql([])
    end
    it 'single item' do
      ll.append(value: 'Adam', key: 'A')
      expect(ll.to_a).to eql([%w[A Adam]])
    end
    let(:arr0) { [%w[A Adam], %w[Z Ziggy]] }
    it 'two items' do
      arr0.each do |key, value|
        ll.append(value: value, key: key)
      end
      result = ll.to_a
      correct = result.all? do |elem|
        arr0.include?(elem)
      end
      expect(correct).to eql(true)
      correct = arr0.all? do |elem|
        result.include?(elem)
      end
      expect(correct).to eql(true)
    end

    let(:arr1) do
      (0...10).to_a.map do |i|
        [(i + 'A'.ord).chr, (i + 'A'.ord).chr * 6]
      end
    end
    it 'many items' do
      arr1.each do |key, value|
        ll.append(value: value, key: key)
      end
      result = ll.to_a
      correct = result.all? do |elem|
        arr1.include?(elem)
      end
      expect(correct).to eql(true)
      correct = arr1.all? do |elem|
        result.include?(elem)
      end
      expect(correct).to eql(true)
    end
  end
  describe '#find' do
    it 'find - empty list returns nil' do
      expect(ll.find(key: 'key')).to eql(nil)
    end
    it 'find - single item list returns nil when not found' do
      ll.append(key: 'A', value: 'Adam')
      expect(ll.find(key: 'B')).to eql(nil)
    end
    it 'find - single item list returns value when found' do
      ll.append(key: 'A', value: 'Adam')
      expect(ll.find(key: 'A')).to eql('Adam')
    end
    let(:arr) { (0...10).to_a.map { |i| [(i + 'A'.ord).chr, (i + 'A'.ord).chr * 5] } }
    it 'find - items in list' do
      arr.each do |key, value|
        ll.append(value: value, key: key)
      end
      arr.each do |key, value|
        expect(ll.find(key: key)).to eql(value)
      end
    end
  end

  describe '#remove' do
    it 'remove on empty list - return nil' do
      expect(ll.remove(key: 'A')).to be_nil
      expect(ll).to be_empty
    end
    it 'remove item from single item list - return value' do
      ll.append(key: 'A', value: 'Adam')
      expect(ll).not_to be_empty
      result = ll.remove(key: 'A')
      expect(result).to eql('Adam')
      expect(ll).to be_empty
    end
    it 'remove first item from two item list - return value' do
      ll.append(key: 'A', value: 'Adam')
      ll.append(key: 'B', value: 'Brad')
      result = ll.remove(key: 'B')
      expect(result).to eql('Brad')
      expect(ll.find(key: 'A')).to eql('Adam')
    end

    let(:arr) { (0...10).to_a.map { |i| [(i + 'A'.ord).chr, (i + 'A'.ord).chr * 5] } }
    it 'remove items from list one at a time' do
      arr.each { |key, value| ll.append(key: key, value: value) }
      arr.each do |key, value|
        expect(ll.find(key: key)).to eql(value)
        expect(ll.remove(key: key)).to eql(value)
        expect(ll.find(key: key)).to be_nil
      end
    end
  end
end
