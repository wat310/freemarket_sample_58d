$(document).on('turbolinks:load', function(){
    if (document.getElementById("token_submit") != null) { //token_submitがnullは実行しない
      Payjp.setPublicKey("pk_test_1e8e6918e2d54a6b56d6ca29"); //test公開鍵
      let btn = document.getElementById("token_submit"); //IDがtoken_submitの場合取得
      btn.addEventListener("click", e => { //ボタンが押されたときに作動
        e.preventDefault(); //ボタンを一旦無効化
        let card = {
          number: document.getElementById("card_number").value,
          cvc: document.getElementById("cvc").value,
          exp_month: document.getElementById("exp_month").value,
          exp_year: document.getElementById("exp_year").value
        }; //入力されたデータ取得

        Payjp.createToken(card, (status, response) => {
          if (status === 200) { //成功
            $("#card_number").removeAttr("name");
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name"); //データを自サーバにpostしないように削除
            $("#token_submit").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
            ); //取得したトークン送信できる状態
            document.inputForm.submit();
            alert("登録が完了しました");
          } else {
            alert("カード情報が正しくありません。");
          }
        });
      });
    }
  false
}
); 

// --------------------------------------------
// 公式のpayjsnのコード
// $(document).on('turbolinks:load',function() {
//   Payjp.setPublicKey('keynom');
//   var form = $("#charge-form"),
//       number = form.find('input[name="number"]'),
//       cvc = form.find('input[name="cvc"]'),
//       exp_month = form.find('select[name="exp_month"]'),
//       exp_year = form.find('input[name="exp_year"]');

//   $("#charge-form").submit(function() {
//     console.log("fire1");
//     form.find("input[type=submit]").prop("disabled", true);

//     var card = {
//         number: number.value,
//         cvc: cvc.value,
//         exp_month: exp_month.value,
//         exp_year: exp_year.value
//     };
//     Payjp.createToken(card, function(s, response) {
//       if (response.error) {
//         form.find('.payment-errors').text(response.error.message);
//         form.find('#token_submit').prop('disabled', false);
//       }
//       else {
//         $(".number").removeAttr("name");
//         $(".cvc").removeAttr("name");
//         $(".exp_month").removeAttr("name");
//         $(".exp_year").removeAttr("name");

//         var token = response.id;

//         form.append($('<input type="hidden" name="payjpToken" />').val(token));
//         console.log("fire2");
//         form.get(0).submit();
//       }
//     });
//   });
// });
// --------------------------------------------