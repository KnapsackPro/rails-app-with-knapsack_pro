describe 'some stuff which requires js', js: true do
  it 'will use the default js driver' do
  end
  it 'will switch to one specific driver', :driver => :webkit do
  end
end
