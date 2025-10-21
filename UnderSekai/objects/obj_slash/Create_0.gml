// obj_slash - Create
sprite_index = spr_slash;
image_speed = 0.4;
depth = -99999;

// Referencias (si fueron pasadas al crear)
/// owner_bar (id de obj_attack_bar), battle_id (id de obj_battle_menu)
// Por seguridad, inicializamos:
if (!variable_instance_exists(id, "owner_bar")) owner_bar = noone;
if (!variable_instance_exists(id, "battle_id")) battle_id = noone;
