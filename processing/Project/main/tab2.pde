void tab2_setup ()
{
}

float red_MIN ( float a, float b )
{
  if ( a < ( 1.0 - b) ) return a ;
  return b ;
}

void tab2_draw ()
{
  int i;
  int max = -1;
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

  endShape (CLOSE);
}

