#ifndef ASM_H_INCLUDED
#define ASM_H_INCLUDED
#include <iostream>

using namespace std;

float op1, op2, aux, i, inc, res;

void asm_set_vars(float $a, float $b){
    op1 = $a;
    op2 = $b;
}

float asm_sum(float $a, float $b)
{
    asm_set_vars($a, $b);
    asm volatile("movss op1, %xmm0");
    asm volatile("addss op2, %xmm0");
    asm volatile("movss %xmm0, res");
    return res;
}

float asm_sub(float $a, float $b){
    asm_set_vars($a, $b);
    asm volatile("movss op1, %xmm0");
    asm volatile("subss op2, %xmm0");
    asm volatile("movss %xmm0, res");
    return res;
}

float asm_mul(float $a, float $b){
    asm_set_vars($a, $b);
    asm volatile("movss op1, %xmm0");
    asm volatile("mulss op2, %xmm0");
    asm volatile("movss %xmm0, res");
    return res;
}

float asm_div(float $a, float $b){
    asm_set_vars($a, $b);
    asm volatile("movss op1, %xmm0");
    asm volatile("divss op2, %xmm0");
    asm("movss %xmm0, res");
    return res;
}

float asm_mod(int $a, int $b){
        int $result;
    __asm__ __volatile__(
        "movl %1, %%eax;"
        "movl %2, %%ebx;"
        "xorl %%edx, %%edx;"
        "idivl %%ebx;"
        "movl %%edx, %0;"
        : "=&a"($result)
        : "g"($a), "g"($b));
    return $result;
}

float asm_pow(int $a, int $b){
    asm_set_vars($a, $b);
    aux = 1;
    i = 0;
    inc = 1;
    asm("movss op1, %xmm0");
    asm("movss op2, %xmm2");
    asm("movss i, %xmm3");
    asm("saltoto:");
    asm("movss aux, %xmm1");
    asm("movss op1, %xmm0");
    asm("mulss %xmm0, %xmm1");
    asm("movss %xmm1, aux");
    asm("addss inc, %xmm3");
    asm("ucomiss %xmm2, %xmm3");
    asm("jg saltoto");
    asm("movss %xmm1, res");
    return res;
}

float asm_deg_rad(float $rad){
    float temp = asm_mul($rad, 3.141592);
    temp = asm_div(temp, 180);
    return temp;
}

float asm_sin(int $a){
}

#endif // ASM_H_INCLUDED
