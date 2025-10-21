// obj_heart - Alarm[0] (intro)
if (mode == "intro") {
    if (parpadeos < 5) {
        if (alpha_state == 0) {
            image_alpha = 1;
            alpha_state = 1;
        } else {
            image_alpha = 0;
            alpha_state = 0;
        }
        parpadeos += 1;
        alarm[0] = 10;
    } else {
        mode = "select";
        image_alpha = 1;
    }
}
