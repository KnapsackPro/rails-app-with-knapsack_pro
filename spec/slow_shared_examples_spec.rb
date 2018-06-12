describe 'Example of slow shared examples' do
  # this should add 1.5s to the total timing of this test file recorded by knapsack_pro
  it_behaves_like 'slow shared example test'

  it do
    expect(true).to be true
  end
end
