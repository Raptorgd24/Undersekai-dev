var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

box_w = 300;
box_h = 160;

options_index = 0;
options_list  = ["RESOLUTION", "FULLSCREEN", "MASTER VOL", "EXIT GAME"];
res_labels    = ["320x240", "640x480", "960x720", "1280x960"];
options_confirm = false;

sizes = {
    main:    { w: 300, h: 160 },
    items:   { w: 560, h: 300 },
    options: { w: 420, h: 200 }
};

box_x = (gui_w - box_w) / 2;
box_target_y = gui_h - box_h - 16;
box_y = gui_h;

tween_duration = 0.3;
tween_timer = 0;
is_closing = false;
is_open = false;

main_index = 0;
main_options = ["Items", "Scrolls", "Options"];
state = "main";

item_index = 0;
items = global.objects;

input_lock = 10;
close_releases_player = true;