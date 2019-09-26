$(document).on('turbolinks:load', function() {
  $(function() {

    function changeFeeAndProfit(fee, profit) {
      var feeHtml = '';
      var profitHtml = '';
      feeHtml = `<div class = fee-form__right>
                    <div class = fee-form__right__text>
                      ¥
                      ${fee}
                    </div>
                  </div>`;

      profitHtml = `<div class = profit-form__right>
                      <div class = profit-form__right__text>
                        ¥
                        ${profit}
                      </div>
                    </div>`;

      $('.fee-form').append(feeHtml);
      $('.profit-form').append(profitHtml);
    }

    function addFeeAndProfitForm(empty_text) {
      var emptyFeeHtml = `<div class = fee-form__right>
                            <div class = fee-form__right__text>
                              ${empty_text}
                            </div>
                          </div>`;

      var emptyProfitHtml = `<div class = profit-form__right>
                        <div class = profit-form__right__text>
                          ${empty_text}
                        </div>
                      </div>`;

      $('.fee-form').append(emptyFeeHtml);
      $('.profit-form').append(emptyProfitHtml);
    }

    $('.input-price').on('keyup', function(e) {
      e.preventDefault;
      var input_count = $(this).val();

      if (input_count >= 300 && input_count <= 9999999 ) {
        $('.fee-form__right').remove();
        $('.profit-form__right').remove();
        var cal_fee = input_count * 0.1;
        var fee = Math.floor(cal_fee);
        var profit = input_count - fee;

        changeFeeAndProfit(fee, profit);

        $('.fee-form__right__text').text("¥" + fee);
        $('.profit-form__right__text').text("¥" + profit);
      }
      else { //範囲外の数値が入力されたら、表示をデフォルトに戻す
        $('.fee-form__right').remove();
        $('.profit-form__right').remove();
        var empty_text = "---";
        addFeeAndProfitForm(empty_text);
      }
    });
  });
});