#ifndef UTILS_H_INCLUDED
#define UTILS_H_INCLUDED
#include <iostream>
#include <windows.h>

using namespace std;

//Definicion de colores para cambiar
#define BLACK			0
#define BLUE			1
#define GREEN			2
#define CYAN			3
#define RED				4
#define MAGENTA			5
#define BROWN			6
#define LIGHTGRAY		7
#define DARKGRAY		8
#define LIGHTBLUE		9
#define LIGHTGREEN		10
#define LIGHTCYAN		11
#define LIGHTRED		12
#define LIGHTMAGENTA	13
#define YELLOW			14
#define WHITE			15


struct InputTwo{
    float a;
    float b;
};

const int ROWS = 120;
const int COLS = 30;

int current_x = 0;
int current_y = 0;

//Funcion para colocar el cursor en X, Y usando API de Windows
void gotoxy(int x,int y){
    HANDLE hcon;
    hcon = GetStdHandle(STD_OUTPUT_HANDLE);
    COORD dwPos;
    dwPos.X = x;
    dwPos.Y= y;
    current_x = x;
    current_y = y;
    SetConsoleCursorPosition(hcon,dwPos);
 }

 //Centramos consola
 void setup_console(){
    HWND console = GetConsoleWindow();
    RECT r;
    GetWindowRect(console, &r);
    MoveWindow(console, r.left, r.top, 1000,530, TRUE);
}

//Cambiamos de color de texto usando la API de Windows
void change_color(int val){
    SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), val);
}

//Imprimimos en las coordenadas guardadas
void print_position(string text, int x){
    gotoxy(x, current_y + 1);
    cout << text;
}

//Imprimimos resultado con el formato solicitado
void print_result(float result){
    string res = to_string(result);
    res = res.substr(0, res.find(".") + 3); //Cortamos el reultado a dos decimales
    int center = (120 - 11 - res.size())/2; //Encontramos el centro
    gotoxy(center, 14);
    change_color(LIGHTGREEN);
    cout << "Resultado: ";
    change_color(CYAN);                     //Color parte entera
    for(size_t i = 0; i < res.size(); i++){//Imprimimos caracter por caracter
        char current = res[i];
        if(current == '.'){
            change_color(RED);          //Cambiamos color cuando encuentra el punto
            cout << ".";                //imprime y cambia de nuevo
            change_color(YELLOW);
        }else{
            cout << current;
        }
    }
}

//Imprimimos en el centro
void print_center(string text, int skips){
    int x = (ROWS - (int)(text.length()))/2;    //Calculamos centro
    gotoxy(x, current_y + 1 + skips);
    cout << text;
}

//Imprimir titulo de grafico
void title(string graph){
    change_color(DARKGRAY);
    gotoxy(2, 6);
    cout << graph;
}

//Con C++ solicita dos numeros y los retorna en una struct
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
    InputTwo result = { a, b };
    return result;
}

//Solicita un numero y lo retorna
double require_one(){
    double a;
    change_color(LIGHTGRAY);
    print_center("Ingrese un numero:  ", 1);
    change_color(GREEN);
    cin >> a;
    return a;
}

//Rutina para imprimir marco
void draw_borders(){
    change_color(DARKGRAY);
    gotoxy(0,0);cout << (char) 201;
    gotoxy(ROWS-1,0);cout << (char)187;
    gotoxy(0,COLS-1);cout<< (char) 200;
    gotoxy(ROWS-1,COLS-1);cout<< (char)188;
    for(int i=1; i<ROWS-1;i++)
    {
        gotoxy(i,0);
        cout << (char) 205;
        gotoxy(i,COLS-1);
        cout << (char) 205;
    }
    for(int i=1; i<COLS-1;i++)
    {
        gotoxy(0,i);
        cout << (char) 186;
        gotoxy(ROWS-1,i);
        cout << (char) 186;
    }
}

//Rutina para imprimir titulo del proyecto
void draw_frame()
{
    draw_borders();
    change_color(LIGHTGRAY);
    gotoxy(23, 1); cout << "   ___      _            _           _                         __   _  _   ";
    gotoxy(23, 2); cout << "  / __\\__ _| | ___ _   _| | __ _  __| | ___  _ __ __ _  __  __/ /_ | || |  ";
    gotoxy(23, 3); cout << " / /  / _` | |/ __| | | | |/ _` |/ _` |/ _ \\| '__/ _` | \\ \\/ / '_ \\| || |_ ";
    gotoxy(23, 4); cout << "/ /__| (_| | | (__| |_| | | (_| | (_| | (_) | | | (_| |  >  <| (_) |__   _|";
    gotoxy(23, 5); cout << "\\____/\\__,_|_|\\___|\\__,_|_|\\__,_|\\__,_|\\___/|_|  \\__,_| /_/\\_\\\\___/   |_|  ";
    change_color(WHITE);
}

//Imprime la opcion seleccionada
void print_option(string selected){
    system("cls");
    draw_frame();
    change_color(LIGHTCYAN);
    print_center(selected, 3);
}

//Espera una respuesta
void getch(){
    change_color(BROWN);
    gotoxy(44,28);
    system("pause");
}

