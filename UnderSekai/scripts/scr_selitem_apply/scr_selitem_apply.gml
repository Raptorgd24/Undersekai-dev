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

        case "ArmorTest":
            image_index  = 5;
        break;

        case "KeyTest":
            image_index  = 6;
        break;
        case "CHECK":
            image_index = 0; // o algún sprite
        break;
        case "PUN":
            image_index = 0;
        break;
        case "JOKE":
            image_index = 0;
        break;
        case "HOLDBREATH":
            image_index = 0;
        break;
		default:
			image_index = 1;
		break;
    }
}
