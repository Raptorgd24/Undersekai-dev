timer       = 0;
phase       = 0;
black_alpha = 0;
blink_count = 0;
blink_speed = 6;
once        = false;
heart_alpha = 0;

var cam   = view_camera[0];
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);
var cam_w = camera_get_view_width(cam);
var cam_h = camera_get_view_height(cam);
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

heart_gui_x  = ((obj_player.x - cam_x) / cam_w) * gui_w;
heart_gui_y  = ((obj_player.y - cam_y) / cam_h) * gui_h;
target_gui_x = 49;
target_gui_y = 416;

with (obj_player) {
    can_move = false;
}
with (obj_usable) {
    can_use = false;
}