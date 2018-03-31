class CreateKazutoriCounts < ActiveRecord::Migration[5.1]
  def change
    create_table :kazutori_counts do |t|
      t.references :countable, polymorphic: true
      t.integer :count
      t.datetime :hour

      t.timestamps
    end
  end
end
