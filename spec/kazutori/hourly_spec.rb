RSpec.describe Kazutori::Hourly do
  let(:kazutori) { Kazutori::Hourly.new }

  describe "#count up" do
    it "count up" do
      expect(kazutori.count_up).to eq 1
      expect(kazutori.count_up).to eq 2
    end
  end
end
