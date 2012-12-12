/*
 * ----------------------------------
 *  Knob Class for Processing 2.0
 * ----------------------------------
 *
 * this is a simple knob class. The following shows 
 * you how to use it in a minimalistic way.
 *
 * DEPENDENCIES:
 *   N/A
 *
 * Created:  March, 19 2012
 * Author:   Alejandro Dirgan
 * Version:  0.3
 *
 * License:  GPLv3
 *   (http://www.fsf.org/licensing/)
 *
 * Follow Us
 *    adirgan.blogspot.com
 *    twitter: @ydirgan
 *    https://www.facebook.com/groups/mmiiccrrooss/
 *    https://plus.google.com/b/111940495387297822358/
 *
 * DISCLAIMER **
 * THIS SOFTWARE IS PROVIDED TO YOU "AS IS," AND WE MAKE NO EXPRESS OR IMPLIED WARRANTIES WHATSOEVER 
 * WITH RESPECT TO ITS FUNCTIONALITY, OPERABILITY, OR USE, INCLUDING, WITHOUT LIMITATION, ANY IMPLIED 
 * WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR INFRINGEMENT. WE EXPRESSLY 
 * DISCLAIM ANY LIABILITY WHATSOEVER FOR ANY DIRECT, INDIRECT, CONSEQUENTIAL, INCIDENTAL OR SPECIAL 
 * DAMAGES, INCLUDING, WITHOUT LIMITATION, LOST REVENUES, LOST PROFITS, LOSSES RESULTING FROM BUSINESS 
 * INTERRUPTION OR LOSS OF DATA, REGARDLESS OF THE FORM OF ACTION OR LEGAL THEORY UNDER WHICH THE LIABILITY 
 * MAY BE ASSERTED, EVEN IF ADVISED OF THE POSSIBILITY OR LIKELIHOOD OF SUCH DAMAGES.
 
 
EXAMPLE: Using knobs to change the color of the background manipulating R,G,B

ADknob rcolor, gcolor, bcolor;
int r,g,b;

void activateMouseWheel()
{
 addMouseWheelListener(new java.awt.event.MouseWheelListener() 
 { 
   public void mouseWheelMoved(java.awt.event.MouseWheelEvent evt) 
   { 
     mouseWheel(evt.getWheelRotation());
   }
 });

}

void setup()
{
   size(500,200);
   smooth();
   rcolor = new ADknob("R",100,100,45,255,0.0,1.0,4.0,20.0,34.0,19.0,34.0,15,7,53.0,20,19,10,-6,14,5,9,14,7,23,false,11,0);
   rcolor.setKnobPosition(234);
   rcolor.setColors(#D30606,0,-1,0,0,0,0,-11574371,-327681);
   gcolor = new ADknob("G",250,100,45,255,0.0,1.0,4.0,20.0,34.0,19.0,34.0,15,7,53.0,20,19,10,-6,14,5,9,14,7,23,false,11,0);
   gcolor.setKnobPosition(202);
   gcolor.setColors(#0FA705,0,-1,0,0,0,0,-11574371,-327681);
   bcolor = new ADknob("B",400,100,45,255,0.0,1.0,4.0,20.0,34.0,19.0,34.0,15,7,53.0,20,19,10,-6,14,5,9,14,7,23,false,11,0);
   bcolor.setKnobPosition(111);
   bcolor.setColors(#050EA7,0,-1,0,0,0,0,-11574371,-327681);
   
   activateMouseWheel();
}

void draw()
{
  background(color(r,g,b));
  r=(int )rcolor.update();
  g=(int )gcolor.update();
  b=(int )bcolor.update();
}

void mouseDragged()
{
  rcolor.change();
  gcolor.change();
  bcolor.change();
}

void mouseWheel(int delta)
{  
  rcolor.changeKnobPositionWithWheel(delta);
  gcolor.changeKnobPositionWithWheel(delta);
  bcolor.changeKnobPositionWithWheel(delta);
}
 
*/
class ADknob
{
  int knobRadius=100;
  int knobX,knobY;
  float knobValue=0;
  int prevKnobPosition=0;
  
