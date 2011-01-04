
import java.util.*;
import java.util.regex.*;
import java.text.*;
import java.math.*;
public class Main
{
	Scanner cin;
    void work()
    {
    	cin=new Scanner(System.in); 
        int n=cin.nextInt();
        BigInteger a=cin.nextBigInteger();
        int x=a.mod(BigInteger.valueOf(3)).intValue();
        for(int i=0;i<n-1;i++)
        {
        	BigInteger b=cin.nextBigInteger();
        	int y=b.mod(BigInteger.valueOf(3)).intValue();
        	x^=y;
        }
        if(x==0) System.out.println("Second wins.");
        else System.out.println("First wins.");
    }
  public static void main(String args[]) throws Exception 
  { 
   
   new Main().work();
  } 

}  
