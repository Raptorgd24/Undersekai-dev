alpha -= fade_speed;
if (alpha <= 0) instance_destroy();
image_xscale += 0.03;
image_yscale += 0.03;
x -= 0.1;
y -= 0.1;