import CLIPSJNI.*;
import mainpkg.ShowImage;

import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;
import java.util.Scanner;

import javax.swing.JFrame;

import java.util.Arrays;


public class PhotoSet
{
  Environment clips = null;
  
  final static String EXIT_LOOP = "exit-loop";
  final static String TRUE = "TRUE";
  final static String FALSE = "FALSE";
  final static String[] YES_NO_ANSWERS = {"yes", "y", "no", "n"};
  
  Map<String, String> questions = null;
  
  
  PhotoSet()
  {
    
    /* Creating the environment */
    clips = new Environment();

    /* Loading a .clp file */
    clips.load("PhotoSet.clp");

    /* Reset the environment */
    clips.reset();
    
  }

 

 

  

  String checkAgenda() throws Exception
  {
    return clips.eval("(agenda)").toString();
  }

  String listFacts() throws Exception
  {
    return clips.eval("(facts)").toString();
  }
  
  /**/
  void interact()
  {
    
   while(true){
	   clips.run(1);
	    String image;
	     try {
	    	
	    	PrimitiveValue fv = clips.eval(" (find-all-facts ((?f show-image2)) TRUE))").get(0);
			image = fv.getFactSlot("immagine").toString();
			System.out.println("----->"+image+"\n");
			 ShowImage frame = new ShowImage(image);
             
             frame.setVisible(true);
		} catch (Exception e) {
			System.out.println("ERRORE \n");
		}
	    /* For each question */
	   
   }
  
  }

  public static void main(String args[])
  {
    PhotoSet classifierDemo = new PhotoSet();
    classifierDemo.interact();
  }
}
