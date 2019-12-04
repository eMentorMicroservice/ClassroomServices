class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.string :room_id
      t.string :references
      t.integer :user_id

      t.timestamps
    end
  end
end
