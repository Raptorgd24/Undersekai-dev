
var results = video_draw();

if (results[0] == 0){
	draw_surface(results[1],0,50)	
}

shader_set(shader);

shader_set_uniform_f(shader_get_uniform(shader, "pixel_size"), 4.0);


