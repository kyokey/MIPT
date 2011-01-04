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
        BigInteger a=BigInteger.ONE;
        BigInteger b=BigInteger.ONE;
        n-=1;
        for(int i=0;i<n;i++)
        {
        	BigInteger c=a.add(b);
        	a=b;
        	b=c;
        }
        System.out.println(b.toString());
    }
  public static void main(String args[]) throws Exception 
  { 
   
   new Main().work();
  } 

}  
