
// Calculating x^y in C

#include <stdio.h>

int main()
{
	int x,y;

	printf("Enter Number : ");
	scanf("%d",&x);
	printf("Enter Exponent : ");
	scanf("%d",&y);

	if(y < 0)
	{
		printf("The exponent may not be negative\n");
		return 0;
	}

	if(y == 0)
	{
		printf("Answer is : 1 \n");
		return 0;
	}


	int ans = x;

	for(int i=0;i<y-1;i++)
	{
		ans *= x;
	}

	printf("Answer is : %d \n",ans); 
	return 0;
}
