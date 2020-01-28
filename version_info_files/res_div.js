function resizeDiv()
{
 var Dummy = document.getElementById('dummy');
 Dummy.style.height = '1in';
 switch(screen.width)
 {
  case 1920:
   document.getElementById('right_panel').style.width = '340px'; break;
  case 1600:
   document.getElementById('right_panel').style.width = '340px'; break;
  case 1440:
   document.getElementById('right_panel').style.width = '312px'; break;
  case 1280:
   document.getElementById('right_panel').style.width = '236px'; break;
  case 1152:
   document.getElementById('right_panel').style.width = '174px'; break;
  case 1024:
   document.getElementById('right_panel').style.width = '110px'; break;
  case 800:
   document.getElementById('right_panel').style.width = '96px'; break;
 }

 if (Dummy.clientHeight==96)
 { document.getElementById('right_panel').style.top = '180px'; }
 if (Dummy.clientHeight==120)
 { document.getElementById('right_panel').style.top = '182px'; }

 if (screen.width<900)
 { document.getElementById('right_panel').style.display = 'none'; }
}
