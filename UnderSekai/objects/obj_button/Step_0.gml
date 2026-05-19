if (!active && place_meeting(x, y, obj_player)) {

    active = true;
    image_index = 1;
    audio_play_sound(snd_noise, 1, false);

    var ctrl = instance_find(obj_puzzle_controller, 0);

    if (ctrl != noone) {
        ctrl.check_input(btnid);
    }
}