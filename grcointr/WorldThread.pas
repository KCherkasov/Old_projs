unit WorldThread;

interface

uses
  Classes, WorldTypes, Windows, SysUtils;

type
  TWorld = class(TThread)
  private
    w: Integer;
    h: integer;
    NPCs: TWorldArray;
    procedure WorldMove{(NPCs:TWorldArray; w,h:Integer)};
  protected

    procedure Execute; override;
  public
  constructor create (iNPCs: TWorldArray; iw,ih: integer); overload;
  end;

  TWMMoving = record
    Msg: Cardinal;
    fwSide: Cardinal;
    lpRect: PRect;
    Result: Integer;
  end;

implementation

 constructor TWorld.create(iNPCs: TWorldArray; iw,ih: integer);
begin
  inherited create(False);
  FreeOnTerminate:=False;
  NPCs:= iNPCs;
  w:= iw;
  h:= ih;
end;

procedure TWorld.WorldMove {NPCs: TWorldArray; w,h: integer)};
const
  step1 = 0;
  step2 = 25;
  step3 = 50;
  step4 = 75;
  step5 = 100;
  shft = 10;
var
  i,k: integer;
  rnd: Byte;
  //w,h: Integer;
  //msg: TWMMoving;
begin
  k:= Length(NPCs) - 1;
  for i:=0 to k do
  begin
    Randomize;
    rnd:= Random(101);
    if (rnd >= step1) and (rnd < step2)then //
    begin
      if (NPCs[i].Top >= shft) then
        NPCs[i].Top:=NPCs[i].Top - shft;
    end
    else
      if (rnd >= step2)and(rnd < step3) then  //
      begin
        if (NPCs[i].Top <= (h-NPCs[i].Height-shft)) then
          NPCs[i].Top:= NPCs[i].Top + shft;
      end
      else
        if (rnd >= step3) and (rnd < step4) then  //
        begin
          if (NPCs[i].Left >= shft) then
            NPCs[i].Left:= NPCs[i].Left - shft;
        end
        else
          if (rnd >= step4) and (rnd <= step5) then  //
          begin
            if (NPCs[i].Left <= (w-NPCs[i].Left-shft)) then
              NPCs[i].Left:= NPCs[i].Left + shft;
          end;
  end;
  Sleep(100);
end;

procedure TWorld.Execute;
begin
  { Place thread code here }
  while True Do
  begin
    WorldMove;
    if terminated then Exit;
  end;
end;



end.
