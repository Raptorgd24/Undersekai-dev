function scr_useitem(_itemname) {
    var data = scr_item_data(_itemname);
    if (is_undefined(data)) return { text: "❌ Error", new_health: global.healthu };

    var result = { text: "", new_health: global.healthu };

    switch (data.type) {
        case "food":
            var old_health = global.healthu;
            scr_heal(data.heal);
            var healed = global.healthu - old_health;
            result.text = "* You consumed " + data.name + ".\n* Recovered " + string(healed) + " HP.";
            result.new_health = global.healthu;
        break;

        case "weapon":
            //obj_player.atk = data.atk;
            result.text = "* You equipped " + data.name + ".";
            show_debug_message("Weapon equipped: " + string(_itemname));
        break;

        case "armor":
            //obj_player.def = data.def;
            result.text = "* You equipped " + data.name + ".";
            show_debug_message("Armor equipped: " + string(_itemname));
        break;

        case "key":
            result.text = "* Used " + data.name + ".";
            show_debug_message("Used key item: " + string(_itemname));
        break;
    }
    
    return result;
}
