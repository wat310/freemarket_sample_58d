$(document).on('turbolinks:load', function() {
  $(function() {

    var search_list = $('#search_brand_result');

    function appendBrand(brand) {
      var html = `<li class = 'brand_list' id = '${brand.id}'>${brand.name}</li>`;
      search_list.append(html);
    }

    //ブランドのインクリメンタルサーチ
    $('.input-brand').on('keyup', function() {
      var input = $('.input-brand').val();
      var count = String(input.length); //入力された文字数をカウントする変数

      if (count != 0) { //入力文字数が1文字以上ならインクリメンタルサーチ実行
        $.ajax({
          type: 'GET',
          url: 'brand_search',
          data: { keyword: input },
          dataType: 'json'
        })
        .done(function(brands) {
          // var html = "";
          $('#search_brand_result').empty(); //キー入力のたびにリストを削除する
  
          brands.forEach(function(brand) {
            appendBrand(brand);
          });
        })
        .fail(function() {
          alert('ブランドの検索に失敗しました')
        })
      }
      else { //ボックスの中を空にしたら、リストを削除
        $('#search_brand_result').empty();
      }
    });

    //インクリメンタルサーチの結果をクリックした時
    $('#brand').on('click', '.brand_list', function(){
      var name = $(this).text();
      $('.input-brand').val(name);
      $('.brand_list').remove();
    })
  });
});