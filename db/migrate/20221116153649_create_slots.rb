class CreateSlots < ActiveRecord::Migration[7.0]
  def change
    create_table :slots do |t|
      t.datetime :start_time, null: false, default: DateTime.now
      t.datetime :end_time, null: false, default: DateTime.now
      t.integer :total_capacity, null: false, default: 0
      t.timestamps
    end
  end
end
