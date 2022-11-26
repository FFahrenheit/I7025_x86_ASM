#include <iostream>
#include <string>
#include "utils.h"
#include "asm.h"
#include <cmath>

using namespace std;

void print_menu();
void print_option(string);
void getch();
void print_result(float);
void graph(double (*)(double), int);
void title(string);

struct InputTwo{
    float a;
    float b;
};
InputTwo require_two();
double require_one();

int main()
{
    int option;
    InputTwo input;
    float result, aux;
    double resultDouble;
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
                resultDouble = asm_sin(aux);
                print_result(resultDouble);
                getch();
                graph(&asm_sin, 1);
                title("GRAFICA DE SENO");
                break;
            case 8:
                print_option("COSENO");
                aux = require_one();
                resultDouble = asm_cos(aux);
                print_result(resultDouble);
                getch();
                graph(asm_cos, 1);
                title("GRAFICA DE COSENO");
                break;
            case 9:
                print_option("TANGENTE");
                aux = require_one();
                resultDouble = asm_tan(aux);
                print_result(resultDouble);
                getch();
                graph(asm_tan, 4);
                title("GRAFICA DE TANGENTE");
                break;
            case 10:
                print_option("GRADOS A RADIANES");
                aux = require_one();
                result = asm_deg_rad(aux);
                print_result(result);
                break;
            case 0:
                change_color(GREEN);
                print_center("GRACIAS POR USAR ESTA CALCULADORA", 2);
                break;
            default:
                change_color(RED);
                print_center("OPCION INVALIDA", 2);
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

double require_one(){
    double a;
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
    change_color(BROWN);
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

float map(float x, float in_min, float in_max, float out_min, float out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

void title(string graph){
    change_color(DARKGRAY);
    gotoxy(2, 6);
    cout << graph;
}

void graph(double (*func)(double), int img){
    system("cls");
    draw_frame();

    float last_x = 0;
    float last_y = 0;
    int r0 = -360;
    int rf = 360;
    int y0 = 7;
    int yf = 26;
    int x0 = 5;
    int xf = 115;
    int j;
    float x, y;

    change_color(LIGHTGRAY);
    gotoxy(1, (y0+yf)/2);
    cout << r0;
    gotoxy(116, (y0+yf)/2);
    cout << rf;
    gotoxy(60, 6);
    cout << img;
    gotoxy(60, 27);
    cout << "-" << img;
    change_color(DARKGRAY);
    gotoxy(6,(y0+yf)/2);
    for(int i = 6; i < 116; i++){
        cout << "_";
    }
    for(int i = 7; i < 27; i++){
        gotoxy(60, i);
        cout << "|";
    }
    change_color(WHITE);

    for(int i = x0; i <= xf; i++){
        x = map(i, x0, xf, r0, rf);
        y = func(x);
        if(y > img){
            y = img;
        }else if(y < img*-1){
            y = img*-1;
        }

        j = round(map(y, -1*img, img, y0, yf));
        gotoxy(i, j);
        cout << "\333";
        continue;

        if(last_x != x){
            float slope = (last_y - y) / (last_x - x);
            cout << slope;
            if(slope >= 0.009){
                cout << "\\";
            }else if(slope <= -0.009){
                cout << "/";
            }else{
                cout << "-";
            }
        }else{
            cout << "-";
        }
        last_x = x;
        last_y = y;
    }
}
