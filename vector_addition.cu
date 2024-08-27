#include <stdio.h>
#include <cuda_runtime.h>

// CUDA Kernel function to add elements of two arrays
__global__ void add(int *a, int *b, int *c, int n) {
    int index = threadIdx.x;
    if (index < n) {
        c[index] = a[index] + b[index];
    }
}

int main() {
    int n = 5;
    int a[] = {1, 2, 3, 4, 5};
    int b[] = {10, 20, 30, 40, 50};
    int c[n];

    // Allocate memory on the GPU
    int *d_a, *d_b, *d_c;
    cudaMalloc((void**)&d_a, n * sizeof(int));
    cudaMalloc((void**)&d_b, n * sizeof(int));
    cudaMalloc((void**)&d_c, n * sizeof(int));

    // Copy data from CPU to GPU
    cudaMemcpy(d_a, a, n * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, n * sizeof(int), cudaMemcpyHostToDevice);

    // Launch the kernel on the GPU
    add<<<1, n>>>(d_a, d_b, d_c, n);

    // Copy the result back to the CPU
    cudaMemcpy(c, d_c, n * sizeof(int), cudaMemcpyDeviceToHost);

    // Free the GPU memory
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    // Print the result
    printf("Result: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", c[i]);
    }
    printf("\n");

    return 0;
}
