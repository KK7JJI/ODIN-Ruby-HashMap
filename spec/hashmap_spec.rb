require_relative '../lib/hashmap/hashmap'

describe HashMap::HashMap do
  subject(:hm) { HashMap::HashMap.new }
  it 'length is 0' do
    expect(hm.length).to be(0)
  end
end
