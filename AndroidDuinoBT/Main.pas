unit Main;

interface

{$IF defined(Win32) or defined(Win64)}
  {$DEFINE Windows}
{$ENDIF}

{$DEFINE UseAndroidBlueTooth}


{$DEFINE NewCommand}
//{$DEFINE SteppingColor}
//{$DEFINE WifiUdp}
//{$DEFINE BlueTooth}



uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.Threading,
  {$IFDEF Windows}
  System.Win.Registry, WinApi.Windows,
  {$ENDIF}
  {$IFDEF Android}
  //{$IFDEF Ver280} Android.JNI.Toast, {$ENDIf}
  {$ENDIF}
  Math,

  {$IFDEF VER300}
  FMX.ScrollBox,
  {$ENDIF}

  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Memo, FMX.TabControl, FMX.ListBox,
  FMX.Controls.Presentation, FMX.Edit, FMX.ComboEdit,
  FMX.Objects,

  System.Sensors, System.Sensors.Components,


  {$IFDEF WifiUdp}
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient,
  {$ENDIF}
  {$IFDEF BlueTooth}
     {$IFDEF UseAndroidBlueTooth}
     AndroidBlueToothManage,
     {$ELSE}
     WirelessBlueToothManage,
     {$ENDIF}
  {$ENDIF}


  RenderBoxFMX,


  // /WebLib ----------------------------------------------
  OpenViewUrl,

  // RastLib -----------------------------------------------
  RastTypeDefine, RastManage,RastPaint, RastCanvasPaint,

  // M2dLib -------------------------------------------
  M2dTypeDefine, M2dGVariable,

  {$IFDEF Windows}
  WinComportManage,
  {$ENDIF}

  MscMessageDefine, StringManage,
  MscUtility, FMX.ScrollBox, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPClient

  ;

type
  TPlayMode =( pmConstColor=0, pmPlayList, pmRandom, pmRambo, pmBlink, pmRGB, pmBreath, pmDistanceSensor, pmXyzSensor,
    pmFinal);
  TValueType = (vtBrightnessLevel=0, vtFinal);

type
  PRgbLed=^TRGBLed;
  TRGBLed=record
    leR,leG,leB:byte;
    leDelayMsec:Cardinal;
  end;
  TRGBLedList = TList; //lis of PRGBLed


{$IFDEF Windows}
  //AnsiString
{$ELSE}
type
  AnsiString = String;
{$ENDIF}
  