  int knobIncrement=1;
  color internalColor=color(13,198,216);
  color internalColorLight=#0DC6D8+#230F0F;
  float strokeExternalCircle=8;
  
  int strokeOutterIndicator=14;
  int strokeInnerIndicator=6;

  int strokeOutterMarks=3;
  int strokeOutterInitEndMarks=5;
  int knobSteps=6;
    
  color colorExternalCircle=0;
  color colorOutterIndicator=0;
  color colorInnerIndicator=#FFFFFF;
  color internalColorMarks=0;
  color externalColorMarks=0;
  color colorMarksLight=#FF4400;
  int knobPlusStroke=5;
  
  color colorText=0;
  
  float angle=0;
  
  float outterOffsetFromCenter=10;
  float knobOutterLength=20;
  
  float innerOffsetFromCenter=10;
  float knobInnerLength=20;
  
  boolean knobmouseOver=false;

  float knobRightAngle=30; 
  int knobLengthMarkOuter=15;
  int knobLengthMarkInner=5;
  
  float knobMaxIniAngle;
  float knobMaxEndAngle;
  float knobTotalAngle;
  
  float[] knobStops;  
  int knobPosition;
  
  float knobStartValue;
  float knobEndValue;
  float knobSum;
  
  boolean knobSnap=true;
  
  float knobActualAngle;
  
  boolean knobKeyPressed=false;
  
  int knobValueTextSize=10;
  color knobColorValueText=#FF4400;
  int knobLabelTextSize=16;
  color knobColorLabelText=#4F639D;
  
  String knobLabelText;
  int knobLabelOffset=15;
  int knobValueOffset=30;
  boolean knobLabelTextVisible=true;
  
  float knobIndicatorOffset=0;
  
  int knobSkips=50;
  int knobNumberOfMarks=10;
  
  int knobOffsetMarks=10;
  
  int konbInnerIndicatorHigh=#FFE200;
  
  int knobValuelabelSize=11;
  color knobColorValueLabel=0;
  
  int knobValueLabelOffset=5;
  boolean showKnobLabelValues=false;
  
  int valueLabelOffset=0;
  
  boolean pressOnlyOnce=true;
  boolean debug=false;
  int deb=0;
  
  boolean knobMoving=false;
  
  ADknob(String knobName, int x, int y, int r, int stops, float vi, float step)
  {
    knobX=x;
    knobY=y;
    knobRadius=r;
    knobMaxIniAngle=(180-knobRightAngle)*PI/180;
    knobMaxEndAngle=knobRightAngle*PI/180+TWO_PI;
    knobTotalAngle=2*knobRightAngle*PI/180+PI;
    knobSteps=stops;
    
    knobStops =  new float[knobSteps+1];

    knobStartValue=vi;
    knobValue=knobStartValue;
    knobSum=step;
    calculateStops();
    
    //Initial Position
    knobPosition=prevKnobPosition=0;
    angle=knobActualAngle=knobStops[knobPosition];
    
    knobLabelText=knobName;
    
    if (stops>10) knobSkips=stops/knobNumberOfMarks;


  }
  
