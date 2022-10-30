#include <iostream>

int gcd(int $a, int $b)
{
    int $result;
    __asm__ __volatile__(
        "movl %1, %%eax;"
        "movl %2, %%ebx;"
        "CONTD: cmpl $0, %%ebx;"
        "je DONE;"
        "xorl %%edx, %%edx;"
        "idivl %%ebx;"
        "movl %%ebx, %%eax;"
        "movl %%edx, %%ebx;"
        "jmp CONTD;"
        "DONE: movl %%eax, %0;"
        : "=g"($result)
        : "g"($a), "g"($b));
    return $result;
}

int suma(int $a, int $b)
{
    int $result;
    __asm__ __volatile__(
        "movl %1, %%eax;"
        "movl %2, %%ebx;"
        "addl %%ebx, %%eax;"
        "movl %%eax,%0;"
        : "=g"($result)
        : "g"($a), "g"($b));
    return $result;
}

int suma3(int $a, int $b, int $c)
{
    int $result;
    __asm__ __volatile__(
        "movl %1, %%eax;"
        "movl %2, %%ebx;"
        "movl %3, %%ecx;"
        "addl %%ebx, %%eax;"
        "addl %%ecx, %%eax;"
        "movl %%eax,%0;"
        : "=g"($result)
        : "g"($a), "g"($b), "g"($c));
    return $result;
}

int promedio(int $a, int $b, int $c, int $d)
{
    int $result;
    __asm__ __volatile__(
        "movl %1, %%eax;"
        "movl %2, %%ebx;"
        "movl %3, %%ecx;"
        "movl %4, %%edx;"
        "addl %%ebx, %%eax;"
        "addl %%ecx, %%eax;"
        "addl %%edx, %%eax;"
        "movl $0x00, %%edx;"
        "movl $0x04, %%ebx;"
        "idivl %%ebx;"
        "movl %%eax, %0;"
        : "=&a"($result)
        : "g"($a), "g"($b), "g"($c), "g"($d));
    return $result;
}

int main(int argc, char **argv)
{
    int a, b, c, d, e;
    a = 4;
    b = 6;
    c = gcd(a, b);
    printf("a=%d \t b=%d \t GCD=%d \n\r", a, b, c);
    c = suma(a, b);
    printf("a=%d \t b=%d \t Suma=%d \n\r", a, b, c);
    d = suma3(a, b, c);
    printf("Suma=%d \n\r", d);
    e = promedio(a, b, c, d);
    printf("Promedio(%d, %d, %d, %d)=%d \n\r", a, b, c, d, e);
    return 0;
}