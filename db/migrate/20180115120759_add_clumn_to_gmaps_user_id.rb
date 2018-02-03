class AddClumnToGmapsUserId < ActiveRecord::Migration[5.1]
  def change
    add_column :gmaps,:user_id,:integer
  end
end
