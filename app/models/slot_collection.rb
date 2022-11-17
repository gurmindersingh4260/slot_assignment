class SlotCollection < ApplicationRecord
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :capacity, presence: true
  belongs_to :slot, class_name: 'Slot', foreign_key: 'slot_id', optional: true
end
