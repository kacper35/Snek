program snek;

uses sysutils, crt;

var
dir,l:integer;
x,y,ranx,rany:integer;
map:array[0..17,0..17] of char;
applex,appley:integer;
movex:array[0..256]of integer;
movey:array[0..256]of integer;
timer:longint;
head:char;
len:integer;
apel,dead:boolean;


procedure fix();
var
i:integer;
begin
    if l > len then begin
        map[movex[1],movey[1]]:='x';
        for i:=1 to len do begin
        movex[i]:=movex[i+1];
        movey[i]:=movey[i+1];
        end;
        l:=len;    
    end;
end;

procedure gen();
var
i:integer;
j:integer;
place:integer;
begin
    textbackground(white);
    place:=0;
    for j:=0 to 17 do begin
        for i:=0 to 17 do begin 
            textcolor(white);
            if map[i,j] = 'b' then begin
                textcolor(yellow);
                textbackground(yellow);  
            end;
            if map[i,j] = 'x' then begin
                textcolor(white);
                textbackground(white);  
            end;
             if map[i,j] = head then begin
                textcolor(red);
                textbackground(green);  
            end;
            if map[i,j] = 'o' then begin
                textcolor(green);
                textbackground(green);  
            end;
            if map[i,j] = 'A' then begin
                textcolor(red);
                textbackground(red);  
            end;
                write(map[i,j],' ');
            
        end; 
        writeln();
    end;
    textcolor(red);
    textbackground(black);
    writeln('points: ',len-1);
end;
procedure movedir();
begin
    case dir of
        1: begin
            y:=y-1;
        end;
        2: begin  
            x:=x-1;;
        end;
        3: begin   
            x:=x+1;
        end;
        4: begin   
            y:=y+1;
        end;
    end;
end;
procedure move();
begin
    if keypressed = true then
        case readkey of
            #72: begin 
                dir:=1; 
                head:='^';
            end;
            #75: begin
                dir:=2;
                head:='<';
            end;
            #77: begin 
                dir:=3;
                head:='>';
            end;
            #80: begin 
                dir:=4;
                head:='v';
            end;
        end;
end;
procedure apple(hx,hy:integer);
var
ranx,rany:longint;
begin
    if apel = false then begin
        repeat 
            ranx:=1+random(10000)mod 16;
        until hx <> ranx;
        repeat
            rany:=1+random(10000)mod 16;
        until hy <> rany;
        applex:=ranx;
        appley:=rany; 
        apel:=true;
    end;
end;
procedure eat();
begin
    apel:=false;
    sound(600);
    delay(20);
    nosound;
    map[applex,appley]:=head;
    apple(x,y);
    len:=len+1;
end;
procedure ded();
var
i:integer;
begin
    if (x>16) or (x < 1) or (y > 16) or (y < 1) then begin
        dead:=true;
    end;
    for i:=1 to l-1 do begin
        if (x=movex[i]) and (y=movey[i]) then begin
            dead:=true;
            break;
        end;
    end;
end;
var i,j:integer;
begin
    randomize;
    l:=0;
    dead:=false;
    len:=1;
    x:=8;
    y:=8;
    timer:=0;
    dir:=1;
    apel:=false;
    textbackground(black);
    clrscr;
    l:=l+1;
    movex[l]:=x;
    movey[l]:=y;
    fix;
    apple(x,y);
    map[x,y]:=head;
    if (x=applex) and (y=appley) then eat;
    map[applex,appley]:='A';
    gen;
    for j:=0 to 17 do begin
        for i:=0 to 17 do begin 
            if ((i=0) or (j=0)) then
                map[i,j]:='b' else
                if ((i=17) or (j=17)) then
                map[i,j]:='b' else
                map[i,j]:='x';
        end; 
    end;
    map[x,y]:='o'; 
    clrscr; 
    while (11=11) do begin
            move;
        timer:=timer+1;
            move;
        if timer = 15000 then begin
            move;
            textbackground(black);
            move;
            movedir;
            l:=l+1;
            movex[l]:=x;
            movey[l]:=y;
            fix;
            map[x,y]:=head;
            move;
            clrscr; 
            move;
            apple(x,y);
            move;
            map[applex,appley]:='A';
            move;
            if (x=applex) and (y=appley) then eat;
            map[applex,appley]:='A';
            ded;
            gen;
            map[x,y]:='o'; 
            move;
            timer:=0;
        end;
        move;
        if keypressed = true then
            if readkey=#27 then
                break;
        if dead = true then 
            break;
    end;
    textbackground(black);
    clrscr;
    delay(100);
    if dead = true then begin
        sound(1200);
        delay(40);
        sound(600);
        delay(40);
        sound(1300);
        delay(40);
        sound(400);
        delay(40);
        sound(1600);
        delay(40);
        nosound;
        textbackground(black);
        textcolor(white);
        Writeln('GAME OVER');
        Writeln('Your score: ',len-1);
    end;
end.     