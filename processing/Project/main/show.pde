import java.awt.Frame;

PFrame f;
secondApplet console;

int tab_number = 0;
int tab_now_number = -1;
int tn = 5;
String[] tab_name = { 
  "Home", "Line", "Complexity", "", ""
} 
;
boolean tab_move = false;
float tab_tn, tab_td;

void show_setup ()
{
  f = new PFrame ();
  background (0.0, 0.0, 1.0);
  tab_tn = tab_td = 65.0;
  tab_move = true;
}

void show_draw ()
{
  if (tab_move)
  {
    retab ();

    if (tab_tn==tab_td) tab_move=true;
    else
    {
      if (abs (tab_tn - tab_td) <= 1) tab_tn = tab_td;
      if (tab_tn>tab_td) tab_tn -= 0.2*(tab_tn-tab_td);
      else tab_tn += 0.2*(tab_td-tab_tn);
    }

    fill (0.0, 0.0, 1.0);
    int x = 130;
    float y = tab_tn;
    triangle (x-18, y, x, y-9, x, y+9);
  }

  switch (tab_number)
  {
  case 0:
    if (tab_now_number != tab_number) tab1_setup ();
    tab1_draw ();
    tab_now_number = tab_number;
    break;
  case 1:
    if (tab_now_number != tab_number) tab2_setup ();
    tab2_draw ();
    tab_now_number = tab_number;
    break;
  case 2:
    if (tab_now_number != tab_number) tab3_setup ();
    tab3_draw ();
    tab_now_number = tab_number;
    break;
  }
}

void retab ()
{
  int i;

  noStroke();

  for (i=0 ; i<5 ; i++)
  {
    if (tab_number == i)
    {
      fill (randomHue, 0.35, 0.22);
    }
    else 
    {
      fill (randomHue, 0.35, 0.42);
    }
    rect (0, 130*i, 130, 130);
  }

  strokeWeight (1);
  stroke (randomHue, 0.35, 0.30);
  for ( i = 0 ; i < 5 ; i ++ )
  {
    stroke (randomHue, 0.35, 0.30);
    line (0, 130*(i+1), 129, 130*(i+1));
    if (tab_number==i+1)
    {
      stroke (randomHue, 0.35, 0.30);
    }
    else
    {
      stroke (randomHue, 0.35, 0.50);
    }
    line (2, 130*(i+1)+2, 127, 130*(i+1)+2);
  }

  noStroke ();
  for ( i = 0 ; i < 5 ; i ++ )
  {
    fill (randomHue, 0.35, 0.82);
    textFont (createFont ("SeoulNamsanEB", 16));
    textAlign (CENTER);
    text (tab_name[i], 65, 65+7+130*i);
  }
}

void show_mousePressed ()
{
  int i;
  for (i=0 ; i<5 ; i++)
  {
    if (mouseX >= 0 && mouseX <= 130 && mouseY >= 130 * i && mouseY <= 130 * (i+1))
    {
      tab_number = i;
      tab_move = true;
      tab_td = 65+130*i;
    }
  }

  switch (tab_number)
  {
  case 0:
    tab1_mousePressed ();
    break;
  case 1:
    tab2_draw ();
    break;
  case 2:
    tab3_draw ();
    break;
  }
}

public class PFrame extends Frame
{
  public PFrame ()
  {
    setBounds (100, 100, 400, 300);
    console = new secondApplet ();
    add (console);
    console.init ();
    show ();
  }
}

public class secondApplet extends PApplet
{
  Download dl;

  String[] message=new String[100];
  int count;

  public void setup ()
  {
    colorMode (HSB, 1.0);
    size (400, 300);
    background (0.0, 0.0, 1.0);

    dl = new Download ();
    dl.start ();

    count = 0 ;
  }

  public void draw ()
  {
  }

  public void prints (String msg)
  {
    int i;

    if ( count == 100 )
    {
      for ( i = 100 - 23 ; i < 100 ; i ++ )
      {
        message [ i - ( 100 - 23 ) ] = message [ i ] ;
      }
      count = 23;
    }
    
    message[count++] = msg;

    background (0.0, 0.0, 1.0);
    fill (0, 0, 0.0, 1.0);
    textFont (createFont ("SeoulNamsanB", 11));
    textAlign (LEFT);
    for (i=count-1 ; i>=count-23 && i>=0 ; i--) 
    {
      text (message[i], 2, 12*(count-i));
    }
  }

  public void mousePressed ()
  {
  }
}

void show_keyPressed ()
{
  switch (tab_number)
  {
  case 0:
    tab1_keyPressed ();
    break;
  case 1:
    break;
  case 2:
    break;
  }
}

