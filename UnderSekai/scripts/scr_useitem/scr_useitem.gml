function scr_useitem(_itemname) {
    var data = scr_item_data(_itemname);
    if (is_undefined(data)) return { text: "Error", new_health: global.healthu, used: false };

    var result = { text: "", new_health: global.healthu, used: false };

    switch (data.type) {
        case "food":
            var old_health = global.healthu;
            var at_max = (global.healthu >= global.maxHP);
            scr_heal(data.heal);
            var healed = global.healthu - old_health;
            if (at_max) {
                result.text = "* Ya tenias la vida al maximo.";
            } else if (global.healthu >= global.maxHP) {
                result.text = "* Has consumido " + data.name + ".\n* Te has recuperado toda la vida.";
            } else {
                result.text = "* Has consumido " + data.name + ".\n* Has recuperado " + string(healed) + " HP.";
            }
            result.new_health = global.healthu;
            result.used = true;
        break;

case "weapon":
    var old_weapon = global.weapon;
    global.weapon = data.name;
    global.ATK = (8 + (global.lv * 2)) + data.atk;
    array_push(global.objects, old_weapon);
    result.text = "* Has equipado " + data.name + ".";
    result.used = false;
break;

case "armor":
    var old_armor = global.armor;
    global.armor = data.name;
    global.DEF = (9 + ceil((global.lv / 4))) + data.def;
    array_push(global.objects, old_armor);
    result.text = "* Has equipado " + data.name + ".";
    result.used = false;
break;

        case "key":
            switch (_itemname) {
                case "KeyTest":
                    result.text = "* Lo examinas con cuidado...\n  No hace nada.";
                break;
                default:
                    result.text = "* No sabes para que sirve esto.";
                break;
            }
            result.used = false;
        break;
    }

    return result;
}