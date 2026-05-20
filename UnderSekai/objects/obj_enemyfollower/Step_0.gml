var spd = 0;

if (returning) {

    var dist_to_spawn = point_distance(x, y, spawn_x, spawn_y);

    if (dist_to_spawn > 2) {
        var dx = spawn_x - x;
        var dy = spawn_y - y;

        x = lerp(x, spawn_x, 0.08);
        y = lerp(y, spawn_y, 0.08);

        spd = point_distance(x, y, spawn_x, spawn_y);

        if (abs(dx) >= abs(dy)) {
            move_dir = (dx > 0) ? "right" : "left";
        } else {
            move_dir = (dy > 0) ? "down" : "up";
        }

        scr_enemyfollower_anim(le_speed * 0.5);

    } else {
        x = spawn_x;
        y = spawn_y;

        if (return_wait > 0) {
            return_wait--;
            scr_enemyfollower_anim(0);
        } else {
            returning     = false;
            detected      = false;
            followPlayer  = false;
            canCollide    = true;
            current_speed = 0;
            move_dir      = "down";
            move_timer    = irandom_range(90, 200);
            is_waiting    = false;
        }
    }

    exit;
}

if (!followPlayer && !detected) {
    // Trail visual
    trail_timer++;
    if (trail_timer >= trail_interval) {
        trail_timer = 0;
        instance_create_layer(x, y, layer, obj_enemyfollowertrail);
    }
    if (is_waiting) {
        wait_timer--;
        scr_enemyfollower_anim(0);
        if (wait_timer <= 0) {
            is_waiting = false;
            move_timer = irandom_range(90, 200);
        }

    } else {
        var vx = hsp * dir;
        move_dir = (dir > 0) ? "right" : "left";

        if (place_meeting(x + vx, y, obj_colision)) {
            dir        *= -1;
            is_waiting  = true;
            wait_timer  = irandom_range(45, 120);
            scr_enemyfollower_anim(0);
        } else {
            x += vx;
            scr_enemyfollower_anim(abs(vx));
        }

        move_timer--;
        if (move_timer <= 0) {
            dir        *= -1;
            is_waiting  = true;
            wait_timer  = irandom_range(60, 150);
        }
    }
}

if (!detected && canCollide && instance_exists(obj_player)) {
    var dist = point_distance(x, y, obj_player.x, obj_player.y);
    if (dist < detect_range) {
        detected      = true;
        current_speed = 0;
        show_alert    = true;
        audio_play_sound(alert_sound, 1, false);
        alarm[0] = room_speed * 0.7;
    }
}

if (followPlayer && instance_exists(obj_player)) {

    var px = obj_player.x;
    var py = obj_player.y;

    var player_outside = (px < zone_x1 || px > zone_x2 || py < zone_y1 || py > zone_y2);
    var self_outside   = (x  < zone_x1 || x  > zone_x2 || y  < zone_y1 || y  > zone_y2);

    if (player_outside || self_outside) {
        followPlayer  = false;
        detected      = false;
        returning     = true;
        return_wait   = irandom_range(30, 60);
        current_speed = 0;
        exit;
    }

    if (!place_meeting(x, y, obj_player)) {
        var dir_to_player = point_direction(x, y, px, py);

        if (current_speed < le_speed) {
            current_speed += 0.2;
        }

        var mvx = lengthdir_x(current_speed, dir_to_player);
        var mvy = lengthdir_y(current_speed, dir_to_player);

        if (abs(mvx) >= abs(mvy)) {
            move_dir = (mvx > 0) ? "right" : "left";
        } else {
            move_dir = (mvy > 0) ? "down" : "up";
        }

        if (!place_meeting(x + mvx, y, obj_colision)) x += mvx;
        if (!place_meeting(x, y + mvy, obj_colision)) y += mvy;

        scr_enemyfollower_anim(current_speed);
    }
}

if (canCollide && place_meeting(x, y, obj_player)) {
    canCollide    = false;
    current_speed = 0;
    detected      = false;
    scr_start_battle(whoAreYou, enemy_unique_id);
}