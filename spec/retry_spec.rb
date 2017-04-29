describe 'Retry' do
  it 'should randomly succeed', retry: 3 do
    expect(rand(2)).to eq(1)
  end

  xit 'should fail always', retry: 3 do
    expect(true).to eq(false)
  end
end
