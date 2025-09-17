// Step Event de obj_follower

if (!instance_exists(obj_player)) exit;

// Posición base = jugador
x = obj_player.x;
y = obj_player.y;

switch (obj_player.last_dir) {
    case "left":
        x += 9;
		y += 30;
        image_angle = 180; // eje X negativo
        break;

    case "right":
        x += 10;
        image_angle = 0;   // eje X positivo
        break;

    case "up":
        y += 12;
		x -= 6;
        image_angle = 90;  // eje Y negativo
        break;

    case "down":
        y += 18;
		x += 25;
        image_angle = 270; // eje Y positivo
        break;
}
