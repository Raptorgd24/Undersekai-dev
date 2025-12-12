function scr_create_menu_items()
{
    var mx = 320;  // posición base central
    var my = 180;

    // izquierda
    sel_left = instance_create_layer(mx-150, my, "Instances_1", obj_selitem);
    sel_left.my_offset = -1;

    // centro
    sel_mid = instance_create_layer(mx, my, "Instances_1", obj_selitem);
    sel_mid.my_offset = 0;

    // derecha
    sel_right = instance_create_layer(mx+150, my, "Instances_1", obj_selitem);
    sel_right.my_offset = +1;

    scr_update_menu_items();
}