type
  TMainForm = class(TForm)
    StyleBook1: TStyleBook;
    IdUDPClient1: TIdUDPClient;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    ImageControl1: TImageControl;
    loSide: TLayout;
    loDiscover: TLayout;
    Layout5: TLayout;
    btnDiscover: TButton;
    btnConnect: TButton;
    ceSendStr: TComboEdit;
    btnSend: TButton;
    lblRasVector: TLabel;
    loUDP: TLayout;
    edIP: TEdit;
    Label4: TLabel;
    edPort: TEdit;
    Label5: TLabel;
    ListBox1: TListBox;
    loPins: TLayout;
    TrackBar3: TTrackBar;
    Switch1: TSwitch;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    RadioButton6: TRadioButton;
    RadioButton7: TRadioButton;
    RadioButton8: TRadioButton;
    RadioButton9: TRadioButton;
    RadioButton10: TRadioButton;
    RadioButton11: TRadioButton;
    RadioButton12: TRadioButton;
    ckbxSwitchAll: TCheckBox;
    TimerReceive: TTimer;
    TabItem2: TTabItem;
    Memo1: TMemo;
    Layout3: TLayout;
    SpeedButton1: TSpeedButton;
    btnGetAnalogInfo: TButton;
    ckbxReceiveLog: TCheckBox;
    TabItem3: TTabItem;
    loRgbSetting: TLayout;
    cbR: TComboBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    Label1: TLabel;
    cbG: TComboBox;
    ListBoxItem7: TListBoxItem;
    ListBoxItem8: TListBoxItem;
    ListBoxItem9: TListBoxItem;
    ListBoxItem10: TListBoxItem;
    ListBoxItem11: TListBoxItem;
    ListBoxItem12: TListBoxItem;
    Label2: TLabel;
    cbB: TComboBox;
    ListBoxItem13: TListBoxItem;
    ListBoxItem14: TListBoxItem;
    ListBoxItem15: TListBoxItem;
    ListBoxItem16: TListBoxItem;
    ListBoxItem17: TListBoxItem;
    ListBoxItem18: TListBoxItem;
    Label3: TLabel;
    btnRgbTest: TButton;
    btnRec: TButton;
    cbDelayMsec: TComboBox;
    cbIdleMsec: TComboBox;
    cbMode: TComboBox;
    tkbarBri: TTrackBar;
    Layout2: TLayout;
    Layout4: TLayout;
    rb0: TRadioButton;
    RadioButton13: TRadioButton;
    RadioButton14: TRadioButton;
    RadioButton15: TRadioButton;
    rbActClr: TRenderBoxFmx;
    sbRgbSettingVisible: TSpeedButton;
    lblColor: TLabel;
    Layout1: TLayout;
    rbMain: TRenderBoxFmx;
    procedure ImageControl1Change(Sender: TObject);
    procedure ImageControl1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);

    procedure btnConnectClick(Sender: TObject);
    procedure btnDiscoverClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure Switch1Click(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure Switch1Switch(Sender: TObject);
    procedure btnGetAnalogInfoClick(Sender: TObject);
    procedure lblRasVectorClick(Sender: TObject);
    procedure lblRasVectorTap(Sender: TObject; const Point: TPointF);
    procedure rbMainLongTimeDown(Sender: TObject; X, Y: Single);
    procedure rbMainMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure rbMainMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure rbMainRender(Sender: TObject; const RenderBmp: TBitmap);
    procedure rbMainRenderCanvasResize(const RenderBmp: TBitmap);
    procedure rbActClrRender(Sender: TObject; const RenderBmp: TBitmap);
    procedure rbMainResize(Sender: TObject);
    procedure rbActClrMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure TrackBar3Enter(Sender: TObject);
    procedure ValueLevelChange(Sender: TObject);
    procedure btnRgbTestClick(Sender: TObject);
    procedure ckbxReceiveLogChange(Sender: TObject);
    procedure btnRecClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rbActClrPaint(Sender: TObject; Canvas: TCanvas);
    procedure cbDelayMsecChange(Sender: TObject);
    procedure cbRChange(Sender: TObject);
    procedure sbRgbSettingVisibleClick(Sender: TObject);
    procedure cbIdleMsecChange(Sender: TObject);
    procedure cbModeChange(Sender: TObject);
    procedure tkbarBriChange(Sender: TObject);
    procedure TimerReceiveTimer(Sender: TObject);
    { Private declarations }

  private
    FPinR,FPinG,FPinB:byte;
    FPinID : byte;
    FActR,FActG,FActB, FPriR,FPriG,FPriB:byte;
    FMainBitDataMapped:boolean;
    FMainBitData:TBitmapData;
    FActColor: TColor;
    FSaturationLevel: byte;
    FHueLevel: word;
    FValueLevel: byte;
    FPlayList:TRGBLedList;
    FDoRecord:boolean;
    FPriRecordMsec:Cardinal;


    procedure SetActColor(const Value: TColor);
    function GetBitDataPixels(const aBitData: TBitmapData; X,
      Y: integer): TColor;
    procedure SetBitDataPixels(const aBitData: TBitmapData; X, Y: integer;
      const Value: TColor);
    function GetPixels(const aBmp: TBitmap; X, Y: integer): TColor;
    procedure SetPixels(const aBmp: TBitmap; X, Y: integer;
      const Value: TColor);
    procedure SetHueLevel(const Value: word);
    procedure SetSaturationLevel(const Value: byte);
    procedure SetValueLevel(const Value: byte);

  protected
    procedure CreateMembers;
    procedure InitialMembers;
    procedure ReleaseMembers;

    procedure Initial_PlayList(const aPlyLst:TRgbLedList);
    procedure Add_PlayList(const aPlyLst:TRgbLedList; aR,aG,aB:byte; aDelayMsec:Cardinal);

    // 資料處理 ----------------------------------------------
    function RGB2TColor(aR,aG,aB:byte):TColor;
    procedure UpdateHueSaturation(aDia:integer; X,Y:integer;
      var aHue:word; var aSaturation:byte);


    // 編輯 -------------------------------------------------
    function Send_Command(const sCmd:String):LongBool;
    procedure Send_PlayList(const aPlyLst:TRgbLedList);

    procedure Clear_TRGBLedList(const rgbLst:TRgbLedList);

    // 介面 ----------------------------------------------------
    procedure Initial_Interface;
    procedure RefreshInterface_Resize;
    procedure Paint_Text(const aCanvas:TCanvas; const sTxt:string; blBeginEndScene:boolean=false);

    // 事件 -------------------------------------------
    procedure ProcessReceivedString(Sender:TObject; const aStr:AnsiString);
  public
    { Public declarations }
    property Pixels[const aBmp:TBitmap; X,Y:integer]:TColor read GetPixels write SetPixels;
    property BitDataPixels[const aBitData:TBitmapData; X,Y:integer]:TColor read GetBitDataPixels write SetBitDataPixels;
    property ActColor:TColor read FActColor write SetActColor;

    property HueLevel:word read FHueLevel write SetHueLevel  default 16;
    property SaturationLevel:byte read FSaturationLevel write SetSaturationLevel default 135;
    property ValueLevel:byte read FValueLevel write SetValueLevel default 255;


  end;

var
  MainForm: TMainForm;
  gDebug:integer;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.Windows.fmx MSWINDOWS}

const
  cRGBDiffer = 25;
  cStep = 10;
  cByteStepValue = 255 div cStep;
  cMaxComandCount = 100;

var
  gDelayMsc:Cardinal=200; // Delay 太短(Ex:<=10) 會有誤訊號
  gIdleMsc:Cardinal=10000;
  gPriMouseX,gPriMouseY:integer;
  gPriTkbarValue:integer=255;
  gActId:integer=0;






procedure TMainForm.Add_PlayList(const aPlyLst: TRgbLedList;
  aR,aG,aB:byte; aDelayMsec:Cardinal);
var
  pRL:PRgbLed;
begin

  if (aPlyLst.Count>0) and (aPlyLst.Count>=cMaxComandCount) then
  begin
    aPlyLst.Delete(0);
  end;

  if (aPlyLst.Count>0) then 
  begin
    aDelayMsec:=GetTickCount-FPriRecordMSec;     
    PRgbLed( aPlyLst.Last)^.leDelayMsec := aDelayMsec;
  end;

  FPriRecordMsec:=GetTickCount;

  new(pRL);
  pRl^.leR := aR;
  pRl^.leG := aG;
  pRl^.leB := aB;
  pRl^.leDelayMsec := {$IFDEF ConstantDelay}gDelayMsec{$Else}aDelayMsec{$Endif};

  aPlyLst.Add(pRl);
end;

procedure TMainForm.btnConnectClick(Sender: TObject);
var
  aId:integer;
