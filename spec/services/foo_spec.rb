describe 'Foo' do
  it do
    if ENV['CI']
      # slow down on CI so the same queue can start on both CI nodes
      sleep 10
    end
    expect(true).to be true
  end
end
