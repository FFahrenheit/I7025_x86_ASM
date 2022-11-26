#include <iostream>
#include <string>
#include "utils.h"
#include "asm.h"

using namespace std;

void print_menu();
void print_option(string);
void getch();
void print_result(float);

struct InputTwo{
    float a;
    float b;
};
InputTwo require_two();
float require_one();

int main()
{
    int option;
    InputTwo input;
    float result, aux;
    do{
        print_menu();
        cin >> option;
        switch(option){
            case 1:
                print_option("SUMA");
                input = require_two();
                result = asm_sum(input.a, input.b);
                print_result(result);
                break;
            case 2:
                print_option("RESTA");
                input = require_two();
                result = asm_sub(input.a, input.b);
                print_result(result);
                break;
            case 3:
                print_option("MULTIPLICACION");
                input = require_two();
                result = asm_mul(input.a, input.b);
                print_result(result);
                break;
            case 4:
                print_option("DIVISION");
                input = require_two();
                result = asm_div(input.a, input.b);
                print_result(result);
                break;
            case 5:
                print_option("MODULO");
                input = require_two();
                result = asm_mod(input.a, input.b);
                print_result(result);
                break;
            case 6:
                print_option("POTENCIA");
                input = require_two();
                result = asm_pow(input.a, input.b);
                print_result(result);
                break;
            case 7:
                print_option("SENO");
                aux = require_one();

            case 10:
                print_option("GRADOS A RADIANES");
                aux = require_one();
                result = asm_deg_rad(aux);
                print_result(result);
                break;
        }
        getch();
    }while(option != 0);


    return 0;
}

InputTwo require_two(){
    float a, b;
    change_color(LIGHTGRAY);
    print_center("Ingrese el primer numero:  ", 1);
    change_color(GREEN);
    cin >> a;
    change_color(LIGHTGRAY);
    print_center("Ingrese el segundo numero: ", 0);
    change_color(GREEN);
    cin >> b;
    InputTwo result = { a, b};
    return result;
}

float require_one(){

    float a;
    change_color(LIGHTGRAY);
    print_center("Ingrese un numero:  ", 1);
    change_color(GREEN);
    cin >> a;
    return a;
}

void print_option(string selected){
    system("cls");
    draw_frame();
    change_color(LIGHTCYAN);
    print_center(selected, 3);
}

void getch(){
    gotoxy(44,28);
    system("pause");
}

void print_menu(){
    system("cls");
    draw_frame();
    change_color(LIGHTCYAN);
    print_center("MENU", 3);
    change_color(WHITE);
    print_position("1)  Suma", 40);
    print_position("2)  Resta", 40);
    print_position("3)  Multiplicacion", 40);
    print_position("4)  Division", 40);
    print_position("5)  Modulo", 40);
    print_position("6)  Potencia", 40);
    print_position("7)  Seno", 40);
    print_position("8)  Coseno", 40);
    print_position("9)  Tangente", 40);
    print_position("10) Grados a radianes", 40);
    print_position("0)  Salir", 40);
    print_position("", 40);
    change_color(LIGHTGRAY);
    print_center("Su eleccion: ", 0);
    change_color(GREEN);
}
