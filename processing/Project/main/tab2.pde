int tab2_offset = 0 ;
int tab2_click = 0 ;
int twinkle = 0;
boolean tw = true ;

boolean[] tab2_check = new boolean [PPMAX] ;

void tab2_setup ()
{
}

float red_MIN ( float a, float b )
{
  if ( a < ( 1.0 - b) ) return a ;
  return b ;
}

float plen ( float x1, float y1, float x2, float y2 )
{
  return sqrt ( (x2 - x1) * (x2- x1) + (y2 - y1) * (y2 - y1) );
}

void tab2_draw ()
{
  int i;
  int max = 5;
  float st = winH/3.0;

  noStroke ();
  fill (0.0, 0.0, 1.0);
  rect (130, 0, winW-130, winH);

  fill (randomHue, 0.15, 0.85);
  textFont (createFont ("SeoulNamsanEB", 30));
  textAlign (LEFT);
  text ("Code Frequency", 129, 22);

  strokeWeight (1.5);
  stroke (0.0, 0.0, 0.0);
  fill (0.0, 0.0, 1.0);
  rect (900, 20, 280, 610, 2);

  twinkle ++;
  if ( twinkle >= 30 )
  {
    tw = !tw;
    twinkle = 0 ;
  }

  for ( i = tab2_offset ; i < cominfo.ppname_numbering_count && i < 8 + tab2_offset ; i ++ )
  {
    if ( i - tab2_offset == tab2_click && tw )
    {
      strokeWeight (1.5);
      stroke (randomHue, 0.35, 0.25) ;
      fill (0.0, 0.0, 1.0);
      rect (905, 30+75*(i-tab2_offset)-5, 270, 75);
    }

    if ( tab2_check [ i ] )
    {
      strokeWeight (3);
      stroke (cominfo.ppco[i][0], cominfo.ppco[i][1], cominfo.ppco[i][2]) ;
      fill (0.0, 0.0, 1.0);
      rect (908, 30+75*(i-tab2_offset)-2, 264, 68, 2);
    }

    PImage img = cominfo.load_avatar(cominfo.ppname_list[i]);
    image (img, 910, 30+75*(i-tab2_offset), 65, 65);

    fill (0.0, 0.0, 0.0);
    textFont (createFont ("SeoulNamsanB", 15));
    textAlign (LEFT);
    text (cominfo.idtoname.getString(cominfo.ppname_list[i]), 985, 35 + 75 * (i-tab2_offset) + 15);
  }

  for ( i = cominfo.min ; i <= cominfo.max ; i ++ )
  {
    if ( max < cominfo.addition [ i ] ) 
      max = cominfo.addition [ i ] ;
    if ( max < cominfo.deletion [ i ] ) 
      max = cominfo.deletion [ i ] ;
  }
  st /= max;

  for ( i = (max/5) ; i <= max ; i += (max/5) )
  {
    strokeWeight (3);
    stroke (color ((0.333*3+randomHue)/4.0, 0.35, 1.0));
    line ( 180, winH/2 - st * i, 190, winH/2 - st * i);

    fill (color ((0.333*3+randomHue)/4.0, 0.35, 1.0));
    textFont (createFont ("SeoulNamsanEB", 13));
    textAlign (RIGHT);
    if (i>=1000)
    {
      String a = Integer.toString(i/1000);
      a = a + "." + Integer.toString((i%1000)/100) + "K";
      text (a, 176, winH/2 - st * i + 6);
    }
    else
    {
      text (Integer.toString(i), 176, winH/2 - st * i + 6);
    }
  }

  fill (color ((0.333*3+randomHue)/4.0, 0.35, 1.0));
  textFont (createFont ("SeoulNamsanEB", 13));
  textAlign (RIGHT);
  text ("Additions", 190, winH/2 - st * i + 6);

  for ( i = (max/5) ; i <= max ; i += (max/5) )
  {
    strokeWeight (3);
    stroke (red_MIN((randomHue)/4.0, (randomHue+3)/4.0), 0.35, 1.0);
    line ( 180, winH/2 + st * i, 190, winH/2 + st * i);

    fill (red_MIN((randomHue)/4.0, (randomHue+3)/4.0), 0.35, 1.0);
    textFont (createFont ("SeoulNamsanEB", 13));
    textAlign (RIGHT);
    if (i>=1000)
    {
      String a = Integer.toString(i/1000);
      a = a + "." + Integer.toString((i%1000)/100) + "K";
      text (a, 176, winH/2 + st * i + 6);
    }
    else
    {
      text (Integer.toString(i), 176, winH/2 + st * i + 6);
    }
  }

  fill (red_MIN((randomHue)/4.0, (randomHue+3)/4.0), 0.35, 1.0);
  textFont (createFont ("SeoulNamsanEB", 13));
  textAlign (RIGHT);
  text ("Deletions", 190, winH/2 + st * i + 6);

  strokeWeight (1);
  stroke (0.0, 0.0, 0.0);

  line (200, winH/2, 900-70, winH/2);

  strokeWeight (0.5);
  stroke (randomHue, 0.20, 1.0);
  if (cominfo.max - cominfo.min >= 4)
  {
    for ( i = cominfo.min ; i <= cominfo.max ; i ++ )
    {
      if ( i % 5 == 0 )
      {
        line (200 + (900 - 270) * (i - cominfo.min) / (cominfo.max - cominfo.min), winH/6.0-70, 200 + (900 - 270) * (i - cominfo.min) / (cominfo.max - cominfo.min), winH*5/6.0+30);

        fill (randomHue, 0.35, 0.9);
        textFont (createFont ("SeoulNamsanEB", 13));
        textAlign (CENTER);
        text (Integer.toString(i/5/12-100) + "/" + Integer.toString((i/5)%12), 200 + (900 - 270) * (i - cominfo.min) / (cominfo.max - cominfo.min), winH*5/6.0+48);
      }
    }
  }

  beginShape ();

  fill ((0.333*3+randomHue)/4.0, 0.35, 0.85);
  stroke ((0.333*3+randomHue)/4.0, 0.35, 0.25);
  strokeWeight (1.5);
  vertex (200, winH/2);
  if (cominfo.min == cominfo.max)
  {
    vertex (200, winH/2 - st * cominfo.addition [ cominfo.min ]);
    vertex (900-70, winH/2 - st * cominfo.addition [ cominfo.min ]);
  }
  else
  {
    for ( i = cominfo.min ; i <= cominfo.max ; i ++ )
    {
      vertex (200 + (900 - 270) * (i - cominfo.min) / (cominfo.max - cominfo.min), winH/2 - st * cominfo.addition [ i ]);
    }
  }
  vertex (900-70, winH/2);

  endShape (CLOSE);


  beginShape ();

  fill (red_MIN((randomHue)/4.0, (randomHue+3)/4.0), 0.35, 0.85);
  stroke (red_MIN((randomHue)/4.0, (randomHue+3)/4.0), 0.35, 0.25);
  strokeWeight (1.5);
  vertex (200, winH/2);
  if (cominfo.min == cominfo.max)
  {
    vertex (200, winH/2 + st * cominfo.deletion [ cominfo.min ]);
    vertex (900-70, winH/2 + st * cominfo.deletion [ cominfo.min ]);
  }
  else
  {
    for ( i = cominfo.min ; i <= cominfo.max ; i ++ )
    {
      vertex (200 + (900 - 270) * (i - cominfo.min) / (cominfo.max - cominfo.min), winH/2 + st * cominfo.deletion [ i ]);
    }
  }
  vertex (900-70, winH/2);

  int j ;

  endShape (CLOSE);

  fill (0, 0);
  strokeWeight (2);
  for ( i = 0 ; i < cominfo.ppname_numbering_count ;  i ++ )
  {
    if ( tab2_check [ i ] )
    {
      stroke (cominfo.ppco[i][0], cominfo.ppco[i][1], cominfo.ppco[i][2]) ;

      beginShape();
      vertex (200, winH*5/6);
      if (cominfo.min == cominfo.max)
      {
        if (cominfo.addition[cominfo.min] != 0 )
        {
          vertex (200, winH*5/6 - winH*2/3 * cominfo.ppname_addition[i][cominfo.min] / cominfo.addition [cominfo.min]);
          vertex (900-70, winH*5/6 - winH/3 * cominfo.ppname_addition[i][cominfo.min] / cominfo.addition [cominfo.min]);
        }
      }
      else
      {
        for ( j = cominfo.min ; j <= cominfo.max ; j ++ )
        {
          if ( cominfo.addition [ j ] != 0 )
          {
            fill (cominfo.ppco[i][0], cominfo.ppco[i][1], cominfo.ppco[i][2]/2.0) ;
            stroke (cominfo.ppco[i][0], cominfo.ppco[i][1], cominfo.ppco[i][2]/2.0) ;
            ellipse (200 + (900 - 270) * (j - cominfo.min) / (cominfo.max - cominfo.min), winH*5/6 - winH*2/3 * cominfo.ppname_addition[i][j] / (float)cominfo.addition [ j ], 4, 4);
            if (plen (200 + (900 - 270) * (j - cominfo.min) / (cominfo.max - cominfo.min), winH*5/6 - winH*2/3 * cominfo.ppname_addition[i][j] / (float)cominfo.addition [ j ], mouseX, mouseY) <= 8)
            {
              fill (0.0, 0.0, 0.0);
              textFont (createFont ("SeoulNamsanEB", 15));
              textAlign (LEFT);
              text (cominfo.idtoname.getString(cominfo.ppname_list[i]) + " : " + Integer.toString ((int) (cominfo.ppname_addition[i][j] / (float)cominfo.addition [ j ]*100))+"%", mouseX, mouseY);
            }
            fill (cominfo.ppco[i][0], cominfo.ppco[i][1], (1+cominfo.ppco[i][2])/2.0, 0.5);
            stroke (cominfo.ppco[i][0], cominfo.ppco[i][1], cominfo.ppco[i][2]) ;
            vertex (200 + (900 - 270) * (j - cominfo.min) / (cominfo.max - cominfo.min), winH*5/6 - winH*2/3 * cominfo.ppname_addition[i][j] / (float)cominfo.addition [ j ]);
          }
        }
      }
      vertex (900-70, winH*5/6);
      endShape();
    }
  }
}

void tab2_keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == UP)
    {
      tw = true;
      twinkle = 0 ;

      if ( tab2_click == 0 )
      {
        if (tab2_offset > 0 )
          tab2_offset -- ;
      }
      else
      {
        tab2_click -- ;
      }
    }
    if (keyCode == DOWN)
    {
      tw = true;
      twinkle = 0 ;

      if ( tab2_click == 7 || tab2_offset + tab2_click == cominfo.ppname_numbering_count - 1 )
      {
        if (tab2_offset < cominfo.ppname_numbering_count - 8)
          tab2_offset ++;
      }
      else
      {
        tab2_click ++;
      }
    }
  }
  if (key == ' ')
  {
    tab2_check [ tab2_click + tab2_offset ] = !tab2_check [ tab2_click + tab2_offset ] ;
  }
}

