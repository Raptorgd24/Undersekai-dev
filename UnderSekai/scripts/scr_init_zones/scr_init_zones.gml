function scr_init_zones() {
    if (!variable_global_exists("zone_TestRooms")) {
        global.zone_TestRooms    = [rm_Room1, rm_RoomTest];
        global.zone_MysteryRooms = [rm_Room666];
        global.zone_Silence = [rm_StartingPointBeta];
        
        global.zone_music = ds_map_create();
        ds_map_add(global.zone_music, "TestRooms", mus_sans);
        ds_map_add(global.zone_music, "MysteryRooms", mus_666);
        ds_map_add(global.zone_music, "Silence", mus_silence);
    }
}