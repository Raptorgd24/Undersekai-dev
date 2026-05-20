alpha -= fade_speed;
if (alpha <= 0) instance_destroy();
image_xscale += 0.03;
image_yscale += 0.03;
// Mueve el objeto hacia posiciones aleatorias en X e Y
// usando += o -= automáticamente

var rand_x = random_range(-1.2, 0.7);
var rand_y = random_range(-1.2, 0.7);

x += rand_x;
y += rand_y;