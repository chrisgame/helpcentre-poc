function findProduct(productName){
    $.getJSON('/'+productName+'/json', function(data){
      var items = []

      $.each(data, function(key, value){
        items.push('<li id="' + key +'">' + value.text + '</li>');
      });

      $('#articleListContainer ul').replaceWith(
        $('<ul/>', {
          html: items.join('')
        })
      );

      $('#articleListContainer ul').attr("id", "articleList")
    })
}

function addArticle(){
    var productName
    var noneChecked = true
    $("[id^=product_]").each(function(){
        if (this.checked){
            noneChecked = false;
            productName = this.value;
        }
    })

    if ($("[name=productName]").val() == '' && noneChecked){
        $('.error').html('Articles must be associated with at least one product or topic').removeClass('hidden');
    }
    else{
        if (productName == null){
            productName = $("[name=productName]").val()
        }
        $.get('/article/store', {productName: productName, text: $("[name=article]").val()}, function(data){
            $('#saveResult').html("Save successful. Unique reference for article is <span id='uniqueId'>"+data+"</span>");
        });
        $('.error').addClass('hidden');
    }
}