begin

  {$IFDEF Android}

    {$IFDEF WifiUdp}
    IdUdpClient1.Host := edIp.Text; // '192.168.3.29'; //
    IdUdpClient1.Port :=  StrToInt(edPort.Text); //8087;
    DoToast( format('%s ( %s )...',[gVerbTypeName[vbConnect], edIp.Text ]) );
    loPins.Enabled := true;
    {$ENDIF}

    {$IFDEF BlueTooth}
    aId := ListBox1.ItemIndex;
    if (aId<0) or (aId>=Listbox1.Items.Count) then exit;

{$IFDEF UseAndroidBlueTooth}
    with AndroidBlueToothManager do
    begin
      //DisConnect;
      if (aId>=0) and (aId<BlueToothDevices.Count) then
      if Connect_TBlueToothDevice( PBlueToothDevice(BlueToothDevices[aId])^) then
        loPins.Enabled := true;
    end;
{$ELSE}
{$ENDIF}


    {$ENDIF}
  {$ENDIF}


  {$IFDEF Windows}
  WinComportManager.CloseComport;

  aId := ListBox1.ItemIndex;
  if (aId<0) or (aId>=Listbox1.Items.Count) then exit;

  if WinComportManager.OpenComport(StrToInt(ListBox1.Items[aId])) then
  begin
    WinComportManager.SetupCOMPort(115200, 30, 30); // timeOut 不能設太大，否則會拖慢程式
    loPins.Enabled := true;
  end;
  {$ENDIF}

end;

procedure TMainForm.btnDiscoverClick(Sender: TObject);
var
  s1:string;
  strs:TStringList;
  i: Integer;
begin
  //
  ListBox1.Items.Clear;


  {$IFDEF Android}


{$IFDEF UseAndroidBlueTooth}
  with AndroidBlueToothManager do
  begin
    if Discover_Devices() then
    for i := 0 to BlueToothDevices.Count-1 do
    with PBlueToothDevice(BlueToothDevices[i])^ do
    begin
      ListBox1.Items.Add(btDeviceName);
    end;

    if ListBox1.Items.Count>0 then
      DoToast( format('%s %s a Device!',[
         gAdverbTypeName[avPlease], gVerbTypeName[vbConnect]
            ]));
  end;
{$ELSE}
{$ENDIF}


  {$ENDIF}

  {$IFDEF Windows}
  try
    strs:=TStringList.Create;

    WinComportManager.EnumComPorts(strs);

    {$IFDEF Debug}
    s1:='';
    for i := 0 to strs.Count-1 do
      s1:=s1+strs[i]+#13;
    //ShowMessage(s1);
    {$ENDIF}

    if strs.Count>0 then
    begin
      ListBox1.Items.Clear;
      for i := 0 to strs.Count-1 do
        ListBox1.Items.Add( copy(strs[i],4, length(strs[i])-3));

      ListBox1.ItemIndex := 0;
    end;

  finally
    strs.Free;
  end;
  {$ENDIF}

end;

procedure TMainForm.btnGetAnalogInfoClick(Sender: TObject);
var
  i:byte;
  aValue:byte;
  sCmd:String;
begin

  //if (ckbxGetAnalogPins.IsChecked) then aValue:=1
  //else aValue:=0;
  aValue:=1;

  for i := 0 to 5 do
  begin
    sCmd := format('A,%d,%d', [i,aValue]);
    Send_Command(sCmd);
  end;

  ceSendStr.Text := sCmd;

end;

procedure TMainForm.btnRecClick(Sender: TObject);
begin

  FDoRecord := not FDoRecord;
  if FDoRecord then
  begin
    Clear_TRGBLedList(FPlayList);
    btnRec.Text := 'Stop'
  end
  else
  begin
    btnRec.Text := 'Rec';
    DoToast( format('Play Count : %d', [FPlayList.Count]) );
  end;

end;

procedure TMainForm.btnRgbTestClick(Sender: TObject);
var
  aStep,stpVal,aR,aG,aB:byte;
  sR,sG,sB,sCmd:string;
begin

  {FPinR := StrToInt(Copy(cbR.Items[cbR.ItemIndex], 2,1));
  FPinB := StrToInt(Copy(cbB.Items[cbB.ItemIndex], 2,1));
  FPinG := StrToInt(Copy(cbG.Items[cbG.ItemIndex], 2,1)); }


  DoToast( format('Play Count : %d', [FPlayList.Count]) );
  Send_PlayList(FPlayList);


  btnRec.Text := 'Rec';
end;

procedure TMainForm.btnSendClick(Sender: TObject);
begin
  Send_Command(ceSendStr.Text);
end;

procedure TMainForm.cbRChange(Sender: TObject);
begin

  FPinR := StrToInt(Copy(cbR.Items[cbR.ItemIndex], 2,1));
  FPinB := StrToInt(Copy(cbB.Items[cbB.ItemIndex], 2,1));
  FPinG := StrToInt(Copy(cbG.Items[cbG.ItemIndex], 2,1));


  Send_Command( format('P,%d,%d,%d', [FPinR,FPinG,FPinB]));

end;

procedure TMainForm.ckbxReceiveLogChange(Sender: TObject);
var
  aStr:AnsiString;
begin
{$IFDEF Windows}
  if ckbxReceiveLog.IsChecked then
    WinComportManager.OnReadString := Self.ProcessReceivedString
  else
    WinComportManager.OnReadString := nil;
{$ENDIF}

{$IFDEF Android}
  TimerReceive.Enabled := ckbxReceiveLog.IsChecked;


  {$IFDEF BlueTooth}

{$IFDEF UseAndroidBlueTooth}
  if ckbxReceiveLog.IsChecked then   //Thread 會造成 Android App Hang 住
    AndroidBlueToothManager.OnReadString := Self.ProcessReceivedString
  else
    AndroidBlueToothManager.OnReadString := nil;
{$ELSE}
{$ENDIF}


  {$ENDIF}
{$ENDIF}

