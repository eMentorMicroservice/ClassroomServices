class AddUserToMessage < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :user_id, :integer, index: true
  end
end
