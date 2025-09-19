talk = 0;
function npc_dialogue() {
	if talk = 0{
    scr_dialogue("sans", 0, "hola, soy goku", true);
    scr_dialogue("sans", 1, "que porque tengo el sprite de sans?", true);
    scr_dialogue("goku", 8, "Buena pregunta", false);
	alarm_set(0,1)
	}
	if talk = 1{
    scr_dialogue("sans", 9, "matate zorra", true);
	alarm_set(1,1)
	}
}
