class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :band_id, null: false
      t.string :title, null: false
      t.string :recording_type, null: false
      t.integer :year, nulll:false
      t.timestamps null: false
    end

    add_index :albums, :band_id
  end
end
