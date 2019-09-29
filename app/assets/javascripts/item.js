$(document).on('turbolinks:load', function(){

  var large_item_box = $('.detail__box__item__image--large');
  var small_item_box = $('.detail__box__item__image--small');
  var small_item_src;

  small_item_box.children('img').on('mouseover',function(){
  //画像の切り替え機能
  small_item_src = $(this).attr('src')
  large_item_box .children('img').attr('src',small_item_src)
})


});