end;

procedure TMainForm.cbDelayMsecChange(Sender: TObject);
var
  aId:integer;
begin
  aId := TComboBox(Sender).ItemIndex;

  case aId of
  0:;
  1: gDelayMsc:=100;
  2: gDelayMsc:=200;
  3: gDelayMsc:=300;
  4: gDelayMsc:=400;
  5: gDelayMsc:=500;
  6: gDelayMsc:=700;
  7: gDelayMSc:=1000;
  8: gDelayMSc:=3000;
  9: gDelayMSc:=5000;
  10:gDelayMSc:=10000;
  end;


  Send_Command( format('TD,%d', [gDelayMsc]));

end;

procedure TMainForm.cbIdleMsecChange(Sender: TObject);
var
  aId, aVal:integer;
begin
  aId := TComboBox(Sender).ItemIndex;

  aVal := 1;

  case aId of
  //0:;
  1: aVal:=1;   // 1秒
  2: aVal:=5;   // 5秒
  3: aVal:=10;  // 10秒
  4: aVal:=20;  // 20秒
  5: aVal:=30;    // 30秒
  6: aVal:=60;    // 60 秒
  7: aVal:=120;   // 120秒
  8: aVal:=180;   // 120秒
  9: aVal:=300;   // 120秒
  else
    aVal:=1;
  end;

  gIdleMsc := aVal*1000;

  Send_Command( format('TI,%d', [gIdleMsc]));

  //DoToast(
end;

procedure TMainForm.cbModeChange(Sender: TObject);
var
  aId, aMode:integer;
begin
  aId := TComboBox(Sender).ItemIndex;

  aMode:=aId mod integer(pmFinal);

  Send_Command( format('M,%d', [aMode]));

end;

procedure TMainForm.Clear_TRGBLedList(const rgbLst: TRgbLedList);
var
  i:integer;
begin
  if (nil=rgbLst) or (rgbLst.Count<=0) then exit;
  
  for i := 0 to rgbLst.Count-1 do
    Dispose(  PRGBLed(rgbLst[i]) );

  rgbLst.Clear;
end;

procedure TMainForm.CreateMembers;
begin
  FPlayList := TRgbLedList.Create;

{$IFDEF Windows}
  if ckbxReceiveLog.IsChecked then
    WinComportManager.OnReadString := Self.ProcessReceivedString
  else
    WinComportManager.OnReadString := nil;
{$ELSE}


{$IFDEF UseAndroidBlueTooth}
  {if ckbxReceiveLog.IsChecked then
    AndroidBlueToothManager.OnReadString := Self.ProcessReceivedString
  else
   AndroidBlueToothManager.OnReadString := nil; }
{$ELSE}
{$ENDIF}

{$ENDIF}

end;


procedure TMainForm.FormCreate(Sender: TObject);
var
  i:Integer;
begin
  CreateMembers;
  InitialMembers;

  btnDiscoverClick(Sender);

  {$IFDEF Windows}
  ListBox1.ItemIndex := 0;
  {$ELSE}
  with  ListBox1 do
  for i := 0 to Items.Count-1 do
  begin
    if (Pos('RV', UpperCase(Items[i]))>0)  then
    begin
      ListBox1.ItemIndex := i;
      break;
    end;
  end;
  {$ENDIF}

  btnConnectClick(Sender);

end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  ReleaseMembers;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  RefreshInterface_Resize;
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  i:integer;
begin

  {$if defined(Android)}
  for i := 0 to Listbox1.Items.Count-1 do
  if Pos('HC05_RasVector', ListBox1.Items[i])>0 then
  begin
    ListBox1.ItemIndex := i;
    btnConnectClick(btnConnect);
    break;
  end;
  {$ELSE if defined(Windows)}
  if (ListBox1.Items.Count>0) then
  begin
    ListBox1.ItemIndex := 0;
    btnConnectClick(btnConnect);
  end;
  {$ENDIF}

  RefreshInterface_Resize;
end;

function TMainForm.GetBitDataPixels(const aBitData: TBitmapData; X,
  Y: integer): TColor;
begin
  if FMainBitDataMapped then
    result := aBitData.GetPixel(X,Y)
  else
    result := Pixels[rbMain.RenderCanvas, X,Y];
end;

function TMainForm.GetPixels(const aBmp: TBitmap; X, Y: integer): TColor;
var
  bData:TBitmapData;
begin
  try
    if aBmp.Map(TMapAccess.maRead, bData) then
    begin
      result := bData.GetPixel(X,Y);
    end;
  finally
    aBmp.Unmap(bData);
  end;

end;

procedure TMainForm.ImageControl1Change(Sender: TObject);
begin
  //
end;

procedure TMainForm.ImageControl1Click(Sender: TObject);
begin
  //
end;

procedure TMainForm.InitialMembers;
begin
  layout4.Height := 52;
  Initial_Interface;

  FPinID := 13;

  FPinR := StrToInt(Copy(cbR.Items[cbR.ItemIndex], 2,1));
  FPinB := StrToInt(Copy(cbB.Items[cbB.ItemIndex], 2,1));
  FPinG := StrToInt(Copy(cbG.Items[cbG.ItemIndex], 2,1));

  FValueLevel:=255;

  Initial_PlayList(FPlayList);

end;

