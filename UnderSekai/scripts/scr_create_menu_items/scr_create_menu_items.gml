function scr_create_menu_items()
{
    var mx = 320;  // posición base central
    var my = 180;

    // izquierda
    global.sel_left = instance_create_layer(mx-150, my, "Instances_1", obj_selitem);
    global.sel_left.my_offset = -1;
	global.sel_left.image_xscale = 0.4;
	global.sel_left.x = 120;
	global.sel_left.y -= 25;
	global.sel_left.image_yscale = 0.4;

    // centro
    global.sel_mid = instance_create_layer(mx, my, "Instances_1", obj_selitem);
    global.sel_mid.my_offset = 0;
	global.sel_mid.image_xscale = 0.75;
	global.sel_mid.x = 160;
	global.sel_mid.y -= 35;
	global.sel_mid.image_yscale = 0.75;
    // derecha
    global.sel_right = instance_create_layer(mx+150, my, "Instances_1", obj_selitem);
    global.sel_right.my_offset = +1;
	global.sel_right.image_xscale = 0.4;
	global.sel_right.x = 200;
	global.sel_right.y -= 25;
	global.sel_right.image_yscale = 0.4;
	
    scr_update_menu_items();
}
