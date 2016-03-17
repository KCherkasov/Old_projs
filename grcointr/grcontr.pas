unit grcontr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, WorldTypes, WorldThread;

type
  TfrmGrContr = class(TForm)
    imgPlayer: TImage;

    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    NPCs: TWorldArray;
    { Public declarations }
  end;

var
  frmGrContr: TfrmGrContr;

  thrd: TWorld;

procedure move (Key: Char);
function name_form (pref: string; n: Byte; ex: string): string;

implementation

{$R *.dfm}

procedure move (Key: Char);
const STEP = 5;
begin
  case Key of
    'w','W':
      begin
        if (frmGrContr.imgPlayer.Top) > STEP then
          frmGrContr.imgPlayer.Top:= frmGrContr.imgPlayer.top - STEP;
      end;
    'a','A':
      begin
        if (frmGrContr.imgPlayer.Left) > STEP then
          frmGrContr.imgPlayer.Left:= frmGrContr.imgPlayer.Left - STEP;
      end;
    's','S':
      begin
        if (frmGrContr.Height - frmGrContr.imgPlayer.Top - Round(1.4*frmGrContr.imgPlayer.Height)) > (step) then
          frmGrContr.imgPlayer.Top:= frmGrContr.imgPlayer.top + STEP;
      end;
    'd','D':
      begin
        if (frmGrContr.Width - frmGrContr.imgPlayer.Left - Round(1.2*frmGrContr.imgPlayer.Width)) > (step) then
          frmGrContr.imgPlayer.Left:= frmGrContr.imgPlayer.Left + STEP;
      end;
    'q','Q':
      begin
        if  ((frmGrContr.imgPlayer.Top) > STEP) and ((frmGrContr.imgPlayer.Left) > STEP) then
        begin
          frmGrContr.imgPlayer.Top:= frmGrContr.imgPlayer.top - STEP;
          frmGrContr.imgPlayer.Left:= frmGrContr.imgPlayer.Left - STEP;
        end;
      end;
    'e','E':
      begin
        if ((frmGrContr.imgPlayer.Top) > STEP) and ((frmGrContr.Width - frmGrContr.imgPlayer.Left - Round(1.2*frmGrContr.imgPlayer.Width)) > (step)) then
        begin
          frmGrContr.imgPlayer.Top:= frmGrContr.imgPlayer.top - STEP;
          frmGrContr.imgPlayer.Left:= frmGrContr.imgPlayer.Left + STEP;
        end;
      end;
    'z','Z':
      begin
        if ((frmGrContr.Height - frmGrContr.imgPlayer.Top - Round(1.4*frmGrContr.imgPlayer.Height)) > (step)) and ((frmGrContr.imgPlayer.Left) > STEP) then
        begin
          frmGrContr.imgPlayer.Top:= frmGrContr.imgPlayer.top + STEP;
          frmGrContr.imgPlayer.Left:= frmGrContr.imgPlayer.Left - STEP;
        end;
      end;
    'c','C':
      begin
        if ((frmGrContr.Height - frmGrContr.imgPlayer.Top - Round(1.4*frmGrContr.imgPlayer.Height)) > (step)) and ((frmGrContr.Width - frmGrContr.imgPlayer.Left - Round(1.2*frmGrContr.imgPlayer.Width)) > (step)) then
        begin
          frmGrContr.imgPlayer.Top:= frmGrContr.imgPlayer.top + STEP;
          frmGrContr.imgPlayer.Left:= frmGrContr.imgPlayer.Left + STEP;
        end;
      end;
  end;
end;

function name_form(pref: string; n: Byte; ex: string): string;
begin
  result:= pref + IntToStr(n) + ex;
end;

procedure TfrmGrContr.FormCreate(Sender: TObject);
const NPC_SIZE = 19;
var i: Byte;
begin
  for i:=0 to NPC_SIZE-1 do
  begin
    NPCs[i]:= TImage.Create(frmGrContr);
    NPCs[i].Parent:= frmGrContr;
    NPCs[i].Width:= 105;
    NPCs[i].Height:= 105;
    NPCs[i].Left:= Random(frmGrContr.Width div 2 - NPCs[i].Width) + NPCs[i].Width;
    NPCs[i].Top:= Random(frmGrContr.Height div 2 - NPCs[i].Height) + NPCs[i].Height;
    NPCs[i].Picture.LoadFromFile(name_form('npc_',(Random(7)+1),'.bmp'));
  end;
    imgPlayer.Picture.LoadFromFile('player.bmp');
  imgPlayer.Top:= frmGrContr.Height div 2 - imgPlayer.Height div 2;
  imgPlayer.Left:= frmGrContr.Width div 2 - imgPlayer.Width div 2;
  thrd:= TWorld.Create(NPCs, frmgrcontr.width, frmgrcontr.height);
  thrd.Resume;
  thrd.Priority:= tpLower;
  thrd.FreeOnTerminate:= True;
end;

procedure TfrmGrContr.FormKeyPress(Sender: TObject; var Key: Char);
begin
  move(Key);
end;

procedure TfrmGrContr.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  thrd.Terminate;
end;

end.
