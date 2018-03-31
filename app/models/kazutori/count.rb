module Kazutori
  class Count < ActiveRecord::Base
    belongs_to :countable, polymorphic: true
    validates :count, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :hour, presence: true
  end
end
