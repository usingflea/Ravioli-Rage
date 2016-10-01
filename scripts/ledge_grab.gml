///scr_ledge_grab_state()
var jkey = keyboard_check_pressed(vk_space);
var dkey = keyboard_check(vk_down);

sprite_index = spr_ledge;

if(jkey)    
    {
        audio_play_sound(aud_jump,10,false); 
        vsp = -jumpspeed;
        state = scr_move_state;
    }
     
if (dkey) 
    {
        state = scr_move_state;
    }
    
    
