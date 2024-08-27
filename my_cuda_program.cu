#include <stdio.h>
#include <cuda_runtime.h>  // ต้องใช้ไลบรารีนี้สำหรับฟังก์ชัน CUDA

// CUDA kernel function
__global__ void helloCUDA() {
    printf("Hello from GPU!\n");
}

int main() {
    // เรียกใช้ kernel ด้วย 1 block และ 1 thread
    helloCUDA<<<1, 1>>>();

    // ซิงค์ CPU กับ GPU เพื่อรอให้ GPU ทำงานเสร็จ
    cudaDeviceSynchronize();

    return 0;
}
