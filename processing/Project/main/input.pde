ControlP5 input_textfield;

void input_setup ()
{
  // setting background color
  background (0.0, 0.0, 1.0);

  //
  fill (randomHue, 0.35, 0.85);
  textFont (createFont ("SeoulNamsanEB", 150));
  textAlign (LEFT);
  text ("C", 30, 170);
  fill (randomHue, 0.27, 0.0);
  textFont (createFont ("SeoulNamsanEB", 150));
  textAlign (LEFT);
  text ("ode", 130, 170);
  textFont (createFont ("SeoulNamsanEB", 150));
  text ("Visualization", 90, 320);

  textFont (createFont ("SeoulNamsanEB", 32));
  textAlign (RIGHT);
  text ("Id:", 900, 550);
  textAlign (RIGHT);
  text ("Repo:", 900, 582);

  input_textfield = new ControlP5 (this);
  input_textfield.addTextfield ("id")
    .setPosition (910, 527)
      .setSize (200, 24)
        .setColorBackground (color (0.0, 0.0, 1.0))
          .setFont (createFont ("SeoulNamsanEB", 22))
            .setFocus (true)
              .setColorForeground (color (0.0, 0.0, 1.0))
                .setColorActive (color (0.0, 0.0, 1.0))
                  .setColor (color (randomHue, 0.27, 0.0));
  input_textfield.addTextfield ("repo")
    .setPosition (910, 559)
      .setSize (200, 24)
        .setColorBackground (color (0.0, 0.0, 1.0))
          .setFont (createFont ("SeoulNamsanEB", 22))
            .setFocus (false)
              .setColorForeground (color (0.0, 0.0, 1.0))
                .setColorActive (color (0.0, 0.0, 1.0))
                  .setColor (color (0.0, 0.0, 0.0));
  stroke (randomHue, 0.35, 0.85);
  strokeWeight (2);
  line (910, 553, 1100, 553);
  line (910, 584, 1100, 584);

  strokeWeight (0);
  fill (randomHue, 0.35, 0.85);
  rect(1120, 561, 20, 20, 3);
  fill (0.0, 0.0, 1.0);
  rect(1125, 566, 10, 10, 3);

  PImage img = loadImage ("nhn.png");
  image (img, 70, winH-img.height/6, img.width/6, img.height/6);
  img = loadImage ("snu.png");
  image (img, 0, winH-img.height/5, img.width/5, img.height/5);
}

void input_draw ()
{
  if (mouseX >= 1120 && mouseX <= 1120+20 && mouseY >= 561 && mouseY <= 581)
  {
    strokeWeight (0);
    fill (color (randomHue, 0.35, 0.85));
    rect(1120, 561, 20, 20, 3);
  }
  else
  {
    strokeWeight (0);
    fill (color (randomHue, 0.35, 0.85));
    rect(1120, 561, 20, 20, 3);
    fill (color (0.0, 0.0, 1.0));
    rect(1125, 566, 10, 10, 3);
  }
}

void input_mousePressed ()
{
  if (mouseX >= 1120 && mouseX <= 1120+20 && mouseY >= 561 && mouseY <= 581)
  {
    id = input_textfield.get (Textfield.class, "id").getText ();
    repo = input_textfield.get (Textfield.class, "repo").getText ();
    
    id = "github";
    repo = "hubot";

    input_end ();
    page_number=1;
  }
}

void input_end ()
{
  input_textfield.remove ("id");
  input_textfield.remove ("repo");
}

