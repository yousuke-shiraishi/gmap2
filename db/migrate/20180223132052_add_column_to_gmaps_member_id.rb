class AddColumnToGmapsMemberId < ActiveRecord::Migration[5.1]
  def change
    add_column :gmaps, :member_id, :integer
  end
end
