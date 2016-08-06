class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name, nulll:false
      t.integer :album_id, nulll:false
      t.integer :ord, nulll:false
      t.string :track_type, nulll:false
      t.text :lyrics
      t.timestamps null: false
    end

    add_index :tracks, :album_id
    add_index :tracks, [:album_id, :ord], unique: true
  end
end
