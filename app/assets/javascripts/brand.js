$(document).on('turbolinks:load', function() {
  $(function() {

    function appendBrand(brand, search_list) {
      var html = `<li class = 'brand_list' id = '${brand.id}'>${brand.name}</li>`;
      search_list.append(html);
    }

    //ブランドのインクリメンタルサーチ
      $(document).on('keyup', '#item_brand', function() {
      var input = $('.input-brand').val();
      var count = String(input.length); //入力された文字数をカウントする変数
      var search_list = $('#search_brand_result');

      if (count != 0) { //入力文字数が1文字以上ならインクリメンタルサーチ実行
        $.ajax({
          type: 'GET',
          url: '/items/brand_search',
          data: { keyword: input },
          dataType: 'json'
        })
        .done(function(brands) {
          $('#search_brand_result').empty(); //キー入力のたびにリストを削除する
          console.log(input);
          console.log(count);
          brands.forEach(function(brand) {
            appendBrand(brand, search_list);
            console.log(brand);
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
    $(document).on('click', '.brand_list', function(){
      var name = $(this).text();
      var id = $(this).attr('id');
      $('.input-brand').val(name);
      $('#brand_result_id').val(id);
      $('.brand_list').remove();
    })
  });
});