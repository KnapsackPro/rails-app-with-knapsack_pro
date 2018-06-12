describe 'Time travel with ActiveSupport::Testing::TimeHelpers' do
  context 'travel_back' do
    before { travel_to Time.new(2004, 11, 24, 01, 04, 44) }
    after { travel_back }

    it do
      expect(Time.current.year).to eq 2004
      expect(Time.now.year).to eq 2004

      # ensure knapsack_pro adds raw method
      # to detect real time
      expect(Time.raw_now.year).to be >= 2017
    end
  end

  context 'travel_to block' do
    let!(:yesterday) { 1.day.ago }

    it do
      travel_to(1.day.ago) do
        expect(Time.current.day).to eq yesterday.day
        expect(Time.raw_now.year).to be >= 2017
      end
    end
  end

  context 'travel_to block 2014' do
    let!(:time_2014) { Time.new(2004, 11, 24, 01, 04, 44) }

    it do
      travel_to(time_2014) do
        expect(Time.current.year).to eq 2004
        expect(Time.raw_now.year).to be >= 2017
      end
    end
  end
end
