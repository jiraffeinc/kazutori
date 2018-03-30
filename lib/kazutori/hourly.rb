require 'kazutori/base'

module Kazutori
  class Hourly < Base
    def key_for(time)
      time.beginning_of_hour.to_i
    end

    def range_keys_for(range)
      [].tap do |keys|
        t = range.first.beginning_of_hour
        while t <= range.last
          keys << t.to_i
          t += 1.hour
        end
      end
    end
  end
end
