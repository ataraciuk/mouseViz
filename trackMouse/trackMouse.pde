import java.awt.*;


private MouseInfo mInfo;
private PointerInfo pInfo;
private Point point = new Point();
private int buttons = 0;
private double pointX = 0;
private double pointY = 0;
private double lastX = -1;
private double lastY = -1;

private PrintWriter output, output2;

private Robot robot;

public void setup()
{
  try
  { 
    robot = new Robot();
  }

  catch(Exception e) {
  }

  output = createWriter("positions-"+year()+"-"+month()+"-"+day()+".txt");
  output2 = createWriter("positions-"+year()+"-"+month()+"-"+day()+"-still.txt");
  hasMouse();
  pointerLocation();
}//ends constr.

private void hasMouse()
{
  buttons = mInfo.getNumberOfButtons();
  if (buttons == -1)
  {
    System.out.println("No mouse detected. Program terminated.");
    System.exit(0);
  }
}//ends hasMouse()

private void pointerLocation()
{
  try
  {
    pInfo = mInfo.getPointerInfo();
    point = pInfo.getLocation();

    pointX = point.getX();
    pointY = point.getY();

    System.out.println("pointer is at: (" + (int)pointX + ", " + (int)pointY + ")");
    if(pointX != lastX || pointY != lastY) {
      output.println((int)pointX + "," + (int)pointY);
    } //only storing when mouse moved
    output2.println((int)pointX + "," + (int)pointY);
    output.flush();
    output2.flush();
    lastX = pointX;
    lastY = pointY;

    delay();
  }

  catch(HeadlessException he)
  {
    System.out.println((he.toString()) + ". Program terminated.");
    System.exit(1);
  }

  catch(SecurityException se)
  {
    System.out.println((se.toString()) + ". Program terminated.");
    System.exit(1);
  }
  catch (Exception e) {
    delay();
  }
}//ends pointerLocation()

public String getPointerLocation()
{ 
  return (point.toString());
}//ends getPointerLocation()

public void delay()
{
  try
  {
    robot.delay(100);
    pointerLocation();
  }

  catch(Exception e) {
  }
}//ends delay()

