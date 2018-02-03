class AddColumnGmapImage < ActiveRecord::Migration[5.1]
  def change
    add_column :gmaps,:image,:string
  end
end
