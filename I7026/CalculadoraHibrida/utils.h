#ifndef UTILS_H_INCLUDED
#define UTILS_H_INCLUDED
#include <iostream>
#include <windows.h>

using namespace std;

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

const int ROWS = 120;
const int COLS = 30;

int current_x = 0;
int current_y = 0;

void gotoxy(int x,int y)
{
    HANDLE hcon;
    hcon = GetStdHandle(STD_OUTPUT_HANDLE);
    COORD dwPos;
    dwPos.X = x;
    dwPos.Y= y;
    current_x = x;
    current_y = y;
    SetConsoleCursorPosition(hcon,dwPos);
 }

 void setup_console()
{
    HWND console = GetConsoleWindow();
    RECT r;
    GetWindowRect(console, &r);
    MoveWindow(console, r.left, r.top, 1000,530, TRUE);
}

void change_color(int val)
{
    SetConsoleTextAttribute(GetStdHandle(STD_OUTPUT_HANDLE), val);
}

void draw_frame()
{
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
    change_color(LIGHTGRAY);
    gotoxy(23, 1); cout << "   ___      _            _           _                         __   _  _   ";
    gotoxy(23, 2); cout << "  / __\\__ _| | ___ _   _| | __ _  __| | ___  _ __ __ _  __  __/ /_ | || |  ";
    gotoxy(23, 3); cout << " / /  / _` | |/ __| | | | |/ _` |/ _` |/ _ \\| '__/ _` | \\ \\/ / '_ \\| || |_ ";
    gotoxy(23, 4); cout << "/ /__| (_| | | (__| |_| | | (_| | (_| | (_) | | | (_| |  >  <| (_) |__   _|";
    gotoxy(23, 5); cout << "\\____/\\__,_|_|\\___|\\__,_|_|\\__,_|\\__,_|\\___/|_|  \\__,_| /_/\\_\\\\___/   |_|  ";
    change_color(WHITE);
}

void print_center(string text, int skips){
    int x = (ROWS - (int)(text.length()))/2;
    gotoxy(x, current_y + 1 + skips);
    cout << text;
}

void print_position(string text, int x){
    gotoxy(x, current_y + 1);
    cout << text;
}

void print_result(float result){

    string res = to_string(result);
    int center = (120 - 11 - res.size())/2;
    gotoxy(center, 14);
    change_color(LIGHTGREEN);
    cout << "Resultado: ";
    change_color(CYAN);
    for(size_t i = 0; i < res.size(); i++){
        char current = res[i];
        if(current == '.'){
            change_color(RED);
            cout << ".";
            change_color(YELLOW);
        }else{
            cout << current;
        }
    }
}

#endif // UTILS_H_INCLUDED
