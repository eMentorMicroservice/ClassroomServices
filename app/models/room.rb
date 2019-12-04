class Room < ApplicationRecord
  has_many :messages
  has_many :room_users


  def self.request(user_id)
    room = Room.create(end_at: 2.hours.from_now)
    room.room_users.build(user_id: user_id)
  end
  def self.find_by_active_user(user_id)
    Room.active_room
  end

  def self.active_room
    Room.select(:id).where(end_at: DateTime.now...DateTime::Infinity.new)
  end

  
end
