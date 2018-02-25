class RemoveColumnToGmapsMemberId < ActiveRecord::Migration[5.1]
  def change
    remove_column :gmaps,:member_id
  end
end
