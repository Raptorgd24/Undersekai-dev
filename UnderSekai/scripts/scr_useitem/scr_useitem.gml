function scr_useitem(_itemname) {
    var data = scr_item_data(_itemname);
    if (is_undefined(data)) return;

    switch (data.type) {
        case "food":
           scr_heal(data.heal);
        break;

        case "weapon":
            //obj_player.atk = data.atk;
            show_debug_message("Weapon equipped: " + string(_itemname));
        break;

        case "armor":
            //obj_player.def = data.def;
            show_debug_message("Armor equipped: " + string(_itemname));
        break;

        case "key":
            show_debug_message("Used key item: " + string(_itemname));
        break;
    }
}
