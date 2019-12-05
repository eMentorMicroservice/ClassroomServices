class RemoveMistakeFromMessage < ActiveRecord::Migration[6.0]
  def change

    remove_column :messages, :integer, :string

    remove_column :messages, :user_id, :string
  end
end
