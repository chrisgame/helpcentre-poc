function findProduct(pathToArticle){
    $.get(pathToArticle, function(articleContents){
      $('#article').html(articleContents)
    })
}

function addArticle(){
    $.get('/article/store', {productName: $("[name=productName]").val(), text: $("[name=article]").val()})
    if ($("[name=productName]").val() == ''){
        $('.error').html('Articles must be associated with at least one product or problem').removeClass('hidden');
    }
}