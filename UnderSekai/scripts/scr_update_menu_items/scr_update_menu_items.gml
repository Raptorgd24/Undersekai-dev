function scr_update_menu_items()
{
    var items = global.objects;
    if (variable_global_exists("temp_menu_items") && global.temp_menu_items != undefined) {
        items = global.temp_menu_items;
    }

    function get_item(offset, items_array)
    {
        var idx = obj_battle_menu.selected_item_index;
        var len = array_length(items_array);
        if (len <= 0) return;
        return items_array[(idx + offset + len) mod len];
    }

    with (global.sel_left)
    {
        scr_selitem_apply(get_item(my_offset, items));
    }

    with (global.sel_mid)
    {
        scr_selitem_apply(get_item(my_offset, items));
    }

    with (global.sel_right)
    {
        scr_selitem_apply(get_item(my_offset, items));
    }
}
