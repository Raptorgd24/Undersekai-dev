function scr_options_load() {
    ini_open("options.ini");
    global.opt_resolution = ini_read_real("display", "resolution", 1);
    global.opt_fullscreen  = ini_read_real("display", "fullscreen", 0);
    global.opt_master_vol  = ini_read_real("audio",   "master_vol", 1.0);
    ini_close();

    scr_options_apply();
}