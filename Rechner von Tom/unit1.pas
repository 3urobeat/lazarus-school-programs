unit Unit1;
//Autor: Tom
//Description: Calculator

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Number0: TButton;
    Number1: TButton;
    Number2: TButton;
    Number3: TButton;
    Number4: TButton;
    Number5: TButton;
    Number6: TButton;
    Number7: TButton;
    Number8: TButton;
    Number9: TButton;
    NumberEqual: TButton;
    Clear: TButton;
    CalcOperatorAdd: TButton;
    CalcOperatorMin: TButton;
    CalcOperatorMul: TButton;
    CalcOperatorDiv: TButton;
    procedure Number0Click(Sender: TObject);
    procedure Number1Click(Sender: TObject);
    procedure Number2Click(Sender: TObject);
    procedure Number3Click(Sender: TObject);
    procedure Number4Click(Sender: TObject);
    procedure Number5Click(Sender: TObject);
    procedure Number6Click(Sender: TObject);
    procedure Number7Click(Sender: TObject);
    procedure Number8Click(Sender: TObject);
    procedure Number9Click(Sender: TObject);
    procedure NumberEqualClick(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure CalcOperatorAddClick(Sender: TObject);
    procedure CalcOperatorDivClick(Sender: TObject);
    procedure CalcOperatorMinClick(Sender: TObject);
    procedure CalcOperatorMulClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1          : TForm1;
  NumInput       : integer;
  SkipToCalc2    : boolean;
  ToCalc1        : string;
  ToCalc2        : string;
  ToCalc1Int     : integer;
  ToCalc2Int     : integer;
  ToCalcOperator : char;

implementation

{$R *.lfm}

{ TForm1 }

//Functions
(*******************************************************************)
//check if SkipToCalc2 is true or false and add the input to the correct side
//of the operator
function calcnumber(x:string):string;
begin
     if SkipToCalc2 = false then
        begin
             ToCalc1 := ToCalc1 + x;
        end
     else
         begin
              ToCalc2                   := ToCalc2 + x;
              Form1.NumberEqual.Enabled := true;
         end;
end;

//set calculation operator and sort new numbers to the right side of the operator
function calcoperator(x:char):string;
begin
     ToCalcOperator            := x;
     SkipToCalc2               := true;
     Form1.Label1.caption      := Form1.Label1.caption + ' ' + x + ' ';
end;

function buttonstate(state:boolean):string;
begin
     Form1.CalcOperatorAdd.Enabled := state;
     Form1.CalcOperatorMin.Enabled := state;
     Form1.CalcOperatorMul.Enabled := state;
     Form1.CalcOperatorDiv.Enabled := state;
end;

//Number buttons
(*******************************************************************)
procedure TForm1.Number0Click(Sender: TObject);
begin
     Label1.caption := Label1.caption + '0';
     calcnumber('0');
end;

procedure TForm1.Number1Click(Sender: TObject);
begin
     Label1.caption := Label1.caption + '1';
     calcnumber('1');
end;

procedure TForm1.Number2Click(Sender: TObject);
begin
     Label1.caption := Label1.caption + '2';
     calcnumber('2');
end;

procedure TForm1.Number3Click(Sender: TObject);
begin
     Label1.caption := Label1.caption + '3';
     calcnumber('3');
end;

procedure TForm1.Number4Click(Sender: TObject);
begin
     Label1.caption := Label1.caption + '4';
     calcnumber('4');
end;

procedure TForm1.Number5Click(Sender: TObject);
begin
     Label1.caption := Label1.caption + '5';
     calcnumber('5');
end;

procedure TForm1.Number6Click(Sender: TObject);
begin
     Label1.caption := Label1.caption + '6';
     calcnumber('6');
end;

procedure TForm1.Number7Click(Sender: TObject);
begin
     Label1.caption := Label1.caption + '7';
     calcnumber('7');
end;

procedure TForm1.Number8Click(Sender: TObject);
begin
     Label1.caption := Label1.caption + '8';
     calcnumber('8');
end;

procedure TForm1.Number9Click(Sender: TObject);
begin
     Label1.caption := Label1.caption + '9';
     calcnumber('9');
end;

(*******************************************************************)

//Calculation operators
procedure TForm1.CalcOperatorAddClick(Sender: TObject);
begin
     calcoperator('+');
     buttonstate(false);
end;

procedure TForm1.CalcOperatorMinClick(Sender: TObject);
begin
     calcoperator('-');
     buttonstate(false);
end;

procedure TForm1.CalcOperatorMulClick(Sender: TObject);
begin
     calcoperator('*');
     buttonstate(false);
end;

procedure TForm1.CalcOperatorDivClick(Sender: TObject);
begin
     calcoperator('/');
     buttonstate(false);
end;

(*******************************************************************)

//Calculate
procedure TForm1.NumberEqualClick(Sender: TObject);
begin
     //before calculating check if a operator has been selected to prevent error
     if SkipToCalc2 then
     begin
        ToCalc1Int := StrToInt(ToCalc1);
        ToCalc2Int := StrToInt(ToCalc2);

        if ToCalcOperator = '+' then
           Label2.caption := IntToStr(ToCalc1Int + ToCalc2Int)
        else if ToCalcOperator = '-' then
           Label2.caption := IntToStr(ToCalc1Int - ToCalc2Int)
        else if ToCalcOperator = '*' then
             Label2.caption := IntToStr(ToCalc1Int * ToCalc2Int)
        else if ToCalcOperator = '/' then
             begin
                  //You used a zero for division? Don't you dare!
                  if ToCalc2 = '0' then
                     begin
                          ShowMessage('You can`t divide with zero!');
                          exit;
                     end;

                  Label2.caption := FloatToStr(ToCalc1Int / ToCalc2Int)
                  //output of / is a real
                  //http://wiki.freepascal.org/Assignment_and_Operations
             end;
        end;
end;

(*******************************************************************)

//Clear calculation
procedure TForm1.ClearClick(Sender: TObject);
begin
     ToCalc1             := '';
     ToCalc2             := '';
     ToCalc1Int          := 0;
     ToCalc2Int          := 0;
     SkipToCalc2         := false;
     Label1.caption      := '';
     Label2.caption      := '';
     NumberEqual.Enabled := false;
     buttonstate(true);
end;

end.

