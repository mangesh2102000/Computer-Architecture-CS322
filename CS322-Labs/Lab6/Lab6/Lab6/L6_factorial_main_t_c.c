/*
 * An application that illustrates calling the factorial function defined elsewhere.
 */

#include <stdio.h>
#include <inttypes.h>
#include <time.h>

long int multiplyNumbers(int n);

int main() {
	
clock_t start, finish;
	int n;
    printf("Enter input number : ");
    scanf("%d",&n);

     start=clock();	  
    for (uint64_t i = 0; i < n; i++) {
         multiplyNumbers(i);
    }

   finish=clock();
printf( "Factorial took %f second \n", ((double) (finish-start))/CLOCKS_PER_SEC);	
    return 0;
}


long int multiplyNumbers(int n) {
    if (n>=1)
        return n*multiplyNumbers(n-1);
    else
        return 1;
}

