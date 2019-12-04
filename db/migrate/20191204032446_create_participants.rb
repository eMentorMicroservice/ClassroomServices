class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.references :room, null: false, foreign_key: true
      t.integer :user_id

      t.timestamps
    end
  end
end