procedure TMainForm.Initial_Interface;
begin
  {$IFDEF Android}

    {$IFDEF BlueTooth}
    loUdp.Visible:=false;
    ListBox1.Align := TAlignLayout.Client;
    {$ENDIF}
    {$IFDEF WifiUdp}
    ListBox1.Visible:=false;
    loUdp.Align := TAlignLayout.Client;
    {$ENDIF}

  {$ENDIF}

  {$IFDEF Windows}
    loUdp.Visible:=false;
    ListBox1.Align := TAlignLayout.Client;
  {$ENDIF}

  loRgbSetting.Visible := false;
  TabControl1.TabIndex := 0;
  lblRasVector.HitTest := true; //加上這個才能觸發 lblRasvectorClick();
end;

procedure TMainForm.Initial_PlayList(const aPlyLst: TRgbLedList);
var
  iR,iG,iB:integer;
  aStep,stpVal,aR,aG,aB:byte;
  sR,sG,sB,sCmd:string;
begin
  {FpinR := StrToInt(Copy(cbR.Items[cbR.ItemIndex], 2,1));
  FpinB := StrToInt(Copy(cbB.Items[cbB.ItemIndex], 2,1));
  FpinG := StrToInt(Copy(cbG.Items[cbG.ItemIndex], 2,1)); }

  aStep := 10;
  stpVal := 255 div aStep;

  try
    FDoRecord:=true;

    {$IFDEF Send_Command}
    for iR := 0 to cStep-1 do
    begin
      // Red ---------------------------
      aR := iR*stpVal;
      {$IFDEF NewCommand}
      {$ELSE}
      sCmd := format('D,%d,%d', [FpinR,aR]);
      Send_Command(sCmd); //Sleep(aDelayMsc);
      {$ENDIF}
      for iG := 0 to cStep-1 do
      begin
        // Red ---------------------------
        aG:=iG*stpVal;
      {$IFDEF NewCommand}
      {$ELSE}
        sCmd := format('D,%d,%d', [FpinG,aG]);
        Send_Command(sCmd); //Sleep(aDelayMsc);
      {$ENDIF}
        for iB := 0 to cStep-1 do
        begin
          // Red ---------------------------
          aB := iB*stpVal;
      {$IFDEF NewCommand}
          sCmd := format('C,%d,%d,%d',[aR,aG,aB])); // color,R,G,B,delayMsec
          Send_Command(sCmd); //Sleep(aDelayMsc);
      {$ELSE}
          sCmd := format('D,%d,%d', [FpinB,aB]);
          Send_Command(sCmd); //Sleep(aDelayMsc);
      {$ENDIF}
          Add_PlayList(aPlyLst, aR,aG,aB,gDelayMsc); //Send_Command(sCmd);
        end;
      end;
    end;
    {$ELSE}
    Randomize;
    for iR := 0 to cStep-1 do
    begin
      // Red ---------------------------
      aR := Random(255); // iR*stpVal;
      for iG := 0 to cStep-1 do
      begin
        aG := Random(255); //iG*stpVal;
        for iB := 0 to cStep-1 do
        begin
          // Red ---------------------------
          aB := Random(255); //iB*stpVal;
          ActColor := RGB2TColor(aR,aG,aB);

          Add_PlayList(aPlyLst, aR,aG,aB,gDelayMsc);
        end;
      end;
    end;
    {$ENDIF}
  finally
    FDoRecord := false;
  end;
end;

procedure TMainForm.lblRasVectorClick(Sender: TObject);
begin
  OpenViewUrl.OpenURL(cRasVectorWeb);
end;

procedure TMainForm.lblRasVectorTap(Sender: TObject; const Point: TPointF);
begin
  lblRasVectorClick(Sender);
end;

procedure TMainForm.Paint_Text(const aCanvas: TCanvas; const sTxt: string; blBeginEndScene:boolean);
begin

  with aCanvas do
  begin
    {$IFDEF UsingFMX}
    if blBeginEndScene then
      BeginScene;

    Fill.Color := $FFFFFFFF;
    FillText(
      RectF(0.0,0.0, TextWidth(sTxt), TextHeight(sTxt)),
      sTxt, false, 1, [], // [TFillTextFlag.ftRightToLeft],
      TTextAlign.Leading, TTextAlign.Leading); // .taCenter);

    if blBeginEndScene then
      EndScene;
    {$ELSE}
    SetBkMode(aCanvas.Handle, TRANSPARENT);
    TextOut(2,2,sTxt);
    {$ENDIF}
  end;
end;

procedure TMainForm.ValueLevelChange(Sender: TObject);
const
  cValue:Array[0..3] of byte =
    (64, 128, 196, 255);
var
  aR,aG,aB:byte;
begin
  with TRadioButton(Sender) do
  begin
    FValueLevel := cValue[Tag];
    rbMain.Render;
    
    ar:=GetRValue(BitDataPixels[FMainBitData, gPriMouseX, gPriMouseY]);
    ag:=GetGValue(BitDataPixels[FMainBitData, gPriMouseX, gPriMouseY]);
    ab:=GetBValue(BitDataPixels[FMainBitData, gPriMouseX, gPriMouseY]);

    ActColor := RGB2TColor(aR,aG,aB);
  end;
end;

procedure TMainForm.RadioButton1Click(Sender: TObject);
begin
  FPinID := TRadioButton(Sender).Tag;
  Switch1Click(Switch1);
end;

procedure TMainForm.rbActClrMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
begin
  rbActClr.Render;
end;

procedure TMainForm.rbActClrPaint(Sender: TObject; Canvas: TCanvas);
var
  tmpRect:TRectF;
begin
  with Canvas do
  begin
    Stroke.Color := FActColor;
    Fill.Color := Stroke.Color;
    Fill.Kind := TBrushKind.bkSolid;

    tmpRect:=RectF(0.0,0.0,rbActClr.Width-1,rbActClr.Height-1);
    FillRect(tmpRect, 0.0, 0.0, [], 1.0); // DrawRectangle(tmpRect,1);
  end;
