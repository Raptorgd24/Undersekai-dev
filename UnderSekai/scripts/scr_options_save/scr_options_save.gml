function scr_options_save() {
    ini_open("options.ini");
    ini_write_real("display", "resolution",  global.opt_resolution);
    ini_write_real("display", "fullscreen",  global.opt_fullscreen);
    ini_write_real("audio",   "master_vol",  global.opt_master_vol);
    ini_close();
}