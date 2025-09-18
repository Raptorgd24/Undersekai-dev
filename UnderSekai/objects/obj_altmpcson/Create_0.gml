talk = 0;
function npc_dialogue() {
	if talk = 0{
    dialogue("sans", 0, "hola, soy goku", true);
    dialogue("sans", 1, "que porque tengo el sprite de sans?", true);
    dialogue("goku", 8, "Buena pregunta", false);
	alarm_set(0,1)
	}
	if talk = 1{
    dialogue("sans", 9, "matate zorra", true);
	alarm_set(1,1)
	}
}
