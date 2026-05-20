function scr_selitem_apply(_itemname)
{
    // aquí defines qué frame corresponde a cada item
	show_debug_message("Sent lol")
	show_debug_message("btw i got a " + _itemname)
    switch (_itemname)
    {
        case "FoodTest":
            image_index  = 2; // hamburguesa
        break;

        case "WeaponTest":
            image_index  = 3;
        break;

        case "Stick":
            image_index  = 4;
        break;

        case "Bandage":
            image_index  = 8;
        break;

        case "ArmorTest":
            image_index  = 5;
        break;

        case "KeyTest":
            image_index  = 6;
        break;

		default:
			image_index = 1;
		break;
    }
}
