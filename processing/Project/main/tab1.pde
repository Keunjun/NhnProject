int tab1_tn = 0;

int tab1_bottom_number = 0;
int tab1_bottom_month = 0;
int tab1_bottom_month1 = 0;
int tab1_bottom_day = 0;
int tab1_bottom_day1 = 1;

class Node
{
  String k;
  int i;
  int value;
  float h, s, b;

  Node left = null;
  Node right = null;
}

boolean tab1_new;
boolean tab1_click;

Node[] huff = new Node[MAX];
int huff_count;

int tab1_click_i;
int tab1_click_count;
boolean tab1_click_f;
boolean tab1_click_new;
float tab1_click_b, tab1_click_p;

class Box
{
  float x1, y1;
  float x2, y2;
  String k;
  int i;
  float h, s, b;
}

Box[] box = new Box[MAX];
int box_count;

void tab1_setup ()
{
  tab1_new = true;
  tab1_click = false;

  noStroke ();
  fill (0.0, 0.0, 1.0);
  rect (130, 0, winW-130, winH);

  strokeWeight (1.5);

  stroke (0.0, 0.0, 0.0);
  fill (0.0, 0.0, 1.0);
  rect (149, 69, 731, 276, 2);
  tab1_new = false;

  fill (randomHue, 0.35, 0.32);
  textFont (createFont ("SeoulNamsanEB", 20));
  textAlign (CENTER);
  text ("LOADING....", 149+731/2, 69+276/2+8);

  tab1_retab ();
}

void huff_insert (Node a)
{
  int i;
  Node temp;

  for ( i = 0 ; i < huff_count ; i ++ )
  {
    if ( huff [ i ] .value > a .value )
    {
      temp = huff [ i ] ;
      huff [ i ] = a ;
      a = temp ;
    }
  }
  huff [ huff_count ++ ] = a ;
}

Node huff_pop ()
{
  int i ;

  Node temp = huff [ 0 ] ;

  for ( i = 0 ; i < huff_count ; i ++ )
  {
    huff [ i ] = huff [ i + 1 ] ;
  }
  huff_count -- ;

  return temp ;
}

void make_box ( float x1, float y1, float x2, float y2, boolean s, Node x)
{
  if ( x.k == "" )
  {
    if ( s )
    {
      make_box ( x1, y1, (x.left.value*x2+x.right.value*x1)/(x.left.value+x.right.value), y2, false, x.left);
      make_box ( (x.left.value*x2+x.right.value*x1)/(x.left.value+x.right.value), y1, x2, y2, false, x.right);
    }
    else 
    {
      make_box ( x1, y1, x2, (x.left.value*y2+x.right.value*y1)/(x.left.value+x.right.value), true, x.left);
      make_box ( x1, (x.left.value*y2+x.right.value*y1)/(x.left.value+x.right.value), x2, y2, true, x.right);
    }
  }
  else
  {
    box [ box_count ] = new Box ();
    box [ box_count ] .x1 = x1 ;
    box [ box_count ] .y1 = y1 ;
    box [ box_count ] .x2 = x2 ;
    box [ box_count ] .y2 = y2 ;
    box [ box_count ] .k = x .k ;
    box [ box_count ] .h = x .h ;
    box [ box_count ] .s = x .s ;
    box [ box_count ] .b = x .b ;
    box [ box_count ] .i = x .i ;
    box_count ++;
  }
}

void tab1_calc ()
{
  tab1_new = false ;
  Node a, b;
  Node temp;

  int i ;

  huff_count = 0 ;

  if (tab1_tn == 0)
  {
    for ( i = 0 ; i < cominfo.filename_numbering_count ; i ++ )
    {
      temp = new Node ();
      temp.k = cominfo.file[i].filename;
      temp.value = cominfo.file[i].commit_count;
      temp.h = cominfo.file[i].h;
      temp.s = cominfo.file[i].s;
      temp.b = cominfo.file[i].b;
      temp.i = i;
      huff_insert (temp);
    }
  }
  
  if (tab1_tn == 1)
  {
  }

  if ( huff_count > 0 )
  {
    while ( huff_count > 1 )
    {
      a = huff_pop ( ) ;
      b = huff_pop ( ) ;
      temp = new Node ( ) ;
      temp.k = "";
      temp.value = a.value + b.value;
      temp.left = a ;
      temp.right = b ;
      huff_insert ( temp ) ;
    }

    box_count = 0 ;
    make_box ( 150, 70, 880, 345, true, huff [ 0 ] ) ;
  }
}

