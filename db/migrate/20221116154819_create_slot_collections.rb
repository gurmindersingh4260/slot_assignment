class CreateSlotCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :slot_collections do |t|
      t.integer :capacity, null: false, default: 0
      t.datetime :start_time, null: false, default: DateTime.now
      t.datetime :end_time, null: false, default: DateTime.now
      t.references :slot
      # , polymorphic: { default: 'Photo' }
      t.timestamps
    end
  end
end
