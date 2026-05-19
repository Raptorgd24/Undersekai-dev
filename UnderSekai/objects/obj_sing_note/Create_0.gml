chart_data = undefined;
lane = "D";
time_ms = 0;
sing_manager = noone;

hit = false;
missed = false;
show_miss = false;
hit_accuracy = "";
show_accuracy = false;

lane_positions = {
    D: 60,
    F: 290,
    J: 140,
    K: 180
};

x = lane_positions[$ lane];

start_y = -8;
target_y = 210;
y = start_y;

speed_y = 2;

image_alpha = 1;
depth = -400;