void tab1_treemap ()
{
  int i ;

  for ( i = 0 ; i < box_count ; i ++ )
  {
    noStroke ();
    if ( tab1_click && mouseX >= box[i].x1 && mouseX <= box[i].x2 && mouseY >= box[i].y1 && mouseY <= box[i].y2 )
    {
      if (i == tab1_click_i)
      {
        if ( tab1_click_count >= 50 )
        {
          if ( tab1_click_f == false )
          {
            tab1_click_p *= (-2);
          }
          else 
          {
            tab1_click_p *= (-1);
          }
          tab1_click_count = 0;
        }
        tab1_click_b = tab1_click_b + tab1_click_p ;
        tab1_click_count ++;
        tab1_click_f = true ;
      }
      else
      {
        tab1_click_b = box [ i ] .b ;
        tab1_click_p = random ( 0.005, 0.015 ) - 0.01 ;
        tab1_click_count = 0;
        tab1_click_f = false;
        tab1_click_new = true ;
        tab1_bottom_number = 0;
        tab1_bottom_month = 0;
        tab1_bottom_month1 = 0;
        tab1_bottom_day = 0;
        tab1_bottom_day1 = 1;
      }
      tab1_click_i = i;
      fill (box [ i ] .h, box [ i ] .s, tab1_click_b);
    }
    else
    {
      fill (box [ i ] .h, box [ i ] .s, box [ i ] .b);
    }
    rect (box [ i ] .x1, box [ i ] .y1, box [ i ]. x2 - box [ i ] .x1, box [ i ] .y2 - box [ i ] .y1) ;
  }
}

