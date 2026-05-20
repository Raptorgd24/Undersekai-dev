var touching = place_meeting(x, y, obj_player);

if (!active && touching && !was_touching) {

    active = true;
    image_index = 1;
    audio_play_sound(snd_noise, 1, false);

    var ctrl = instance_find(obj_puzzle_controller, 0);

    if (ctrl != noone) {
        ctrl.check_input(btnid);
    }
}

was_touching = touching;
