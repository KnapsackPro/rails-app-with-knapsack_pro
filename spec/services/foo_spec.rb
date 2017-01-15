describe 'Foo' do
  it do
    if ENV['KNAPSACK_PRO_QUEUE_ID']
      # slow down so the same queue can start on both CI nodes
      sleep 10
    end
    expect(true).to be true
  end
end
