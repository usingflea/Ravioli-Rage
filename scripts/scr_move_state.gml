//script move state
//Get the player's input
key_right = keyboard_check(vk_right);
key_left = -keyboard_check(vk_left);
key_jump = keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(0, gp_face1);
key_jump_held = keyboard_check(vk_space) || gamepad_button_check(0, gp_face1);

//React to inputs
if (gamepad_is_connected(0))
{
    move = gamepad_axis_value(0, gp_axislh);
    if(move < 0 && move > -1)
    {
        move = -1;
    }
    else if(move > 0 && move < 1)
    {
        move = 1;
    }
}else
{
    move = key_left + key_right;
}

hsp = (move * movespeed) + hsp_carry;
hsp_carry = 0;
if (vsp < 10) vsp += grav;

if (place_meeting(x,y+1,obj_wall))
{
    jumps = jumpsmax;
}

if (key_jump) && (jumps > 0)
{
    audio_play_sound(aud_jump,10,false);    
    jumps -= 1;
    vsp = -jumpspeed;
}

if (vsp < 0) && (!key_jump_held) vsp = max( vsp, -jumpspeed/4)

//Triple Jump cancelado!
//if (key_jump) && (place_meeting(x+1,y,object5) || place_meeting(x-1,y,object5))
//{
//    vsp = -jumpspeed;
//    jumpsmax = 3;
//}

//Colisions

if( hsp != 0) 
    {
        hsp_dir = sign(hsp);
    }

//Horizontal Collision
if (place_meeting(x+hsp,y,obj_wall))
{
    while(!place_meeting(x+sign(hsp),y,obj_wall))
    {
        x += sign(hsp);
    }
    hsp = 0;
}


/**if (place_meeting(x+hsp,y,obj_MovingPlatform))
{
    while(!place_meeting(x+sign(hsp),y,obj_MovingPlatform))
    {
        x += sign(hsp);
    }
    hsp = 0;
}**/
x += hsp;

//Vertical Collision
if (place_meeting(x,y+vsp,obj_wall))
{
    while(!place_meeting(x,y+sign(vsp),obj_wall))
    {
        y += sign(vsp);
    }
    vsp = 0;
}


/**if (place_meeting(x,y+vsp,obj_MovingPlatform))
{
    while(!place_meeting(x,y+sign(vsp),obj_MovingPlatform))
    {
        y += sign(vsp);
    }
    vsp = 0;
}**/
y += vsp;
//End collisions

//Ledge grab
var was_free = !position_meeting(x+(17*hsp_dir), yprevious-13, obj_wall);
var is_not_free = position_meeting(x+(17*hsp_dir), y-13, obj_wall);
var moving_down = yprevious < y;

if (was_free && is_not_free && moving_down)
    {
       hsp = 0;
       vsp = 0;
       
       
       //move against the ledge
       while(!place_meeting(x+hsp_dir, y, obj_wall))
       {
        x+=hsp_dir;
       }
       //Make sure the height is right
       while(position_meeting(x+(17*hsp_dir), y-14, obj_wall)) 
       {
        y-=0.9;
       }
       state = ledge_grab;
    }  
    
//Animate
if (move != 0) image_xscale = move;
if (place_meeting(x,y+1,obj_wall))
{
    if (move!=0) sprite_index = sprite_player_move; else sprite_index = sprite_player;
}
 else
 {
    if(vsp < 0) sprite_index = sprite_jump; else sprite_index = sprite_jump;
 }

image_speed=0.1;


