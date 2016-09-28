///menu
switch (mpos)
{
    case 0:
    { 
        room_goto(Level_1);
        break;
    }
    case 1:
    { 
        room_goto(Level_2); 
        break;
    }
    case 2:
    { 
        room_goto(Level_3); 
        break;
    }
    case 3:
    { 
        room_goto(Level_4); 
        break;
    }
    case 4:
    {   
        room_goto(Fausto_Test_Chamber);
        break;
    }
    case 5:
    { 
        game_end(); break;
    }
  
    default: break;
}
