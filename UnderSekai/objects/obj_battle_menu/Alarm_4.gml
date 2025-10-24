/// @description End batlle
// Puede escribir su código en este editor
audio_stop_sound(songbattle)
mode = "end";
global.xp += expgiven;
global.gold += goldGiven;
scr_lvlup_game()	
    with (obj_thebox) {
		var expwon = string(other.expgiven)
		var goldwon = string(other.goldGiven)
        text = "Battle won, earnt "+ expwon+"EXP and "+goldwon+"G";
        display_text = "";
        text_index = 0;
    }
	    
       
    