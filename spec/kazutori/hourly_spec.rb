RSpec.describe Kazutori::Hourly do
  before { Redis.new.flushdb }
  describe "#count_up" do
    it "count up" do
      kazutori = Kazutori::Hourly.new
      expect(kazutori.count_up).to eq 1
      expect(kazutori.count_up).to eq 2
      kazutori = Kazutori::Hourly.new("other")
      expect(kazutori.count_up).to eq 1
      expect(kazutori.count_up).to eq 2
    end
  end
end