  ADknob(String knobName, int x, int y, int r, int stops, float vi, float step, float eec,  float oofc, float ol, float iofc, float il, int lmo, int lmi, float a, int ls, int lo, int vs, int vo, int om, int som, int soiem, int soi, int sii, int nom, boolean vvl, int vls, int vlo)
  {
    //int knobRadius, int strokeExternalCircle,float outterOffsetFromCenter, float knobOutterLength
    // float innerOffsetFromCenter, float knobInnerLength, int knobLengthMarkOuter, int knobLengthMarkInner, float knobRightAngle
    // in labelSize, labelOffset, valueSize, valueOffset

    
    knobX=x;
    knobY=y;
    knobRadius=r;
    knobSteps=stops;
    
    knobStops =  new float[knobSteps+1];

    knobStartValue=vi;
    knobValue=knobStartValue;
    knobSum=step;
    
    
    //Initial Position
    knobPosition=prevKnobPosition=0;
    angle=knobActualAngle=knobStops[knobPosition];
    
    knobLabelText=knobName;
    strokeExternalCircle=eec;
    outterOffsetFromCenter=oofc;
    knobOutterLength=ol;
    innerOffsetFromCenter=iofc;
    knobInnerLength=il;
    knobLengthMarkOuter=lmo;
    knobLengthMarkInner=lmi;
    knobRightAngle=a;
 
    knobLabelTextSize=ls;
    knobLabelOffset=lo;
    knobValueTextSize=vs;
    knobValueOffset=vo;

    knobMaxIniAngle=(180-knobRightAngle)*PI/180;
    knobMaxEndAngle=knobRightAngle*PI/180+TWO_PI;
    knobTotalAngle=2*knobRightAngle*PI/180+PI;
    calculateStops();
    setKnobPosition(knobPosition);
    
    knobNumberOfMarks=nom;
    
    if (stops>10) knobSkips=stops/knobNumberOfMarks;
    
    knobOffsetMarks=om;
    
    strokeOutterMarks=som;
    
    strokeOutterIndicator=soi;
    strokeInnerIndicator=sii;
    strokeOutterInitEndMarks=soiem;
    
    showKnobLabelValues=vvl;
    
    knobValuelabelSize=vls;
    
    valueLabelOffset=vlo;

  }
////////////////////////////////////////////////////////////////////////
  float round2nDecimals(float number, float decimal) {
      return (float)(round((number*pow(10, decimal))))/pow(10, decimal);
  }   
////////////////////////////////////////////////////////////////////////
  void calculateStops()
  {
    float steps = knobTotalAngle/knobSteps;
    float rangle=knobMaxIniAngle;

    for (int i = 0; i <= knobSteps; i++)
    {
      knobStops[i]=rangle;
      rangle+=steps;
    }
    knobEndValue=knobStartValue+knobSteps*knobSum;
    
  }
////////////////////////////////////////////////////////////////////////
  void drawLabels()
  {
    if (!knobLabelTextVisible) return;
    textSize(knobLabelTextSize);
    fill(knobColorLabelText);
    pushMatrix();
    translate(knobX,knobY);
    text(knobLabelText,0,knobRadius+knobLabelOffset);
    popMatrix();
    
  }
////////////////////////////////////////////////////////////////////////
  void drawValues()
  {
    changeKnobValue();
    
    textSize(knobValueTextSize);
    textAlign(CENTER);
    fill(knobColorValueText);
    pushMatrix();
    translate(knobX,knobY);
    //text("nnn",-knobRadius-10,knobRadius+10);
    text(str(round2nDecimals(knobValue,1)),0,knobRadius+knobValueOffset);
  
    popMatrix();

  }
////////////////////////////////////////////////////////////////////////
  void showLabelValue(int value, int offset)
  {
    if (!showKnobLabelValues) return;
    
    pushMatrix();
    textSize(knobValuelabelSize);
    textAlign(CENTER);
    fill(knobColorValueLabel);
    translate(0,0);
    rotate(PI/2);
    translate(0,-offset);
    text(str(value),0,0-valueLabelOffset);
    popMatrix();
  }
////////////////////////////////////////////////////////////////////////
  void changeKnobValue()
  {
    knobValue=knobStartValue+knobPosition*knobSum;
  }
////////////////////////////////////////////////////////////////////////
  void drawExternalMarks()
  {
   
    int knobMarks=9;
    float ksv=knobStartValue;
    
    pushMatrix();
    translate(knobX,knobY);
       
    for (int i = 0; i < knobSteps+1; i++)
    {

      pushMatrix();
      rotate(knobIndicatorOffset+knobStops[i]);

      if ((i==0) || (i==knobSteps)) 
      {
        stroke(externalColorMarks);
        if (knobPosition==i)
          stroke(colorMarksLight);
          
        strokeWeight(strokeOutterInitEndMarks); 
        line(knobRadius+knobOffsetMarks, 0, knobRadius+knobOffsetMarks+knobLengthMarkOuter, 0); 
        
        if (i==0)
           showLabelValue((int )knobStartValue,(knobRadius+knobOffsetMarks+knobLengthMarkOuter+knobValueLabelOffset));
        else   
           showLabelValue((int )knobEndValue,(knobRadius+knobOffsetMarks+knobLengthMarkOuter+knobValueLabelOffset));
      }
      else if (i<(knobSteps-5))
      {
        stroke(internalColorMarks);
        if (knobPosition==i)
          stroke(colorMarksLight);

        if ((i%knobSkips)==0)
        {
          if ((int)knobPosition==i)
            strokeWeight(strokeOutterMarks+knobPlusStroke);
          else
             strokeWeight(strokeOutterMarks);
     
          line(knobRadius+knobOffsetMarks, 0, knobRadius+knobOffsetMarks+knobLengthMarkInner, 0);
          showLabelValue((int )ksv+1,(knobRadius+knobOffsetMarks+knobLengthMarkInner+knobValueLabelOffset));
          
        }
        ksv+=knobSum;
        
      }
      popMatrix();
    }
    popMatrix(); 
  }
////////////////////////////////////////////////////////////////////////
  void drawIndicator()
  {

    pushMatrix();
    translate(knobX,knobY);
    
    //Initial Position
    rotate(knobIndicatorOffset+angle);

    stroke(colorOutterIndicator);
    strokeWeight(strokeOutterIndicator);
    line(outterOffsetFromCenter,0,knobOutterLength,0);

    stroke(colorInnerIndicator);
    if (mouseOver(false)) stroke(konbInnerIndicatorHigh);
    strokeWeight(strokeInnerIndicator);
    line(innerOffsetFromCenter,0,knobInnerLength,0);
    popMatrix(); 
  }
////////////////////////////////////////////////////////////////////////
  void drawCircle()
  {
    pushMatrix();
    translate(0,0);  
    stroke(colorExternalCircle);
    fill(internalColor);
    strokeWeight(strokeExternalCircle);
    ellipse(knobX,knobY,knobRadius*2,knobRadius*2);
    popMatrix();
  }
////////////////////////////////////////////////////////////////////////
  float update()
  {

    if (mouseOver(false) && keyPressed && !knobKeyPressed)
    {
      knobKeyPressed=true;
       ///have to be from one on ones
       if (keyCode==DOWN || keyCode==LEFT) for (int i=0; i<(int )(knobSteps/10); i++) decrementKnobPosition();
       if (keyCode==UP || keyCode==RIGHT) for (int i=0; i<(int )(knobSteps/10); i++) incrementKnobPosition();
    }
    if (!keyPressed) knobKeyPressed=false;
    
    drawCircle(); 
    drawIndicator();
    drawValues();
    drawLabels();
    drawExternalMarks();

    
    return knobValue;
  }
////////////////////////////////////////////////////////////////////////
  void deBounce(int n)
  {
    if (pressOnlyOnce) 
      return;
    else
      
    if (deb++ > n) 
    {
      deb=0;
      pressOnlyOnce=true;
    }
    
  }    
////////////////////////////////////////////////////////////////////////
  boolean mouseOver(boolean clicked)
  {
    if ((mouseX > (knobX-knobRadius-knobOutterLength) && mouseX < (knobX+knobRadius+knobOutterLength)) && (mouseY > (knobY-knobRadius-knobOutterLength) && mouseY < (knobY+knobRadius+knobOutterLength)))
    {
      if (mouseButton==LEFT && clicked)
         knobmouseOver=true;

      if (!clicked)
         knobmouseOver=true;

      if (mousePressed && mouseButton==LEFT && keyPressed && debug)
      {
        if (keyCode==CONTROL)
        {
          knobX=knobX+(int )((float )(mouseX-pmouseX)*0.4);
          knobY=knobY+(int )((float )(mouseY-pmouseY)*0.4);
          knobMoving=true;
          println("Moving...");
        }
        if (keyCode==SHIFT && pressOnlyOnce) 
        {
          printGeometry();
          pressOnlyOnce=false;
        }
        deBounce(5);
      }
      
      if (!mousePressed) knobMoving=false;

    }
    else
      knobmouseOver=false;

    return knobmouseOver;
  }
////////////////////////////////////////////////////////////////////////
  int delta()
  {
    float offx = mouseX - knobX;
    float offy = mouseY - knobY;
     
    float thisAngle = atan2(offy, offx);
    float prevAngle = atan2(pmouseY - knobY, pmouseX - knobX);
    
    float diff = thisAngle - prevAngle;
   
    return (thisAngle < prevAngle) ? -1 : 1;    
  }
////////////////////////////////////////////////////////////////////////
  void change()
  {
    if (!mouseOver(true) || knobMoving) return;
    
    float thisAngle = atan2(mouseY - knobY, mouseX - knobX);

    float steps = knobTotalAngle/knobSteps;
    
    if (thisAngle<=0 || (thisAngle>0 && thisAngle<PI/2)) thisAngle=thisAngle+TWO_PI;
    
    
      for (int i = 0; i < knobSteps; i++)
      {
        if (thisAngle >= knobStops[i] && thisAngle <  knobStops[i]+steps)
          if (thisAngle >= (knobStops[i]+(steps/2)))
          { 
            updateKnobPosition(i+1);
            i=knobSteps;
           }  
           else
          {
            updateKnobPosition(i);
            i=knobSteps;
          }
      }
   
    //println(str(angle)+","+str(knobActualAngle));
    
    //Contraint to min,max
    if (thisAngle > knobMaxEndAngle) thisAngle=knobMaxEndAngle; 
    if (thisAngle < knobMaxIniAngle) thisAngle=knobMaxIniAngle;
    
    knobActualAngle=thisAngle;
  
    return;    
  }
////////////////////////////////////////////////////////////////////////
  float getKnobValue()
  {
    return knobValue;
  }
////////////////////////////////////////////////////////////////////////
  int getKnobPosition()
  {
    return knobPosition;
  }
////////////////////////////////////////////////////////////////////////
  void setColor(color kcolor)
  {
    internalColor=kcolor;
    internalColorLight=internalColor+#230F0F;
  }
////////////////////////////////////////////////////////////////////////
  void updateKnobPosition(int position)
  {
    if (position>knobSteps) position=knobSteps;
    if (position<0) position=0;
    
    prevKnobPosition=knobPosition;
    knobPosition=position;
    
    if (knobSnap)
       angle=knobStops[position];
    else
       angle=knobActualAngle;      
      
  }
////////////////////////////////////////////////////////////////////////
  void setKnobPosition(int position)
  {
    if (position>knobSteps) position=knobSteps;
    if (position<0) position=0;
    
    prevKnobPosition=knobPosition;
    knobPosition=position;
    angle=knobStops[position];
      
  }
////////////////////////////////////////////////////////////////////////
  void setKnobValue(float value)
  {
    if (value<knobStartValue) value=knobStartValue;
    if (value>knobEndValue) value=knobEndValue;
   
    setKnobPosition((int )(knobSteps*(knobStartValue-value)/(knobStartValue-knobEndValue)));
      
  }
////////////////////////////////////////////////////////////////////////
  float getAnglefromPosition()
  {
     return knobStops[knobPosition];
  }
////////////////////////////////////////////////////////////////////////
  void changeKnobPositionWithWheel(int delta)
  {
    if (!mouseOver(false)) return;
    
    if (keyPressed && keyCode==SHIFT) delta=delta*(int )(knobSteps/10);
    if (keyPressed && keyCode==CONTROL) delta=delta*(int )(knobSteps/4);    
    
    prevKnobPosition=knobPosition;
    knobPosition+=delta;
    if (knobPosition<0) knobPosition=0;
    
    if (knobPosition>knobSteps) knobPosition=knobSteps;

    angle=knobStops[knobPosition];

  }
////////////////////////////////////////////////////////////////////////
  void incrementKnobPosition()
  {
    prevKnobPosition=knobPosition;
    knobPosition++;
    if (knobPosition>knobSteps) knobPosition=knobSteps;

    if (knobSnap)
       angle=knobStops[knobPosition];
    else   
       angle=knobStops[knobPosition];
  } 
////////////////////////////////////////////////////////////////////////
  void decrementKnobPosition()
  {
    prevKnobPosition=knobPosition;
    knobPosition--;
    if (knobPosition<0) knobPosition=0;

    if (knobSnap)
       angle=knobStops[knobPosition];
    else   
       angle=knobStops[knobPosition];
  } 
////////////////////////////////////////////////////////////////////////
  void setKnobRadius(int r)
  {
    knobRadius=r;
    update();
  }
////////////////////////////////////////////////////////////////////////
  void setWidthExternalCircle(int w)
  {
    strokeExternalCircle=w;
  }
////////////////////////////////////////////////////////////////////////
  void setOutterOffsetFromCenter(int o)
  {
    outterOffsetFromCenter=o;
  }
////////////////////////////////////////////////////////////////////////
  void setKnobOutterLength(int o)
  {
    knobOutterLength=o;
  }
////////////////////////////////////////////////////////////////////////
  void setInnerOffsetFromCenter(int o)
  {
    innerOffsetFromCenter=o;
  }
////////////////////////////////////////////////////////////////////////
  void setKnobInnerLength(int o)
  {
    knobInnerLength=o;
  }
////////////////////////////////////////////////////////////////////////
  void setKnobLengthMarkOuter(int o)
  {
    knobLengthMarkOuter=o;
  }
////////////////////////////////////////////////////////////////////////
  void setKnobLengthMarkInner(int o)
  {
    knobLengthMarkInner=o;
  }
////////////////////////////////////////////////////////////////////////
  void setMarkAngle(int o)
  {
    knobRightAngle=o;
    knobMaxIniAngle=(180-knobRightAngle)*PI/180;
    knobMaxEndAngle=knobRightAngle*PI/180+TWO_PI;
    knobTotalAngle=2*knobRightAngle*PI/180+PI;
    calculateStops();
    setKnobPosition(knobPosition);
  }
////////////////////////////////////////////////////////////////////////
  void setKnobLabelTextSize(int o)
  {
    knobLabelTextSize=o;
  }
////////////////////////////////////////////////////////////////////////
  void setKnobLabelOffset(int o)
  {
    knobLabelOffset=o;
  }
////////////////////////////////////////////////////////////////////////
  void setKnobValueTextSize(int o)
  {
    knobValueTextSize=o;
  }
////////////////////////////////////////////////////////////////////////
  void setKnobValueOffset(int o)
  {
    knobValueOffset=o;
  }
////////////////////////////////////////////////////////////////////////
  void setKnobIndicatorOffset(float o)
  {
    knobIndicatorOffset=o;
  }
////////////////////////////////////////////////////////////////////////
  void setKnobOffsetMarks(int o)
  {
    knobOffsetMarks=o;
  }
////////////////////////////////////////////////////////////////////////
  void setStrokeOutterMarks(int o)
  {
    strokeOutterMarks=o;
  }
////////////////////////////////////////////////////////////////////////
  void setStrokeOutterInitEndMarks(int o)
  {
    strokeOutterInitEndMarks=o;
  }
////////////////////////////////////////////////////////////////////////
  void setStrokeOutterIndicator(int o)
  {
    strokeOutterIndicator=o;
  }
////////////////////////////////////////////////////////////////////////
  void setStrokeInnerIndicator(int o)
  {
    strokeInnerIndicator=o;
  }
////////////////////////////////////////////////////////////////////////
  void setShowKnobLabelValues(boolean o)
  {
    showKnobLabelValues=o;
  }  
////////////////////////////////////////////////////////////////////////
  boolean getShowKnobLabelValues()
  {
    return showKnobLabelValues;
  }  
////////////////////////////////////////////////////////////////////////
  void setColorExternalCircle(color o)
  {
    colorExternalCircle=o;
  }
////////////////////////////////////////////////////////////////////////
  color getColorExternalCircle()
  {
    return colorExternalCircle;
  }
////////////////////////////////////////////////////////////////////////
  void setInternalColor(color o)
  {
    internalColor=o;
  }
////////////////////////////////////////////////////////////////////////
  color getInternalColor()
  {
    return internalColor;
  }
////////////////////////////////////////////////////////////////////////
  void setColorOutterIndicator(color o)
  {
    colorOutterIndicator=o;
  }
////////////////////////////////////////////////////////////////////////
  color getColorOutterIndicator()
  {
    return colorOutterIndicator;
  }
////////////////////////////////////////////////////////////////////////
  void setColorInnerIndicator(color o)
  {
    colorInnerIndicator=o;
  }
////////////////////////////////////////////////////////////////////////
  color getColorInnerIndicator()
  {
    return colorInnerIndicator;
  }
////////////////////////////////////////////////////////////////////////
  void setInternalColorMarks(color o)
  {
    internalColorMarks=o;
  }
////////////////////////////////////////////////////////////////////////
  color getInternalColorMarks()
  {
    return internalColorMarks;
  }
////////////////////////////////////////////////////////////////////////
  void setExternalColorMarks(color o)
  {
    externalColorMarks=o;
  }
////////////////////////////////////////////////////////////////////////
  color getExternalColorMarks()
  {
    return externalColorMarks;
  }
////////////////////////////////////////////////////////////////////////
  void setKnobColorValueLabel(color o)
  {
    knobColorValueLabel=o;
  }
////////////////////////////////////////////////////////////////////////
  color getKnobColorValueLabel()
  {
    return knobColorValueLabel;
  }
////////////////////////////////////////////////////////////////////////
  void setKnobColorLabelText(color o)
  {
    knobColorLabelText=o;
  }
////////////////////////////////////////////////////////////////////////
  color getKnobColorLabelText()
  {
    return knobColorLabelText;
  }
////////////////////////////////////////////////////////////////////////
  void setKnobColorValueText(color o)
  {
    knobColorValueText=o;
  }
////////////////////////////////////////////////////////////////////////
  color getKnobColorValueText()
  {
    return knobColorValueText;
  }
////////////////////////////////////////////////////////////////////////
  void setKnobValueLabelSize(color o)
  {
    knobValuelabelSize=o;
  }
////////////////////////////////////////////////////////////////////////
  color getKnobValueLabelSize()
  {
    return knobValuelabelSize;
  }
////////////////////////////////////////////////////////////////////////
  void setKnobValueLabelOffset(color o)
  {
    valueLabelOffset=o;
  }
////////////////////////////////////////////////////////////////////////
  color getKnobValueLabelOffset()
  {
    return valueLabelOffset;
  }
////////////////////////////////////////////////////////////////////////
  void showKnobLabelText()
  {
    knobLabelTextVisible=true;
  }
////////////////////////////////////////////////////////////////////////
  void hideKnobLabelText()
  {
    knobLabelTextVisible=false;
  }
////////////////////////////////////////////////////////////////////////
  int getColorRGB(color val, int pos)
  {
    int rvalue=0;
    //B 
    if(pos==3) rvalue=(int )blue(val);
    //G
    if(pos==2) rvalue=(int )green(val);
    //R
    if(pos==1) rvalue=(int )red(val);
    return rvalue;
    
  }
////////////////////////////////////////////////////////////////////////
  void setKnobNumberOfMarks(int o)
  {
    if (knobSteps>=o)
    {
      knobNumberOfMarks=o;
      knobSkips=knobSteps/knobNumberOfMarks;
    }
  }
////////////////////////////////////////////////////////////////////////
  void setColors(color ic, color ec, color ii, color oi, color icm, color ecm, color cvl, color clt, color cvt)
  {
    internalColor=ic;
    colorExternalCircle=ec;
    colorInnerIndicator=ii;
    colorOutterIndicator=oi;
    internalColorMarks=icm;
    externalColorMarks=ecm;
    knobColorValueLabel=cvl;
    knobColorLabelText=clt;
    knobColorValueText=cvt;
  }
////////////////////////////////////////////////////////////////////////
  void getKnobParameters()
  {

    println("ADknob knob;");
    println("void setup()");
    println("{");
    println("  size(300,300);");
    println("  smooth();");
    print("  knob = new ADknob(");
    print("\"KNOB\","+str(150)+","+str(150)+","+str(knobRadius)+","+str(knobSteps)+","+str(knobStartValue)+","+str(knobSum)+",");
    print(str(strokeExternalCircle)+","+str(outterOffsetFromCenter)+","+str(knobOutterLength)+",");
    print(str(innerOffsetFromCenter)+","+str(knobInnerLength)+","+str(knobLengthMarkOuter)+","+str(knobLengthMarkInner)+",");
    print(str(knobRightAngle)+","+str(knobLabelTextSize)+","+str(knobLabelOffset)+","+str(knobValueTextSize)+","+str(knobValueOffset)+",");
    print(str(knobOffsetMarks)+","+str(strokeOutterMarks)+","+str(strokeOutterInitEndMarks)+","+str(strokeOutterIndicator)+","+str(strokeInnerIndicator)+","+str(knobNumberOfMarks)+",");
    print(str(showKnobLabelValues)+","+str(knobValuelabelSize)+","+str(valueLabelOffset));
    println(");");

    print("  knob.setColors(");
    print(str(internalColor)+","+str(colorExternalCircle)+","+str(colorInnerIndicator)+","+str(colorOutterIndicator)+",");
    print(str(internalColorMarks)+","+str(externalColorMarks)+","+str(knobColorValueLabel)+","+str(knobColorLabelText)+","+str(knobColorValueText));   
    println(");");
    println("  activateMouseWheel();");
    println("}");
    
    println("\nvoid draw()");
    println("{");    
    println("  background(#E0E0E0);");
    println("  knob.update();");
    println("}");
    
    println("\nvoid activateMouseWheel()");
    println("{");
    println(" addMouseWheelListener(new java.awt.event.MouseWheelListener()"); 
    println(" {"); 
    println("   public void mouseWheelMoved(java.awt.event.MouseWheelEvent evt)"); 
    println("   { ");
    println("     mouseWheel(evt.getWheelRotation());");
    println("   }");
    println(" });");

    println("}");
        
    println("\nvoid mouseDragged()");
    println("{");
    println("  knob.change();");
    println("}");    
    
    println("\nvoid mouseWheel(int delta)");
    println("{");
    println("  knob.changeKnobPositionWithWheel(delta);");
    println("}");     
  }
////////////////////////////////////////////////////////////////////////
  void printGeometry()
  {
    print("  knob = new ADknob(");
    println("\""+knobLabelText+"\","+str(knobX)+","+str(knobY)+","+str(knobRadius)+","+str(knobSteps)+","+str(knobStartValue)+","+str(knobSum)+");");
  }
////////////////////////////////////////////////////////////////////////
  void setDebugOn()
  {
    debug=true;
  }
////////////////////////////////////////////////////////////////////////
  void setDebugOff()
  {
    debug=false;
  }  
} //end Class Knob

