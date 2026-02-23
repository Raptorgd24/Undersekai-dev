/// @description Zoom coso

zoom_sprite_id = instance_create_layer(0, 0, "Instances", obj_zoom_effect);

// Iniciar zoom-in
zoom_target = 0.75;   // zoom-in suave
zooming = true;
zoom_current = 1.0;
