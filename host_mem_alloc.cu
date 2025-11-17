// #include <cuda_runtime.h>
// For malloc/free, random numbers, and basic utility functions
#include <stdlib.h>
// For tools to copy, compare, and manipulate strings & memory blocks
#include <string.h>
// For measure execution time, get system time, and format dates
#include <time.h>

// You know ;D
#include <stdio.h>


// Define the kernel for summation
void sumArraysOnHost(float *A, float *B, float *C, int N) {

    for (int idx = 0; idx < N; idx++)
        C[idx] = A[idx] + B[idx];

}


// Define the kernel for initialization of array
void initialData(float *data, int size) {

    for (int i = 0; i < size; i++) 
        data[i] = (float) (i);

}



// MAIN
int main(void) {
    
    const size_t N = 1024;
    const size_t bytes = N * sizeof(float);


    float *h_A, *h_B, *h_C;

    // Declare the array pointers in heap
    h_A = (float *)malloc(bytes);
    h_B = (float *)malloc(bytes);
    h_C = (float *)malloc(bytes);

    // Initialize the arrays
    clock_t t0 = clock();
    initialData(h_A, N);
    initialData(h_B, N);
    clock_t t1 = clock();


    // Do the summation between array in host
    clock_t t2 = clock();
    sumArraysOnHost(h_A, h_B, h_C, N);
    clock_t t3 = clock();

    double init_time_sec = (double)(t1 - t0) / CLOCKS_PER_SEC;
    double comp_time_sec = (double)(t3 - t2) / CLOCKS_PER_SEC;

    printf("Init time: %.6f \n", init_time_sec);
    printf("Comp time: %.6f \n", comp_time_sec);


    // Free the heap memory
    free(h_A);
    free(h_B);
    free(h_C);


    // Fucking old return
    return 0;

}