end;

procedure TMainForm.rbActClrRender(Sender: TObject; const RenderBmp: TBitmap);
var
  sVal:string;
  cnvW,cnvH:single;
begin
  exit;

  with RenderBmp.Canvas do
  begin
    cnvW:=RenderBmp.Width;
    cnvH:=RenderBmp.Height;

    {$IFDEF UsingFMX}
    BeginScene;
    {$ENDIf}

    //Clear($FF000000);
    Fill.Color:=FActColor;
    Canvas.FillRect(rectF(0.0,0.0,cnvW,cnvH),0,0,AllCorners,1); //,TCornerType.ctRound);

    sVal :=format('(%3d,%3d,%3d)', [FActR, FActG,FActB]);
    Paint_Text(RenderBmp.Canvas, sVal, false );
    {$IFDEF UsingFMX}
    EndScene;
    {$ENDIf}
  end;
end;

procedure TMainForm.rbMainLongTimeDown(Sender: TObject; X, Y: Single);
var
  aHue:word;
  aSat,aR,aG,aB:byte;
begin
  rbMain.MouseShift := [ssLeft];

  with TRenderBoxFmx(Sender) do
  begin
    //ActColor := rbMain.Canvas.Pixels[X,Y];
    Self.UpdateHueSaturation( round(Min(rbMain.Width,rbMain.Height)), round(X),round(Y), aHue, aSat);
    HueLevel:=aHue; SaturationLevel:=aSat; ValueLevel:=FValueLevel;
    RastManager.ColorHSV2RGB(HueLevel,SaturationLevel,ValueLevel,aR,aG,aB);
    ActColor := RGB2TColor(aR,aG,aB);
  end;

end;

procedure TMainForm.rbMainMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
var
  aHue:word;
  aSat,aR,aG,aB,aVal:byte;
  intx,intY:integer;
begin

  intX:=round(X);
  intY:=round(Y);

  with RastManager do
  begin

    if SameText(Sender.ClassName, 'TRenderBoxFMX') then
    with TRenderBoxFMX(Sender) do
    begin
      {ar:=GetRValue(Pixels[rbMain.RenderCanvas, intX, intY]);
      ag:=GetGValue(Pixels[rbMain.RenderCanvas, intX, intY]);
      ab:=GetBValue(Pixels[rbMain.RenderCanvas, intX, intY]); }
      ar:=GetRValue(BitDataPixels[FMainBitData, intX, intY]);
      ag:=GetGValue(BitDataPixels[FMainBitData, intX, intY]);
      ab:=GetBValue(BitDataPixels[FMainBitData, intX, intY]);

      //Refresh_lblMoveRGB( ar,ag,ab);
{$IFDEF Windows}
      if ( [ssleft]=rbMain.MouseShift) then
{$ENDIF}
      begin
        ActColor := RGB2TColor(aR,aG,aB);

        gPriMouseX := intX;
        gPriMouseY := intY;
        //RastManager.ColorRGB2HSV(aR,aG,aB, aHue,aSat,aVal);
        //HueLevel:=aHue; SaturationLevel:=aSat; ValueLevel:=aVal;
      end;

    end;
  end;

end;

procedure TMainForm.rbMainMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  aHue:word;
  aSat,aR,aG,aB,aVal:byte;
  intX,intY:integer;
begin

  {with TRenderboxFMX(Sender) do
  //if ( [ssleft]=MouseShift) then
  begin
    intX:=round(X); intY:=round(Y);

    //ActColor := rbMain.Canvas.Pixels[X,Y];
    Self.UpdateHueSaturation( round(Min(rbMain.Width,rbMain.Height)), intX, intY, aHue, aSat);
    HueLevel:=aHue; SaturationLevel:=aSat; ValueLevel:=FValueLevel;
    RastManager.ColorHSV2RGB(HueLevel,SaturationLevel,ValueLevel,aR,aG,aB);
    ActColor := RGB2TColor(aR,aG,aB); //aR + aG shl 8 + aB shl 16;
  end;}

  with RastManager do
  begin
    intX:=round(X); intY:=round(Y);

    if SameText(Sender.ClassName, 'TRenderBoxFMX') then
    with TRenderBoxFMX(Sender) do
    begin
      ar:=GetRValue(BitDataPixels[FMainBitData, intX, intY]);
      ag:=GetGValue(BitDataPixels[FMainBitData, intX, intY]);
      ab:=GetBValue(BitDataPixels[FMainBitData, intX, intY]);

      //if ( [ssleft]=rbMain.MouseShift) then
      begin
        ActColor := RGB2TColor(aR,aG,aB);    
           
        gPriMouseX := intX;
        gPriMouseY := intY;
        //RastManager.ColorRGB2HSV(aR,aG,aB, aHue,aSat,aVal);
        //HueLevel:=aHue; SaturationLevel:=aSat; ValueLevel:=aVal;
      end;

    end;
  end;

end;

procedure TMainForm.rbMainRender(Sender: TObject; const RenderBmp: TBitmap);
begin

  RastPainter.Paint_HueSaturationCircle(RenderBmp, FValueLevel, $FF000000);
end;

procedure TMainForm.rbMainRenderCanvasResize(const RenderBmp: TBitmap);
begin

  if FMainBitDataMapped then
  begin
    RenderBmp.Unmap(FMainBitData);
  end;
  FMainBitDataMapped:=false;

  //

  if RenderBmp.Map(TMapAccess.maRead, FMainBitData) then
  begin
    FMainBitDataMapped:=true;
  end;

end;

procedure TMainForm.rbMainResize(Sender: TObject);
begin
  rbMain.Render;
end;

