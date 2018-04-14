require 'rails_helper'

module Kazutori
  RSpec.describe Count, type: :model do
    describe 'validations' do
      it { is_expected.to validate_presence_of :count }
      it { is_expected.to validate_numericality_of(:count).only_integer }
      it { is_expected.to validate_numericality_of(:count).is_greater_than(0) }
      it { is_expected.to validate_presence_of :hour }
    end
  end
end
