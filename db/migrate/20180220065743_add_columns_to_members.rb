class AddColumnsToMembers < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :image, :string
    add_column :members, :name, :string
    add_column :members, :birth, :date
  end
end
