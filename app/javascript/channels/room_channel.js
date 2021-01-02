import consumer from "./consumer"

// turbolinksの読み込み後にidを取得しないとエラー
document.addEventListener('turbolinks:load', () => {
  // js.erb内で使用できるよう変数定義
  window.messageContainer = document.getElementById('message-container')
  
  // 他のページで動作しないよう制限
  if (messageContainer === null){
    return
  }
  
  consumer.subscriptions.create("RoomChannel", {
    connected(){}, 
    
    disconnected(){},
    
    received(data){
      // サーバー側から受け取ったHTMLを最後に加える
      messageContainer.insertAdjacentHTML('beforeend', data['message'])
    }
    
  })
  
  
  // ページを開いた時にページの一番下に移動
  
  const documentElement = document.documentElement
  // js.erb内でも使用できるように変数を決定
  window.messageContent = document.getElementById("message_content")
  
  window.scrollToBottom = () => {
    window.scroll(0, documentElement.scrollHeight)
  }
  
  scrollToBottom()
})




// const chatChannel = consumer.subscriptions.create("RoomChannel", {
  
//   // フロント側からサーバー側を監視できているかを確認できた時に動く
//   connected() {
//     console.log('connected!')
//   },

//   disconnected() {
//     // Called when the subscription has been terminated by the server
//   },

//   // dataを受け取った時のアクション
//   received(data) {
//     // test
//     // return alert(data['message']);
    
//     return $('#messages').append(data['message']);
//   },

//   // 実行されるとConsumer（Websocketコネクションのクライアント）になった
//   // RoomChannel#speak({ message: message})が呼ばれる
//   speak: function(message) {
//     return this.perform('speak', {
//       message: message
//     });
//   }
// });

// // // Enterキー押すと送信
// // $(document).on('keypress', '[data-behavior~=room_speaker]', (event) => {
// //   if(event.keyCode === 13){
// //     chatChannel.speak(event.target.value);
// //     event.target.value = '';
// //     return event.preventDefault();
// //   }
// // });
