function scr_update_menu_items()
{

    function get_item(offset)
    {
		var idx = obj_battle_menu.selected_item_index;
		    var len = array_length(global.objects);
			if (len <= 0) return;
        return global.objects[(idx + offset + len) mod len];
		
    }

    with (sel_left)
    {
        scr_selitem_apply(get_item(my_offset));
    }

    with (sel_mid)
    {
        scr_selitem_apply(get_item(my_offset));
    }

    with (sel_right)
    {
        scr_selitem_apply(get_item(my_offset));
    }
}
