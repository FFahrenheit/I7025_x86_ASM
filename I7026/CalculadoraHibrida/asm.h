#ifndef ASM_H_INCLUDED
#define ASM_H_INCLUDED

//Variables globales para funcionar con asm
float op1, op2, aux, i, inc, res;
double d;

//Funcion para guardar parametros como variables globales
void asm_set_vars(float $a, float $b){
    op1 = $a;
    op2 = $b;
}

//Suma con ASM, usando instrucciones FPU
float asm_sum(float $a, float $b){
    asm_set_vars($a, $b);
    asm volatile("movss op1, %xmm0");
    asm volatile("addss op2, %xmm0");
    asm volatile("movss %xmm0, res");
    return res;
}

//Resta con ASM, usando instrucciones FPU
float asm_sub(float $a, float $b){
    asm_set_vars($a, $b);
    asm volatile("movss op1, %xmm0");
    asm volatile("subss op2, %xmm0");
    asm volatile("movss %xmm0, res");
    return res;
}

//Multiplicar con ASM, usando instrucciones FPU
float asm_mul(float $a, float $b){
    asm_set_vars($a, $b);
    asm volatile("movss op1, %xmm0");
    asm volatile("mulss op2, %xmm0");
    asm volatile("movss %xmm0, res");
    return res;
}

//Didividr con ASM, usando instrucciones FPU
float asm_div(float $a, float $b){
    asm_set_vars($a, $b);
    asm volatile("movss op1, %xmm0");
    asm volatile("divss op2, %xmm0");
    asm("movss %xmm0, res");
    return res;
}

//Modulo con ASM, usando instrucciones tradicionales,
//dividimos pero retornamos el residuo
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

//Potencia con ASM, usando instrucciones FPU
float asm_pow(int $a, int $b){
    asm_set_vars($a, $b);
    aux = 1;
    i = 0;
    inc = 1;
    asm("movss op1, %xmm0");
    asm("movss op2, %xmm2");
    asm("movss i, %xmm3");
    asm("saltoto:");        //Repetimos multiplicaciones y sumamos el resultado
    asm("movss aux, %xmm1");
    asm("movss op1, %xmm0");
    asm("mulss %xmm0, %xmm1");
    asm("movss %xmm1, aux");
    asm("addss inc, %xmm3");
    asm("ucomiss %xmm2, %xmm3"); //Comparar escalar con FPU
    asm("jg saltoto");           //Repetir si es igual
    asm("movss %xmm1, res");
    return res;
}

//Para convertir, usamos ASM para multiplicar por PI y dividir entre 180
double asm_deg_rad(double $rad){
    double temp = asm_mul($rad, 3.141592);
    temp = asm_div(temp, 180);
    return temp;
}

//Obtener el seno como double gld usando FPU, no usamos MOV sino FLD y FSTP
double asm_sin(double $a){
    d = asm_deg_rad($a);
    asm("fldl %0;"
        "fsin;"
        "fstpl %0":"+m"(d));
    return d;
}

//Obtener el coseno como double gld usando FPU, no usamos MOV sino FLD y FSTP
double asm_cos(double $a){
    d = asm_deg_rad($a);
    asm("fldl %0;"
        "fcos;"
        "fstpl %0":"+m"(d));
    return d;
}

//Para obtener la tangente, dividimos seno entre coseno ya implementado
double asm_tan(double $a){
    return asm_div(asm_sin($a), asm_cos($a));
}

#endif // ASM_H_INCLUDED
