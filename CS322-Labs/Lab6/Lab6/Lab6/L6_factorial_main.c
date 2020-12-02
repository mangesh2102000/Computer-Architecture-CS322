/*
 * An application that illustrates calling the factorial function defined elsewhere.
 */

#include <stdio.h>
#include <inttypes.h>
#include <time.h>

uint64_t factorial(uint64_t n);

int main() {
	
    clock_t start=clock();	  
    for (uint64_t i = 0; i < 100000; i++) {
          factorial(i);
    }

   clock_t finish=clock();
printf( "Factorial took %f second \n", ((double) (finish-start))/CLOCKS_PER_SEC);	
    return 0;
}