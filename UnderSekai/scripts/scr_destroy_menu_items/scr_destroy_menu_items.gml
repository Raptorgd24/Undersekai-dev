function scr_destroy_menu_items()
{
    if (global.sel_left  != noone) instance_destroy(global.sel_left);
    if (global.sel_mid   != noone) instance_destroy(global.sel_mid);
    if (global.sel_right != noone) instance_destroy(global.sel_right);
    
    global.sel_left  = noone;
    global.sel_mid   = noone;
    global.sel_right = noone;
    global.temp_menu_items = undefined;
}