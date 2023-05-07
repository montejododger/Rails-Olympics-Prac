class UpdateGarden < ActiveRecord::Migration[7.0]
  def change
    remove_column :gardens, :garden_owner_id

  end
end
