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
    connected(){
      
    }, 
    
    disconnected(){
      
    },
    
    received(data){
      // console.log("data_user_id = " + data['user']['id']);
      // 送信者以外はbroadcastでレンダリング 、送信者はcurrent_userを使うためにredirectでレンダリング 
      if(data['user']['id'] != current_user_num){
        messageContainer.insertAdjacentHTML('beforeend', data['message'])
        scrollToBottom()
        // console.log("Bloadcast!!!")
      }else{
        return
      }
    }
    
  })
  
  console.log("test room_channel")
  
  const documentElement = document.documentElement
  // js.erb内でも使用できるように変数を決定
  window.messageContent = document.getElementById("message_content")
  window.imagesContent = document.getElementById("images_content")

  // 送信者かどうかのチェックのために定義
  var current_user_num = $('#current_user_num').val();
  // console.log("current_user = " + current_user_num);
  
  window.scrollToBottom = () => {
    window.scroll(0, documentElement.scrollHeight)
  }
  
  
  
  // フォームが入力された時、空欄でなければ有効化、空欄なら無効化
  const messageButton = document.getElementById("message-button")
  
  // disabledのtoggle関数
  const button_activation = () => {
    if (messageContent.value === "" && imagesContent.value === ""){
      messageButton.classList.add('disabled')
    }else{
      messageButton.classList.remove('disabled')
    }
  }
  
  // フォーム入力時の動作
  messageContent.addEventListener('input', () => {
    button_activation()
    changeLineCheck()
  })
  
  // 画像フォルダにセット時の動作
  imagesContent.addEventListener('input', () => {
    button_activation()
  })
  
  // 送信ボタンを押した時に無効化
  messageButton.addEventListener('click', () => {
    messageButton.classList.add('disabled')
    changeLineCount(1)
  })
  
  // フォームの最大行数
  const maxLineCount = 10
  
  // 入力メッセージの行数を調べる
  const getLineCount = () => {
    return (messageContent.value + '\n').match(/\r?\n/g).length;
  }
  
  let lineCount = getLineCount()
  let newLineCount
  
  const changeLineCheck = () => {
    // 現在の入力行数を取得
    newLineCount = Math.min(getLineCount(), maxLineCount)
    // 以前の入力行数と異なる場合は変更
    if (lineCount !== newLineCount) {
      changeLineCount(newLineCount)
    }
  }
  
  
  const footer = document.getElementById('footer')
  let footerHeight = footer.scrollHeight
  let newFooterHeight, footerHeightDiff
  
  const changeLineCount = (newLineCount) => {
    // フォームの行数変更
    messageContent.rows = lineCount = newLineCount
    // 新しいfooterの高さ取得し、違いを計算
    newFooterHeight = footer.scrollHeight
    footerHeightDiff = newFooterHeight - footerHeight
    // 新しいfooterの高さをチャット欄のpadding-bottomに反映しスクロール
    // 行数が増える時と減る時で操作順を変更しないとうまくいかない
    if (footerHeightDiff > 0){
      messageContainer.style.paddingBottom = newFooterHeight + "px"
      window.scrollBy(0, footerHeightDiff)
    }else{
      window.scrollBy(0, footerHeightDiff)
      messageContainer.style.paddingBottom = newFooterHeight + "px"
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
        url: "/show_additionally",
        cache: false,
        data: { oldest_message_id: oldestMessageId, remote: true }
      })
    }
  }, { passive: true });
  
  // 最初にページ一番下に移動
  scrollToBottom()
})




