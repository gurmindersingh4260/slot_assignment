# frozen_string_literal: true

class Slot < ApplicationRecord
  validates :start_time, presence: true
  validates :end_time, presence: true , date: { after_or_equal_to: :start_date }
  validates :total_capacity, presence: true

  has_many :slot_collections
end
