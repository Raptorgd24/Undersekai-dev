/// @description El verdadero gameover
room_goto(rm_gameOver_screen)
deathsong = audio_play_sound(mus_gameover,1,true,0)
audio_sound_gain(deathsong,1,1000)