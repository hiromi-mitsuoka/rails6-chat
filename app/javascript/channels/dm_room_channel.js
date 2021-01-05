import consumer from "./consumer"

// turbolinks
document.addEventListener('turbolinks:load', () =>{
  // js.erb内で使用する変数を定義
  window.dmMessageContainer = document.getElementById('dm_message-container')
  
  // 他のページで動作しないよう制限
  if (dmMessageContainer === null){
    return
  }
  
  consumer.subscriptions.create({channel: "DmRoomChannel", room: $("#dm_messages").data("dm_room_id")}, {
    connected() {
      // Called when the subscription is ready for use on the server
    },
  
    disconnected() {
      // Called when the subscription has been terminated by the server
    },
  
    received(data) {
      // dmMessageContainer.insertAdjacentHTML('beforeend', data['dm_message'])
      dmMessageContainer.insertAdjacentHTML('beforeend', data['dm_message'])
    }
  });
  
  console.log("test DM_room_channel")
  
  const documentElement = document.documentElement
  // js.erb内で使用する変数定義
  window.dmMessageContent = document.getElementById("dm_message_content")
  window.dmImagesContent = document.getElementById("dm_images_content")
  
  // window.scrollToBottom = () => {
  //   window.scroll(0, documentElement.scrollHeight)
  // }
  
  // scrollToBottom()
  
  // フォームが入力された時、空欄でなければ有効化、空欄なら無効化
  const dmMessageButton = document.getElementById("dm_message-button")
  
  // disabledのtoggle関数
  const dm_button_activation = () => {
    if (dmMessageContent.value === ""){
      dmMessageButton.classList.add('disabled')
    }else{
      dmMessageButton.classList.remove('disabled')
    }
  }
  
  // フォーム入力時の操作
  dmMessageContent.addEventListener('input', () => {
    dm_button_activation()
  })
  
  // ifの条件にdmImagesContent.value === ""いれる
  // dmImagesContent.addEventListener('input', () => {
  //   dm_button_activation()
  // })
  
})

