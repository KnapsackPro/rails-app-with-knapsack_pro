def duplicated_helper
  'a'
end

describe 'a helper' do
  it do
    expect(duplicated_helper).to eq 'a'
  end
end
