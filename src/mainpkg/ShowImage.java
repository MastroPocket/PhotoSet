package mainpkg;

import java.awt.Graphics;
import java.awt.Image;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.swing.JComponent;
import javax.swing.JFrame;

public class ShowImage extends JFrame{
	private String image="./image/";
	
	public ShowImage(String image){
		this.image+=image;
	    setTitle("ImageTest");
	    setSize(DEFAULT_WIDTH, DEFAULT_HEIGHT);

	   ImageComponent component = new ImageComponent();
	   this.add(component);

	    }

	    public static final int DEFAULT_WIDTH = 600;
	    public static final int DEFAULT_HEIGHT = 600;
	}


class ImageComponent extends JComponent{
	
	private Image image;
	public ImageComponent(){
		try{
			File image2 = new File("./images/f-stops.jpg");
			image = ImageIO.read(image2);

		}catch (IOException e){
			e.printStackTrace();
		}
	 }
	 
	public void paintComponent (Graphics g){
		if(image == null) return;
	    int imageWidth = image.getWidth(this);
	    int imageHeight = image.getHeight(this);

	    g.drawImage(image, 50, 50, this);

	}  

	}


