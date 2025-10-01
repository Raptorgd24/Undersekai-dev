// obj_controlMenu - Alarm[0]
// alarm usado para ejecutar room_goto_next() después de que full_fade haya alcanzado 1
if (!room_changing) {
    // protección redundante
    room_changing = true;
}
room_goto_next();
