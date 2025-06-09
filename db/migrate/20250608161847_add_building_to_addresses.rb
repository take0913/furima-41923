class AddBuildingToAddresses < ActiveRecord::Migration[7.1]
  def change
    add_column :addresses, :building, :string
  end
end