procedure TMainForm.RefreshInterface_Resize;
  procedure subRefreshInterface_Horizontal;
  var
    aSize:Single;
  begin
    aSize:=Self.Width / 2 ;
    loSide.Width := aSize;
    loSide.Align := TAlignLayOut.Right;
  end;
  procedure subRefreshInterface_Vertical;
  var
    aSize:Single;
  begin
    aSize := Self.Height / 2;
    loSide.Height := aSize;
    loSide.Align := TAlignLayOut.Top;
  end;
begin


  loSide.Align := TAlignLayOut.None;
  TabControl1.Align := TAlignLayout.None;

  if (Self.width<Self.Height) then
    subRefreshInterface_Vertical
  else
    subRefreshInterface_Horizontal;

  TabControl1.Align := TAlignLayout.Client;

  rbMain.Render;
end;

procedure TMainForm.ReleaseMembers;
begin
  Clear_TRgbLedList(FPlayList);
  FPlayList.Free;

  {$IFDEF Windows}
  WinComportManager.CloseComport;
  {$ENDIF}


end;

function TMainForm.RGB2TColor(aR, aG, aB: byte): TColor;
begin

  {$IFDEF UsingFMX}
  result := aB + aG shl 8 + aR shl 16;
  {$ELSE}
  result := aR + aG shl 8 + aB shl 16;
  {$ENDIF}
  result := $FF000000 or result;
end;

procedure TMainForm.sbRgbSettingVisibleClick(Sender: TObject);
begin
  loRgbSetting.Visible := not loRgbSetting.Visible;
end;

function TMainForm.Send_Command(const sCmd: String): LongBool;
var
  s1:{$IFDEF Windows}AnsiString{$ELSE}String{$ENDIF};
begin
  result := false;
  if (''=sCmd) then exit;

  {$IFDEF Android}

    {$IFDEF WifiUdp}
    IdUdpClient1.Send(sCmd);
    {$ENDIF}
    {$IFDEF BlueTooth}

