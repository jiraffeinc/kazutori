class CreateKazutoriCounts < ActiveRecord::Migration[5.1]
  def change
    create_table :kazutori_counts do |t|
      t.references :countable, polymorphic: true, index: false
      t.integer :count
      t.datetime :hour

      t.timestamps
      t.index [:countable_type, :countable_id, :hour], unique: true, name: "index_coutable_hour", length: {countable_type: 191}
    end
  end
end
