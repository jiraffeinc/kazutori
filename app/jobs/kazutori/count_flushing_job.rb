require 'activerecord-import'
module Kazutori
  class CountFlushingJob < ApplicationJob
    queue_as :default
    def perform(counter_name, class_name, date_string)
      target_class = class_name.constantize
      counter_class = counter_name.constantize
      time_range = Time.zone.parse(date_string).all_day
      target_class.unscoped.find_in_batches do |records|
        access_counts = records.flat_map do |record|
          counter = counter_class.new(record)
          counter.flush_counts!(time_range) do |counts|
            counts.map.with_index.select { |count, _| count > 0 }.map do |count, i|
              Kazutori::Count.new(count: count, hour: time_range.first + counter.next(i), countable: record)
            end
          end
        end
        Kazutori::Count.import(access_counts).tap do |result|
          result.failed_instances.first.validate! if result.failed_instances.present?
        end
      end
    end
  end
end
