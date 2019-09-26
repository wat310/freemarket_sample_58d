// var form = $("#card__form");
//   Payjp.setPublicKey("pk_test_1e8e6918e2d54a6b56d6ca29");
//     //↑テスト公開鍵をセット
//   $("#submit_btn").on("click",function(e){
//     e.preventDefault();
//     //↑ここでrailsの処理を止めてjsの処理を行う
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
//       if(status == 200){ //←うまくいった場合200になり
//         $("#card_number").removeAttr("name");
//         $("#card_cvc").removeAttr("name");
//         $("#card_month").removeAttr("name");
//         $("#card_year").removeAttr("name");
//         //↑removeAttr("name")でデータを保持しないように消す
//         var payjphtml = `<input type="hidden" name="payjpToken" value=${response.id}>`
//         form.append(payjphtml);
//         //↑dbにトークンを保存するのでjsで作ったトークンをセット
//         document.inputForm.submit();
//         //↑ここでsubmit！これでrailsのアクションへ。上でトークンをセットしているのでparamsの中には{payjpToken="トークン"}という情報が入っている
//       }else{
//         alert("カード情報が正しくありません。");
//       }
//     });
//   });

// // document.addEventListener(
// //   "DOMContentLoaded", e => {
// //     if (document.getElementById("token_submit") != null) { //token_submitというidがnullの場合、下記コードを実行しない
// //       Payjp.setPublicKey("pk_test_61fe8dd669a59526fd8542f5"); //ここに公開鍵を直書き
// //       let btn = document.getElementById("token_submit"); //IDがtoken_submitの場合に取得されます
// //       btn.addEventListener("click", e => { //ボタンが押されたときに作動します
// //         e.preventDefault(); //ボタンを一旦無効化します
// //         let card = {
// //           number: document.getElementById("card_number").value,
// //           cvc: document.getElementById("cvc").value,
// //           exp_month: document.getElementById("exp_month").value,
// //           exp_year: document.getElementById("exp_year").value
// //         }; //入力されたデータを取得します。
// //         Payjp.createToken(card, (status, response) => {
// //           if (status === 200) { //成功した場合
// //             $("#card_number").removeAttr("name");
// //             $("#cvc").removeAttr("name");
// //             $("#exp_month").removeAttr("name");
// //             $("#exp_year").removeAttr("name"); //データを自サーバにpostしないように削除
// //             $("#card_token").append(
// //               $('<input type="hidden" name="payjp-token">').val(response.id)
// //             ); //取得したトークンを送信できる状態にします
// //             document.inputForm.submit();
// //             alert("登録が完了しました"); //確認用
// //           } else {
// //             alert("カード情報が正しくありません。"); //確認用
// //           }
// //         });
// //       });
// //     }
// //   },
// //   false
// // );