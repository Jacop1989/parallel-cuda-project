#include <stdio.h>

__global__ void helloFromGPU() {
    printf("Hello from GPU!\n");
}

int main() {
    // Launch a kernel with 1 block and 1 thread
    helloFromGPU<<<1, 1>>>();

    // Synchronize the device to ensure the kernel is complete
    cudaDeviceSynchronize();

    return 0;
}
