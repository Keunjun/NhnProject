int tab1_tn = 0;

void tab1_setup ()
{
  noStroke ();
  fill (0.0, 0.0, 1.0);
  rect (130, 0, winW-130, winH);

  tab1_retab ();
}

void tab1_draw ()
{
  stroke (randomHue, 0.35, 0.22);
  fill (0.0, 0.0, 1.0);
  rect (150, 70, 730, 275);
  rect (150, 355, 730, 275);
  rect (900, 20, 280, 610);
}

void tab1_retab ()
{
  noStroke ();
  fill (0.0, 0.0, 1.0);
  rect (149, 20, 732, 42);
  
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
  textFont (createFont ("SeoulNamsanEB", 30));
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
  textFont (createFont ("SeoulNamsanEB", 30));
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
}

