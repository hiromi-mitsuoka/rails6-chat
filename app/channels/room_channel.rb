class RoomChannel < ApplicationCable::Channel
  def subscribed
    # test
    # puts "******Channel******"
    
    # 配信するroom名を決定
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  
  

  # def speak(data)
  #   # jsからspeakのmessageを受け取り、room_channelのreceivedにbroadcast
  #   # ActionCable.server.broadcast "room_channel", message: data['message']
    
  #   Message.create! content: data['message']
  # end
end
