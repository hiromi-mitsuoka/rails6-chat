import consumer from "./consumer"

// turbolinks
document.addEventListener('turbolinks:load', () =>{
  // js.erb内で使用する変数を定義
  window.dmMessageContainer = document.getElementById('dm_message-container')
  window.dmMessageContainerNotMessage = document.getElementById('no_message_but_move_js')
  window.dmMessages = document.getElementById('dm_messages')
  
  // 他のページで動作しないよう制限
  if (dmMessageContainer === null && dmMessageContainerNotMessage === null){
    return
  }
  
  consumer.subscriptions.create({channel: "DmRoomChannel", room: $('#dm_messages').data('room_id')}, {
    connected() {
      // Called when the subscription is ready for use on the server
    },
  
    disconnected() {
      // Called when the subscription has been terminated by the server
    },
  
    received(data) {
      // console.log("data_dm_user_id = " + data['dm_user']['id']);
      // 送信者以外はbroadcastでレンダリング 、送信者はcurrent_userを使うためにredirectでレンダリング 
      if(data['dm_user']['id'] != dm_current_user_num){
        dmMessageContainer.insertAdjacentHTML('beforeend', data['dm_message'])
        scrollToBottom()
        // console.log("Bloadcast!!!")
      }else{
        return
      }
    }
  });
  
  
  
  const documentElement = document.documentElement
  // js.erb内で使用する変数定義
  window.dmMessageContent = document.getElementById("dm_message_content")
  window.dmImagesContent = document.getElementById("dm_images_content")
  
  // 送信者かどうかのチェックのために定義
  var dm_current_user_num = $('#dm_current_user_num').val();
  // console.log("current_user = " + current_user_num);
  
  window.scrollToBottom = () => {
    window.scroll(0, documentElement.scrollHeight)
  }
  
  
  
  console.log("test DM_room_channel")
  
  // フォームが入力された時、空欄でなければ有効化、空欄なら無効化
  const dmMessageButton = document.getElementById("dm_message-button")
  
  // disabledのtoggle関数
  const dm_button_activation = () => {
    if (dmMessageContent.value === "" && dmImagesContent.value === ""){
      dmMessageButton.classList.add('disabled')
    }else{
      dmMessageButton.classList.remove('disabled')
    }
  }
  
  // フォーム入力時の操作
  dmMessageContent.addEventListener('input', () => {
    dm_button_activation()
    dmChangeLineCheck()
  })
  
  dmImagesContent.addEventListener('input', () => {
    dm_button_activation()
  })
  
  dmMessageButton.addEventListener('click', () => {
    dmMessageButton.classList.add('disabled')
    dmChangeLineCount(1)
  })
  
  // フォームの最大行数
  const maxLineCount = 10
  
  // 入力メッセージの行数を調べる
  const getLineCount = () => {
    return (dmMessageContent.value + '\n').match(/\r?\n/g).length;
  }
  
  let lineCount = getLineCount()
  let newLineCount
  
  const dmChangeLineCheck = () => {
    // 現在の入力行数を取得
    newLineCount = Math.min(getLineCount(), maxLineCount)
    // 以前の入力行数と異なる場合は変更
    if (lineCount !== newLineCount) {
      dmChangeLineCount(newLineCount)
    }
  }
  
  
  const footer = document.getElementById('dm_footer')
  let footerHeight = footer.scrollHeight
  let newFooterHeight, footerHeightDiff
  
  const dmChangeLineCount = (newLineCount) => {
    // フォームの行数変更
    dmMessageContent.rows = lineCount = newLineCount
    // 新しいfooterの高さ取得し、違いを計算
    newFooterHeight = footer.scrollHeight
    footerHeightDiff = newFooterHeight - footerHeight
    // 新しいfooterの高さをチャット欄のpadding-bottomに反映しスクロール
    // 行数が増える時と減る時で操作順を変更しないとうまくいかない
    if (footerHeightDiff > 0){
      dmMessageContainer.style.paddingBottom = newFooterHeight + "px"
      window.scrollBy(0, footerHeightDiff)
    }else{
      window.scrollBy(0, footerHeightDiff)
      dmMessageContainer.style.paddingBottom = newFooterHeight + "px"
    }
    footerHeight = newFooterHeight
  }
  
  
  // 全体トークの無限スクロール対応
  
  let oldestMessageId
  // メッセージの追加読み込みの可否を決定
  window.showAdditionally = true
  
  window.addEventListener('scroll', () => {
    if (documentElement.scrollTop === 0 && showAdditionally) {
      showAdditionally = false
      // 表示済みのメッセージの中で一番古いidを取得
      oldestMessageId = document.getElementsByClassName('message')[0].id.replace(/[^0-9]/g, '')
      // Ajaxを利用してメッセージの追加読み込みリクエストを送る。最も古いメッセージidも込み
      $.ajax({
        type: "GET",
        url: "/dm_show_additionally",
        cache: false,
        data: { oldest_message_id: oldestMessageId, remote: true }
      })
    }
  }, { passive: true });
  
  scrollToBottom()
})

