class AddReference < ActiveRecord::Migration[7.0]
  def change
    # add_column :gardens, :garden_owner_id
    # add_index :gardens, :garden_owner_id
    add_reference :gardens, :garden_owner, foreign_key: { to_table: :users, index: false }
  end
end
