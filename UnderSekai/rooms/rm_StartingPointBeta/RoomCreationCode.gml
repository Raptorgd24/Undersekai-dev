var save = instance_find(obj_save, 0);
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

if (array_contains(global.events_done, "Test")) {
    show_debug_message("Mi bombo test");
	if instance_exists(obj_eventTrigger){
		instance_destroy(obj_eventTrigger)

	}
}