void tab1_draw ()
{ 
  if (tab1_new)
  {
    //rect (150, 70, 730, 275, 2);
    if ( !tab1_click )
    {
      tab1_calc ();
    }
    tab1_treemap ();
  }
  else tab1_treemap ();

  //rect (150, 355, 730, 275, 2);

  if ( tab1_tn == 0 && tab1_click_i != -1 && tab1_click && tab1_bottom_number == 0 )
  {
    noStroke();
    fill (0.0, 0.0, 1.0);
    rect (150, 355, 731, 275, 2);

    int wn = 24;
    int max = -1 ;
    int i, j;

    for ( i = 0, j = cominfo.file[box[tab1_click_i].i].syear * 12 + cominfo.file[box[tab1_click_i].i].smonth - tab1_bottom_month - (wn - 1) ; i < 680 / wn ; i ++ , j ++ )
    {
      if ( max < cominfo.file[box[tab1_click_i].i].count_year_sum[j] )
        max = cominfo.file[box[tab1_click_i].i].count_year_sum[j];
    }

    max ++ ;
    int temp = max / 5;

    if ( temp < 1 ) max = 5;
    temp = max / 5;

    for ( i = 0 ; i < 5 ; i ++ )
    {
      stroke (randomHue, 0.25, 1.0);
      strokeWeight (1);
      line (200, 355+225-temp/(float)max*i*210, 200+680, 355+225-temp/(float)max*i*210);

      fill (randomHue, 0.35, 0.9);
      textFont (createFont ("SeoulNamsanEB", 16));
      textAlign (RIGHT);
      text (Integer.toString(temp*i), 190, 355+225-temp/(float)max*i*225+7);
    }

    for ( i = 0, j = cominfo.file[box[tab1_click_i].i].syear * 12 + cominfo.file[box[tab1_click_i].i].smonth - tab1_bottom_month - (wn - 1) ; i < wn ; i ++ , j ++ )
    {
      if ( cominfo.file[box[tab1_click_i].i].count_year_sum[j] != 0 )
      {
        noStroke ();
        if ( tab1_bottom_month1 == wn - 1 - i )
        {
          fill (randomHue, 0.35, 0.40);
        }
        else
        {
          fill (randomHue, 0.35, 0.80);
        }
        rect (200+(680/wn)*i+2, 355+225-(cominfo.file[box[tab1_click_i].i].count_year_sum[j]/(float)max*210-1), 680/wn-4, (cominfo.file[box[tab1_click_i].i].count_year_sum[j]/(float)max*210));
      }
      if ( tab1_bottom_month1 == wn - 1 - i )
      {
        fill (randomHue, 0.1, 0.1);
        ellipse (200+(680/wn)*(i+0.5), 355+225+8, 5, 5);
      }
      if ( j % 12 == 0 )
      {
        fill (randomHue, 0.35, 0.9);
        textFont (createFont ("SeoulNamsanEB", 16));
        textAlign (RIGHT);
        text (Integer.toString(j/12+1900), 200+(680/wn)*(i+0.5), 355+225+22);
      }
    }
  }
  
  if ( tab1_tn == 0 && !tab1_click && tab1_bottom_number == 0 )
  {
    noStroke();
    fill (0.0, 0.0, 1.0);
    rect (150, 355, 731, 275, 2);

    int wn = 24;
    int max = -1 ;
    int i, j;
    
    Date a = new Date ();

    for ( i = 0, j = a.getYear() * 12 + a.getMonth() - tab1_bottom_month - (wn - 1) ; i < 680 / wn ; i ++ , j ++ )
    {
      if ( max < cominfo.count_year_sum[j] )
        max = cominfo.count_year_sum[j];
    }

    max += 3;
    int temp = max / 5;

    if ( temp < 1 ) max = 5;
    temp = max / 5;

    for ( i = 0 ; i < 5 ; i ++ )
    {
      stroke (randomHue, 0.25, 1.0);
      strokeWeight (1);
      line (200, 355+225-temp/(float)max*i*210, 200+680, 355+225-temp/(float)max*i*210);

      fill (randomHue, 0.35, 0.9);
      textFont (createFont ("SeoulNamsanEB", 16));
      textAlign (RIGHT);
      text (Integer.toString(temp*i), 190, 355+225-temp/(float)max*i*210+7);
    }

    for ( i = 0, j = a.getYear() * 12 + a.getMonth() - tab1_bottom_month - (wn - 1) ; i < wn ; i ++ , j ++ )
    {
      if ( cominfo.count_year_sum[j] != 0 )
      {
        noStroke ();
        if ( tab1_bottom_month1 == wn - 1 - i )
        {
          fill (randomHue, 0.35, 0.40);
        }
        else
        {
          fill (randomHue, 0.35, 0.80);
        }
        rect (200+(680/wn)*i+2, 355+225-(cominfo.count_year_sum[j]/(float)max*210-1), 680/wn-4, (cominfo.count_year_sum[j]/(float)max*210));
      }
      if ( tab1_bottom_month1 == wn - 1 - i )
      {
        fill (randomHue, 0.1, 0.1);
        ellipse (200+(680/wn)*(i+0.5), 355+225+8, 5, 5);
      }
      if ( j % 12 == 0 )
      {
        fill (randomHue, 0.35, 0.9);
        textFont (createFont ("SeoulNamsanEB", 16));
        textAlign (RIGHT);
        text (Integer.toString(j/12+1900), 200+(680/wn)*(i+0.5), 355+225+22);
      }
    }
  }

  if ( tab1_tn == 0 && !tab1_click && tab1_bottom_number == 1 )
  {
    noStroke();
    fill (0.0, 0.0, 1.0);
    rect (150, 355, 731, 275, 2);

    int wn = 31;
    int max = -1 ;
    int i, j;

    Date a = new Date ();
    
    for ( i = 1 ; i <= 31 ; i ++ )
    {
      if ( max < cominfo.count[a.getYear() * 12 + a.getMonth() - tab1_bottom_month - tab1_bottom_month1][i] )
        max = cominfo.count[a.getYear() * 12 + a.getMonth() - tab1_bottom_month - tab1_bottom_month1][i];
    }

    max += 3 ;
    int temp = max / 5;

    if ( temp < 1 ) max = 5;
    temp = max / 5;

    for ( i = 0 ; i < 5 ; i ++ )
    {
      stroke (randomHue, 0.25, 1.0);
      strokeWeight (1);
      line (200, 355+225-temp/(float)max*i*210, 200+680, 355+225-temp/(float)max*i*210);

      fill (randomHue, 0.35, 0.9);  
      textFont (createFont ("SeoulNamsanEB", 16));
      textAlign (RIGHT);
      text (Integer.toString(temp*i), 190, 355+225-temp/(float)max*i*210+7);
    }

    for ( i = 1 ; i <= 31 ; i ++ )
    {
      if ( cominfo.count[a.getYear() * 12 + a.getMonth() - tab1_bottom_month - tab1_bottom_month1][i] != 0 )
      {
        noStroke ();
        fill (randomHue, 0.35, 0.80);
        rect (200+(682/wn)*(i-1)+2, 355+225-(cominfo.count[a.getYear() * 12 + a.getMonth() - tab1_bottom_month - tab1_bottom_month1][i]/(float)max*210-1), 682/wn-4, (cominfo.count[a.getYear() * 12 + a.getMonth() - tab1_bottom_month - tab1_bottom_month1][i]/(float)max*210));
      }
      fill (randomHue, 0.35, 0.9);
      textFont (createFont ("SeoulNamsanEB", 10));
      textAlign (CENTER);
      text (Integer.toString(i), 200+(682/wn)*(i-1+0.5), 355+225+11);
    }
  }
  
  if ( tab1_tn == 0 && tab1_click_i != -1 && tab1_click && tab1_bottom_number == 1 )
  {
    noStroke();
    fill (0.0, 0.0, 1.0);
    rect (150, 355, 731, 275, 2);

    int wn = 31;
    int max = -1 ;
    int i, j;

    for ( i = 1 ; i <= 31 ; i ++ )
    {
      if ( max < cominfo.file[box[tab1_click_i].i].count[cominfo.file[box[tab1_click_i].i].syear * 12 + cominfo.file[box[tab1_click_i].i].smonth - tab1_bottom_month - tab1_bottom_month1][i] )
        max = cominfo.file[box[tab1_click_i].i].count[cominfo.file[box[tab1_click_i].i].syear * 12 + cominfo.file[box[tab1_click_i].i].smonth - tab1_bottom_month - tab1_bottom_month1][i];
    }

    max ++ ;
    int temp = max / 5;

    if ( temp < 1 ) max = 5;
    temp = max / 5;

    for ( i = 0 ; i < 5 ; i ++ )
    {
      stroke (randomHue, 0.25, 1.0);
      strokeWeight (1);
      line (200, 355+225-temp/(float)max*i*210, 200+680, 355+225-temp/(float)max*i*210);

      fill (randomHue, 0.35, 0.9);  
      textFont (createFont ("SeoulNamsanEB", 16));
      textAlign (RIGHT);
      text (Integer.toString(temp*i), 190, 355+225-temp/(float)max*i*210+7);
    }

    for ( i = 1 ; i <= 31 ; i ++ )
    {
      if ( cominfo.file[box[tab1_click_i].i].count[cominfo.file[box[tab1_click_i].i].syear * 12 + cominfo.file[box[tab1_click_i].i].smonth - tab1_bottom_month - tab1_bottom_month1][i] != 0 )
      {
        noStroke ();
        fill (randomHue, 0.35, 0.80);
        rect (200+(682/wn)*(i-1)+2, 355+225-(cominfo.file[box[tab1_click_i].i].count[cominfo.file[box[tab1_click_i].i].syear * 12 + cominfo.file[box[tab1_click_i].i].smonth - tab1_bottom_month - tab1_bottom_month1][i]/(float)max*210-1), 682/wn-4, (cominfo.file[box[tab1_click_i].i].count[cominfo.file[box[tab1_click_i].i].syear * 12 + cominfo.file[box[tab1_click_i].i].smonth - tab1_bottom_month - tab1_bottom_month1][i]/(float)max*210));
      }
      fill (randomHue, 0.35, 0.9);
      textFont (createFont ("SeoulNamsanEB", 10));
      textAlign (CENTER);
      text (Integer.toString(i), 200+(682/wn)*(i-1+0.5), 355+225+11);
    }
  }

  fill (0.0, 0.0, 1.0);
  stroke (0.0, 0.0, 0.0);

  if ( tab1_tn == 0 && tab1_click_i != -1 && tab1_click )
  {
    if ( tab1_click_new )
    {
      rect (900, 20, 280, 610, 2);
      fill (randomHue, 0.35, 0.32);
      textFont (createFont ("SeoulNamsanB", 11));
      textAlign (LEFT);
      text ("File&Directory name: ", 910, 41);
      fill (0.0, 0.0, 0.0);
      if (box[tab1_click_i].k.length() >= 24)
      {
        textFont (createFont ("SeoulNamsanB", 19*24/box[tab1_click_i].k.length()));
      }
      else 
        textFont (createFont ("SeoulNamsanB", 19));
      text (box[tab1_click_i].k, 922, 61);

      fill (randomHue, 0.35, 0.82);
      stroke (randomHue, 0.35, 0.7);
      strokeWeight (2);
      line (910, 70, 1170, 70);

      int i, j;
      int sum=0;

      for ( i = 0 ; i < cominfo.file[box[tab1_click_i].i].ppname_numbering_count ; i ++ )
      {
        sum += cominfo.file[box[tab1_click_i].i].ppcount[i];
      }

      for ( i = 0 ; i < cominfo.file[box[tab1_click_i].i].ppname_numbering_count ; i ++ )
      {
        for ( j = i + 1 ; j < cominfo.file[box[tab1_click_i].i].ppname_numbering_count ; j ++ )
        {
          if ( cominfo.file[box[tab1_click_i].i].ppcount[i] < cominfo.file[box[tab1_click_i].i].ppcount[j] )
          {
            int tempc = cominfo.file[box[tab1_click_i].i].ppcount[i];
            cominfo.file[box[tab1_click_i].i].ppcount[i] = cominfo.file[box[tab1_click_i].i].ppcount[j];
            cominfo.file[box[tab1_click_i].i].ppcount[j] = tempc;

            String tempi = cominfo.file[box[tab1_click_i].i].ppid[i];
            cominfo.file[box[tab1_click_i].i].ppid[i] = cominfo.file[box[tab1_click_i].i].ppid[j];
            cominfo.file[box[tab1_click_i].i].ppid[j] = tempi;
          }
        }
      }

      for ( i = 0 ; i < cominfo.file[box[tab1_click_i].i].ppname_numbering_count && i < 7 ; i ++ )
      {
        PImage avi = cominfo.load_avatar(cominfo.file[box[tab1_click_i].i].ppid[i]);
        image (avi, 910, 80 + 78 * i, 68, 68);

        stroke (0.0, 0.0, 0.0);
        line (988, 80 + 78 * i, 1170, 80 + 78 * i);
        fill (0.0, 0.0, 0.0);
        textFont (createFont ("SeoulNamsanB", 15));
        textAlign (LEFT);
        text (cominfo.idtoname.getString(cominfo.file[box[tab1_click_i].i].ppid[i]), 988, 80 + 78 * i + 17);

        fill (randomHue, 0.35, 0.5);
        rect (988, 80 + 78 * i + 30, (float)cominfo.file[box[tab1_click_i].i].ppcount[i]/sum*142, 30);

        fill (0.0, 0.0, 0.0);
        textFont (createFont ("SeoulNamsanEB", 15));
        textAlign (LEFT);
        text (Integer.toString((int)((float)cominfo.file[box[tab1_click_i].i].ppcount[i]/sum*100))+"%", 988+ (float)cominfo.file[box[tab1_click_i].i].ppcount[i]/sum*142 + 5, 80 + 78 * i + 30 + 15+6);
      }

      tab1_click_new = false;
    }
  }
  else
  {
    strokeWeight (1.5);
    rect (900, 20, 280, 610, 2);
  }
}

