// obj_sing_note - Create

chart_data = undefined;
lane = "D";
time_ms = 0;
sing_manager = noone;

hit = false;
missed = false;
show_miss = false;
hit_accuracy = "";
show_accuracy = false;

// Posición visual
lane_positions = {
    D: 80,
    F: 160,
    J: 240,
    K: 320
};

x = lane_positions[$ lane];
y = 50;
start_y = 50;
target_y = 450; // línea de hit

speed_y = 2; // velocidad de caída

image_alpha = 1;
depth = -400;
