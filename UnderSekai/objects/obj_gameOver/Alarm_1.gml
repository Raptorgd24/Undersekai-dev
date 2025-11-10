/// @description Alarm1 pedacitos

alarm[2] = room_speed*3; 
    audio_play_sound(snd_heart_shatter2, 1, false);
with (obj_heart) {
    var xx = x;
    var yy = y;
    instance_destroy();
	
    for (var i = 0; i < 5; i++) {
        var piece = instance_create_layer(xx, yy, "Instances", obj_heart_piece);
        var lesize =random_range(0.5, 1)
        piece.direction = irandom_range(0, 359);
        piece.speed = random_range(2, 4);
        piece.gravity = 0.3;
        piece.gravity_direction = 270; 
		piece.image_xscale = lesize;
		piece.image_yscale = lesize;
    }
}
