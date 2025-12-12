function scr_destroy_menu_items()
{
    if (sel_left  != noone) instance_destroy(sel_left);
    if (sel_mid   != noone) instance_destroy(sel_mid);
    if (sel_right != noone) instance_destroy(sel_right);

    sel_left  = noone;
    sel_mid   = noone;
    sel_right = noone;
}
