class CreateRelationships < ActiveRecord::Migration
  
  def change
    create_table :relationships do |t|
      t.integer :listener_id
      t.integer :loudspeaker_id

      t.timestamps null: false
    end
    add_index :relationships, :listener_id
    add_index :relationships, :loudspeaker_id
    add_index :relationships, [:listener_id, :loudspeaker_id], unique: true
  end
end
