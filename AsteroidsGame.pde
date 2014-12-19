SpaceShip spaceship;
Starfield starfield;
boolean keys[];
ArrayList<Asteroid> asteroids;
ArrayList<Bullet> bullets;
public void setup()
{
	size(700, 700);
	keys = new boolean[4];
	keys[0] = false;
  keys[1] = false;
  keys[2] = false;
  keys[3] = false;
	spaceship = new SpaceShip();
	starfield = new Starfield();
	asteroids = new ArrayList<Asteroid>();
	bullets = new ArrayList<Bullet>();
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
		for (int n = 0; n < bullets.size(); n++)
		{
			if(asteroids.get(i).getX() < bullets.get(n).getX()+12 && asteroids.get(i).getX() > bullets.get(n).getX()-12 && asteroids.get(i).getY() < bullets.get(n).getY()+12 && asteroids.get(i).getY() > bullets.get(n).getY()-12)
			{
				asteroids.remove(i);
				bullets.remove(n);
				asteroids.add(new Asteroid());
			}
		}
	}
	for (int i = 0; i < bullets.size(); i++)
	{
		bullets.get(i).move();
		bullets.get(i).show();
		if((bullets.get(i).getX() < 0 || bullets.get(i).getX() > 700) || (bullets.get(i).getY() < 0 || bullets.get(i).getY() > 700))
			{
				bullets.remove(i);
			}
	}
	if(keys[0]){spaceship.rotateRight();}
	if(keys[1]){spaceship.rotateLeft();}
	if(keys[2]){spaceship.accelerate(0.1);}
}
public void keyPressed()
{
	if(keyCode == RIGHT){keys[0] = true;}
	if(keyCode == LEFT){keys[1] = true;}
	if(keyCode == UP){keys[2] = true;}
}
public void keyReleased()
{
	if(keyCode == RIGHT){keys[0] = false;}
	if(keyCode == LEFT){keys[1] = false;}
	if(keyCode == UP){keys[2] = false;}
	if(keyCode == 32){spaceship.hyperspace();}
	if(keyCode == 65){spaceship.shoot();}
}
class SpaceShip extends Floater
{
	public SpaceShip()
	{
		corners = 4;
		xCorners = new int[corners];
		yCorners = new int[corners];
		xCorners[0] = -10; yCorners[0] = 10;
		xCorners[1] = -5; yCorners[1] = 0;
		xCorners[2] = -10; yCorners[2] = -10;
		xCorners[3] = 15; yCorners[3] = 0;
		myColor =  color(255);
		myCenterX = 350;
		myCenterY = 350;
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
	public void rotateRight(){myPointDirection+=6;}
	public void rotateLeft(){myPointDirection-=6;}
	public void hyperspace()
	{
		myCenterY = Math.random()*350;
		myCenterX = Math.random()*350;
	}
	public void shoot(){bullets.add(new Bullet());}
	public double getRads(){return myPointDirection * (Math.PI / 180);}
}
class Asteroid extends Floater
{
	private int rotationSpeed;
	private int mySize;
	public Asteroid()
	{
		mySize = 4;
		rotationSpeed = (int)(Math.random()*8-4);
		corners = 4;
		xCorners = new int[corners];
		yCorners = new int[corners];
		xCorners[0] = -(int)(int)pow(2, mySize); yCorners[0] = (int)pow(2, mySize);
		xCorners[1] = (int)pow(2, mySize); yCorners[1] = (int)pow(2, mySize);
		xCorners[2] = (int)pow(2, mySize); yCorners[2] = -(int)pow(2, mySize);
		xCorners[3] = -(int)pow(2, mySize); yCorners[3] = -(int)pow(2, mySize);
		myColor =  color(255);
		myCenterX = Math.random()*700;
		myCenterY = Math.random()*700;
		myDirectionX = Math.random()*4-2;
		myDirectionY = Math.random()*4-2;
		myPointDirection = Math.random()*359;
	}
	public Asteroid(int s)
	{
		mySize = s;
		rotationSpeed = (int)(Math.random()*8-4);
		corners = 4;
		xCorners = new int[corners];
		yCorners = new int[corners];
		xCorners[0] = -(int)pow(2, mySize); yCorners[0] = (int)pow(2, mySize);
		xCorners[1] = (int)pow(2, mySize); yCorners[1] = (int)pow(2, mySize);
		xCorners[2] = (int)pow(2, mySize); yCorners[2] = -(int)pow(2, mySize);
		xCorners[3] = -(int)pow(2, mySize); yCorners[3] = -(int)pow(2, mySize);
		myColor =  color(255);
		myCenterX = Math.random()*700;
		myCenterY = Math.random()*700;
		myDirectionX = Math.random()*4-2;
		myDirectionY = Math.random()*4-2;
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
class Bullet extends Floater
{
	public Bullet()
	{
		myColor =  color(255, 10, 10);
		myCenterX = spaceship.getX();
		myCenterY = spaceship.getY();
		myDirectionX = 5 * Math.cos(spaceship.getRads()) + spaceship.getDirectionX();
		myDirectionY = 5 * Math.sin(spaceship.getRads()) + spaceship.getDirectionY();
		System.out.println("Bullet X direction: "+myDirectionX+"\n"+"Bullet Y direction: "+myDirectionY);
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
	}
	public void show()  
	{
		fill(myColor);
		stroke(myColor);
		ellipse((float)myCenterX, (float)myCenterY, (float)2, (float)2);
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
			x[i] = (int)(Math.random()*700);
			y[i] = (int)(Math.random()*700);
		}
	}
	public void show()
	{
		for (int i = 0; i < x.length; i++) {
			point(x[i], y[i]);
		}
	}

}