cursor_timer++;

var spd = 0.2;
name_scale += (target_scale - name_scale) * spd;

key_pop = lerp(key_pop, 1, 0.2);