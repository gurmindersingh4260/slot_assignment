class SlotCreator
  def initialize(params)
    @start_time = params[:start_time]
    @end_time = params[:end_time]
    @total_capacity = params[:total_capacity]
    @slot_time = 15 # in minutes
  end

  def call
    number_of_slots = calculate_number_of_slots(@start_time, @end_time, @slot_time)
    slot_collections = calculate_slot_collections(number_of_slots, @total_capacity, @slot_time, @start_time)
    # for slot Assign capacity to slot
    ActiveRecord::Base.transaction do
      @slot = Slot.create!({ start_time: @start_time, end_time: @end_time, total_capacity: @total_capacity })
      slot_collections.each do |slot_collection|
        SlotCollection.create({
                                start_time: slot_collection[:start_time],
                                end_time: slot_collection[:end_time],
                                capacity: slot_collection[:capacity],
                                slot_id: @slot.id
                              })
        @slot
      end
    rescue ActiveRecord::RecordNotSaved, ActiveRecord::RecordInvalid
      @slot.errors.add(:base, 'Error in creating the slot!!')
      false
    end
  end

  private

  def calculate_number_of_slots(start_time, end_time, slot_time)
    time_diff_in_minutes = time_diff(start_time, end_time)
    (time_diff_in_minutes / slot_time).ceil
  end

  def time_diff(start_time, end_time)
    (Time.parse(end_time.to_s) - Time.parse(start_time.to_s)) / 60
  end

  def calculate_slot_collections(number_of_slots, total_capacity, slot_time, start_time)
    slot_collections = []
    average_capacity = (total_capacity / number_of_slots).floor
    remaining_capacity = total_capacity
    (1..number_of_slots).each do
      slot_collection = { start_time:, end_time: start_time + slot_time, capacity: average_capacity }
      slot_collections.push(slot_collection)
      remaining_capacity -= average_capacity
    end
    unless remaining_capacity.zero?
      slot_collections.reverse.map do |slot_collection|
        slot_collection[:capacity] += 1
        remaining_capacity -= 1
        break if remaining_capacity.zero?
      end
    end
    slot_collections
  end
end
