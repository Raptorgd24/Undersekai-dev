opciones = ["FIGHT", "ACT", "ITEM", "MERCY"];
seleccion = 0;
heart_offset_x = [ -840, -20, 40, 100 ];

text_to_show = "The Roaring Knight appears.";

box_width = 550;
box_height = 170;
box_x = 45;
box_y = 225;
image_alpha = 0;
if (enemy = "Roaring_Fraud"){
audio_play_sound(mus_roaringfraud, 1, true);
}