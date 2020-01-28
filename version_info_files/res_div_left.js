function resizeDiv_Left()
{
 var Dummy = document.getElementById('dummy');
 Dummy.style.height = '1in';
 switch(screen.width)
 {
  case 1920:
   {
    document.getElementById('left_panel').style.left = '200px';
    document.getElementById('left_panel').style.width = '240px';
    break;
   }
  case 1600:
   {
    document.getElementById('left_panel').style.left = '100px';
    document.getElementById('left_panel').style.width = '240px';
    break;
   }
  case 1440:
   {
    document.getElementById('left_panel').style.left = '60px';
    document.getElementById('left_panel').style.width = '240px';
    break;
   }
  case 1280:
   {
    document.getElementById('left_panel').style.left = '15px';
    document.getElementById('left_panel').style.width = '230px';	
    break;
   }
  case 1152:
   {
    document.getElementById('left_panel').style.left = '5px';
    document.getElementById('left_panel').style.width = '230px';   
    break;
   }
  case 1024:
   document.getElementById('left_panel').style.left = '5px'; break;
  case 800:
   document.getElementById('left_panel').style.left = '1px'; break;
 }

 if (Dummy.clientHeight==96)
 { document.getElementById('left_panel').style.top = '180px'; }
 if (Dummy.clientHeight==120)
 { document.getElementById('left_panel').style.top = '182px'; }

 if (screen.width<900)
 { document.getElementById('left_panel').style.display = 'none'; }
}
