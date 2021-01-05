class DmRoomChannel < ApplicationCable::Channel
  def subscribed
    5.times { puts "*****DMChannel******" }
    stream_from "dm_room_channel_#{params['room']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
