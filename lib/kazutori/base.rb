require 'redis-namespace'
require 'globalid'
require 'active_support/time'

module Kazutori
  class Base
    def initialize(*args)
      @redis = Redis::Namespace.new solve_namespace(args), redis: Redis.new(url: ENV["REDIS_URL"])
    end

    def count_up(time=Time.zone.now)
      @redis.incr(key_for(time)).to_i
    end

    def get_counts(range)
      @redis.mget(*range_keys_for(range)).map(&:to_i)
    end

    def delete_counts(range)
      @redis.del(*range_keys_for(range))
    end

    def flush_counts!(range)
      yield get_counts(range)
      delete_counts(range)
    end

    private
    def solve_namespace(namespace)
      namespace.flat_map do |object|
        if object.respond_to?(:to_global_id)
          object.to_global_id.to_s
        else
          object.to_s
        end
      end.join(':')
    end

    def key_for(time)
      raise NotImplementedError
    end

    def range_keys_for(range)
      raise NotImplementedError
    end
  end
end
