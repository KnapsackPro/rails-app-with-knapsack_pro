describe 'Timecop' do
  let(:time_1) { Time.local(2015, 12, 1) }
  let(:time_2) { Time.local(2016, 1, 21) }

  it 'travel in time' do
    Timecop.travel(time_1)

    expect(Time.now.year).to eq 2015
    expect(Time.now.month).to eq 12
    expect(Time.now.day).to eq 1

    Timecop.travel(time_2)

    expect(Time.now.year).to eq 2016
    expect(Time.now.month).to eq 1
    expect(Time.now.day).to eq 21

    Timecop.return
  end
end
