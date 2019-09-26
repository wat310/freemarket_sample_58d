// 公式のpayjsnのコード
// $(document).on('turbolinks:load',function() {
//   Payjp.setPublicKey('pk_test_7e69455f3e701137c2af4142');
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
// payjp処理・記事参考に流れ記載
// var form = $("#card__form");
//   Payjp.setPublicKey("pk_test_1e8e6918e2d54a6b56d6ca29");
//     //↑テスト公開鍵
//   $("#submit_btn").on("click",function(e){
//     e.preventDefault();
//     //↑railsの処理を止めてjsの処理を行う
//     var card = {
//       number: $("#card_number").val(),
//       cvc: $("#card_cvc").val(),
//       exp_month: $("#card_month").val(),
//       exp_year: $("#card_year").val()
//     };
//     //↑Pay.jpに登録するデータを準備
//     Payjp.createToken(card,function(status,response){
//     //↑先ほどのcard情報がトークンという暗号化したものとして返ってくる
//       form.find("input[type=submit]").prop("disabled", true);
//       if(status == 200){ //←成功は200
//         $("#card_number").removeAttr("name");
//         $("#card_cvc").removeAttr("name");
//         $("#card_month").removeAttr("name");
//         $("#card_year").removeAttr("name");
//         //↑removeAttr("name")でデータを保持しないように消す
//         var payjphtml = `<input type="hidden" name="payjpToken" value=${response.id}>`
//         form.append(payjphtml);
//         //↑dbにトークンを保存するのでjsで作ったトークンをセット
//         document.inputForm.submit();
//         //↑ここでsubmit！railsのアクションへ。上でトークンをセットしているのでparamsの中には{payjpToken="トークン"}という情報が入っている
//       }else{
//         alert("カード情報が正しくありません。");
//       }
//     });
//   });

// --------------------------------------------
// 参考その２
document.addEventListener(
  "DOMContentLoaded", e => {
    if (document.getElementById("token_submit") != null) { //token_submitというidがnullの場合、下記コードを実行しない
      Payjp.setPublicKey("pk_test_61fe8dd669a59526fd8542f5"); //ここに公開鍵を直書き
      let btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得
      btn.addEventListener("click", e => { //ボタンが押されたときに作動
        e.preventDefault(); //ボタンを一旦無効化
        let card = {
          number: document.getElementById("card_number").value,
          cvc: document.getElementById("cvc").value,
          exp_month: document.getElementById("exp_month").value,
          exp_year: document.getElementById("exp_year").value
        }; //入力されたデータを取得
        Payjp.createToken(card, (status, response) => {
          if (status === 200) { //成功した場合
            $("#card_number").removeAttr("name");
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name"); //データを自サーバにpostしないように削除
            $("#card_token").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
            ); //取得したトークンを送信できる状態に
            document.inputForm.submit();
            alert("登録が完了しました"); //確認用
          } else {
            alert("カード情報が正しくありません。"); //確認用
          }
        });
      });
    }
  },
  false
);