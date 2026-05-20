function scr_enemyfollower_anim(_speed) {
    var frame_sets = {
        down:  [0,  1,  2,  3],
        left:  [4,  5,  6,  7],
        right: [8,  9,  10, 11],
        up:    [12, 13, 14, 15]
    };

    var frames = frame_sets[$ move_dir];

    if (_speed <= 0) {
        image_index = frames[0];
        anim_timer  = 0;
        image_speed = 0;
        exit;
    }

    var anim_spd = clamp(_speed / le_speed, 0.1, 1.0) * 0.15;
    anim_timer  += anim_spd;
    image_index  = frames[floor(anim_timer) mod 4];
    image_speed  = 0;
}