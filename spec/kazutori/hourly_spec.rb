RSpec.describe Kazutori::Hourly do
  before { Redis.new.flushdb }
  it "works" do
    kazutori = Kazutori::Hourly.new
    expect(kazutori.count_up).to eq 1
    expect(kazutori.count_up).to eq 2
    expect(kazutori.count_up(1.hours.ago)).to eq 1
    expect(kazutori.count_up(1.hours.ago)).to eq 2
    kazutori.count_up(2.hours.ago)
    expect(kazutori.get_counts(1.hours.ago..Time.zone.now)).to eq [2, 2]
    expect(kazutori.get_counts(2.hours.ago..2.hours.ago)).to eq [1]
    kazutori.delete_counts(1.hours.ago..Time.zone.now)
    expect(kazutori.get_counts(1.hours.ago..Time.zone.now)).to eq [0, 0]

    kazutori = Kazutori::Hourly.new("other")
    expect(kazutori.count_up).to eq 1
    expect(kazutori.count_up).to eq 2
    expect(kazutori.keys).to eq [Time.zone.now.beginning_of_hour.to_i.to_s]
    expect(Kazutori.namespaces).to eq ["", "other"]
    kazutori.flush_counts!(Time.zone.now..Time.zone.now) do |counts|
      expect(counts).to eq [2]
    end
    expect(kazutori.get_counts(Time.zone.now..Time.zone.now)).to eq [0]
  end
end
