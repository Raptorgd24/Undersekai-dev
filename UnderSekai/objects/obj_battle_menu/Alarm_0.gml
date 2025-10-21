// Eliminar sprite si existe
if (instance_exists(zoom_sprite_id)) {
    with (zoom_sprite_id) instance_destroy();
}

// Restaurar cámara original
camera_set_view_size(view_camera[0], default_cam_w, default_cam_h);
camera_set_view_pos(view_camera[0], 0, 0);

zoom_current = 1.0;
zooming = false;
