require 'rails_helper'

module Kazutori
  RSpec.describe CountFlushingJob, type: :job do
    let(:counter) { Kazutori::Hourly.new(item) }
    let(:item) { Item.new(1) }
    let(:the_time) { Time.zone.now }
    let(:the_time_range) { the_time.all_day }

    around do |example|
      Timecop.safe_mode = Timecop.safe_mode?.tap do |_|
        Timecop.safe_mode = true
        Timecop.freeze(the_time) do
          example.run
        end
      end
    end

    describe '.perform_now' do
      let(:class_name) { Item.name }
      let(:date_string) { the_time.strftime('%F') }

      subject { Kazutori::Count.order(:id).to_a }

      context 'アクセスなし' do
        before do
          described_class.perform_now(Kazutori::Hourly.name, class_name, date_string)
        end

        it { is_expected.to eq [] }
      end

      context 'アクセスあり', access_counter: :random_count do
        let(:the_day) { Time.zone.now.beginning_of_day }
        let(:expected_counts) { (1..24).to_a }
        let(:expected_counts_after_deletion) { [0] * 24 }

        before do
          100.times do
            Timecop.freeze(the_day - (1 + rand(30 * 24 * 60 * 60)).seconds) do
              counter.count_up
            end
          end
          (0..24).each do |i|
            Timecop.freeze(the_day + i.hours) do
              (i + 1).times do
                counter.count_up
              end
            end
          end
          100.times do
            Timecop.freeze(the_day + 1.day + rand(30 * 24 * 60 * 60).seconds) do
              counter.count_up
            end
          end
        end

        before do
          described_class.perform_now(Kazutori::Hourly.name, class_name, date_string)
        end

        let(:expected_hours) { (0...24).map { |i| the_day + i.hours } }

        it { expect(subject.map(&:count)).to eq expected_counts }
        it { expect(subject.map(&:hour)).to eq expected_hours }
      end
    end
  end
end
