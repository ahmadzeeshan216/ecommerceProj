$(document).ready(function() {

    alert("ready!");
    $("#cmnt_submin").click(function() {
        product_id_ = $("#product_id").val();
        cmnt_body = $("#cmnt_body").val();
        token = $("#authenticity_token").val();

        data = { body: cmnt_body, product_id: product_id_, authenticity_token: token };
        url = '/comments.json';

        $.ajax({
            url: url,
            data: data,
            cache: false,

            type: "post",
            success: function(data) {
                alert(data.r);
            }
        });
    });
});