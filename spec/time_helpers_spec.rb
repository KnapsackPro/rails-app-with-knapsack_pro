describe 'Time travel with ActiveSupport::Testing::TimeHelpers' do
  context 'travel_back' do
    before { travel_to Time.new(2004, 11, 24, 01, 04, 44) }
    after { travel_back }

    it do
      expect(Time.current.year).to eq 2004
    end
  end

  context 'travel_to block' do
    let!(:yesterday) { 1.day.ago }

    it do
      travel_to(1.day.ago) do
        expect(Time.current.day).to eq yesterday.day
      end
    end
  end
end
