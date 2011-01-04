/*
	Problem: MIPT 009 Fibonacci numbers
	Author: Amber
	Method: HP
	Date: 2006-9-27
*/
import java.util.*;
import java.math.*;

public class Main
{
	public static void main(String[] args)
	{
		Scanner cin = new Scanner(System.in);
		int N = cin.nextInt();
		BigInteger F[] = new BigInteger [3];

		F[0] = F[1] = BigInteger.ONE;
		for (int i = 0; i < N - 1; i++)
			F[(i + 2) % 3] = F[i % 3].add(F[(i + 1) % 3]);
		System.out.println(F[N % 3]);
	}
}
