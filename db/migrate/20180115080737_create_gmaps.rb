class CreateGmaps < ActiveRecord::Migration[5.1]
  def change
    create_table :gmaps do |t|
      t.string :title
      t.text :coment
      t.string :magic_word
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
