import org.json.*;
import controlP5.*;
import java.util.*;
import java.text.*;

int page_number=0;
int now_page_number=-1;

int winW=1200;
int winH=650;

float randomHue ;

String id, repo;

Data cominfo;

void setup ()
{
  colorMode (HSB, 1.0);
  randomHue = random (0.0, 1.0);
  size (winW, winH);
  
  cominfo = new Data ();
}

void draw ()
{
  switch (page_number)
  {
  case 0:
    if (page_number != now_page_number) input_setup ();
    input_draw ();
    now_page_number = 0;
    break;
  case 1:
    if (page_number != now_page_number) show_setup ();
    show_draw ();
    now_page_number = 1;
    break;
  }
}

void mousePressed ()
{
  switch (page_number)
  {
  case 0: 
    input_mousePressed(); 
    break;
  case 1: 
    show_mousePressed(); 
    break;
  }
}
