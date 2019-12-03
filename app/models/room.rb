class Room < ApplicationRecord
  has_many :messages
  has_many :room_users

  def self.find_by_active_user
    
  end
end
