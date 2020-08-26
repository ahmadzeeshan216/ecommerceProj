function cmnt_edit_btn_click(id) {

    $(document).ready(function() {
        $("#cmnt_body_edit_txt_area" + id).val($("#cmnt_body_para_" + id).text())
        $("#cmnt_update_div" + id).toggle();
    });

}


function minusQuantity(id) {
    $(document).ready(function() {
        quantity = parseInt($("#quantity_" + id).val())
        if (quantity > 0) {
            quantity--;
            $("#quantity_" + id).val(quantity)
        }
    });
}

function plusQuantity(availableQuantity, id) {
    $(document).ready(function() {
        quantity = parseInt($("#quantity_" + id).val())
        if (availableQuantity > quantity) {
            quantity++;
            $("#quantity_" + id).val(quantity)
        } else {
            alert("cannot add more products")
        }
    });
}