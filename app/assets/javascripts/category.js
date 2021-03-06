$(document).on('turbolinks:load', function() {
  $(function() {
    function appendOption(category) {
      var html =`<option value="${category.name}" data-category="${category.id}" id="${category.id}" class="a">${category.name}</option>`;
      return html;
    }

    //子カテゴリーの表示
    function appendChildrenBox(insertHTML) {
      var childSelectHtml = '';
      childSelectHtml= `<div class='form_group' id='children'>
                          <select class='select' id='child_category' name='child_category'>
                            <option value='---' data-category='---'>---</option>
                            ${insertHTML}
                          </select>
                        </div>`;
      $('.category-forms').append(childSelectHtml);
    }

    //孫カテゴリーの表示
    function appendGrandchildrenBox(insertHTML) {
      var grandchildSelectHtml = '';
      grandchildSelectHtml = `<div class='form_group' id='grandchildren'>
                                <select class='select' id='grandchild_category' name='grandchild_category'>
                                  <option value='---' data-category='---'>---</option>
                                  ${insertHTML}
                                </select>
                              </div>`;
      $('.category-forms').append(grandchildSelectHtml);
    }

    //ブランドの表示
    function appendBrandBox() {
    var brandHtml = '';
    brandHtml = `<div class = 'form-group' id = 'brand'>
                  <label class = 'label'>
                    ブランド
                    <span class = 'form-free'>任意</span>
                  </label>
                  <br>
                  <input type = 'text' name = "item[brand]" class = 'input-brand' id ='item_brand' placeholder = '例) シャネル'>
                  <input type = 'hidden' name = "item[brand_id]" id = 'brand_result_id'>
                  <ul id = 'search_brand_result'></ul>
                </div>`;
    $('#state').before(brandHtml);
    }

    //親カテゴリー選択後に発生するイベント
    $('#parent_category').on('change', function() {
      var parentCategory = $('#parent_category').val(); //親カテゴリーの名前を取得
      if (parentCategory != "---") { //親カテゴリーが初期値でないなら
        $.ajax({ //ajax通信を実行
          url: '/items/get_category_children', //routes.rbに記載
          type: 'GET',
          dataType: 'json',
          data: {parent_info: parentCategory} //リクエストで一緒に送るデータ
        })
        .done(function(children) { //成功したら
          $('#children').remove(); //親が変更された時に子、孫、ブランド、サイズを隠す
          $('#grandchildren').remove();
          $('#brand').remove();
          // $('#size').remove();
          $('#size').css({
            'display': 'none'
          });
          $('#size_edit').css({
            'display': 'none'
          });

          var insertHTML = '';
          children.forEach(function(child) {
            insertHTML += appendOption(child);
          })
          appendChildrenBox(insertHTML);
        })
        .fail(function() {
          alert('カテゴリー取得に失敗しました')
        })
      }
      else { //親カテゴリーが初期値だったら、子以下は隠す
        $('#children').remove();
        $('#grandchildren').remove();
        $('#brand').remove();
        $('#size').css({
          'display': 'none'
        });
        $('#size_edit').css({
          'display': 'none'
        });
      }
    });

    //子カテゴリー選択後に発生するイベント
    $('.category-forms').on('change', '#child_category', function() {
      var childId = $('#child_category option:selected').data('category'); //子要素のidを取得
      if (childId != "---") { //子カテゴリーが初期値でなければ
        $.ajax({ //ajax通信を実行
          url: '/items/get_category_grandchildren', //routes.rbに記載
          type: 'GET',
          dataType: 'json',
          data: {child_id: childId} //リクエストで一緒に送るデータ
        })
        .done(function(grandchildren) { //成功したら
          if (grandchildren.length != 0) {
            $('#grandchildren').remove(); //子が変更された時に孫、ブランド、サイズを隠す
            $('#brand').remove();
            $('#size').css({
              'display': 'none'
            });
            $('#size_edit').css({
              'display': 'none'
            });
  
            var insertHTML = '';
            grandchildren.forEach(function(grandchild) {
              insertHTML += appendOption(grandchild);
            });
            appendGrandchildrenBox(insertHTML);
          }
        })
        .fail(function() {
          alert('カテゴリー取得に失敗しました');
        })
      }
      else {
        $('#grandchildren').remove(); //子カテゴリーが初期値だったら、孫以下は隠す
            $('#brand').remove();
            $('#size').css({
              'display': 'none'
            });
            $('#size_edit').css({
              'display': 'none'
            });
      }
    });

    //孫カテゴリー選択後に発生するイベント
    $(document).on('change', '#grandchild_category', function() {
      $('#brand').remove();
      $('#size').css({
        'display': 'none'
      });
      $('#size_select').val("");
      $('#size_edit').css({
        'display': 'none'
      });
      $('#size_edit').val("");

      var gc_id = $('#grandchild_category option:selected').attr('id');
      $('#grand_child_result_id').val(gc_id);
      var parent_name = $('#parent_category').val(); //親のテキストを取得
      var child_name = $('#child_category').val();

      // サイズの出現
      if (parent_name == "レディース" || parent_name == "メンズ") {
        $('#size').css({
          'display': 'block'
        });
        $('#size_edit').css({
          'display': 'block'
        });
      }

      // ブランドの出現
      if (parent_name == "レディース" || parent_name == "メンズ" || parent_name == "家電・スマホ・カメラ" || child_name == "飲料/酒") {
        appendBrandBox();
      }
    });
  });
});