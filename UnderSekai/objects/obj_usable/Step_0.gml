// Step Event de obj_follower

if (!instance_exists(obj_player)) exit;

// Posición base = jugador
x = obj_player.x;
y = obj_player.y;

switch (obj_player.last_dir) {
    case "left":
        x += 2;
		y += 28;
        image_angle = 180; // eje X negativo
        break;

    case "right":
        x += 15;
        image_angle = 0;   // eje X positivo
        break;

    case "up":
        y -= 0;
		x -= 6;
        image_angle = 90;  // eje Y negativo
        break;

    case "down":
        y += 15;
		x += 15;
        image_angle = 270; // eje Y positivo
        break;
}