//Rutina para imprimir un contador...
void counter(){
    system("cls");
    gotoxy(0,5);
    cout <<"\t\t\t\t\t\t 333333333333333\n";
    cout << "\t\t\t\t\t\t3:::::::::::::::33 \n";
    cout << "\t\t\t\t\t\t3::::::33333::::::3\n";
    cout << "\t\t\t\t\t\t3333333     3:::::3\n";
    cout << "\t\t\t\t\t\t            3:::::3\n";
    cout << "\t\t\t\t\t\t            3:::::3\n";
    cout << "\t\t\t\t\t\t    33333333:::::3 \n";
    cout << "\t\t\t\t\t\t    3:::::::::::3  \n";
    cout << "\t\t\t\t\t\t    33333333:::::3 \n";
    cout << "\t\t\t\t\t\t            3:::::3\n";
    cout << "\t\t\t\t\t\t            3:::::3\n";
    cout << "\t\t\t\t\t\t            3:::::3\n";
    cout << "\t\t\t\t\t\t3333333     3:::::3\n";
    cout << "\t\t\t\t\t\t3::::::33333::::::3\n";
    cout << "\t\t\t\t\t\t3:::::::::::::::33 \n";
    cout << "\t\t\t\t\t\t 333333333333333   \n";
    Sleep(1000);
    gotoxy(0,5);
    cout<<"\t\t\t\t\t\t 222222222222222  \n";
    cout<<"\t\t\t\t\t\t2:::::::::::::::22  \n";
    cout<<"\t\t\t\t\t\t2::::::222222:::::2 \n";
    cout<<"\t\t\t\t\t\t2222222     2:::::2 \n";
    cout<<"\t\t\t\t\t\t            2:::::2 \n";
    cout<<"\t\t\t\t\t\t            2:::::2 \n";
    cout<<"\t\t\t\t\t\t         2222::::2  \n";
    cout<<"\t\t\t\t\t\t    22222::::::22   \n";
    cout<<"\t\t\t\t\t\t  22::::::::222     \n";
    cout<<"\t\t\t\t\t\t 2:::::22222        \n";
    cout<<"\t\t\t\t\t\t2:::::2             \n";
    cout<<"\t\t\t\t\t\t2:::::2             \n";
    cout<<"\t\t\t\t\t\t2:::::2       222222\n";
    cout<<"\t\t\t\t\t\t2::::::2222222:::::2\n";
    cout<<"\t\t\t\t\t\t2::::::::::::::::::2\n";
    cout<<"\t\t\t\t\t\t22222222222222222222\n";
    Sleep(1000);
    gotoxy(0,5);
    cout<<"\t\t\t\t\t\t  1111111            \n";
    cout<<"\t\t\t\t\t\t 1::::::1               \n";
    cout<<"\t\t\t\t\t\t1:::::::1               \n";
    cout<<"\t\t\t\t\t\t111:::::1               \n";
    cout<<"\t\t\t\t\t\t   1::::1               \n";
    cout<<"\t\t\t\t\t\t   1::::1               \n";
    cout<<"\t\t\t\t\t\t   1::::1               \n";
    cout<<"\t\t\t\t\t\t   1::::l               \n";
    cout<<"\t\t\t\t\t\t   1::::l               \n";
    cout<<"\t\t\t\t\t\t   1::::l               \n";
    cout<<"\t\t\t\t\t\t   1::::l               \n";
    cout<<"\t\t\t\t\t\t   1::::l               \n";
    cout<<"\t\t\t\t\t\t111::::::111            \n";
    cout<<"\t\t\t\t\t\t1::::::::::1            \n";
    cout<<"\t\t\t\t\t\t1::::::::::1            \n";
    cout<<"\t\t\t\t\t\t111111111111            \n";
    Sleep(1000);
}

//Rutina para imprimir intro del proyecto
void draw_intro(){
    counter();
    system("cls");
    draw_frame();
    change_color(GREEN);
    print_center("  ___           ___                   _   ___                 _                       __  __          _ _ _     ", 5);
    print_center(" | _ \\___ _ _  |_ _|____ __  __ _ ___| | |_ _|_ ____ _ _ _   | |   ___ _ __  ___ ___ |  \\/  |_  _ _ _(_) | |___ ",0);
    print_center(" |  _/ _ \\ '_|  | |(_-< '  \\/ _` / -_) |  | |\\ V / _` | ' \\  | |__/ _ \\ '_ \\/ -_)_ / | |\\/| | || | '_| | | / _ \\",0);
    print_center(" |_| \\___/_|   |___/__/_|_|_\\__,_\\___|_| |___|\\_/\\__,_|_||_| |____\\___/ .__/\\___/__| |_|  |_|\\_,_|_| |_|_|_\\___/",0);
    getch();
}

//Rutina para imprimir fin del proyecto
void end_screen(){
    system("cls");
    draw_borders();
    gotoxy(0,10);
    cout<<"\t\t\t           .--.    _..._    \n";
    cout<<"\t\t\t     _.._  |__|  .'     '.  \n";
    cout<<"\t\t\t   .' .._| .--. .   .-.   . \n";
    cout<<"\t\t\t   | '     |  | |  '   '  | \n";
    cout<<"\t\t\t __| |__   |  | |  |   |  | \n";
    cout<<"\t\t\t|__   __|  |  | |  |   |  | \n";
    cout<<"\t\t\t   | |     |  | |  |   |  | \n";
    cout<<"\t\t\t   | |     |__| |  |   |  | \n";
    cout<<"\t\t\t   | |          |  |   |  | \n";
    cout<<"\t\t\t   | |          |  |   |  | \n";
    cout<<"\t\t\t   |_|          '--'   '--' \n";

    cout << "\n\n\t| _,_    _ |  |    ,_  |      _ _   |\\/|    .||  \n";
    cout << "\t|_\\|||(|(/_|  |\\/(|||  |_()|)(/_/_  |  |L||`|||()\n";
    cout << "\t                           |                    \n";

    gotoxy(0,4);
    change_color(GREEN);

    print_center("GRACIAS POR USAR ESTA CALCULADORA", 2);
}

#endif // UTILS_H_INCLUDED
