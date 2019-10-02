// MEMO:現在簡易varのため未使用
$(document).on('turbolinks:load', function(){

  function toggleChangeBtn() {
      var slideIndex = $('.srider-box').index($('.slider'));
      $('.button').show();
      if(slideIndex == 0){
          $('.prev').hide();
      }else if(slideIndex == $('.srider-box').length - 1){
          $('.next').hide();
        }
      }
  toggleChangeBtn();

  $('.next').click(function() {
      var $displaySlide = $('.slider');
      $displaySlide.removeClass('.slider');
      $displaySlide.next().addClass('.slider');
      toggleChangeBtn();
    });
  $('.prev').click(function() {
     var $displaySlide = $('.slider');
     $displaySlide.removeClass('.slider');
     $displaySlide.prev().addClass('.slider');
     toggleChangeBtn();
    });
});