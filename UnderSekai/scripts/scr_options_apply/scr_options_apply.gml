function scr_options_apply() {
    var _scales = [1, 2, 3, 4];
    var _scale  = _scales[clamp(global.opt_resolution, 0, 3)];
    var _w = 320 * _scale;
    var _h = 240 * _scale;

    if (global.opt_fullscreen) {
        window_set_fullscreen(true);
    } else {
        window_set_fullscreen(false);
        window_set_size(_w, _h);
        window_center();
    }

    audio_master_gain(global.opt_master_vol);
}