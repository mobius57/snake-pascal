# snake-pascal
program SnakeGame;

uses
  Crt;

const
  Width = 20;
  Height = 20;

type
  Direction = (Up, Down, Left, Right);

var
  SnakeX, SnakeY, FruitX, FruitY: Integer;
  SnakeLength, Score: Integer;
  SnakeTailX, SnakeTailY: array [1..100] of Integer;
  GameOver: Boolean;
  Dir: Direction;

procedure Initialize;
begin
  Randomize;
  SnakeX := Width div 2;
  SnakeY := Height div 2;
  FruitX := Random(Width) + 1;
  FruitY := Random(Height) + 1;
  SnakeLength := 0;
  Score := 0;
  GameOver := False;
  Dir := Right;
end;

procedure DrawBorder;
var
  i, j: Integer;
begin
  ClrScr;
  
  for i := 1 to Width + 2 do
    write('#');
  
  writeln;
  
  for j := 1 to Height do
  begin
    write('#');
    
    for i := 1 to Width do
    begin
      if (i = SnakeX) and (j = SnakeY) then
        write('O')
      else if (i = FruitX) and (j = FruitY) then
        write('F')
      else
        write(' ');
    end;
    
    writeln('#');
  end;
  
  for i := 1 to Width + 2 do
    write('#');
  
  writeln;
end;

procedure ProcessInput;
var
  Key: Char;
begin
  if KeyPressed then
  begin
    Key := ReadKey;
    
    case Key of
      #27: GameOver := True; // Escape key
      'W', 'w': if Dir <> Down then Dir := Up;
      'S', 's': if Dir <> Up then Dir := Down;
      'A', 'a': if Dir <> Right then Dir := Left;
      'D', 'd': if Dir <> Left then Dir := Right;
    end;
  end;
end;

procedure UpdateSnake;
var
  i: Integer;
begin
  SnakeTailX[1] := SnakeX;
  SnakeTailY[1] := SnakeY;
  
  for i := 2 to SnakeLength do
  begin
    if (SnakeTailX[i] = SnakeX) and (SnakeTailY[i] = SnakeY) then
      GameOver := True;
    
    SnakeTailX[i] := SnakeTailX[i - 1];
    SnakeTailY[i] := SnakeTailY[i - 1];
  end;
  
  case Dir of
    Up: Dec(SnakeY);
    Down: Inc(SnakeY);
    Left: Dec(SnakeX);
    Right: Inc(SnakeX);
  end;
  
  if (SnakeX < 1) or (SnakeX > Width) or (SnakeY < 1) or (SnakeY > Height) then
    GameOver := True;
  
  if (SnakeX = FruitX) and (SnakeY = FruitY) then
  begin
    Inc(Score);
    Inc(SnakeLength);
   
