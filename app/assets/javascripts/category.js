$(document).on('turbolinks:load', function() {
  $(function() {
    function appendOption(category) {
      var html =`<option value="${category.name}" data-category="${category.id}">${category.name}</option>`;
      return html;
    }

    //子カテゴリーの表示
    function appendChildrenBox(insertHTML) {
      var childSelectHtml = '';
      childSelectHtml= `<div class = 'form_group' id = 'children'>
                          <select class = 'select' id = 'child_category' name = 'category_id'>
                            <option value = '---' data-category = '---'>---</option>
                            ${insertHTML}
                          </select>
                        </div>`;
      $('.category-forms').append(childSelectHtml);
    }

    //孫カテゴリーの表示
    function appendGrandchildrenBox(insertHTML) {
      var grandchildSelectHtml = '';
      grandchildSelectHtml = `<div class = 'form_group' id = 'grandchildren'>
                                <select class = 'select' id = 'grandchild_category' name = 'category_id'>
                                  <option value = '---' data-category = '---'>---</option>
                                  ${insertHTML}
                                </select>
                              </div>`;
      $('.category-forms').append(grandchildSelectHtml);
    }

    //サイズの表示

    //ブランドの表示
    function appendBrandBox(insertHTML) {
    var brandHtml = '';
    brandHtml = `<div class = 'form_group' id = 'brand'>
                  <label class = 'label'>ブランド</label>
                  <span class = 'form-free'>任意</span>
                  <br>
                  <input type = 'text' name = "brand" class = 'input-brand' placeholder = '例) シャネル'>
                </div>`;
    $('.sell-form-box').append(brandHtml);
    }

    //親カテゴリー選択後に発生するイベント
    $('#parent_category').on('change', function() {
      var parentCategory = $('#parent_category').val(); //親カテゴリーの名前を取得
      if (parentCategory != "---") { //親カテゴリーが初期値でないなら
        $.ajax({ //ajax通信を実行
          url: 'get_category_children', //routes.rbに記載
          type: 'GET',
          dataType: 'json',
          data: {parent_name: parentCategory} //リクエストで一緒に送るデータ
        })
        .done(function(children) { //成功したら
          $('#children').remove(); //親が変更された時に子、孫、ブランド、サイズを隠す
          $('#grandchildren').remove();
          // $('#brand').remove();
          // $('#size').remove();

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
        // $('#brand').remove();
        // $('#size').remove();
      }
    });

    //子カテゴリー選択後に発生するイベント
    $('.category-forms').on('change', '#child_category', function() {
      var childId = $('#child_category option:selected').data('category'); //子要素のidを取得
      if (childId != "---") { //子カテゴリーが初期値でなければ
        $.ajax({ //ajax通信を実行
          url: 'get_category_grandchildren', //routes.rbに記載
          type: 'GET',
          dataType: 'json',
          data: {child_id: childId} //リクエストで一緒に送るデータ
        })
        .done(function(grandchildren) { //成功したら
          if (grandchildren.length != 0) {
            $('#grandchildren').remove(); //子が変更された時に孫、ブランド、サイズを隠す
            // $('#brand').remove();
            // $('#size').remove();
  
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
            // $('#brand').remove();
            // $('#size').remove();
      }
    });

    //孫カテゴリー選択後に発生するイベント
    $('category-forms').on('chabge', '#grandchild_category', function() {
      // var grandchildId = $('#grandchild_category option:selected').data('category'); //孫要素のidを取得

    });

  });
});