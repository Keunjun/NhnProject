/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/58303*@* */
/* !do not delete the line above, required for linking your tweak if you re-upload */
ADLinechart lineGraph;
timer t;
int i=0, delta=1;
int dataSets=1;

ADbutton title,yLabel,xLabel,legend,xValues, yValues, addDS, shadow, export;

ADknob titleSize, titleXoffset, xLabelSize, xLabelOffset, yLabelSize, yLabelOffset, legendSize, legendXOffset, legendYOffset, xGridSize, yGridSize, xGridOffset, yGridOffset;
ADknob graphXSize, graphYSize, yGridMarks, xGridMarks, samples, xLabelFrec, pointRadius, lineWidth, area;

boolean gTitle=false, gYlabel=false, gXlabel=false, gLegend=false, gXvalues=true, gYvalues=true, gShadow=false;

ADknob bRed, bGreen, bBlue;
int r,g,b;

int nColors=7;
ADbutton[] enableColorButton = new ADbutton[nColors];
String[] enableButtonColorLabel = {"TI","XL","YL","XV","YV","BA","GR"};
boolean[] enableColor = {false,false,false,false,false,false,false};
String[] enableButtonHelp = {
  "Title Color",
  "X Label Color",
  "Y Label Color",
  "X Values Color",
  "Y Values Color",
  "BackGround Color",
  "Grid Color",
};
boolean firstRead=true;

