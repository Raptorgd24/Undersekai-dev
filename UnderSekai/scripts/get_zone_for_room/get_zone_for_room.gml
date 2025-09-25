function get_zone_for_room(_room) {
    if (array_length(global.zone_TestRooms) > 0) {
        for (var i = 0; i < array_length(global.zone_TestRooms); i++) {
            if (global.zone_TestRooms[i] == _room) return "TestRooms";
        }
    }
    if (array_length(global.zone_MysteryRooms) > 0) {
        for (var i = 0; i < array_length(global.zone_MysteryRooms); i++) {
            if (global.zone_MysteryRooms[i] == _room) return "MysteryRooms";
        }
    }
    if (array_length(global.zone_Silence) > 0) {
        for (var i = 0; i < array_length(global.zone_Silence); i++) {
            if (global.zone_Silence[i] == _room) return "Silence";
        }
    }
    return undefined;
}