void tab1_retab ()
{
  noStroke ();
  fill (0.0, 0.0, 1.0);
  rect (130, 0, 772, 62);

  fill (randomHue, 0.15, 0.85);
  textFont (createFont ("SeoulNamsanEB", 30));
  textAlign (LEFT);
  text ("Home", 129, 22);

  if (tab1_tn == 0)
  {
    fill (randomHue, 0.35, 0.10);
    stroke (randomHue, 0.35, 0.10);
  }
  else
  {
    fill (randomHue, 0.35, 0.92);
    stroke (randomHue, 0.35, 0.92);
  }
  textFont (createFont ("SeoulNamsanEB", 20));
  textAlign (LEFT);
  text ("File", 150, 55);
  strokeWeight (2);
  line (150, 60, 505, 60);

  if (tab1_tn == 1)
  {
    fill (randomHue, 0.35, 0.10);
    stroke (randomHue, 0.35, 0.10);
  }
  else
  {
    fill (randomHue, 0.35, 0.92);
    stroke (randomHue, 0.35, 0.92);
  }
  textFont (createFont ("SeoulNamsanEB", 20));
  textAlign (LEFT);
  text ("Contributor", 515, 55);
  strokeWeight (2);
  line (515, 60, 870, 60);
}

void tab1_mousePressed ()
{
  if (mouseX >= 150 && mouseX <= 515 && mouseY >= 20 && mouseY <= 60)
  {
    tab1_tn = 0;
    tab1_retab();
  }
  else if (mouseX >= 515 && mouseX <= 880 && mouseY >= 20 && mouseY <= 60)
  {
    tab1_tn = 1;
    tab1_retab();
  }

  if (mouseX >= 150 && mouseX <= 880 && mouseY >= 70 && mouseY <= 345)
  {
    tab1_click = true;
  }
  else
  {
    noStroke();
    fill (0.0, 0.0, 1.0);
    rect (150, 355, 731, 275, 2);

    tab1_click_i = -1;
    tab1_click_count = 0;
    tab1_click = false;
    tab1_click_f = false;
    tab1_click_new = false;
  }
}

