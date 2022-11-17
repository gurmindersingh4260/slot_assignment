class SlotSerializer < ApplicationSerializer
  attributes :start_time, :end_time, :total_capacity, :slot_collections
  has_many :slot_collections, if: Proc.new { |record| record.slot_collections.any? }
end