void setup()
{
  size(1200,750);
  smooth();
  t = new timer(100);
  lineGraph = new ADLinechart(30,30,1140,300,"Data Set 1");
  lineGraph.setDebugOn();
  
  title = new ADbutton(20, 370, 120, 30, 7, "Hide Title");
  xLabel = new ADbutton(150, 370, 120, 30, 7, "Hide xLabel");
  yLabel = new ADbutton(280, 370, 120, 30, 7, "Hide yLabel");

  legend = new ADbutton(410, 370, 120, 30, 7, "Hide legend");
  xValues = new ADbutton(540, 370, 120, 30, 7, "Hide xValues");
  yValues = new ADbutton(670, 370, 120, 30, 7, "Hide yValues");
  shadow = new ADbutton(800, 370, 120, 30, 7, "Hide Shadow");
  
  addDS = new ADbutton(930, 370, 120, 30, 7, "add DataSet");
  export = new ADbutton(1060, 370, 120, 30, 7, "Export");
  
  enableColorButton[0] = new ADbutton(1073, 415, 25, 20, 7, enableButtonColorLabel[0]);
  enableColorButton[1] = new ADbutton(1108, 415, 25, 20, 7, enableButtonColorLabel[1]);
  enableColorButton[2] = new ADbutton(1143, 415, 25, 20, 7, enableButtonColorLabel[2]);
  enableColorButton[3] = new ADbutton(1073, 450, 25, 20, 7, enableButtonColorLabel[3]);
  enableColorButton[4] = new ADbutton(1108, 450, 25, 20, 7, enableButtonColorLabel[4]);
  enableColorButton[5] = new ADbutton(1143, 450, 25, 20, 7, enableButtonColorLabel[5]);
  enableColorButton[6] = new ADbutton(1073, 485, 25, 20, 7, enableButtonColorLabel[6]);

  for (int i=0; i<nColors; i++)
    enableColorButton[i].setHelpOn(enableButtonHelp[i]);
    
  bRed =new ADknob("RED",1120,550,20,255,0.0,1.0,5.0,0.0,12.0,5.0,20.0,9,1,15.0,10,12,9,-6,11,2,3,6,3,11,false,11,0);
  bRed.setColors(-1245184,0,-1,0,0,0,0,-11574371,-1);
  bRed.setKnobPosition(0);
  bGreen = new ADknob("GREEN",1120,620,20,255,0.0,1.0,5.0,0.0,12.0,5.0,20.0,9,1,15.0,10,12,9,-6,11,2,3,6,3,11,false,11,0);
  bGreen.setColors(-16732160,0,-1,0,0,0,0,-11574371,-1);
  bGreen.setKnobPosition(0);
  bBlue = new ADknob("BLUE",1120,690,20,255,0.0,1.0,5.0,0.0,12.0,5.0,20.0,9,1,15.0,10,12,9,-6,11,2,3,6,3,11,false,11,0);
  bBlue.setColors(-16777015,0,-1,0,0,0,0,-11574371,-1);
  bBlue.setKnobPosition(0);    
  
  titleSize = new ADknob("Title Size",80,470,25,48,10,1.0,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  titleSize.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  titleSize.setKnobValue(24);
  titleXoffset = new ADknob("Title Offset",80,575,25,200,-40,1.0,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  titleXoffset.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  titleXoffset.setKnobValue(40);

  xLabelSize = new ADknob("xLabel Size",210,470,25,32,10,1.0,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  xLabelSize.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  xLabelSize.setKnobValue(16);
  xLabelOffset = new ADknob("xLabel Offset",210,575,25,200,-40,1.0,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  xLabelOffset.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  xLabelOffset.setKnobValue(10);
  xLabelFrec = new ADknob("xLabel Fncy",210,680,25,150,1,1.0,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  xLabelFrec.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  xLabelFrec.setKnobValue(20);

  yLabelSize = new ADknob("yLabel Size",340,470,25,32,10,1.0,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  yLabelSize.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  yLabelSize.setKnobValue(16);
  yLabelOffset = new ADknob("yLabel Offset",340,575,25,200,-40,1.0,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  yLabelOffset.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  yLabelOffset.setKnobValue(25);

  legendSize = new ADknob("legend Size",470,470,25,32,10,1.0,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  legendSize.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  legendSize.setKnobValue(10);
  legendXOffset = new ADknob("legend X Offset",470,575,25,200,-40,1.0,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  legendXOffset.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  legendXOffset.setKnobValue(10);
  legendYOffset = new ADknob("legend Y Offset",470,680,25,200,-40,1.0,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  legendYOffset.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  legendYOffset.setKnobValue(10);

  xGridSize = new ADknob("x Grid Size",600,470,25,250,5,1.0,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  xGridSize.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  xGridSize.setKnobValue(80);
  yGridSize = new ADknob("y Grid Size",600,575,25,120,5,1.0,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  yGridSize.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  yGridSize.setKnobValue(70);
  yGridMarks = new ADknob("y Grid Marks",600,680,25,30,1,1.0,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  yGridMarks.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  yGridMarks.setKnobValue(4);

  xGridOffset = new ADknob("x Grid Offset",730,470,25,240,-120,1.0,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  xGridOffset.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  xGridOffset.setKnobValue(10);
  yGridOffset = new ADknob("y Grid Offset",730,575,25,240,-120,1.0,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  yGridOffset.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  yGridOffset.setKnobValue(0);
  xGridMarks = new ADknob("x Grid Marks",730,680,25,100,1,1.0,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  xGridMarks.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  xGridMarks.setKnobValue(10);

  graphXSize = new ADknob("x Dim",860,470,25,950,180,1.0,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  graphXSize.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  graphXSize.setKnobValue(1130);
  graphYSize = new ADknob("y Dim",860,575,25,200,100,1.0,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  graphYSize.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  graphYSize.setKnobValue(300);
  samples = new ADknob("samples",860,680,25,1000,5,1.0,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  samples.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  samples.setKnobValue(100);

  pointRadius = new ADknob("point radius",990,470,25,20,0,1,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  pointRadius.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  pointRadius.setKnobValue(5);
  lineWidth = new ADknob("line Width",990,575,25,20,0,1,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  lineWidth.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  lineWidth.setKnobValue(2);
  area = new ADknob("Transparency",990,680,25,200,0,1,6.0,10.0,14.0,10.0,14.0,10,5,26.0,15,16,12,-72,10,5,9,14,6,5,false,11,0);
  area.setColors(-26368,-16514816,-1,0,-16777216,-32512,0,-11574371,-16777216);
  area.setKnobValue(50);

 
  activateMouseWheel();  
  
  showTitle();
  showYlabel();
  showXlabel();
  showLegend();
  showShadow();
  
}
//////////////////////////////////////////////////////////////////////
void draw()
{
  background(#C4A465);

  drawLines();
  drawGraph();  
  updateButtons();
  updateKnobs();
}
//////////////////////////////////////////////////////////////////////
void drawLines()
{
  stroke(0);
  strokeWeight(1);
  line(10,360,1190,360);

  noFill();
  for (int i=0; i<9; i++)
    rect(20+(i*130),405,120,330);
}
//////////////////////////////////////////////////////////////////////
void drawGraph()
{
  if (t.over())
  {
    //pushValue(y,x,lineIndex)
    lineGraph.pushValue(-(sin((i-10)*PI/56))*(1+cos(i*PI/56)),i,0);
    i+=3;
    t.reset();
  }
  lineGraph.update();
}
//////////////////////////////////////////////////////////////////////
void updateButtons()
{
  if (title.update()) showTitle(); 
  if (yLabel.update()) showYlabel();
  if (xLabel.update()) showXlabel();
  if (legend.update()) showLegend();
  if (yValues.update()) showYvalues();
  if (xValues.update()) showXvalues();
  if (addDS.update()) addDataSet();
  if (shadow.update()) showShadow();
  if (export.update()) lineGraph.exportParameters();
  
  for (int i=0; i<nColors; i++)
  {
    if (enableColorButton[i].update()) checkEnableColor(i);
  }

  for (int i=0; i<nColors; i++)
  {
    if (enableColor[i] && firstRead)
    {
      if (i==0)
      {
        bRed.setKnobPosition((int )red(lineGraph.getTitleColor()));
        bGreen.setKnobPosition((int )green(lineGraph.getTitleColor()));
        bBlue.setKnobPosition((int )blue(lineGraph.getTitleColor()));
      }
      if (i==1)
      {
        bRed.setKnobPosition((int )red(lineGraph.getXlabelColor()));
        bGreen.setKnobPosition((int )green(lineGraph.getXlabelColor()));
        bBlue.setKnobPosition((int )blue(lineGraph.getXlabelColor()));
      }
      if (i==2)
      {
        bRed.setKnobPosition((int )red(lineGraph.getYlabelColor()));
        bGreen.setKnobPosition((int )green(lineGraph.getYlabelColor()));
        bBlue.setKnobPosition((int )blue(lineGraph.getYlabelColor()));
      }
      if (i==3)
      {
        bRed.setKnobPosition((int )red(lineGraph.getXNumbersColor()));
        bGreen.setKnobPosition((int )green(lineGraph.getXNumbersColor()));
        bBlue.setKnobPosition((int )blue(lineGraph.getXNumbersColor()));
      }
      if (i==4)
      {
        bRed.setKnobPosition((int )red(lineGraph.getYNumbersColor()));
        bGreen.setKnobPosition((int )green(lineGraph.getYNumbersColor()));
        bBlue.setKnobPosition((int )blue(lineGraph.getYNumbersColor()));
      }
      if (i==5)
      {
        bRed.setKnobPosition((int )red(lineGraph.getBackgroudColor()));
        bGreen.setKnobPosition((int )green(lineGraph.getBackgroudColor()));
        bBlue.setKnobPosition((int )blue(lineGraph.getBackgroudColor()));
      }
      if (i==6)
      {
        bRed.setKnobPosition((int )red(lineGraph.getGridColor()));
        bGreen.setKnobPosition((int )green(lineGraph.getGridColor()));
        bBlue.setKnobPosition((int )blue(lineGraph.getGridColor()));
      }
 
      firstRead=false;
    }
  }


  r=(int )bRed.update();
  g=(int )bGreen.update();
  b=(int )bBlue.update();
  
  for (int i=0; i<nColors; i++)
  {
    if (enableColor[i] && !firstRead)
    {
      if (i==0) lineGraph.setTitleColor(color(r,g,b));
      if (i==1) lineGraph.setXlabelColor(color(r,g,b));
      if (i==2) lineGraph.setYlabelColor(color(r,g,b));
      if (i==3) lineGraph.setXNumbersColor(color(r,g,b));
      if (i==4) lineGraph.setYNumbersColor(color(r,g,b));
      if (i==5) lineGraph.setBackgroudColor(color(r,g,b));
      if (i==6) lineGraph.setGridColor(color(r,g,b));
    }
  }  
   
}
//////////////////////////////////////////////////////////////////////
void checkEnableColor(int nc)
{

  for (int i=0; i<nColors; i++)
  {
    enableColor[i]=false;
    enableColorButton[i].setColor(#B7B7B7);
  }
  enableColor[nc]=true;
  enableColorButton[nc].setColor(#E88746);
  
  firstRead=true;
  
}

//////////////////////////////////////////////////////////////////////
void addDataSet()
{
  if (dataSets>=10) 
  {
    println("Sorry!, only 10 DataSets are allowed!");
  }
  else
  {
    lineGraph.addDataSet("Data Set "+str(++dataSets));
    println("Adding dataset !"+str(dataSets));
  }
  
}
//////////////////////////////////////////////////////////////////////
void showShadow()
{
  if (gShadow) 
  {
    lineGraph.hideShadow();
    shadow.setLabel("Show Shadow");
  }
  else
  {
    lineGraph.showShadow();
    shadow.setLabel("Hide Shadow");
  }
  
  gShadow=!gShadow;
  
}
//////////////////////////////////////////////////////////////////////
void showTitle()
{
  if (gTitle) 
  {
    lineGraph.hideTitle();
    title.setLabel("Show Title");
  }
  else
  {
    lineGraph.showTitle();
    title.setLabel("Hide Title");
  }
  
  gTitle=!gTitle;
  
}
//////////////////////////////////////////////////////////////////////
void showYlabel()
{
  if (gYlabel) 
  {
    lineGraph.hideYlabel();
    yLabel.setLabel("Show yLabel");
  }
  else
  {
    lineGraph.showYlabel();
    yLabel.setLabel("Hide yLabel");
  }
  
  gYlabel=!gYlabel;
  
}
//////////////////////////////////////////////////////////////////////
void showXlabel()
{
  if (gXlabel) 
  {
    lineGraph.hideXlabel();
    xLabel.setLabel("Show xLabel");
  }
  else
  {
    lineGraph.showXlabel();
    xLabel.setLabel("Hide xLabel");
  }
  
  gXlabel=!gXlabel;
  
}
//////////////////////////////////////////////////////////////////////
void showLegend()
{
  if (gLegend) 
  {
    lineGraph.hideLegend();
    legend.setLabel("Show legend");
  }
  else
  {
    lineGraph.showLegend();
    legend.setLabel("Hide legend");
  }
  
  gLegend=!gLegend;
  
}

//////////////////////////////////////////////////////////////////////
void showYvalues()
{
  if (gYvalues) 
  {
    lineGraph.hideYvalues();
    yValues.setLabel("Show yValues");
  }
  else
  {
    lineGraph.showYvalues();
    yValues.setLabel("Hide yValues");
  }
  
  gYvalues=!gYvalues;
  
}
//////////////////////////////////////////////////////////////////////
void showXvalues()
{
  if (gXvalues) 
  {
    lineGraph.hideXvalues();
    xValues.setLabel("Show xValues");
  }
  else
  {
    lineGraph.showXvalues();
    xValues.setLabel("Hide xValues");
  }
  
  gXvalues=!gXvalues;
  
}







//////////////////////////////////////////////////////////////////////
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
//////////////////////////////////////////////////////////////////////
void mouseDragged()
{
  titleSize.change();
  titleXoffset.change();
  xLabelSize.change();
  yLabelSize.change();
  xLabelOffset.change();
  yLabelOffset.change();
  xGridSize.change();
  yGridSize.change();
  xGridOffset.change();
  yGridOffset.change();
  graphXSize.change();
  graphYSize.change();
  yGridMarks.change();
  xGridMarks.change();
  samples.change();
  xLabelFrec.change();
  pointRadius.change();
  lineWidth.change();
  area.change();
  bRed.change();
  bGreen.change();
  bBlue.change();
  legendSize.change();
  legendXOffset.change();
  legendYOffset.change();


}
//////////////////////////////////////////////////////////////////////
void mouseWheel(int delta)
{
  titleSize.changeKnobPositionWithWheel(delta);
  titleXoffset.changeKnobPositionWithWheel(delta);
  xLabelSize.changeKnobPositionWithWheel(delta);
  xLabelOffset.changeKnobPositionWithWheel(delta);
  yLabelSize.changeKnobPositionWithWheel(delta);
  yLabelOffset.changeKnobPositionWithWheel(delta);
  legendSize.changeKnobPositionWithWheel(delta);
  legendXOffset.changeKnobPositionWithWheel(delta);
  legendYOffset.changeKnobPositionWithWheel(delta);
  xGridSize.changeKnobPositionWithWheel(delta);
  yGridSize.changeKnobPositionWithWheel(delta);
  xGridOffset.changeKnobPositionWithWheel(delta);
  yGridOffset.changeKnobPositionWithWheel(delta);
  graphXSize.changeKnobPositionWithWheel(delta);
  graphYSize.changeKnobPositionWithWheel(delta);

  yGridMarks.changeKnobPositionWithWheel(delta);
  xGridMarks.changeKnobPositionWithWheel(delta);

  samples.changeKnobPositionWithWheel(delta);
  xLabelFrec.changeKnobPositionWithWheel(delta);

  pointRadius.changeKnobPositionWithWheel(delta);
  lineWidth.changeKnobPositionWithWheel(delta);
  area.changeKnobPositionWithWheel(delta);
  
  bRed.changeKnobPositionWithWheel(delta);
  bGreen.changeKnobPositionWithWheel(delta);
  bBlue.changeKnobPositionWithWheel(delta);


}
//////////////////////////////////////////////////////////////////////
void updateKnobs()
{
  lineGraph.setTitleSize((int )titleSize.update());
  lineGraph.setTitleOffset((int )titleXoffset.update());
  
  lineGraph.setXLabelSize((int )xLabelSize.update());
  lineGraph.setXLabelOffset((int )xLabelOffset.update());
  
  lineGraph.setYLabelSize((int )yLabelSize.update());
  lineGraph.setYLabelOffset((int )yLabelOffset.update());
  lineGraph.setLegendSize((int )legendSize.update());
  lineGraph.setlegendXOffset((int )legendXOffset.update());
  lineGraph.setlegendYOffset((int )legendYOffset.update());
  
  lineGraph.setXGridSize((int )xGridSize.update());
  lineGraph.setYGridSize((int )yGridSize.update());
  
  lineGraph.setXGridOffset((int )xGridOffset.update());
  lineGraph.setYGridOffset((int )yGridOffset.update());
  
  lineGraph.setGraphWidth((int )graphXSize.update());
  lineGraph.setGraphHeigth((int )graphYSize.update());
  
  lineGraph.setYgridMarks((int )yGridMarks.update());
  lineGraph.setXgridMarks((int )xGridMarks.update());

  lineGraph.setSamples((int )samples.update());
  
  lineGraph.setXlabelFrecuency((int )xLabelFrec.update());
  
  for (int i=0; i<lineGraph.getDataSets(); i++)
  {
    lineGraph.setPointRadius(pointRadius.update(),i);
    lineGraph.setLineWidth(lineWidth.update(),i);
    lineGraph.setUnderCurveTransparecy((int )area.update(),i);
  }
  
  bRed.update();
  bGreen.update();
  bBlue.update();
  
}


