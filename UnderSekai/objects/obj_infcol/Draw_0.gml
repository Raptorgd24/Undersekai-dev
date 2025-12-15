var cam = view_camera[0];
var view_y = camera_get_view_y(cam);
var view_h = camera_get_view_height(cam);

var start_y = y - sprite_height_bg;
var draw_y = start_y;

while (draw_y < view_y + view_h + sprite_height_bg) {
    draw_sprite_ext(
        sprite_index,
        0,
        x,
        draw_y,
        final_xscale,
        final_yscale,
        image_angle,
        image_blend,
        image_alpha
    );
    
    draw_y += sprite_height_bg;
}
