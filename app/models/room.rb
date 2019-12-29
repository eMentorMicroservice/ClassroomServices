class Room < ApplicationRecord
  has_many :messages
  has_many :participants

  def isActive?
    return self.end_at >= DateTime.now
  end

  def extend_class(times)
    self.end_at += times.hours
    self.save
    return self
  end

  def self.request(student_id, teacher_id)
    r = Room.find_by_active_user(student_id)
    if !r
      room = Room.create(end_at: 2.hours.from_now)
      room.participants.build(user_id: teacher_id)
      room.participants.build(user_id: student_id)
      if room.save
        return room
      else
        nil
      end
    else
      r
    end
  end

  def self.find_by_active_user(user_id)
    active_room = Room.active_room
    if active_room.length > 0
      p = Participant.where(room: Room.active_room, user_id: user_id).last
      p.room
    else
      nil
    end
  end

  def self.active_room
    Room.where(end_at: DateTime.now...DateTime::Infinity.new)
  end
end
