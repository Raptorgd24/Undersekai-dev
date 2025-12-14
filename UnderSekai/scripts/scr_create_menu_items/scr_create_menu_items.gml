function scr_create_menu_items()
{
    var mx = 320;  // posición base central
    var my = 180;

    // izquierda
    sel_left = instance_create_layer(mx-150, my, "Instances_1", obj_selitem);
    sel_left.my_offset = -1;
	sel_left.image_xscale = 0.4;
	sel_left.x = 120;
	sel_left.y -= 25;
	sel_left.image_yscale = 0.4;

    // centro
    sel_mid = instance_create_layer(mx, my, "Instances_1", obj_selitem);
    sel_mid.my_offset = 0;
	sel_mid.image_xscale = 0.75;
	sel_mid.x = 160;
	sel_mid.y -= 35;
	sel_mid.image_yscale = 0.75;
    // derecha
    sel_right = instance_create_layer(mx+150, my, "Instances_1", obj_selitem);
    sel_right.my_offset = +1;
	sel_right.image_xscale = 0.4;
	sel_right.x = 200;
	sel_right.y -= 25;
	sel_right.image_yscale = 0.4;
	
    scr_update_menu_items();
}
