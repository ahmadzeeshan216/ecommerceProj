function cmnt_edit_btn_click(id) {

    $(document).ready(function() {
        $("#cmnt_body_edit_txt_area" + id).val($("#cmnt_body_para_" + id).text())
        $("#cmnt_update_div" + id).toggle();
    });
}