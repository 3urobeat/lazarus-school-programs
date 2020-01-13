//Autor: Tom
//Beschreibung: Glückspielprogramm, Gewinne basierend auf Augenzahlen von gerolltem Würfel.
//Besonderheiten: Guthabenkonto, Einsatz und mehrfaches würfeln mit einem Klick.

//Notiz: Die Gewinnchancen sind eindeutig zu hoch. So gehen sie noch bankrupt!

unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, ComCtrls, Menus, ExtCtrls, EditBtn;

type

  { TForm1 }

  TForm1 = class(TForm)
    Dice12: TImage;
    Dice21: TImage;
    Dice22: TImage;
    Dice31: TImage;
    Dice32: TImage;
    Dice41: TImage;
    Dice42: TImage;
    Dice51: TImage;
    Dice52: TImage;
    Dice61: TImage;
    Dice62: TImage;
    einsatz: TEdit;
    Dice11: TImage;
    Label2: TLabel;
    Label3: TLabel;
    gewinnzahl: TLabel;
    Label5: TLabel;
    MenuItem5: TMenuItem;
    StatusBar1: TStatusBar;
    wuerfelcountedit: TEdit;
    ListBox1: TListBox;
    mal2: TButton;
    mal4: TButton;
    mal6: TButton;
    malmax: TButton;
    roll: TButton;
    auszahlen: TButton;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    guthaben: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    ProgressBar1: TProgressBar;
    geldbutton: TButton;
    geldedit: TEdit;
    plus10roll: TButton;
    procedure auszahlenClick(Sender: TObject);
    procedure mal2Click(Sender: TObject);
    procedure mal4Click(Sender: TObject);
    procedure mal6Click(Sender: TObject);
    procedure malmaxClick(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure geldbuttonClick(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure plus10rollClick(Sender: TObject);
    procedure rollClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  RandomZahl: integer;
  RandomZahl1: integer;
  RandomZahl2: integer;
  progress  : integer;

implementation

{$R *.lfm}

{ TForm1 }

(*------------------ Functions: ------------------*)
function multieinsatz(x:integer):string;
begin
  try
     //zu hoher einsatz?
     if (StrToFloat(Form1.Einsatz.caption) * x) > 500 then
        begin
             ShowMessage('Sie können maximal 500€ pro roll setzen.');
             exit;
        end;
     if (StrToFloat(Form1.Einsatz.caption) * x) > StrToFloat(Form1.guthaben.caption) then
        begin
             ShowMessage('Sie besitzen nicht genügend Guthaben um diese Summe zu setzen.');
             exit;
        end;
     Form1.Einsatz.caption := FloatToStr(StrToFloat(Form1.Einsatz.text)* x);
  except
     ShowMessage('Bitte Eingabe korrigieren!');
     exit;
  end;
end;



(*------------------ Menü: ------------------*)
procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  ShowMessage('Programm von Tom' + sLineBreak + sLineBreak +'29.08.2019');
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  geldedit.text         := '';
  guthaben.caption      := '0';
  einsatz.text          := '0,50';
  gewinnzahl.caption    := '0';
  wuerfelcountedit.text := '1';
  ListBox1.clear;
  Dice11.visible        := false;
  Dice21.visible        := false;
  Dice31.visible        := false;
  Dice41.visible        := false;
  Dice51.visible        := false;
  Dice61.visible        := false;
  Dice12.visible        := false;
  Dice22.visible        := false;
  Dice32.visible        := false;
  Dice42.visible        := false;
  Dice52.visible        := false;
  Dice62.visible        := false;
  progressbar1.position := 0;
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
     ShowMessage('Eine zufällige Zahl wird von 1 bis 12 gewürfelt.' + sLineBreak + sLineBreak + '1-6: Sie haben leider ihren Einsatz verloren.' + sLineBreak + '7-9: Einsatz gewonnen!' + sLineBreak + '10:   Einsatz x2 gewonnen!' + sLineBreak + '11:   Einsatz x3 gewonnen!' + sLineBreak + '12:   Einsatz x4 gewonnen!');
end;


(*------------------ Programm Prozeduren: ------------------*)
//Guthaben hinzufügen:
procedure TForm1.geldbuttonClick(Sender: TObject);
begin
  try
     if (StrToFloat(guthaben.caption) + StrToFloat(geldedit.text)) > 100000 then
        begin
             ShowMessage('Der maximale Guthabenstand beträgt 100000.');
             exit;
        end;
     if StrToFloat(geldedit.text) < 0.50 then
        begin
             ShowMessage('Minimaler Betrag ist 0,50€!');
             exit;
        end;
     guthaben.caption := FloatToStr(StrToFloat(geldedit.text) + StrToFloat(guthaben.caption));
     geldedit.text    := '';
  except
     ShowMessage('Bitte Eingabe korrigieren!');
     exit;
  end;
end;

//einsatz x2
procedure TForm1.mal2Click(Sender: TObject);
begin
     multieinsatz(2);
end;

//einsatz x4
procedure TForm1.mal4Click(Sender: TObject);
begin
     multieinsatz(4);
end;

//einsatz x4
procedure TForm1.mal6Click(Sender: TObject);
begin
     multieinsatz(6);
end;

//einsatz max
procedure TForm1.malmaxClick(Sender: TObject);
begin
  try
     if StrToFloat(guthaben.caption) > 500 then
        Einsatz.text := '500'
     else
        Einsatz.text := guthaben.caption;
  except
     ShowMessage('Bitte Eingabe korrigieren!');
     exit;
  end;
end;

//+10 rollen
procedure TForm1.plus10rollClick(Sender: TObject);
begin
  try
     if (StrToInt(wuerfelcountedit.text) + 10) > 499 then
        begin
             ShowMessage('Maximale Anzahl gleichzeitiger Würfelversuche liegt bei 499.');
             exit;
        end;
     if (StrToFloat(einsatz.text) * (StrToInt(wuerfelcountedit.text) + 10)) > StrToFloat(guthaben.caption) then
        begin
             ShowMessage('Um ' + IntToStr(StrToInt(wuerfelcountedit.text) + 10) + ' mal zu würfeln, benötigen sie ' + FloatToStr(StrToFloat(einsatz.text) * (StrToInt(wuerfelcountedit.text) + 10)) + '€ auf ihrem Guthabenkonto!');
             exit;
        end;
     wuerfelcountedit.text := IntToStr(StrToInt(wuerfelcountedit.text) + 10);
  except
     ShowMessage('Bitte Eingabe korrigieren!');
     exit;
  end;
end;

//Rollen:
procedure TForm1.rollClick(Sender: TObject);
begin
  try
     //zu viele kommastellen im einsatz? kürzen.
     if Length(einsatz.text) > 4 then
        einsatz.text := Copy(einsatz.text, 1, 4) + '0';
     //zu viele rolls?
     if (StrToInt(wuerfelcountedit.text)) > 499 then
        begin
             ShowMessage('Maximale Anzahl gleichzeitiger Würfelversuche liegt bei 499.');
             exit;
        end;
     //zu geringer einsatz?
     if StrToFloat(einsatz.text) < 0.50 then
        begin
             ShowMessage('Bitte setzen sie mindestends 0,50€!');
             exit;
        end;
     //zu hoher einsatz?
     if StrToFloat(einsatz.text) > 500 then
        begin
             ShowMessage('Sie können maximal 500€ pro roll setzen.');
             exit;
        end;
     //nicht genügend guthaben?
     if (StrToFloat(einsatz.text) * StrToInt(wuerfelcountedit.text)) > StrToFloat(guthaben.caption) then
        begin
             ShowMessage('Sie besitzen nicht genügend Guthaben um mit dieser Summe ' + wuerfelcountedit.text + ' mal zu würfeln.' + sLineBreak + 'Um ' + wuerfelcountedit.text + ' mal zu würfeln, benötigen sie ' + FloatToStr(StrToFloat(einsatz.text) * StrToInt(wuerfelcountedit.text)) + '€ auf ihrem Guthabenkonto!');
             exit;
        end;
     //mehr als 4 rolls bestätigen
     if StrToInt(wuerfelcountedit.text) > 4 then
        begin
             if MessageDlg('Bei klicken auf Ja bestätigen sie ' + wuerfelcountedit.Text + ' rolls.' + sLineBreak +  'Bei einem Einsatz von ' + einsatz.text + '€ werden ' + wuerfelcountedit.text + ' rolls sie ' + FloatToStr(StrToFloat(einsatz.text) * StrToFloat(wuerfelcountedit.text)) + '€ kosten.', mtConfirmation, [mbYes,mbNo], 0) = mrNo then
                exit;
        end;

     //einsatz abziehen
     Guthaben.caption := FloatToStr(StrToFloat(Guthaben.caption) - StrToFloat(Einsatz.caption));

     //alle bilder invisible setzen
     Dice11.visible        := false;
     Dice21.visible        := false;
     Dice31.visible        := false;
     Dice41.visible        := false;
     Dice51.visible        := false;
     Dice61.visible        := false;
     Dice12.visible        := false;
     Dice22.visible        := false;
     Dice32.visible        := false;
     Dice42.visible        := false;
     Dice52.visible        := false;
     Dice62.visible        := false;

     progressbar1.position := 0;
     progress := 100 div StrToInt(wuerfelcountedit.text);

     //loop mit wuerfelcountedit.text
     while StrToInt(wuerfelcountedit.text) <> 0 do
     begin
           Randomize;
           RandomZahl1 := Random(6) + 1;
           RandomZahl2 := Random(6) + 1;
           RandomZahl  := RandomZahl1 + Randomzahl2;
           geldedit.text := IntToStr(RandomZahl1);
           gewinnzahl.caption := IntToStr(RandomZahl);
           progressbar1.position := progressbar1.position + progress;

           case RandomZahl1 of
                1:
                   Dice11.Visible := true;
                2:
                   Dice21.Visible := true;
                3:
                   Dice31.Visible := true;
                4:
                   Dice41.Visible := true;
                5:
                   Dice51.Visible := true;
                6:
                   Dice61.Visible := true;
           end;

           case RandomZahl2 of
                1:
                   Dice12.Visible := true;
                2:
                   Dice22.Visible := true;
                3:
                   Dice32.Visible := true;
                4:
                   Dice42.Visible := true;
                5:
                   Dice52.Visible := true;
                6:
                   Dice62.Visible := true;
           end;

           case RandomZahl of
                1..6:
                  begin
                       ListBox1.Items.Insert(0, '-' + einsatz.text);
                  end;
                7..9:
                  begin
                       guthaben.caption := FloatToStr(StrToFloat(einsatz.caption) + StrToFloat(guthaben.caption));
                       ListBox1.Items.Insert(0, einsatz.text);
                  end;
                10:
                   begin
                        guthaben.caption := FloatToStr(StrToFloat(einsatz.caption) * 2 + StrToFloat(guthaben.caption));
                        ListBox1.Items.Insert(0, FloatToStr(StrToFloat(einsatz.text) * 2));
                   end;
                11:
                   begin
                        guthaben.caption := FloatToStr(StrToFloat(einsatz.caption) * 3 + StrToFloat(guthaben.caption));
                        ListBox1.Items.Insert(0, FloatToStr(StrToFloat(einsatz.text) * 3));
                   end;
                12:
                   begin
                        guthaben.caption := FloatToStr(StrToFloat(einsatz.caption) * 4 + StrToFloat(guthaben.caption));
                        if wuerfelcountedit.text = '1' then
                           ShowMessage('Jackpot!' + sLineBreak + 'Sie haben ' + FloatToStr(StrToFloat(einsatz.caption) * 4) + '€ gewonnen!' + sLineBreak + 'Neuer Guthabenstand: ' + guthaben.caption + '€');
                        ListBox1.Items.Insert(0, FloatToStr(StrToFloat(einsatz.text) * 4) + ' - Jackpot!');
                   end;
           end;

           //wuerfelcount einen abziehen
           wuerfelcountedit.text := IntToStr(StrToInt(wuerfelcountedit.text) - 1);

           if ListBox1.Items.Count > 100 then
              begin
                   ListBox1.Items.Delete(100);
              end;

           //Sleep, da sonst Ergebnisse doppelt nacheinander vorkommen
           Sleep(25);
     end;

     //set to 1 after loop
     wuerfelcountedit.text := '1';
  except
       ShowMessage('Bitte Eingabe korrigieren!');
       exit;
  end;
end;

//auszahlen
procedure TForm1.auszahlenClick(Sender: TObject);
begin
     if StrToFloat(guthaben.caption) = 0 then
        begin
             ShowMessage('Sie haben nichts auf ihrem Guthabenkonto.');
             exit;
        end;
     ShowMessage(guthaben.Caption + '€ sind von ihrem Guthabenkonto verschwunden.' + sLineBreak + 'Fügen sie neues Guthaben hinzu um wieder zu spielen.');
     guthaben.caption := '0';
end;

end.
