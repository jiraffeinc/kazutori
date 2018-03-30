require 'redis-namespace'
require 'globalid'
require 'active_support/time'

module Kazutori
  class Base
    def initialize(*args)
      @redis = Redis::Namespace.new solve_namespace(args), redis: Redis.new(url: ENV["REDIS_URL"])
    end

    def count_up
      @redis.incr(key_for(Time.zone.now)).to_i
    end

    private
    def solve_namespace(*namespace)
      namespace.flat_map do |object|
        if object.respond_to?(:to_global_id)
          object.to_global_id.to_s
        else
          object.to_sgit
        end
      end.join(':')
    end

    def key_for(time)
      raise NotImplementedError
    end
  end
end
