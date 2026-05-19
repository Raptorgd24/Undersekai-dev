/*var save = instance_find(obj_save, 0);
if (!instance_exists(obj_player)) {
    
    if (save != noone) {
        instance_create_layer(save.x, save.y+2, "Instances", obj_player);
    }
}


if (!instance_exists(obj_usable)) {
    instance_create_layer(save.x, save.y, "Instances", obj_usable);
}

if (!instance_exists(obj_cam)) {
    instance_create_layer(save.x, save.y+10, "Instances", obj_cam);
}

if (!instance_exists(obj_control)) {
    instance_create_layer(0, 0, "Instances", obj_control);
}
// Crear controller
instance_create_layer(0, 0, "Instances", obj_puzzle_controller);

// Crear botones (ejemplo)
var positions = [
    [100,200],
    [150,200],
    [200,200],
    [250,200],
    [300,200],
    [350,200]
];

for (var i = 0; i < 6; i++) {
    var b = instance_create_layer(positions[i][0], positions[i][1], "Instances", obj_button);
    b.btnid = i + 1;
}