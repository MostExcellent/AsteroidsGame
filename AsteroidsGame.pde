SpaceShip spaceship;
Starfield starfield;
ArrayList<Asteroid> asteroids;
public void setup()
{
	size(500, 500);
	spaceship = new SpaceShip();
	starfield = new Starfield();
	asteroids = new ArrayList<Asteroid>();
	for (int i = 0; i <= 10; i++)
	{
		asteroids.add(new Asteroid());
	}
}
public void draw()
{
	background(0);
	spaceship.move();
	spaceship.show();
	starfield.show();
	for (int i = 0; i < asteroids.size(); i++) {
		asteroids.get(i).move();
		asteroids.get(i).show();
	}
}
public void keyPressed()
{
	if(keyCode == RIGHT)
	{
		spaceship.rotateRight();
	}
	if(keyCode == LEFT)
	{
		spaceship.rotateLeft();
	}
}
class SpaceShip extends Floater
{
	public SpaceShip()
	{
		corners = 4;
		xCorners = new int[corners];
		yCorners = new int[corners];
		xCorners[0] = -5; yCorners[0] = 5;
		xCorners[1] = 0; yCorners[1] = 0;
		xCorners[2] = -5; yCorners[2] = -5;
		xCorners[3] = 15; yCorners[3] = 0;
		myColor =  color(255);
		myCenterX = 250;
		myCenterY = 250;
		myDirectionX = 0;
		myDirectionY = 0;
		myPointDirection = 0;
	}
	public void setX(int x){myCenterX = x;}
	public int getX(){return (int)myCenterX;}
	public void setY(int y){myCenterY = y;}
	public int getY(){return (int)myCenterY;}
	public void setDirectionX(double x){myDirectionX = x;}
	public double getDirectionX(){return myDirectionX;}
	public void setDirectionY(double y){myDirectionY = y;}
	public double getDirectionY(){return myDirectionY;}
	public void setPointDirection(int degrees){myPointDirection = degrees;}
	public double getPointDirection(){return myPointDirection;}
	public void rotateRight(){myPointDirection+=4;}
	public void rotateLeft(){myPointDirection-=4;}
}
class Asteroid extends Floater
{
	private int rotationSpeed;
	private int mySize;
	public Asteroid()
	{
		rotationSpeed = (int)(Math.random()*8-4);
		corners = 4;
		xCorners = new int[corners];
		yCorners = new int[corners];
		xCorners[0] = -10; yCorners[0] = 10;
		xCorners[1] = 10; yCorners[1] = 10;
		xCorners[2] = 10; yCorners[2] = -10;
		xCorners[3] = -10; yCorners[3] = -10;
		myColor =  color(255);
		myCenterX = Math.random()*250;
		myCenterY = Math.random()*250;
		myDirectionX = Math.random()*6-3;
		myDirectionY = Math.random()*6-3;
		myPointDirection = Math.random()*359;
	}
	public void setX(int x){myCenterX = x;}
	public int getX(){return (int)myCenterX;}
	public void setY(int y){myCenterY = y;}
	public int getY(){return (int)myCenterY;}
	public void setDirectionX(double x){myDirectionX = x;}
	public double getDirectionX(){return myDirectionX;}
	public void setDirectionY(double y){myDirectionY = y;}
	public double getDirectionY(){return myDirectionY;}
	public void setPointDirection(int degrees){myPointDirection = degrees;}
	public double getPointDirection(){return myPointDirection;}
	public void move() //move the floater in the current direction of travel
	{
		myCenterX += myDirectionX;
		myCenterY += myDirectionY;

		//wrap around screen    
		if (myCenterX > width) {
			myCenterX = 0;
		} else if (myCenterX < 0) {
			myCenterX = width;
		}
		if (myCenterY > height) {
			myCenterY = 0;
		} else if (myCenterY < 0) {
			myCenterY = height;
		}
		rotate(rotationSpeed);
	}
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{
	protected int corners; //the number of corners, a triangular floater has 3   
	protected int[] xCorners;
	protected int[] yCorners;
	protected int myColor;
	protected double myCenterX, myCenterY; //holds center coordinates   
	protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
	protected double myPointDirection; //holds current direction the ship is pointing in degrees    
	abstract public void setX(int x);
	abstract public int getX();
	abstract public void setY(int y);
	abstract public int getY();
	abstract public void setDirectionX(double x);
	abstract public double getDirectionX();
	abstract public void setDirectionY(double y);
	abstract public double getDirectionY();
	abstract public void setPointDirection(int degrees);
	abstract public double getPointDirection();

	//Accelerates the floater in the direction it is pointing (myPointDirection)   
	public void accelerate(double dAmount)
	{
		//convert the current direction the floater is pointing to radians    
		double dRadians = myPointDirection * (Math.PI / 180);
		//change coordinates of direction of travel    
		myDirectionX += ((dAmount) * Math.cos(dRadians));
		myDirectionY += ((dAmount) * Math.sin(dRadians));
	}
	public void rotate(int nDegreesOfRotation) {myPointDirection += nDegreesOfRotation;}
	public void move() //move the floater in the current direction of travel
	{
		myCenterX += myDirectionX;
		myCenterY += myDirectionY;

		//wrap around screen    
		if (myCenterX > width) {
			myCenterX = 0;
		} else if (myCenterX < 0) {
			myCenterX = width;
		}
		if (myCenterY > height) {
			myCenterY = 0;
		} else if (myCenterY < 0) {
			myCenterY = height;
		}
	}
	public void show() //Draws the floater at the current position  
	{
		fill(myColor);
		stroke(myColor);
		//convert degrees to radians for sin and cos         
		double dRadians = myPointDirection * (Math.PI / 180);
		int xRotatedTranslated, yRotatedTranslated;
		beginShape();
		for (int nI = 0; nI < corners; nI++) {
			//rotate and translate the coordinates of the floater using current direction 
			xRotatedTranslated = (int)((xCorners[nI] * Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians)) + myCenterX);
			yRotatedTranslated = (int)((xCorners[nI] * Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians)) + myCenterY);
			vertex(xRotatedTranslated, yRotatedTranslated);
		}
		endShape(CLOSE);
	}
}
public class Starfield
{
	private int[] x;
	private int[] y;
	public Starfield ()
	{
		x = new int[500];
		y = new int[500];
		for(int i = 0; i < 500; i++)
		{
			x[i] = (int)(Math.random()*500);
			y[i] = (int)(Math.random()*500);
		}
	}
	public void show()
	{
		for (int i = 0; i < x.length; i++) {
			point(x[i], y[i]);
		}
	}

}