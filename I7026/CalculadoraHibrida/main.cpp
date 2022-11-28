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
void graph(double (*)(double), int, float);
void title(string);

InputTwo require_two();
double require_one();

/*
Programa principal, en C++, se encarga de mostrar
el menú, pedir entradas y mostrarlas
*/
int main()
{
    setup_console();
    int option;
    InputTwo input;
    float result, aux;
    double resultDouble;
    draw_intro();       //Muestra la presentación del programa
    do{
        print_menu();   //Muestra el menú en C++
        cin >> option;  //Y recibe la entrada
        switch(option){ //Dependiendo de la opción, se hace una subrutina
            case 1:
                print_option("SUMA");
                input = require_two();              //Pedimos la entrada con C++
                result = asm_sum(input.a, input.b); //Llamamos a la función que realiza la suma en ASM
                print_result(result);               //Imprime el resultado con C++
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
                print_option("POTENCIA");               //Repetimos para todas las operaciones
                input = require_two();                  //ariemtéticas
                result = asm_pow(input.a, input.b);
                print_result(result);
                break;
            case 7:
                print_option("SENO");           //Para graficas y trigonometricas
                aux = require_one();            //pedimos un valor para calcular
                resultDouble = asm_sin(aux);    //calculamos con ASM
                print_result(resultDouble);     //mostramos el restado
                getch();
                graph(&asm_sin, 1, aux);        //Y graficamos, enviamos la funcion
                title("GRAFICA DE SENO");       //como parametro
                break;
            case 8:
                print_option("COSENO");
                aux = require_one();
                resultDouble = asm_cos(aux);
                print_result(resultDouble);
                getch();
                graph(asm_cos, 1, aux);
                title("GRAFICA DE COSENO");
                break;
            case 9:
                print_option("TANGENTE");
                aux = require_one();           //Repetimos para sin, cos, tan
                resultDouble = asm_tan(aux);
                print_result(resultDouble);
                getch();
                graph(asm_tan, 4, aux);
                title("GRAFICA DE TANGENTE");
                break;
            case 10:
                print_option("GRADOS A RADIANES");  //Extra, como igual hicimos
                aux = require_one();                //la funcion, la agregamos como
                result = asm_deg_rad(aux);          //opcion
                print_result(result);
                break;
            case 0:
                end_screen();                       //Al salir mostramos creditos
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

//Imprimimos el menú con C++
void print_menu(){
    system("cls");  //Limpiamos la pantalla
    draw_frame();   //Mostramos el marco
    change_color(LIGHTCYAN);
    print_center("MENU", 3);
    change_color(WHITE);            //Imprimimos las opciones
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

//Funcion para mapear valores, usado para graficar
float map(float x, float in_min, float in_max, float out_min, float out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

void graph(double (*func)(double), int img, float expected){
    system("cls");
    draw_frame();

    float accurate = 0; //Mas acercado al valor ingresado
    int accurate_i = 0; //Valor en "x" mas acercado
    int r0 = -360;      //X inicial
    int rf = 360;       //X final
    int y0 = 7;         // Fila inicial
    int yf = 26;        // Fila final
    int x0 = 5;         //Columna inicial
    int xf = 115;       //Columna final
    int j;
    float x, y;

    change_color(LIGHTGRAY);    //Imprimimos rango e imagen
    gotoxy(1, (y0+yf)/2);
    cout << r0;
    gotoxy(116, (y0+yf)/2);
    cout << rf;
    gotoxy(60, 6);
    cout << img;
    gotoxy(60, 27);
    cout << "-" << img;
    change_color(DARKGRAY);
    gotoxy(6,(y0+yf)/2);        //Graficamos ejes x y y
    for(int i = 6; i < 116; i++){
        cout << "_";
    }
    for(int i = 7; i < 27; i++){
        gotoxy(60, i);
        cout << "|";
    }
    change_color(WHITE);

    for(int i = x0; i <= xf; i++){  //Para cada fila (x)
        x = map(i, x0, xf, r0, rf); //Mapeamos con respecto al rango

        if(abs(expected - x) < abs(expected - accurate) || i == x0){
            accurate = x;
            accurate_i = i;
        }   //Calculamos si es el mas acercado

        y = func(x);    //Obtenemos el valor, con la funcion ASM
        y = (y > img) ? img : y < img*-1 ? img*-1 : y; //Si se sale, truncamos
        j = round(map(y, -1*img, img, y0, yf)); //Redondeamos y mapeamos con columnas

        gotoxy(i, j);
        cout << "\333"; //Imprimimos
    }

    y = func(accurate);
    y = (y > img) ? img : (y < img*-1) ? img*-1 : y;
    j = round(map(y, -1*img, img, y0, yf));
    change_color(RED);
    gotoxy(accurate_i, j);
    cout << "\333";     //Calculamos e imprimimos el mas acercado
}
