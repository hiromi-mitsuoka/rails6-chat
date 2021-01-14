// 画像がセットされたらpink
// $pink: #C14F7E;

// var imageFile = document.getElementsByClassName("images-on");
var changeColor = document.getElementsByClassName("change-color");

$('.images-on').on('change', function () {
  if (imageFile.value !== ""){
    changeColor[0].style.color = "#C14F7E";
  }else{
    changeColor[0].style.color = "gray"
  }
});