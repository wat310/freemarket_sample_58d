$(document).on('turbolinks:load', function() {
  $(function() {

    $('.input-price').on('keyup', function(e) {
      e.preventDefault;
      var input_count = $(this).val();

      if (input_count >= 300 && input_count <= 9999999 ) {
        var cal_fee = input_count * 0.1;
        var fee = Math.floor(cal_fee);
        var profit = input_count - fee;

        $('.fee-form__right__text').text("¥" + fee);
        $('.profit-form__right__text').text("¥" + profit);
      }
      else { //範囲外の数値が入力されたら、表示をデフォルトに戻す
        $('.fee-form__right__text').text("-");
        $('.profit-form__right__text').text("-");
      }
    });
  });
});