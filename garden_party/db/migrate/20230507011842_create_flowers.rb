class CreateFlowers < ActiveRecord::Migration[7.0]
  def change
    create_table :flowers do |t|
      t.string :flower_type, null: false
      t.references :gardener, null: false, foreign_key: {to_table: :users}
      t.references :garden, null: false, foreign_key: true

      t.timestamps
    end
  end
end
