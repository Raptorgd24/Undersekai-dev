// Movimiento en forma de ∞ suave (lemniscata)
t += 0.05;

// Ecuación tipo lemniscata de Bernoulli suavizada
var a = 1; // controla la suavidad
var sin_t = sin(t);
var cos_t = cos(t);

x = origin_x + amplitude_x * sin_t / (1 + sqr(cos_t));
y = origin_y + amplitude_y * sin_t * cos_t / (1 + sqr(cos_t));

// Crear trail cada cierto tiempo
trail_timer++;
if (trail_timer >= trail_interval) {
    trail_timer = 0;
   instance_create_layer(x, y, layer, obj_trail);
}