{$IFDEF UseAndroidBlueTooth}
  with AndroidBlueToothManager do
  if Send_String(sCmd) then
  begin
    //DoToast(sCmd);
    result:=true;
  end
  else
    DoToast( format('%s "%s" %s!',[gVerbTypeName[vbExport], ceSendStr.Text, gNounTypeName[ntError] ]));
{$ELSE}
{$ENDIF}

    {$ENDIf}
  {$ENDIF}

  Sleep(20);


  {$IFDEF Windows}
  s1 := AnsiString(sCmd+#13+#10);
  WinComportManager.SendText(s1);
  {$ENDIF}
end;

procedure TMainForm.Send_PlayList(const aPlyLst: TRgbLedList);
var
  i:integer;
  sDiv:string;
  incNum:integer;
  aStrs:T256Strings;
begin
  if (nil=aPlyLst) or (aPlyLst.Count<=0) then exit;

  {$IFDEF Windows}
  if (WinComportManager.IsConnected) then
  {$ENDIf}



  {$IFDEF Android}

{$IFDEF UseAndroidBlueTooth}
  with AndroidBlueToothManager do
  if IsConnected then
{$ELSE}
{$ENDIF}

  {$ENDIF}
  begin
    Send_Command(format('M,%d', [ integer(pmConstColor)]));  Sleep(100);
    Send_Command('RS'); Sleep(100);
    with StringManager do
    for i := 0 to aPlyLst.Count-1 do
    with PRgbLed( aPlyLst[i])^ do
    begin

      {$IFDEF NewCommand}
      Send_Command(format('C,%d,%d,%d,%d', [leR,leG,leB,leDelayMsec]));
      {$ELSE}
      Send_Command(format('D,%d,%d',[FPinR,leR]));
      Send_Command(format('D,%d,%d',[FPinG,leG]));
      Send_Command(format('D,%d,%d',[FPinB,leB]));
      {$ENDIF}
      Sleep( 20); //gDelayMsc );
    end;
    Sleep(100);
    Send_Command('RE');  Sleep(100);
    Send_Command(format('M,%d', [integer(pmPlayList)]));  Sleep(100);

    DoToast('Play Finished.');
  end;

end;

procedure TMainForm.SetActColor(const Value: TColor);
var
  aValue,
  aR,aG,aB, stepR,stepG,stepB:byte;
  sCmd:String;
begin
  FActColor := Value;

  {$IFDEF SteppingColor}
  stepR := GetRValue(FActColor) div cByteStepValue;
  stepG := GetGValue(FActColor) div cByteStepValue;
  stepB := GetBValue(FActColor) div cByteStepValue;

  aR:= stepR * cByteStepValue;
  aG:= stepG * cByteStepValue;
  aB:= stepB * cByteStepValue;
  {$ELSE}
  aR := GetRValue(FActColor);
  aG := GetGValue(FActColor);
  aB := GetBValue(FActColor);
  {$ENDIf}

  if (abs(aR-FPriR)>cRgbDiffer) or
     (abs(aG-FPriG)>cRgbDiffer) or
     (abs(aB-FPriB)>cRgbDiffer) then
  begin
    FActR:=aR;
    FActG:=aG;
    FActB:=aB;

    FPriR:=FActR;
    FPriG:=FActG;
    FPriB:=FActB;
  end
  else
  begin
    exit;
  end;

  {$IFDEF Windows}
  rbActClr.Refresh; //Render;
  {$ELSE}
  layout4.Repaint;
  {$ENDIF}

  {FpinR := StrToInt(Copy(cbR.Items[cbR.ItemIndex], 2,1));
  FpinB := StrToInt(Copy(cbB.Items[cbB.ItemIndex], 2,1));
  FpinG := StrToInt(Copy(cbG.Items[cbG.ItemIndex], 2,1));  }

  lblColor.Text := format('C,%d,%d,%d', [FActR,FActG,FActB]);

  {$IFDEF Windows}
  if (WinComportManager.IsConnected) then
  {$ENDIf}

  {$IFDEF Android}
    {$IFDEF BlueTooth}
{$IFDEF UseAndroidBlueTooth}
  with AndroidBlueToothManager do
  if IsConnected then
{$ELSE}
{$ENDIF}

    {$ENDIF}
  {$ENDIF}
  begin
    // Red -----------
    {$IFDEF NewCommand}
    sCmd := format('C,%d,%d,%d', [FActR,FActG,FActB]);
    Send_Command(sCmd);// Sleep(20);
    {$ELSE}
    sCmd := format('D,%d,%d', [FpinR,FActR]);
    Send_Command(sCmd);// Sleep(20);

    // Green -----------------------------
    sCmd := format('D,%d,%d', [FpinG,FActG]);
    Send_Command(sCmd);// Sleep(20);

    // Blue --------------------------------
    sCmd := format('D,%d,%d', [FpinB,FActB]);
    Send_Command(sCmd);// Sleep(20);
    {$ENDIF}

    if (FDoRecord) then Add_PlayList(FPlayList,FActR,FActG,FActB,gDelayMsc );
  end;
end;

procedure TMainForm.SetBitDataPixels(const aBitData: TBitmapData; X, Y: integer;
  const Value: TColor);
begin

end;

procedure TMainForm.SetHueLevel(const Value: word);
begin
  FHueLevel := Value;
end;

procedure TMainForm.SetPixels(const aBmp: TBitmap; X, Y: integer;
  const Value: TColor);
begin

end;

procedure TMainForm.SetSaturationLevel(const Value: byte);
begin
  FSaturationLevel := Value;
end;

procedure TMainForm.SetValueLevel(const Value: byte);
begin
  FValueLevel := Value;
end;

procedure TMainForm.SpeedButton1Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

procedure TMainForm.Switch1Click(Sender: TObject);
var
  aValue:byte;
  iPin:integer;
  sCmd:String;
begin
  if Switch1.IsChecked then aValue:=255
  else aValue:=0;

  if ckbxSwitchAll.IsChecked then
  begin
    for iPin:=2 to 13 do
    begin
      sCmd := format('D,%d,%d', [iPin,aValue]);
      Send_Command(sCmd);
    end;
  end
  else
  begin
    sCmd := format('D,%d,%d', [FPinId,aValue]);
    Send_Command(sCmd);
  end;

  ceSendStr.Text := sCmd;
end;

procedure TMainForm.Switch1Switch(Sender: TObject);
begin
  Switch1Click(Switch1);
end;


procedure TMainForm.ProcessReceivedString(Sender: TObject; const aStr:AnsiString);
begin
  if (aStr<>'') then
  begin
    if (ckbxReceiveLog.IsChecked) then
      Memo1.Lines.Add(aStr);
  end;

end;

procedure TMainForm.TimerReceiveTimer(Sender: TObject);
var
  s1:String;
begin
  //
  {$IFDEF Windows}
  // 由 Thread 接收
  {$ENDIF}

  {$IFDEF Android}

  if Self.ckbxReceiveLog.IsChecked then
{$IFDEF UseAndroidBlueTooth}
  if AndroidBlueToothManager.IsConnected then
  if AndroidBlueToothManager.Read_String(s1) then
{$ELSE}
{$ENDIF}
    Memo1.Lines.Add(s1);
  {$ENDIF}
end;

procedure TMainForm.tkbarBriChange(Sender: TObject);
var
  aValue:byte;
  iPin:integer;
  sCmd:String;
begin
  aValue := round(tkbarBri.Value);

  sCmd := format('V,%d,%d', [integer(vtBrightnessLevel),aValue ]);
  Send_Command(sCmd);
end;

procedure TMainForm.TrackBar3Change(Sender: TObject);
var
  aValue:byte;
  iPin:integer;
  sCmd:String;
begin
  aValue := round(TrackBar3.Value);

  if ckbxSwitchAll.IsChecked then
  begin
    for iPin:=2 to 13 do
    begin
      sCmd := format('D,%d,%d', [iPin,aValue]);
      Send_Command(sCmd);
    end;
  end
  else
  begin
    //gPriTkbarValue := aValue;
    sCmd := format('D,%d,%d', [FPinId,aValue]);
    Send_Command(sCmd);
  end;
  ceSendStr.Text := sCmd;
end;

procedure TMainForm.TrackBar3Enter(Sender: TObject);
begin
  gPriTkBarValue:=-255;
end;

procedure TMainForm.UpdateHueSaturation(aDia, X, Y: integer; var aHue: word;
  var aSaturation: byte);

VAR
    Angle   :  INTEGER;
    Distance:  INTEGER;
    xDelta  :  INTEGER;
    yDelta  :  INTEGER;
    Radius  :  INTEGER;
begin
  Radius := aDia div 2;
  xDelta := X - Radius;
  yDelta := Y - Radius;

  Angle := ROUND(360 + 180*ArcTan2(-yDelta,xDelta)/PI);

  // Make sure range is correct
  IF   Angle < 0
  THEN Angle := Angle + 360
  ELSE
    IF   Angle > 360
    THEN Angle := Angle - 360;

  aHue := Angle;

  Distance := ROUND( SQRT( SQR(xDelta) + SQR(yDelta)) );
  IF   Distance >= Radius
  THEN aSaturation := 255
  ELSE aSaturation := MulDiv(Distance, 255, Radius);


  IF   aSaturation=0 then
   aHue := 0; //NaN;  // Keep conversion routine "happy"


end;

initialization

  gDebug :=200;

finalization

end.
