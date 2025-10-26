// obj_number - Step
// 

// odio la gravedad
y += vy;
vy += gravity;

if (y > ystart && bounces < max_bounces) {
    y = ystart;
    vy = bounce_power;
    bounces++;
}

if (bounces >= max_bounces) {
	gravity=0;
    image_alpha -= 0.02;
    if (image_alpha <= 0) instance_destroy();
}
if (image_xscale <= 0.7 && image_yscale<= 0.7)
{
	image_xscale += 0.05;
	image_yscale += 0.05;
}

