function scr_sansmiss(_target) {
    if (global.enemy != "Sans" || !instance_exists(_target)) {
        return;
    }

    with (_target) {
        sans_miss = true;
        scr_sansmovement(false);
    }
}