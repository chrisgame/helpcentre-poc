function findProduct(pathToArticle){
    $.get(pathToArticle, function(articleContents){
      $('#article').html(articleContents)
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
        $('.error').html('Articles must be associated with at least one product or problem').removeClass('hidden');
    }
    else{
        if (productName == null){
            productName = $("[name=productName]").val()
        }
        $.get('/article/store', {productName: productName, text: $("[name=article]").val()});
        $('.error').addClass('hidden');
    }
}