void tab1_keyPressed()
{
  if ( tab1_tn == 0 && tab1_bottom_number == 0 )
  {
    if (key == CODED)
    {
      if (keyCode == UP)
      {
        tab1_bottom_number = 1 ;
      }
      if (keyCode == LEFT)
      {
        if ( tab1_bottom_month1 == 23 )
        {
          tab1_bottom_month++;
        }
        else
        {
          tab1_bottom_month1++;
        }
      }
      if (keyCode == RIGHT)
      {
        if ( tab1_bottom_month1 == 0 )
        {
          tab1_bottom_month--;
        }
        else
        {
          tab1_bottom_month1--;
        }
      }
    }
  }

  if ( tab1_tn == 0 && tab1_bottom_number == 1 )
  {
    if (key == CODED)
    {
      if (keyCode == DOWN)
      {
        tab1_bottom_number = 0 ;
      }
      if (keyCode == LEFT)
      {
        if ( tab1_bottom_day == 31 )
        {
          tab1_bottom_day++;
        }
        else
        {
          tab1_bottom_day1++;
        }
      }
      if (keyCode == RIGHT)
      {
        if ( tab1_bottom_day1 == 1 )
        {
          tab1_bottom_day--;
        }
        else
        {
          tab1_bottom_day1--;
        }
      }
    }
  }
}

