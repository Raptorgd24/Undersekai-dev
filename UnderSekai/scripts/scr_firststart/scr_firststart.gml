function scr_firststart(){
	
        if (file_exists("save.dat"))
			file_delete("save.dat");

        global.room_name = "rm_ruins1";
        global.name = "EMPTY";
        global.lv = 1;
        global.healthu = 20;
        global.maxHP = 20;
        global.gold = 0;
        global.objects = [];
        global.weapon = "Stick";
        global.armor = "Bandage";
        global.play_time = 0
		global.events_done = [];
		global.xp = 0
        global.fame = 0;
        global.route = "pacifist";
        global.kills = 0;
        global.spares = 0;
        global.deaths = 0;
        global.event_data_map = ds_map_create();
        scr_save_game();
		if (!variable_global_exists("song_asset")) {
		    global.song_asset = mus_silence; 
		}
        room_goto(rm_NamingMenu);
		
}