def duplicated_helper
  'b'
end

describe 'b helper' do
  it do
    expect(duplicated_helper).to eq 'b'
  end
end
