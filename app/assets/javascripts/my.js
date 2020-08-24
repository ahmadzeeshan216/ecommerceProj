function cmnt_edit_btn_click(id) {

    $(document).ready(function() {
        $("#cmnt_body_edit_txt_area" + id).val($("#cmnt_body_para_" + id).text())
        $("#cmnt_update_div" + id).toggle();
    });

}


function minusQuantity() {
    $(document).ready(function() {
        quantity = parseInt($("#quantity").val())
        if (quantity > 0) {
            quantity--;
            $("#quantity").val(quantity)
        }
    });
}

function plusQuantity() {
    $(document).ready(function() {
        quantity = parseInt($("#quantity").val())
        availableQuantity = parseInt($("#availableQuantity").val())
        if (availableQuantity > quantity) {
            quantity++;
            $("#quantity").val(quantity)
        } else {
            alert("cannot add more products")
        }
    });
}