sing_manager = instance_find(obj_sing_manager, 0);

combo_x = 320;
combo_y = 50;
accuracy_x = 320;
accuracy_y = 80;
score_x = 320;
score_y = 110;

lane_y = 450;

var gui_w = display_get_gui_width();
var lane_count = 4;
var total_lane_width = 280;
var lane_start_x = (gui_w - total_lane_width) / 2;
var lane_spacing = total_lane_width / (lane_count - 1);

lane_positions = {
    D: lane_start_x,
    F: lane_start_x + lane_spacing,
    J: lane_start_x + lane_spacing * 2,
    K: lane_start_x + lane_spacing * 3
};

depth = -350;