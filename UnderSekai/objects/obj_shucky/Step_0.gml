timer++;

if (!done && timer >= sound_length) {
    done = true;
    scr_init_zones();
	scr_load_game();
	shader_reset();
}

