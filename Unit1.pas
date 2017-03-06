unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls,
  StdCtrls, ExtCtrls, PBNumEdit, GPanel,ActiveX,
  Grids, ipwcore, ipwipdaemon, DB, ADODB, SUIDlg, Menus, CoolTrayIcon,enkripsi,IdHTTP,LibXmlComps, LibXmlParser,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, ScktComp,
  MemDS, DBAccess, MyAccess,MemData, DBXpress, FMTBcd, SqlExpr;

  type TServerConnectionStatus = record
       tcsActiveConnections : Integer;
       tcsScreenName        : string[10];
       tcsRemoteAddress     : string[15];
       tcsRemotePort        : Integer;
       tcsMessage           : AnsiString;
  end;
  type
    arrDataBulan = array[1..4] of String;
  type
    arrDataISO = array[1..128] of String;

  type TDataMessageISO = record
      arrDatanya : arrDataISO;
      status     : String;
  end;

  type TMessageDataISO = array of TDataMessageISO;
  type TServerConnectionStatusArray = array of TServerConnectionStatus;

type
  TDidyThread = class(TThread)
  private
      fDataKirim : String;
      procedure RefreshCount;
      procedure error;
      procedure KirimMessage;
  protected
      procedure Execute; override;
  public
      myPriority    : TThreadPriority;
      myMTI         : String;
      mypesanDatang : WideString;
      mySocket      : TipwIPDaemon;
      myConn        : Integer;
      myMemo        : TMemo;
      myViewLog     : TListView;
      myEdit        : TPBNumEdit;
      myChkLog      : TCheckBox;
      myChkTimeOut  : TCheckBox;
      myChkLateResp : TCheckBox;
      myConString   : String;
      myConString1  : String;
      myXMLParser   : TXMLParser;
      myLstparamURL : Tstringlist;
      myhasilURL    : Tstringlist;
      myAnsibuf     : AnsiString;
      mydataXML     : string;
      myNopelanggan : string;
      myIdHttp      : TIdHTTP;
      myvjmltagihan : integer;
      mybaris       : integer;
      myvbulan      : string;
      myvtahun      : string;
      myvkeluar     : boolean;
      myjmlbln      : integer;
      myIdTransaksi : string;
      myCekidpel    : boolean;
      myGol         : string;
      myTotal       : integer;
      myJmlrek      : string;
      myDatabiling  : string;
      myDatabiling1 : string;
      myvFaktor     : integer;
      myarrBlntagih : arrDatabulan;
      myDecounter   : integer;
      myCounter     : integer;
      myvnolppa     : string;
      mykode_aktif  : string;
      mykode_loket  : string;
      myQuery1      : TADOQuery;
      myQuery2      : TADOQuery;
      myKonek1      : TADOConnection;
      myKonek2      : TADOConnection;
      myAdodb1      : TADOConnection;
      myadodb2      : TADOConnection;
      myIpRemote    : string;
      mycekidpel1   : boolean;
      myLokasiId    : string;
      myvpenambahan : string;
      myvmycekidpel : boolean;
      mymaterai     : string;
      mytmp1        : string;
      mytmp2        : string;
      myvdendapokok1: string;
      myvkdbiaya1   : string;
      myvdendapokok2: string;
      myvkdbiaya2   : string;
      myvblnTagih   : string;
      myvthnTagih   : string;
      myvbulan_rek  : string;
      myvbeban_tetap: string;
      myvbiaya_tarif: string;
      myvdenda2     : string;
      myvdenda      : string;
      myvbiayaket   : string;
      myvmaterai    : string;
      myvretribusi   : string;
      myvtotal      : string;
      myvtunai      : string;
      myvkembalian  : string;
      myvtanggal_bayar: string;
      myvtanggal    : string;
      myvwaktu      : string;
      myvactivite_time: string;
      myvkode_kolektor: string;
      myvdiskon_denda : string;
      myvdiskon_tagihan: string;
      myvptg_denda  : string;
      myvptg_tagihan: string;
      myvbiaya_tambahan: string;
      myvbiaya_lain: string;
      myvstatus    : string;
      myvkode_golongan: string;
      myvno_rek    : string;
      myvno_urut   : string;
      myvkode_wilayah: string;
      myvsaluran   : string;
      myvbayar     :boolean;
      myTimer:TTimer;
      mywaktos:byte;
  end;


type
  TForm1 = class(TForm)
    Panel1: TPanel;
    pcLearnSockets: TPageControl;
    TabSheet1: TTabSheet;
    Panel3: TPanel;
    gbServerSettings: TGroupBox;
    lblServerPort: TLabel;
    btnServerOpen: TButton;
    btnServerClose: TButton;
    edServerPort: TEdit;
    gbUserDefinedServerSettings: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    cbLogAllClientMessages: TCheckBox;
    btnReset: TButton;
    btnLoad: TButton;
    chkTO: TCheckBox;
    chkLateRespon: TCheckBox;
    edLateRespon: TEdit;
    edMessIn: TPBNumEdit;
    edProses: TPBNumEdit;
    edSend: TPBNumEdit;
    Panel4: TPanel;
    PanelImage: TPanel;
    ShapePort: TShape;
    ShapeHOST: TShape;
    Image1: TImage;
    ShapeDB: TShape;
    ShapeDB1: TShape;
    ImageDB1: TImage;
    GPanel1: TGPanel;
    Label2: TLabel;
    TabSheet2: TTabSheet;
    sgServerConnections: TStringGrid;
    TabSheet3: TTabSheet;
    lvServerActivity: TListView;
    TabSheet4: TTabSheet;
    pnlLog: TPanel;
    lViewLog: TListView;
    Panel2: TPanel;
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    CoolTray: TCoolTrayIcon;
    PopupMenu1: TPopupMenu;
    ShowMainForm1: TMenuItem;
    ShutdownServer1: TMenuItem;
    suipassdlg: TsuiInputDialog;
    ipwIPDaemon1: TipwIPDaemon;
    dfs: TStatusBar;
    Timer2: TTimer;
    Timer3: TTimer;
    Timer4: TTimer;
    memReceive: TMemo;


    procedure btnServerOpenClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CoolTrayDblClick(Sender: TObject);
    procedure ShowMainForm1Click(Sender: TObject);
    function ExecuteThreadSynch(Priority : TThreadPriority;MTI : String;pesanDatang : WideString;SocketServ : TipwIPDaemon;Conn : Integer;Memo : TMemo;ViewLog : TListView;Edit : TPBNUMEdit;ChkLog,chkTimeOut,chkLateResp:TCheckBox;conString:String;conString1:String;conXMLParser:TXMLParser;conLstparamURL,conhasilURL:Tstringlist;conAnsibuf:AnsiString;condataXML:String;conNopelanggan:string;conIdHttp:TIdHTTP;convjmlTagihan,conBaris:integer;convBulan,convtahun:String;convKeluar:boolean;conjmlbln:integer;conIdTransaksi:string;conCekidpel:boolean;conGol:string;conTotal:integer;conJmlrek: string;conDatabiling: string;conDatabiling1: string;convFaktor: integer;conarrBlntagih: arrdatabulan;conDecounter: integer;conCounter: integer;convnolppa: string;conKode_aktif: string;conKode_loket: string;conMyquery1:TADOQuery;conMyquery2:TADOQuery;conKonek1:TADOConnection;conKonek2:TADOConnection;conIpRemote:string;conCekidpel1:boolean
    ;conLokasiId,conPenambahan:string;conmyvmycekidpel:boolean;conmaterai,contmp1,contmp2,condendapokok1,conkdbiaya1,condendapokok2,conkdbiaya2,
    convblntagih,convthntagih,convbulan_rek,convbeban_tetap,
    convbiaya_tarif,convdenda2,convdenda,convbiayaket,convmaterai,convretribusi,
    convtotal,convtunai,convkembalian,convtanggal_bayar,convtanggal,convwaktu,
    convactivite_time,convkode_kolektor,convdiskon_denda,convdiskan_tagihan,
    convptg_denda,convptg_tagihan,convbiaya_tambahan,convbiaya_lain,convstatus,
    convkode_golongan,convno_rek,convno_urut,convkode_wilayah,convsaluran:string;conBayar:boolean;conTimer:TTimer;conWaktos:byte) : TDidyThread;

    procedure ipwIPDaemon1Connected(Sender: TObject; ConnectionId,
      StatusCode: Integer; const Description: String);
    procedure ipwIPDaemon1ConnectionRequest(Sender: TObject;
      const Address: String; Port: Integer; var Accept: Boolean);
    procedure ipwIPDaemon1DataIn(Sender: TObject; ConnectionId: Integer;
      Text: String; EOL: Boolean);
    procedure ipwIPDaemon1Disconnected(Sender: TObject; ConnectionId,
      StatusCode: Integer; const Description: String);
    procedure ipwIPDaemon1Error(Sender: TObject; ErrorCode: Integer;
      const Description: String);
    procedure btnResetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ShutdownServer1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lViewLogDblClick(Sender: TObject);
    procedure btnServerCloseClick(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
    procedure Timer4Timer(Sender: TObject);
  private
    { Private declarations }
    myDidyThread : TDidyThread;
  public
    { Public declarations }
    function BisaKonekKeDB:Boolean;
    procedure Cetak(par:String);
    procedure AddConnectionsInfo(ClientInfo : TServerConnectionStatus);
    procedure DeleteConnectionsInfo(ClientInfo : TServerConnectionStatus); overload;
    procedure DeleteConnectionsInfo(I : Integer); overload;
    procedure DisplayConnectionsInfo;
    procedure ThreadTerminated(Sender:TObject);
  end;

const
  maxConnetion = 10;

var
  Form1: TForm1;
    arrShape : array of TShape;
    arrImage : array of TImage;
    ipListed : array of String;
    ServerConnectionStatus : TServerConnectionStatusArray;
    arrMessageDataISO : TMessageDataISO;
    incMess : integer = 0;
    parsingMess : integer = 0;
    sendMess : integer = 0;
    waktos : byte = 0;
    DBip,DBnama,DBnama2,DBuser,DBpass,dirFileLog : String;
    AplikasiOK : Boolean = FALSE;
    defaultpassAdmin : String = 'yuskamal5870';
    AdminPass : String;
    secureString : String = '7Cys9+3/t0h4xuri';
    portLokal : integer;
    messDatang : AnsiString;
    nmFileLog200,nmFileLog210,nmFileLog400,nmFileLog410 : String;
    FileLog200,FileLog210,FileLog400,FileLog410 : TextFile;
    KonString1 : WideString;
    Konstring2 : WideString;
    vLstparamURL,vhasilUrl : TStringList;
    vheaderResi,vfooterResi,vbeaAdminpos,vmaksjmltagihan,vkode_unit,vbayarDenda:string;
    vXMLParser : TXMLParser;
    vAnsibuf:Ansistring;
    dataXML,vnopelanggan,vbulan,vtahun,vIdTransaksi:string;
    vIdHttp:TIdHTTP;
    vjmltagihan,baris,vbaris,vjmlbln:integer;
    keluar,vkeluar,vCekidpel,vcekidpel1,vconmyvmycekidpel:boolean;
    vFormaturl,vGol,vJmlrek,vDatabiling,vDatabiling1,vconlokasiid,vconPenambahan,vconmaterai,vcontmp1,vcontmp2,vcondendapokok1,vconkdbiaya1,vcondendapokok2,vconkdbiaya2,
    convblntagih,convthntagih,convbulan_rek,convbeban_tetap,
    convbiaya_tarif,convdenda2,convdenda,convbiayaket,convmaterai,convretribusi,
    convtotal,convtunai,convkembalian,convtanggal_bayar,convtanggal,convwaktu,
    convactivite_time,convkode_kolektor,convdiskon_denda,convdiskan_tagihan,
    convptg_denda,convptg_tagihan,convbiaya_tambahan,convbiaya_lain,convstatus,
    convkode_golongan,convno_rek,convno_urut,convkode_wilayah,convsaluran:string;
    vtotalTagihan,vTotal,vFaktor,vDecounter,vCounter:integer;
    vArrblnTagih: arrDatabulan;
    VTGH,VTGH1:INTEGER;
    tmptglhariini,vnolppa,vkode_aktif,vkode_loket:string;
    vconvblntagih,vconvthntagih,vconvbulan_rek,vconvbeban_tetap,

    vconvbiaya_tarif,vconvdenda2,vconvdenda,vconvbiayaket,vconvmaterai,vconvretribusi:string;
    vconvtotal,vconvtunai,vconvkembalian,vconvtanggal_bayar,vconvtanggal,vconvwaktu:string;
    vconvactivite_time,vconvkode_kolektor,vconvdiskon_denda,vconvdiskan_tagihan:string;
    vconvptg_denda,vconvptg_tagihan,vconvbiaya_tambahan,vconvbiaya_lain,vconvstatus:string;
    vconvkode_golongan,vconvno_rek,vconvno_urut,vconvkode_wilayah,vconvsaluran:string;
    //sSQL  : TMyQuery;
    //sSQL1 : TMyQuery;
    //sSQL  :TSQLQuery;
    //sSQL1  :TSQLQuery;
    //con1,con2:TMyConnection;
    //con1,con2:TSQLConnection;

    RetryMode: TRetryMode;
    adodb1,adodb2: TADOConnection;
    sSQL,sSQL1:TADOQuery;
    IpRemote,vno_lppa,vtglJatuhTemp:string;
    vmycekidpel:boolean;
    vbayar:boolean;
    vpesan:string;
implementation
//uses inifiles,UnitSetting,UnitUtil,winsock,clipBrd;
uses inifiles,UnitUtil,winsock,clipBrd;

{$R *.dfm}

{ TForm1 }

function getIPs: Tstrings;
type
  TaPInAddr = array[0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  Buffer: array[0..63] of AnsiChar;
  I: Integer;
  GInitData: TWSAData;
begin
    WSAStartup($101, GInitData);
    Result := TstringList.Create;
    Result.Clear;
    GetHostName(Buffer, SizeOf(Buffer));
    phe := GetHostByName(buffer);
    if phe = nil then Exit;
    pPtr := PaPInAddr(phe^.h_addr_list);
    I := 0;
    while pPtr^[I] <> nil do
    begin
      Result.Add(inet_ntoa(pptr^[I]^));
      Inc(I);
    end;
    WSACleanup;
end;

procedure TForm1.AddConnectionsInfo(ClientInfo: TServerConnectionStatus);
var
  I, X     : Integer;
  AddToSCS : Boolean;
begin
  AddToSCS := True;
  for I := 0 to High(ServerConnectionStatus) do
  begin
    if (ServerConnectionStatus[I].tcsScreenName = 'Empty') then
      begin
        AddToSCS := False;
        Break;
      end;
  end;

  if (AddToSCS) then //An empty slot was not found so add one and use it
    begin
      SetLength(ServerConnectionStatus, Length(ServerConnectionStatus) + 1);
      X := High(ServerConnectionStatus);
    end
  else
    X := I;
  //Add the new connection information
  with ServerConnectionStatus[X] do
  begin
    tcsActiveConnections := ClientInfo.tcsActiveConnections;
    tcsScreenName        := ClientInfo.tcsScreenName;
    tcsRemoteAddress     := ClientInfo.tcsRemoteAddress;
    tcsRemotePort        := ClientInfo.tcsRemotePort;
  end;
end;

function TForm1.BisaKonekKeDB: Boolean;
begin
   try

      if adodb1.Connected=false then
      begin
        adodb1.ConnectionString := KonString1;
        adodb1.CommandTimeout:=15;
        adodb1.ConnectionTimeout:=15;
        adodb1.LoginPrompt:=false;
        Cetak('[Trying Connecting to DBMS MySQL Server ] '+DBip);
        adodb1.Connected:=true;

         if  (adodb1.Connected=true) then
         begin
           Cetak('[Connected to DBMS MySQL Server Mitra on DB Name] '+Dbnama+' Success');
           result:=true;
           {langsung ambil nomer lppa}
           sSql:=TADOQuery.Create(nil);
           sSql.Connection:=adodb1;
           sSql.SQL.Clear;
           sSql.SQL.Add('select no_lppa from tkode_lppa where tanggal_lppa='+quotedstr(tmptglhariini)+'');
           sSql.Open;
           vno_lppa:='LP'+sSql.Fields.Fields[0].AsString;
           {ambil tanggal terakhir jatuh tempo}
           sSql.SQL.Clear;
           sSql.SQL.Add('select waktu_tanggal from refwaktudenda');
           sSql.Open;
           vtglJatuhTemp:=sSql.Fields.Fields[0].AsString;
           sSql1:=TADOQuery.Create(nil);
           sSql1.Connection:=adodb2;


         end
      end
      else
      begin
        adodb1.Connected:=false;
        Cetak('[Reconnected to DBMS MySQL Server Mitra on DB Name] '+DBnama);
      end;


      if adodb2.Connected=false then
      begin
        adodb2.ConnectionString := KonString2;
        adodb2.LoginPrompt:=false;
        Cetak('[Trying Connecting to DBMS MySQL Server ] '+DBip);
        adodb2.Connected:=true;
        if  (adodb2.Connected=true) then
        begin
           Cetak('[Connected to DBMS MySQL Server Mitra on DB Name] '+DBnama2+' Success');
           result:=true;
        end
      end
      else
      begin
        adodb2.Connected:=false;
        Cetak('[Reconnected to DBMS MySQL Server Mitra on DB Name] '+DBnama2);
      end;

      ShapeDB1.Brush.Color := clLime;
      ShapeDB.Brush.Color := clLime;
      ImageDB1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'database_accept.ico');
      ImageDB1.Hint := 'Database '+DBip+'  '+DBNama;

   except
        on E:Exception do begin
         Cetak('ERROR : '+E.Message);
         ShapeDB1.Brush.Color := clRed;
         result := FALSE;
         adodb1.Connected:=false;
         adodb2.Connected:=false;
         //con1.Disconnect;
         //con2.Disconnect;
      end;
   end;
end;

procedure TForm1.Cetak(par: String);
begin
    if memReceive.Lines.Count>100 then
       memReceive.Clear;
    memReceive.Lines.Add('['+formatdatetime('hh:nn:ss',now)+'] '+par)
end;

procedure TForm1.DeleteConnectionsInfo(
  ClientInfo: TServerConnectionStatus);
var
  J : Integer;
begin
  //Find the Entry and clear it
  for J := 0 to High(ServerConnectionStatus) do
    with ServerConnectionStatus[J] do
    begin
      if (tcsRemoteAddress = ClientInfo.tcsRemoteAddress) and
         (tcsRemotePort = ClientInfo.tcsRemotePort) then
         begin
           tcsActiveConnections := 0;
           tcsScreenName        := 'Empty';
           tcsRemoteAddress     := '';
           tcsRemotePort        := 0;
           Break;
         end;
    end;
end;

procedure TForm1.DeleteConnectionsInfo(I: Integer);
begin
  with ServerConnectionStatus[I] do
  begin
     tcsActiveConnections := 0;
     tcsScreenName        := 'Empty';
     tcsRemoteAddress     := '';
     tcsRemotePort        := 0;
   end;
end;

procedure TForm1.DisplayConnectionsInfo;
var
  I : Integer;
begin
  with sgServerConnections do begin
      for i := 0 to High(ServerConnectionStatus) do begin
          cells[0,i+1] := IntToStr(ServerConnectionStatus[i].tcsActiveConnections);
          cells[1,i+1] := ServerConnectionStatus[i].tcsScreenName;
          cells[2,i+1] := ServerConnectionStatus[i].tcsRemoteAddress;
          cells[3,i+1] := IntToStr(ServerConnectionStatus[i].tcsRemotePort);
      end;
  end;
end;

procedure TForm1.ThreadTerminated(Sender: TObject);
begin

   // con1.Free;
   // con2.Free;
end;

procedure TForm1.btnServerOpenClick(Sender: TObject);
var
  PrevCursor : TCursor;
  X : TListItem;
begin
  PrevCursor := Screen.Cursor;
  Screen.Cursor := crHourglass;

  DisplayConnectionsInfo;
  ipwIPDaemon1.LocalPort := StrToInt(edServerPort.Text);
  X := lvServerActivity.Items.Add;
  X.Caption := 'Opening...';
  try
      ipwIPDaemon1.Listening := TRUE;
      ShapePort.Brush.Color := clLime;
      X.Caption := 'Opened';
      Cetak('Server Started...on Port : ' + edServerPort.Text);
      X.SubItems.Add(ipwIPDaemon1.LocalHost);
      X.SubItems.Add(GetIPS.Strings[0]);
      X.SubItems.Add(IntToStr(ipwIPDaemon1.LocalPort));
      X.SubItems.Add(formatdatetime('dd-mm-yyyy hh:nn:ss.zzz',now));
      X.SubItems.Add('OK');
      Screen.Cursor := PrevCursor;
      dfs.Panels.Items[1].Text:='Middle Dacen Conected [0] ';
  except
     ON E:EipwIPDaemon do begin
        Cetak('ERROR : '+IntToStr(E.code)+'  '+E.Message);
        ShapePort.Brush.Color := clRed;
     end;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);

   function CekFileKonf:Boolean;
   var
      MyIniFile: TIniFile;
   begin
       if not FileExists(ExtractFilePath(Application.ExeName)+'param.ini') then
          result := FALSE
       else begin
          try
            MyIniFile := TIniFile.Create(ExtractFilePath(Application.ExeName)+'param.ini');
            with MyIniFile do begin
                portLokal := ReadInteger('Konf','port',0);
                dirFileLog := ReadString('Konf','DirLogFile','');
                AdminPass := ReadString('Konf','passAdmin','');
                DBip := ReadString('Database','IpDB','');
                vheaderResi:= ReadString('Header','HeaderResi','');
                vfooterResi:= ReadString('Footer','FooterResi','');
                vbeaAdminpos:= ReadString('Bea Admin','Bea Admin Pos','');
                vkode_loket:= ReadString('Kode','Kode loket','');
                vkode_unit:= ReadString('Kode','Kode unit','');
                vbayarDenda:=ReadString('Denda','Bayar','');
                vmaksjmltagihan:=ReadString('Maks Jml Tagihan','Maks Jml Tagihan','');
                DBnama := ReadString('Database','namaDB','');
                DBnama2 := ReadString('Database1','namaDB2','');
                DBuser := ReadString('Database','userDB','');
                DBpass := ReadString('Database','passDB','');
                //DBpass := DecodePWDEx(DBpass,secureString);
                AdminPass := DecodePWDEx(AdminPass,secureString);
                dfs.Panels.Items[0].Text:='IP GATEWAY '+Dbip;
                if (portlokal=0) or (dirFileLog='') or (DBip='') or (DBnama='') or (DBuser='') or (DBpass='') then
                   result := FALSE
                else begin
                     konstring1:='Provider=MSDASQL.1;Persist Security Info=False;Extended Properties="DRIVER=MySQL ODBC 5.1 Driver;DSN=con1;SERVER='+Dbip+';DATABASE='+dbnama+';UID='+dbuser+';PWD='+dbpass+';PORT=3306"';

                                  //Provider=MSDASQL.1;Persist Security Info=False;Extended Properties="Driver=MySQL ODBC 5.1 ANSI Driver;SERVER=118.97.244.10;UID=userpos20;PORT=3306;CHARSET=utf8;COLUMN_SIZE_S32=1"
                                   //DRIVER={MySQL ODBC 5.1 Driver}

                     //konstring1:='Driver=MySQL ODBC 5.3 ANSI Driver;SERVER=118.97.244.10;UID=userpos20;PWD=Us3rP0s;DATABASE=pdam_update;PORT=3306;COLUMN_SIZE_S32=1';
                     //KonString1 := 'Provider=MSDASQL.1;Password=root123;Persist Security Info=True;User ID=rootpdam;Data Source=myodbc;Initial Catalog=pdam_bo';

                     konstring2:='Provider=MSDASQL.1;Persist Security Info=True;Extended Properties="DRIVER=MySQL ODBC 5.1 Driver;DSN=con1;SERVER='+Dbip+';DATABASE='+dbnama2+';UID='+dbuser+';PWD='+dbpass+';PORT=3306"';
                     ipwIPDaemon1.LocalPort := portLokal;
                     edServerPort.Text := IntToStr(portlokal);
                     result := TRUE;
                end;
            end;
          finally
            freeAndNil(MyIniFile);
          end;
       end;
   end;

   function BisaBukaLogFile:Boolean;
   var
     dirToday : String;
   begin
       dirToday := DirFileLog+'\'+FormatDateTime('YYYYMMDD',now);
       if ForceDirectories(dirToday) then begin
          {nmFileLog200 := dirToday+'\200_'+FormatDateTime('YYYYMMDD',now)+'.log';
          nmFileLog210 := dirToday+'\210_'+FormatDateTime('YYYYMMDD',now)+'.log';
          nmFileLog400 := dirToday+'\400_'+FormatDateTime('YYYYMMDD',now)+'.log';
          nmFileLog410 := dirToday+'\410_'+FormatDateTime('YYYYMMDD',now)+'.log';
          }
          nmFileLog200 := dirToday+'\'+FormatDateTime('YYYYMMDD',now)+'_0200.log';
          nmFileLog210 := dirToday+'\'+FormatDateTime('YYYYMMDD',now)+'_0210.log';
          nmFileLog400 := dirToday+'\'+FormatDateTime('YYYYMMDD',now)+'_0400.log';
          nmFileLog410 := dirToday+'\'+FormatDateTime('YYYYMMDD',now)+'_0410.log';


          AssignFile(FileLog200,nmFileLog200);
          if FileExists(nmFileLog200) then
             Append(FileLog200)
          else
             Rewrite(FileLog200);

          AssignFile(FileLog210,nmFileLog210);
          if FileExists(nmFileLog210) then
             Append(FileLog210)
          else
             Rewrite(FileLog210);

          AssignFile(FileLog400,nmFileLog400);
          if FileExists(nmFileLog400) then
             Append(FileLog400)
          else
             Rewrite(FileLog400);

          AssignFile(FileLog410,nmFileLog410);
          if FileExists(nmFileLog410) then
             Append(FileLog410)
          else
             Rewrite(FileLog410);

          result := TRUE;
       end else
          result := FALSE;
   end;

   {tempat function bacaiplisted}
   function BacaIpListed:Boolean;
   var
     strIp : TStringList;
     i : integer;
   begin
       if FileExists(ExtractFilePath(Application.ExeName)+'iplisted.txt') then begin
          try
             strIp := TStringList.Create;
             strIp.LoadFromFile(ExtractFilePath(Application.ExeName)+'iplisted.txt');
             setlength(iplisted,strIp.Count);
             setlength(arrShape,strIp.Count);
             setlength(arrImage,strIp.Count);
            // for i := 0 to high(iplisted)-1 do begin
             for i := 0 to high(iplisted) do begin
                ipListed[i] := strIp.Strings[i];
                arrShape[i] := TShape.Create(PanelImage);
                arrShape[i].Shape := stRectangle;
                arrShape[i].Brush.Style := bsSolid;
                arrShape[i].Pen.Width := 1;
                arrShape[i].Pen.Style := psClear;
                arrShape[i].Brush.Color := $0080FFFF;
                arrShape[i].Height := 50;
                arrShape[i].Width := 10;
                arrShape[i].Left := (i+1) * 50 ;//+ (i+50);
                arrShape[i].Top := 115;
                arrShape[i].Tag := i+5;
                arrShape[i].Parent := PanelImage;
                arrImage[i] := TImage.Create(PanelImage);
                arrImage[i].Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'computer_delete.ico');
                arrImage[i].AutoSize := TRUE;
                arrImage[i].ShowHint := TRUE;
                arrImage[i].Hint := strIp.Strings[i];
                arrImage[i].Top := 170;
                arrImage[i].Left := ((i+1) * 40) + (i*10) ;
                arrImage[i].Parent := PanelImage;
            end;
          finally
             result := TRUE;
             freeAndNil(strIp);
          end;
       end else
          result := FALSE;
   end;

begin
   inc(waktos);
   if waktos=2 then begin
      try
          Timer1.Enabled := FALSE;
          if CekFileKonf then begin
             Cetak('Konfiguration File ... OK ');
             if BisaBukaLogFile then begin
                 if BisaKonekKeDB then begin
                    if BacaIpListed then begin
                        AplikasiOK := TRUE;
                        btnServerOpenClick(self);
                        Timer1.Enabled := TRUE;
                        {langsung ambil nomer lppa}
                        {
                        sSql:=TADOQuery.Create(nil);
                        sSql.SQLConnection:=con1;
                        sSql.SQL.Clear;
                        sSql.SQL.Add('select no_lppa from tkode_lppa where tanggal_lppa='+quotedstr(tmptglhariini)+'');
                        sSql.Open;
                        vno_lppa:='LP'+sSql.Fields.Fields[0].AsString;

                        sSql.SQL.Clear;
                        sSql.SQL.Add('select waktu_tanggal from refwaktudenda');
                        sSql.Open;
                        vtglJatuhTemp:=sSql.Fields.Fields[0].AsString;
                        sSql1:=TADOQuery.Create(nil);
                        sSql1.SQLConnection:=con2;
                        }
                    end else
                       Cetak('Tidak ada IP Client yang terdaftar ...');
                 end else
                 begin
                    Cetak('Koneksi ke Database GAGAL');
                    timer3.Enabled:=true;
                    timer3.Interval:=20000;
                    waktos:=0;
                 end
             end else
                Cetak('LOG File tidak bisa terbentuk ...');
          end else
             Cetak('File Konfigurasi belum terbentuk dengan Benar');
      except
         MessageDlg('Error .....',mtError,[mbOK],0);
      end;
   end else if waktos=5 then begin
       Timer1.Enabled := FALSE;
       if AplikasiOK then begin
          //CoolTray.HideMainForm;
          //CoolTray.MinimizeToTray := TRUE;
       end;
   end else if waktos=10 then begin
     // cek folder harian
   end;

end;

procedure TForm1.CoolTrayDblClick(Sender: TObject);
begin
   CoolTray.ShowMainForm;
end;

procedure TForm1.ShowMainForm1Click(Sender: TObject);
begin
   CoolTray.ShowMainForm;
end;

function TForm1.ExecuteThreadSynch(Priority: TThreadPriority; MTI: String;
  pesanDatang: WideString; SocketServ: TipwIPDaemon; Conn: Integer;
  Memo: TMemo; ViewLog: TListView; Edit: TPBNUMEdit; ChkLog, chkTimeOut,
  chkLateResp: TCheckBox; conString: String;conString1: String;conXMLParser: TXMLParser;conLstparamURL,
  conhasilURL: Tstringlist;conAnsibuf: AnsiString;condataXML: String;conNopelanggan: string;conIdHttp: TIdHTTP;convjmlTagihan,
  conBaris: Integer;convBulan,convTahun: String;convKeluar: boolean;conjmlbln: integer;conIdTransaksi: string;conCekidpel: boolean;conGol: string;conTotal: integer;conJmlrek: string;conDatabiling: string;conDatabiling1: string;convFaktor: integer;conarrblntagih: arrdatabulan;conDecounter: integer;conCounter: integer;convnolppa: string;conKode_aktif:string;conKode_loket:string;conMyquery1:TADOQuery;conMyquery2:TADOQuery;conKonek1:TADOConnection;conKonek2:TADOConnection;conIpRemote:string;conCekidpel1:boolean;conLokasiId,conPenambahan:string;conmyvmycekidpel:boolean;conmaterai,contmp1,contmp2,condendapokok1,conkdbiaya1,condendapokok2,conkdbiaya2,
  convblntagih,convthntagih,convbulan_rek,convbeban_tetap,
  convbiaya_tarif,convdenda2,convdenda,convbiayaket,convmaterai,convretribusi,
  convtotal,convtunai,convkembalian,convtanggal_bayar,convtanggal,convwaktu,
  convactivite_time,convkode_kolektor,convdiskon_denda,convdiskan_tagihan,
  convptg_denda,convptg_tagihan,convbiaya_tambahan,convbiaya_lain,convstatus,
  convkode_golongan,convno_rek,convno_urut,convkode_wilayah,convsaluran:string;conBayar:boolean;conTimer:TTimer;conWaktos:byte): TDidyThread;
var
    didy : TDidyThread;
begin
    didy := TDidyThread.Create(true);
    didy.FreeOnTerminate := true;
    didy.myPriority := Priority;
    didy.myMTI := MTI;
    didy.mypesanDatang := pesanDatang;
    didy.mySocket := SocketServ;
    didy.myConn := Conn;
    didy.myMemo := Memo;
    didy.myViewLog := ViewLog;
    didy.myEdit := Edit;
    didy.myChkLog := ChkLog;
    didy.myChkTimeOut := chkTimeOut;
    didy.myChkLateResp := chkLateRespon;
    didy.myConString := conString;
    didy.myConString1:=conString1;
    didy.myXMLParser := conXMLParser;
    didy.myLstparamURL:=conLstparamURL;
    didy.myhasilURL :=conhasilURL;
    didy.myAnsibuf:=conAnsibuf;
    didy.mydataXML:=condataXML;
    didy.myNopelanggan:=conNopelanggan;
    didy.myIdHttp:=conIdHttp;
    didy.myvjmltagihan:=convjmlTagihan;
    didy.mybaris:=conBaris;
    didy.myvbulan:=convBulan;
    didy.myvtahun:=convTahun;
    didy.myvkeluar:=convKeluar;
    didy.myjmlbln:=conjmlbln;
    didy.myIdTransaksi:=conIdTransaksi;
    didy.myCekidpel:=conCekidpel;
    didy.myGol:=conGol;
    didy.myTotal:=conTotal;
    didy.myJmlrek:=conJmlrek;
    didy.myDatabiling:=conDatabiling;
    didy.myDatabiling1:=conDatabiling1;
    didy.myvFaktor:=convFaktor;
    didy.myarrBlntagih:=conarrBlntagih;
    didy.myDecounter:=conDecounter;
    didy.myCounter:=conCounter;
    didy.myvnolppa:=convnolppa;
    didy.mykode_aktif:=conKode_aktif;
    didy.mykode_loket:=conKode_loket;
    didy.myQuery1:=conMyquery1;
    didy.myQuery2:=conMyquery2;
    didy.myKonek1:=conKonek1;
    didy.myKonek2:=conKonek2;
    didy.myIpRemote:=conIpRemote;
    didy.mycekidpel1:=conCekidpel1;
    didy.myLokasiId:=conLokasiId;
    didy.myvpenambahan:=conPenambahan;
    didy.myvmycekidpel:=conmyvmycekidpel;
    didy.mymaterai:=conMaterai;
    didy.mytmp1:=contmp1;
    didy.mytmp2:=contmp2;
    didy.myvdendapokok1:=condendapokok1;
    didy.myvkdbiaya1:=conkdbiaya1;
    didy.myvdendapokok2:=condendapokok2;
    didy.myvkdbiaya2:=conkdbiaya2;
    didy.myvblnTagih   := convblntagih;
    didy.myvthnTagih   :=convthntagih;
    didy.myvbulan_rek  :=convbulan_rek;
    didy.myvbeban_tetap:=convbeban_tetap;
    didy.myvbiaya_tarif:=convbiaya_tarif;
    didy.myvdenda2     :=convdenda2;
    didy.myvdenda      :=convdenda;
    didy.myvbiayaket   :=convbiayaket;
    didy.myvmaterai    :=convmaterai;
    didy.myvretribusi   :=convretribusi;
    didy.myvtotal      :=convtotal;
    didy.myvtunai      :=convtunai;
    didy.myvkembalian  :=convkembalian;
    didy.myvtanggal_bayar:=convtanggal_bayar;
    didy.myvtanggal    :=convtanggal;
    didy.myvwaktu      :=convwaktu;
    didy.myvactivite_time:=convactivite_time;
    didy.myvkode_kolektor:=convkode_kolektor;
    didy.myvdiskon_denda :=convdiskon_denda;
    didy.myvdiskon_tagihan:=convdiskan_tagihan;
    didy.myvptg_denda  :=convptg_denda;
    didy.myvptg_tagihan:=convptg_tagihan;
    didy.myvbiaya_tambahan:=convbiaya_tambahan;
    didy.myvbiaya_lain:=convbiaya_lain;
    didy.myvstatus    :=convstatus;
    didy.myvkode_golongan:=convkode_golongan;
    didy.myvno_rek    :=convno_rek;
    didy.myvno_urut   :=convno_urut;
    didy.myvkode_wilayah:=convkode_wilayah;
    didy.myvsaluran   :=convsaluran;
    didy.myvbayar:=conBayar;
    didy.myTimer:=conTimer;
    didy.mywaktos:=conWaktos;
    didy.OnTerminate := ThreadTerminated;
    didy.Resume;
    Result := didy;
end;

{ TDidyThread }


procedure TDidyThread.Execute;
var
  PrimBitMap,SecBitMap,databalik1,MTIbalik,SQLText : String;
  arrBalik             : arrDataISO;
  ReadyToSend ,adaDir: Boolean;
  sudahAda:boolean;
  posisi:integer;
  vFaktor:integer;
  kolom,tmpNopelanggan,vblnTagih,vthnTagih,vdata:string;
  jmlTagih,vkodeGol,vtglTransaksi:string;
  mydataXML2,mydataXML3,vnilai:string;
  vno_rek,vkode_wilayah,vbulan_rek,vbeban_tetap,vbiaya_tarif,vdenda,vdenda2,vdenda_pokok,vbiaya_ket,vmaterai:string;
  vretribusi,vtunai,vkembalian,vtanggal_bayar,vuser_id,vtanggal,vwaktu:string;
  vactivite_time,vkode_kolektor,vdiskon_denda,vdiskon_tagihan,vptg_denda,vptg_tagihan:string;
  vbiaya_tambahan,vstatus,vkode_golongan,vtgl,vno_urut,vsaluran,vbiaya_lain,dirToday:string;

    function CekLength(messBalik:String):String;
    var
      lmess,hasilmod,hasilbagi : integer;
      chrlength : String;
    begin
      lmess := length(messBalik);
      if lmess>255 then begin
        hasilMod := lmess mod 256;
        hasilbagi := (lmess - hasilmod) div 256;
        chrLength :=  chr(hasilmod) + chr(hasilbagi);
      end else
        chrlength := chr(lmess)+chr(0);//+chr(lmess);
      result := chrlength;
    end;

    function UnpackArrayISO(strTemp : String;var primBitMap,secBitMap : String):arrDataISO;
    var
      totalISO,i,posnya : Cardinal;
      bitmapnya : String;
      arrDatang : arrDataISO;
      panjang,kode : integer;
    begin
      primBitMap := Copy(strTemp,1,16);
      bitmapnya := DecodeMap(PrimBitMap);
      totalISO := 64;
      strTemp := Copy(strTemp,17,length(strTemp));
      if Copy(bitmapnya,1,1)='1' then begin  // ada secondary bitmap
         SecBitMap := Copy(strTemp,1,16);
         bitmapnya := bitmapnya + DecodeMap(SecBitMap);
         totalISO := 128;
      end;

      for i := 1 to 128 do
         arrDatang[i] := '';

      posnya := 1;
      for i := 1 to totalISO do begin
          if bitmapnya[i]='1' then begin
             if arrISO[i,4]='LVAR' then begin
                VAL(Copy(strTemp,posnya,1),panjang,Kode);
                posnya := posnya + 1;
             end else if arrISO[i,4]='LLVAR' then begin
                VAL(Copy(strTemp,posnya,2),panjang,Kode);
                posnya := posnya + 2;
             end else if arrISO[i,4]='LLLVAR' then begin
                VAL(Copy(strTemp,posnya,3),panjang,Kode);
                posnya := posnya + 3;
             end else
                VAL(arrISO[i,3],panjang,Kode);

             arrDatang[i] := Copy(strTemp,posnya,panjang);
             posnya := posnya + panjang;
          end;
      end;
      result := arrDatang;
    end;

    function cetaklog1(par: String):string;
    begin
      if mymemo.Lines.Count>100 then
         mymemo.Clear;
      mymemo.Lines.Add('['+formatdatetime('hh:nn:ss',now)+'] Request Inquery [ '+myLokasiId+' ] => No pelanggan '+par);
    end;

    function cetaklog2(par: String):string;
    begin
      if mymemo.Lines.Count>100 then
         mymemo.Clear;
         mymemo.Lines.Add('['+formatdatetime('hh:nn:ss',now)+'] Respon Inquery  [ '+myLokasiId+' ] => No pelanggan '+par);
    end;

    function cetaklog3(par: String):string;
    begin
      if mymemo.Lines.Count>100 then
         mymemo.Clear;
      mymemo.Lines.Add('['+formatdatetime('hh:nn:ss',now)+'] Request Payment [ '+myLokasiId+' ] => No pelanggan '+par);
    end;

    function cetaklog4(par: String):string;
    begin
      if mymemo.Lines.Count>100 then
         mymemo.Clear;
      mymemo.Lines.Add('['+formatdatetime('hh:nn:ss',now)+'] Respon Payment  [ '+myLokasiId+' ] => '+par  );
    end;

    function cetaklog5(par: String):string;
    begin
      if mymemo.Lines.Count>100 then
         mymemo.Clear;
      mymemo.Lines.Add('['+formatdatetime('hh:nn:ss',now)+'] Request Cek Status [ '+myLokasiId+' ] => No pelanggan '+par);
    end;

    function cetaklog6(par: String):string;
    begin
      if mymemo.Lines.Count>100 then
         mymemo.Clear;
      mymemo.Lines.Add('['+formatdatetime('hh:nn:ss',now)+'] Respon Cek Status  [ '+myLokasiId+' ] => No pelanggan '+par);
    end;


    function hitungmaterai(mytmp1:string;mytmp2:string):string;
    var
      vjmlhargaair:string;
    begin
       mymaterai:=inttostr(strtoint(mytmp1)+strtoint(mytmp2));
       if strtoint(mymaterai)<= 250000 then
          result:='0'
       else if ( strtoint(mymaterai)> 250000 ) and ( strtoint(mymaterai)<= 1000000 ) then
          result:='3000'
       else
          result:='6000';

    end;


    function hitungdenda: string;
    var
      vkdbiaya:string;
      vpenambahan:string;
      mySql:TMyQuery;
    begin
        {menentukan denda pokok}

        myquery2.SQL.Clear;
        myquery2.SQL.Add('select biaya from refbiaya where kode_biaya=''01'' ');
        myquery2.Open;

        myvdendapokok1:=myquery2.Fields.Fields[0].AsString;

        {jika pembayaran terlambat}
        if myvmycekidpel then
        begin
          if (myjmlbln >1) and (myjmlbln < 6 ) then
          begin
              myvkdbiaya1:='02';
              myquery2.SQL.Clear;
              myquery2.SQL.Add('select biaya from refbiaya where kode_biaya='+quotedstr(myvkdbiaya1)+' ');
              myquery2.Open;
              myvpenambahan:= myquery2.Fields.Fields[0].AsString;
          end
          else if (myjmlbln >= 6) and (myjmlbln < 12) then
          begin
              myvkdbiaya1:='03';
              myquery2.SQL.Clear;
              myquery2.SQL.Add('select biaya from refbiaya where kode_biaya='+quotedstr(myvkdbiaya1)+' ');
              myquery2.Open;
              myvpenambahan:= myquery2.Fields.Fields[0].AsString;
          end
          else  if ( myjmlbln >12 ) then
          begin
              myvkdbiaya1:='04';
              myquery2.SQL.Clear;
              myquery2.SQL.Add('select biaya from refbiaya where kode_biaya='+quotedstr(myvkdbiaya1)+' ');
              myquery2.Open;
              myvpenambahan:= myquery2.Fields.Fields[0].AsString;
          end;


          if myjmlbln = 1 then
             //result:='0'
             result:=inttostr(strtoint(myvdendapokok1))
          else
             result:= inttostr(strtoint(myvdendapokok1) + strtoint(myvpenambahan));
        end
        else
        begin
          {cek jumlah bulan nya}
          if myjmlbln = 1 then
          begin
             myvpenambahan:='0';
          end
          else if (myjmlbln >1) and (myjmlbln < 6 ) then
          begin
              myvkdbiaya1:='02';

              myquery2.SQL.Clear;
              myquery2.SQL.Add('select biaya from refbiaya where kode_biaya='+quotedstr(myvkdbiaya1)+' ');
              myquery2.Open;
              myvpenambahan:= myquery2.Fields.Fields[0].AsString;

          end
          else if (myjmlbln >= 6) and (myjmlbln < 12) then
          begin
              myvkdbiaya1:='03';
              myquery2.SQL.Clear;
              myquery2.SQL.Add('select biaya from refbiaya where kode_biaya='+quotedstr(myvkdbiaya1)+' ');
              myquery2.Open;
              myvpenambahan:= myquery2.Fields.Fields[0].AsString;
          end
          else  if ( myjmlbln >12 ) then
          begin
              myvkdbiaya1:='04';
              myquery2.SQL.Clear;
              myquery2.SQL.Add('select biaya from refbiaya where kode_biaya='+quotedstr(myvkdbiaya1)+' ');
              myquery2.Open;
              myvpenambahan:= myquery2.Fields.Fields[0].AsString;
          end;


          if myjmlbln =1 then
             result:='0'
          else
             //result:= inttostr(strtoint(myvdendapokok1) + strtoint(myvpenambahan));
             result:= inttostr(strtoint(myvdendapokok1) );
        end;
    end;


    function hitungdenda2: string;
    var
      vkdbiaya:string;
      vpenambahan:string;

    begin
        {menentukan denda pokok}
        myquery2.SQL.Clear;
        myquery2.SQL.Add('select biaya from refbiaya where kode_biaya=''01'' ');
        myquery2.Open;
        myvdendapokok2:=myquery2.Fields.Fields[0].AsString;
        {jika pembayaran terlambat}
        if myvmycekidpel then
        begin
          result:=myvdendapokok2;
        end
        else
        begin
          result:='0';
        end;
    end;

    function PackingArrBalik(arrBalik : arrDataISO):String;
    var
        y : integer;
        dataBalik ,mapBalik, StrLog: String;
        adaSecNya : Boolean;
        secBitmapBalik,primBitmaBalik : String;
    begin
          dataBalik := '';
          mapBalik := '';
          adaSecNya := FALSE;
          strLog := '';
          for y := 2 to 128 do begin
             if arrBalik[y]<>'' then begin
                if y>64 then
                   adaSecNya := TRUE;
                mapbalik := mapBalik + '1';
                if arrISO[y,4]='LVAR' then
                   dataBalik := DataBalik + IntToStr(length(arrBalik[y])) +arrBalik[y]
                else if arrISO[y,4]='LLVAR' then
                   dataBalik := dataBalik + Padding(IntToStr(length(arrBalik[y])),0,2,'0') + arrBalik[y]
                else if arrISO[y,4]='LLLVAR' then
                    dataBalik := dataBalik + Padding(IntToStr(length(arrBalik[y])),0,3,'0') + arrBalik[y]
                else
                    dataBalik := dataBalik + arrBalik[y];
             end else
                mapBalik := mapBalik + '0';
          end;
          if adaSecNya then begin
             mapBalik := '1' + mapBalik;
             secBitmapBalik := EncodeMap(Copy(mapBalik,65,64));
          end else begin
            mapBalik := '0' + mapBalik;
            mapBalik := Copy(mapBalik,1,64);
            secBitmapBalik := '';
          end;
          primBitmaBalik := EncodeMap(Copy(mapBalik,1,64));
          result := primBitmaBalik + secBitmapBalik + dataBalik;
    end;

    procedure TampilkanISOnya;
    var
        x : integer;
    begin
        myMemo.Lines.Add('M T I           -> '+myMTI);
        myMemo.Lines.Add('Primary Bitmap  -> '+PrimBitMap);
        myMemo.Lines.Add('-----------------------------------------------------------------------------');
        for x := 1 to 128 do begin
            if arrBalik[x]<>'' then
               myMemo.Lines.Add(Padding(arrIso[x,0],0,3,' ')+ ' - '+padding(arrISO[x,1],1,50,' ')+' -> '+arrBalik[x]);
        end;
    end;


begin

  inherited;
      arrBalik := UnpackArrayISO(mypesanDatang,PrimBitMap,SecBitMap);
      arrBalik[39] := '99';
      if myMTI='0800' then begin
         arrBalik[7]  := waktosGMT;
         arrBalik[39] := '00';
         MTIbalik := '0810';
         // cek log harian
         dirToday := DirFileLog+'\'+FormatDateTime('YYYYMMDD',now);
         if DirectoryExists(dirToday) then
         begin

         end
         else
         begin
           closefile(FileLog200);
           closefile(FileLog210);
           closefile(FileLog400);
           closefile(FileLog410);

           ForceDirectories(dirToday);
           nmFileLog200 := dirToday+'\'+FormatDateTime('YYYYMMDD',now)+'_0200.log';
           nmFileLog210 := dirToday+'\'+FormatDateTime('YYYYMMDD',now)+'_0210.log';
           nmFileLog400 := dirToday+'\'+FormatDateTime('YYYYMMDD',now)+'_0400.log';
           nmFileLog410 := dirToday+'\'+FormatDateTime('YYYYMMDD',now)+'_0410.log';

           AssignFile(FileLog200,nmFileLog200);
           if FileExists(nmFileLog200) then
             Append(FileLog200)
           else
             Rewrite(FileLog200);
           AssignFile(FileLog210,nmFileLog210);
           if FileExists(nmFileLog210) then
             Append(FileLog210)
           else
             Rewrite(FileLog210);
           AssignFile(FileLog400,nmFileLog400);
           if FileExists(nmFileLog400) then
             Append(FileLog400)
           else
             Rewrite(FileLog400);
           AssignFile(FileLog410,nmFileLog410);
           if FileExists(nmFileLog410) then
             Append(FileLog410)
           else
             Rewrite(FileLog410);
         end;
      end else if myMTI = '0400' then begin
         mtiBalik := '0410';
         arrBalik[39] := '00';
         fDataKirim := '0< <'+myMTI+'<'+myMTI+mypesanDatang;
         Synchronize(RefreshCount);
      end else if myMTI='0200' then begin  // request
         fDataKirim := '0< <'+myMTI+'<'+myMTI+mypesanDatang;
         Synchronize(RefreshCount);

         if (myChkLog.State = cbChecked) then
             TampilkanISOnya;

         CoInitialize(Nil);
         try

             arrBalik[7]  := waktosGMT;

             mynopelanggan:=ArrBalik[48];

             {--------awal ubah disini------------}
             {-----------Proses Inquery/Request--------------}
             if arrBalik[3]='380000' then
             begin
                try
                  try
                   myLokasiId:=trim(arrBalik[43]);
                   cetaklog1(ArrBalik[48]);
                   MTIbalik := '0210';
                   myquery1:=TADOQuery.Create(nil);
                   myquery2:=TADOQuery.Create(nil);
                   myquery2.Connection:=adodb2;
                   myquery1.Connection:=adodb1;

                   if copy(arrbalik[13],3,2)= copy(tmptglhariini,9,2) then
                   begin
                     if strtoint(copy(arrbalik[13],3,2)) >= strtoint(vtglJatuhTemp) then
                        mycekidpel:=true
                     else
                        mycekidpel:=false;
                     myvmycekidpel:=mycekidpel;

                     if not mycekidpel then
                     begin
                        if vbayardenda='0' then
                          mycekidpel1:=false
                        else
                          mycekidpel1:=false;
                     end
                     else
                     begin
                        if vbayardenda='0' then
                           mycekidpel1:=true
                        else
                           mycekidpel1:=false;
                     end;
                     {Jika lebih kecil dari tgl yg ada di tabel refwaktudenda, maka boleh tarnsaksi}
                     if not mycekidpel1  then
                     begin
                       {melakukan pengecekan apakah pelanggan ada apa tidak}
                       myquery2.SQL.Clear;
                       myquery2.SQL.Add('select no_pelanggan,kode_aktif from tpelanggan where no_pelanggan='+quotedstr(mynopelanggan)+' ');
                       MYQUERY2.open;
                       {jika nomor pelanggan tidak ada }
                       if myquery2.Eof then
                       begin
                         arrBalik[39] :='01';
                         arrBalik[48] :='Nomor Pelanggan tidak ditemukan';
                       end
                       else
                       begin
                          mykode_aktif:=myquery2.Fields.Fields[1].AsString;
                         {jika pelanggan ada cek apakah aktif apa tidak}
                         if mykode_aktif<>'Y' then
                         begin
                           arrBalik[39] :='02';
                           arrBalik[48] :='Nomor Pelanggan Non Aktif';
                         end
                         else
                         begin
                           {cek apakah sudah melakukan pembayaran atau belum}
                           myquery1.SQL.Clear;
                           myquery1.SQL.Add('SELECT no_pelanggan,kode_loket FROM  tpembayaran where no_pelanggan='+quotedstr(myNopelanggan)+' ');
                           myquery1.Open;

                           {jika sudah di bayarkan}
                           if not myquery1.Eof then
                           begin
                              mykode_loket:=myquery1.Fields.Fields[1].AsString;
                              {jika bukan loket pos}
                              if mykode_loket <>'POS' then
                              begin
                                arrBalik[39] :='03';
                                arrBalik[48] :='Nomor Pelanggan sudah dibayarkan di tempat lain';
                              end
                              else
                              begin
                                arrBalik[39] :='04';
                                arrBalik[48] :='Nomor Pelanggan sudah Lunas';
                              end;
                           end
                           else
                           begin
                              myquery1.Active:=true;
                              myquery1.SQL.Clear;
                              myquery1.SQL.Add('select no_pelanggan from ttagihan where no_pelanggan='+quotedstr(mynopelanggan)+' ');
                              myquery1.Open;
                              myjmlbln:=myquery1.RecordCount;
                              if myjmlbln = 0 then
                              begin
                                arrBalik[39] :='05';
                                arrBalik[48] :='Belum ada tagihan';
                              end
                              else
                              begin
                                 myquery1.SQL.Clear;
                                 myquery1.SQL.Add('SELECT  a.no_pelanggan,c.nama,c.alamat,a.kode_golongan,a.bulan_rek,b.meter_lalu,b.Meter_Kini '+
                                         ' ,a.pemakaian,(a.tagihan-a.beban) as Uang_Air,a.beban,a.tagihan as Jml_Tagihan,c.kode_wilayah,c.no_urut '+
                                         ' FROM ttagihan a, tcatat_meter b,tpelanggan c where a.no_pelanggan=b.no_pelanggan '+
                                         ' and  a.no_pelanggan=c.no_pelanggan and  a.bulan_rek = b.bulan_rek and a.no_pelanggan='+quotedstr(mynopelanggan)+' ');
                                 myquery1.Open;
                                 mydataXML:=myquery1.Fields.Fields[0].AsString +'|'+ myquery1.fields.Fields[1].AsString +'|'+ myquery1.fields.Fields[2].AsString +'|'+myquery1.fields.Fields[3].AsString +'|'+myquery1.fields.Fields[11].AsString+'/'+myquery1.fields.Fields[12].AsString+'|^'+ copy(myquery1.fields.Fields[4].AsString,1,4)+copy(myquery1.fields.Fields[4].AsString,6,2) +'|'+ myquery1.fields.Fields[5].AsString +'|'+ myquery1.fields.Fields[6].AsString +'|'+myquery1.fields.Fields[7].AsString +'|'+myquery1.fields.Fields[8].AsString +'|'+myquery1.fields.Fields[9].AsString +'|'+hitungmaterai(myquery1.fields.Fields[8].AsString,myquery1.fields.Fields[9].AsString)+'|'+hitungdenda+'|'+inttostr((strtoint(myquery1.fields.Fields[10].AsString)+ strtoint(hitungmaterai(myquery1.fields.Fields[8].AsString,myquery1.fields.Fields[9].AsString))+ strtoint(hitungdenda) )) +'|'+vbeaAdminpos+'|';
                                 myquery1.Next;
                                 while not myquery1.Eof do
                                 begin
                                   mydataXML  :=mydataXML+ copy(myquery1.fields.Fields[4].AsString,1,4)+copy(myquery1.fields.Fields[4].AsString,6,2)+'|'+ myquery1.fields.Fields[5].AsString +'|'+ myquery1.fields.Fields[6].AsString +'|'+myquery1.fields.Fields[7].AsString +'|'+myquery1.fields.Fields[8].AsString +'|'+myquery1.fields.Fields[9].AsString +'|'+hitungmaterai(myquery1.fields.Fields[8].AsString,myquery1.fields.Fields[9].AsString)+'|'+hitungdenda2+'|'+ inttostr(strtoint(myquery1.fields.Fields[10].AsString) + strtoint(hitungmaterai(myquery1.fields.Fields[8].AsString,myquery1.fields.Fields[9].AsString)) + strtoint(hitungdenda2) ) +'|'+vbeaAdminpos+'|';
                                   myquery1.Next;
                                   inc(mycounter);
                                 end;
                                 if mycounter > strtoint(vmaksjmltagihan) then
                                 begin
                                   arrBalik[39] :='06';
                                   arrBalik[48] :='Jumlah billing lebih dari '+vmaksjmltagihan+' bulan harap bayar dikantor Pdam Kab Jember';
                                 end
                                 else
                                 begin
                                   mydataXML:=bacadatateks(mydataXML,'^',1)+inttostr(mycounter)+'^'+bacadatateks(mydataXML,'^',2);
                                   arrBalik[39] :='00';
                                   arrBalik[48]:=mydataXML;

                                 end;
                               end;
                           end;
                          end;
                       end;
                     end
                     else
                     begin
                        arrBalik[39] :='07';
                        arrBalik[48] :='Melebihi tanggal jatuh tempo,harap bayar di PDAM Jember';
                     end;

                   end
                   else
                   begin
                      arrBalik[39] :='08';
                      arrBalik[48] :='Tanggal Midle tidak sama dengan tanggal Gateway,eksekusi gagal';
                   end;

                   if arrBalik[39]='00' then
                   begin
                     arrBalik[61] := vheaderResi;
                     arrBalik[62] := vfooterResi;
                   end
                   else
                   begin
                     arrBalik[61] := '';
                     arrBalik[62] := arrBalik[48];
                   end;
                   cetaklog2(arrBalik[48]);
                  finally

                    freeandnil(myquery1);
                    freeandnil(myquery2);
                  end;

                except
                 on E:Exception do begin
                     vpesan:=e.Message;
                     arrBalik[39] :='91';
                     arrBalik[48] :='Gagal eksekusi ke Data base,input ulang';
                     arrBalik[61] := '';
                     arrBalik[62] := arrBalik[48];
                     cetaklog2(vpesan);
                     mytimer.Enabled:=true;
                     mytimer.Interval:=5000;
                     waktos:=0;

                    {
                     adodb1.Connected:=false;
                     if adodb1.Connected=false then
                     begin
                       adodb1.ConnectionString := KonString1;
                       adodb1.CommandTimeout:=15;
                       adodb1.ConnectionTimeout:=15;
                       adodb1.LoginPrompt:=false;
                       cetaklog2('[Trying Connecting to DBMS MySQL Server ] '+DBip);
                       adodb1.Connected:=true;

                       if  (adodb1.Connected=true) then
                       begin
                         Cetaklog2('[Connected to DBMS MySQL Server Mitra on DB Name] '+Dbnama+' Success');
                         sSql:=TADOQuery.Create(nil);
                         sSql.Connection:=adodb1;
                         sSql.SQL.Clear;
                         sSql.SQL.Add('select no_lppa from tkode_lppa where tanggal_lppa='+quotedstr(tmptglhariini)+'');
                         sSql.Open;
                         vno_lppa:='LP'+sSql.Fields.Fields[0].AsString;

                         sSql.SQL.Clear;
                         sSql.SQL.Add('select waktu_tanggal from refwaktudenda');
                         sSql.Open;
                         vtglJatuhTemp:=sSql.Fields.Fields[0].AsString;
                         sSql1:=TADOQuery.Create(nil);
                         sSql1.Connection:=adodb2;
                       end
                     end;

                     adodb2.Connected:=false;
                     if adodb2.Connected=false then
                     begin
                       adodb2.ConnectionString := KonString2;
                       adodb2.LoginPrompt:=false;
                       Cetaklog2('[Trying Connecting to DBMS MySQL Server ] '+DBip);
                       adodb2.Connected:=true;
                       if  (adodb2.Connected=true) then
                       begin
                        Cetaklog2('[Connected to DBMS MySQL Server Mitra on DB Name] '+DBnama2+' Success');
                       end
                     end;
                    }
                 end;
                end;

             end
             {--------akhir ubah disini------------}

             {--------awal ubah disini proses payment------------}
             {-----------Proses Payment--------------}
             else if arrBalik[3]='180000' then
             begin
               try
                 MTIbalik := '0210';
                 myLokasiId:=trim(arrBalik[43]);
                 cetaklog3(arrBalik[48]);
                 myquery1:=TADOQuery.Create(nil);
                 myquery2:=TADOQuery.Create(nil);
                 myquery1.Connection:=adodb1;
                 myquery2.Connection:=adodb2;
                 myquery1.SQL.Clear;
                 myquery1.SQL.Add('select biaya from refbiaya where kode_biaya=''01'' ');
                 myquery1.Open;
                 myvdendapokok1:=myquery1.Fields.Fields[0].AsString;
                 mydataXML:=arrBalik[48];
                 myIdTransaksi:=arrBalik[42];
                 myJmlrek:=bacadatateks(bacadatateks(mydataXML,'^',1),'|',6);
                 mybaris:=0;
                 myvFaktor:=1;
                 posisi:=0;
                 myvbayar:=false;
               while myvfaktor <= strtoint(myJmlrek)  do
               begin
                 mynopelanggan:=bacadatateks(mydataXML,'|',1);
                 myDatabiling:=bacadatateks(mydataXML,'^',2);

                 myvblnTagih:=copy(StringReplace(TRIM(bacadatateks(mydatabiling,'|',(10 * myBaris)+1)),',','',[rfReplaceAll, rfIgnoreCase]),5,2);
                 myvthnTagih:=copy(StringReplace(TRIM(bacadatateks(mydatabiling,'|',(10 * myBaris)+1)),',','',[rfReplaceAll, rfIgnoreCase]),1,4);
                 myvjmltagihan:= strtoint(StringReplace(TRIM(bacadatateks(mydatabiling,'|',(10 * myBaris)+9)),',','',[rfReplaceAll, rfIgnoreCase]));
                 myvbulan_rek:=myvthntagih+'.'+myvblntagih;
                 myvbeban_tetap:=StringReplace(TRIM(bacadatateks(mydatabiling,'|',(10 * myBaris)+6)),',','',[rfReplaceAll, rfIgnoreCase]);
                 myvbiaya_tarif:=StringReplace(TRIM(bacadatateks(mydatabiling,'|',(10 * myBaris)+5)),',','',[rfReplaceAll, rfIgnoreCase]);
                 myvdenda2:=inttostr( strtoint(StringReplace(TRIM(bacadatateks(mydatabiling,'|',(10 * myBaris)+8)),',','',[rfReplaceAll, rfIgnoreCase]))) ;//hitungdenda2;

                 if strtoint(myvdenda2) < strtoint(myvdendapokok1)  then
                 begin
                    myvdenda:='0';
                    myvbiayaket:='0';
                 end
                 else
                 begin
                    myvdenda:=myvdendapokok1;
                    myvbiayaket:=inttostr( strtoint(StringReplace(TRIM(bacadatateks(mydatabiling,'|',(10 * myBaris)+8)),',','',[rfReplaceAll, rfIgnoreCase]))- strtoint(myvdendapokok1) );
                 end;

                 myvmaterai:=StringReplace(TRIM(bacadatateks(mydatabiling,'|',(10 * myBaris)+7)),',','',[rfReplaceAll, rfIgnoreCase]);
                 myvretribusi:='0';
                 myvtotal:=StringReplace(TRIM(bacadatateks(mydatabiling,'|',(10 * myBaris)+9)),',','',[rfReplaceAll, rfIgnoreCase]);
                 myvtunai:=StringReplace(TRIM(bacadatateks(mydatabiling,'|',(10 * myBaris)+9)),',','',[rfReplaceAll, rfIgnoreCase]);
                 myvkembalian:='0';
                 myvtanggal_bayar:=formatDateTime('dd/mm/yyyy',now);
                 myvtanggal:=formatDateTime('dd/mm/yyyy',now);
                 myvwaktu:=copy(arrBalik[12],1,2)+':'+copy(arrBalik[12],3,2)+':'+copy(arrBalik[12],5,2);
                 myvactivite_time:=vtanggal+' '+vwaktu;
                 myvkode_kolektor:='0';
                 myvdiskon_denda:='0';
                 myvdiskon_tagihan:='0';
                 myvptg_denda:='0';
                 myvptg_tagihan:='0';
                 myvbiaya_tambahan:='0';
                 myvbiaya_lain:='0';
                 myvstatus:='Y';
                 myvkode_golongan:=bacadatateks(mydataXML,'|',4);
                 vtgl:='';
                 myvbulan:='';
                 myvtahun:='';
                 myvkeluar:=false;

                 myquery1.SQL.Clear;
                 myquery1.SQL.Add('select a.no_rek,c.no_urut,a.kode_wilayah,'+
                         ' c.saluran '+
                         ' from tkode_rekening a ,tpelanggan c where '+
                         ' a.no_pelanggan='+quotedstr(mynopelanggan)+' and (a.no_pelanggan =c.no_pelanggan) and a.kode_bulan='+quotedstr(copy(myvbulan_rek,6,2))+' and '+
                         ' a.tahun='+quotedstr(copy(myvbulan_rek,1,4))+' ');
                 myquery1.Open;

                 if not myquery1.Eof then
                 begin
                    myvno_rek:=myquery1.Fields.Fields[0].AsString;
                    myvno_urut:=myquery1.Fields.Fields[1].AsString;
                    myvkode_wilayah:=myquery1.Fields.Fields[2].AsString;
                    myvsaluran:=myquery1.Fields.Fields[3].AsString;
                 end
                 else
                 begin
                    myvno_rek:='0';
                    myvno_urut:='0';
                    myvkode_wilayah:='0';
                 end;

                 {proses insert data ke tabel tpembayaran}
                 try
                    myquery1.SQL.Clear;
                    myquery1.SQL.Add('select no_pelanggan from tpembayaran where no_pelanggan='+quotedstr(mynopelanggan)+' and bulan_rek='+quotedstr(myvbulan_rek)+' ');
                    myquery1.Open;
                    {jika belum di bayar, lakukan insert}
                    if myquery1.Eof then
                    begin

                      myquery1.SQL.Clear;
                      myquery1.SQL.Add('insert into tpembayaran(no_rek,no_lppa,no_pelanggan,no_urut,kode_wilayah,bulan_rek,'+
                          'beban_tetap,biaya_tarif,denda,biaya_ket,materai,retribusi,total,tunai,kembali,tanggal_bayar,'+
                          'kode_loket,user_id,tanggal,waktu,activite_time,kode_kolektor,kode_unit,diskon_denda,diskon_tagihan,'+
                          'ptg_denda,ptg_tagihan,biaya_tambahan,status,saluran,kode_golongan) VALUES('+quotedstr(myvno_rek)+','+quotedstr(vno_lppa)+','+quotedstr(mynopelanggan)+','+
                          ''+quotedstr(myvno_urut)+','+quotedstr(myvkode_wilayah)+','+quotedstr(myvbulan_rek)+','+quotedstr(myvbeban_tetap)+','+quotedstr(myvbiaya_tarif)+','+quotedstr(myvdenda)+','+quotedstr(myvbiayaket)+','+quotedstr(myvmaterai)+','+
                          ''+quotedstr(myvretribusi)+','+quotedstr((myvtotal))+','+quotedstr(myvtunai)+','+quotedstr(myvkembalian)+','+quotedstr(myvtanggal_bayar)+','+quotedstr(vkode_loket)+','+quotedstr(myidtransaksi)+','+quotedstr(myvtanggal)+','+quotedstr(myvwaktu)+','+
                          ''+quotedstr(myvactivite_time)+','+quotedstr(myvkode_kolektor)+','+quotedstr(vkode_unit)+','+quotedstr(myvdiskon_denda)+','+quotedstr(myvdiskon_tagihan)+','+quotedstr(myvptg_denda)+','+
                          ''+quotedstr(myvptg_tagihan)+','+quotedstr(myvbiaya_tambahan)+','+quotedstr(myvstatus)+','+quotedstr(myvsaluran)+','+quotedstr(myvkode_golongan)+')');

                      myquery1.ExecSQL;
                      myvbayar:=true;
                    end
                    else
                    begin
                      myvbayar:=false;
                    end;

                 except
                     arrBalik[39] :='12';
                     arrBalik[48] :='Payment gagal';
                 end;
                 inc(mybaris);
                 inc(myvfaktor);
               end;

                 if not myvbayar then
                 begin
                   arrBalik[39] :='88';
                   arrBalik[48] :='Tagihan sudah dibayar';
                 end
                 else
                 begin
                    arrBalik[39]:='00';
                 end;

                 if arrBalik[39]='00' then
                 begin
                     arrBalik[61] := vheaderResi;
                     arrBalik[62] := vfooterResi;
                 end
                 else
                 begin
                     arrBalik[61] := '';
                     arrBalik[62] := arrBalik[48];
                 end;

               except
                  on E:Exception do
                  begin
                  end;
               end;
               cetaklog4(arrBalik[48]);

             end
             {--------akhir ubah disini proses payment------------}


             {--------awal ubah disini proses cekstatus------------}
             else if arrBalik[3]='380001' then
             begin
                  try
                    myLokasiId:=trim(arrBalik[43]);
                    cetaklog5(arrBalik[48]);
                   myquery1:=TADOQuery.Create(nil);
                   myquery1.Connection:=adodb1;

                   MTIbalik := '0210';
                   mynopelanggan:=bacadatateks(ArrBalik[48],'|',1);
                   myDatabiling:=bacadatateks(ArrBalik[48],'^',2);
                   vtglTransaksi:=formatdatetime('yyyy-mm-dd',now);
                   myIdTransaksi:=copy(arrBalik[42],7,9);
                   mybaris:=0;
                   myvFaktor:=1;
                   posisi:=0;
                   myvbayar:=false;
                while myvfaktor <= strtoint(myJmlrek)  do
                begin
                   myvblnTagih:=copy(StringReplace(TRIM(bacadatateks(mydatabiling,'|',(10 * myBaris)+1)),',','',[rfReplaceAll, rfIgnoreCase]),5,2);
                   myvthnTagih:=copy(StringReplace(TRIM(bacadatateks(mydatabiling,'|',(10 * myBaris)+1)),',','',[rfReplaceAll, rfIgnoreCase]),1,4);
                   myvbulan_rek:=myvthntagih+'.'+myvblntagih;
                   myquery1.SQL.Clear;
                   myquery1.SQL.Add('select no_pelanggan from tpembayaran where no_pelanggan='+quotedstr(mynopelanggan)+' and bulan_rek='+quotedstr(myvbulan_rek)+' and kode_loket='+quotedstr(vkode_loket)+' and user_id='+quotedstr(myidtransaksi)+' ');
                   myquery1.Open;
                   if not myquery1.Eof then
                   begin
                      arrBalik[39] :='00';
                   end
                   else
                   begin
                      arrBalik[39]:='12';
                      arrBalik[48] :='Tagihan sudah dibayarkan ';
                   end;
                   inc(mybaris);
                   inc(myvfaktor);
                end;

                   if arrBalik[39]='00' then
                   begin
                     arrBalik[61] := vheaderResi;
                     arrBalik[62] := vfooterResi;
                   end
                   else
                   begin
                     arrBalik[61] := '';
                     arrBalik[62] := bacadatateks(arrBalik[48],'|',1);
                   end;
                  except
                     on E:Exception do begin
                        myMemo.Lines.Add('SQL ERROR : '+E.Message);
                        arrBalik[39] := '99';
                        arrBalik[61] := '';
                     end;
                  end;
               cetaklog6(arrBalik[48]);
            end;
         finally

         end;
         CoUninitialize();
      end;
      dataBalik1 := MTIbalik+PackingArrBalik(arrBalik);
      if MTIbalik<>'0810' then begin
          fDataKirim := '1<'+arrBalik[39]+'<'+MTIbalik+'<'+Databalik1;
          Writeln(FileLog210,dataBalik1+'#'+IpRemote+'#'+waktosNonGMT);
          Flush(FileLog210);

          Synchronize(RefreshCount);
          if (myChkLog.Checked)  then begin
              myMemo.Lines.Add('');
              myMemo.Lines.Add('Send Message    -> '+dataBalik1);
              myMTI := MTIbalik;
              TampilkanISOnya;
          end;
      end;

      if not myChkTimeOut.Checked then begin
         try
             Synchronize(error);
             mySocket.Send(myConn,CekLength(databalik1)+databalik1);
         except
           on E:EipwIPDaemon do begin
              ReadyToSend := FALSE;
              if E.Code=10035 then begin
                 while not ReadyToSend do begin
                   mySocket.DoEvents;
                 end;
                 mySocket.Send(myConn, ceklength(databalik1)+databalik1);
              end;
           end;
         end;
      end;
end;

procedure TDidyThread.KirimMessage;
var
  DataKirim : String;
  ReadyToSend : Boolean;

    function CekLength(messBalik:String):String;
    var
      lmess,hasilmod,hasilbagi : integer;
      chrlength : String;
    begin
      lmess := length(messBalik);
      if lmess>255 then begin
        hasilMod := lmess mod 256;
        hasilbagi := (lmess - hasilmod) div 256;
        chrLength :=  chr(hasilbagi) + chr(hasilmod);
      end else
        chrlength := chr(0)+chr(lmess);
      result := chrlength;
    end;

begin
   DataKirim := BacaDataTeks(fDataKirim,'<',4);
   try
         mySocket.Send(myConn,CekLength(DataKirim)+DataKirim);

         myEdit.AsInteger := myEdit.AsInteger + 1;
   except
     on E:EipwIPDaemon do begin
        ReadyToSend := FALSE;
        if E.Code=10035 then begin
           while not ReadyToSend do begin
             mySocket.DoEvents;
           end;
           mySocket.Send(myConn, ceklength(DataKirim)+DataKirim);
        end;
     end;
   end;
end;

procedure TdidyThread.error;
begin
  //
end;

procedure TDidyThread.RefreshCount;
var
   X : TListItem;
begin
   if myViewLog.Items.Count>100 then
      myViewLog.Items.Clear;
   X := myViewLog.Items.Add;
   if BacaDataTeks(fDataKirim,'<',1)='1' then begin
      myEdit.AsInteger := myEdit.AsInteger + 1;
      X.Caption := FormatDateTime('hh:nnn:ss.zzz',now);
      X.SubItems.Add(BacaDataTeks(fDataKirim,'<',3));
      X.SubItems.Add(BacaDataTeks(fDataKirim,'<',4));
      X.SubItems.Add(BacaDataTeks(fDataKirim,'<',2));
   end else begin
      X.Caption := FormatDateTime('hh:nnn:ss.zzz',now);
      X.SubItems.Add(BacaDataTeks(fDataKirim,'<',3));
      X.SubItems.Add(BacaDataTeks(fDataKirim,'<',4));
      X.SubItems.Add('');
   end;
   X.MakeVisible(false);
end;


procedure TForm1.ipwIPDaemon1Connected(Sender: TObject; ConnectionId,
  StatusCode: Integer; const Description: String);
var
  ketemu : Boolean;
  i : integer;
  X : TListItem;
  ClientConnectInfo : TServerConnectionStatus;
begin
    Cetak('Connection from '+ipwIPDaemon1.RemoteHost[ConnectionId]+'  Accepted ...');
    // warnai Koneksi Image dan Shape
    X := lvServerActivity.Items.Add;
    X.Caption := 'Connected';
    X.SubItems.Add(ipwIPDaemon1.RemoteHost[ConnectionID]);
    X.SubItems.Add(ipwIPDaemon1.RemoteHost[ConnectionID]);
    X.SubItems.Add(IntToStr(ipwIPDaemon1.RemotePort[ConnectionID]));
    X.SubItems.Add(formatdatetime('dd-mm-yyyy hh:nn:ss.zzz',now));
    X.SubItems.Add('OK');

    with ServerConnectionStatus[ConnectionId] do begin
        tcsActiveConnections := ConnectionId;
        tcsScreenName        := 'MIDDLE';
        tcsRemoteAddress     := ipwIPDaemon1.RemoteHost[ConnectionID];
        tcsRemotePort        := ipwIPDaemon1.RemotePort[ConnectionID];
        tcsMessage           := '';
    end;
    DisplayConnectionsInfo;

    ketemu := FALSE;
    i := 0;
    while (i<=High(ipListed)) and (not ketemu) do begin
        if ipListed[i]=ipwIPDaemon1.RemoteHost[ConnectionId] then
        begin
           ketemu := TRUE;
           IpRemote:=ipwIPDaemon1.RemoteHost[ConnectionId];
           dfs.Panels.Items[1].Text:='Middle Dacen Conected [1]   '+ipwIPDaemon1.RemoteHost[ConnectionID];
        end
        else
           inc(i);
    end;
    if ketemu then begin
       arrImage[i].Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'computer_accept.ico');
       arrShape[i].Brush.Color := clLime;
    end;
end;


procedure TForm1.ipwIPDaemon1ConnectionRequest(Sender: TObject;
  const Address: String; Port: Integer; var Accept: Boolean);
var
  i : integer;
  ketemu : Boolean;
  X : TListItem;
begin
    cetak('Connection Request From : '+address+' port : '+IntToStr(port));
    // Cek Ip Listed
    X := lvServerActivity.Items.Add;
    X.Caption := 'Connection REQ';
    X.SubItems.Add('');
    X.SubItems.Add(Address);
    X.SubItems.Add(IntToStr(port));
    X.SubItems.Add(formatdatetime('dd-mm-yyyy hh:nn:ss.zzz',now));
    ketemu := FALSE;
    i := 0;
    //while (i<High(ipListed)) and (not ketemu) do begin
    while (i<=High(ipListed)) and (not ketemu) do begin
        if ipListed[i]=address then
           ketemu := TRUE
        else
           inc(i);
    end;
    if ketemu then begin
       if ipwIPDaemon1.ConnectionCount>maxConnetion then begin
          X.SubItems.Add('DENY, Max Connection Exeeded');
          Accept := FALSE;
       end else begin
           Accept := TRUE;
           cetak('Connection Request From : '+address+' ACCEPTED');
           X.SubItems.Add('ACCEPTED');
       end;
    end else begin
       X.SubItems.Add('DENY, unrecognized IP Address');
       Accept := FALSE;
    end;
end;

procedure TForm1.ipwIPDaemon1DataIn(Sender: TObject; ConnectionId: Integer;
  Text: String; EOL: Boolean);
var
  prosesMessage,ReadText : AnsiString;
  PnjData,conID : Integer;
  MTIBalik,MTI : String;
  X : TListItem;


begin
  //EOL := FALSE;
  conID := ConnectionId;
  repeat

     edMessIn.AsInteger := edMessIn.AsInteger + 1;
     ServerConnectionStatus[ConID].tcsMessage := ServerConnectionStatus[ConID].tcsMessage + Text;
     Text := '';
     while length(ServerConnectionStatus[ConID].tcsMessage)>0 do begin
           pnjData := Ord(ServerConnectionStatus[ConID].tcsMessage[1]) + Ord(ServerConnectionStatus[ConID].tcsMessage[2])*256;   // ini yg normal
           prosesMessage := Copy(ServerConnectionStatus[ConID].tcsMessage,3,PnjData);
           if length(prosesMessage)=pnjData then begin
                ServerConnectionStatus[ConID].tcsMessage := Copy(ServerConnectionStatus[ConID].tcsMessage, pnjData+3,length(ServerConnectionStatus[ConID].tcsMessage));
                 Writeln(FileLog200,prosesMessage+'#'+ipwIPDaemon1.RemoteHost[ConnectionId]+'#'+waktosNonGMT);
                 Flush(FileLog200);
                 edProses.AsInteger := edProses.AsInteger + 1;
                 MTI := Copy(prosesMessage,1,4);
                  if MTI='0800' then begin
                     Cetak('Client SIGN ON ...');
                     MTIBalik := '0810'
                  end else if MTI='0400' then
                     MTIBalik := '0410'
                  else if MTI='0200' then
                     //MTIBalik := '0710';
                     MTIBalik := '0210';
                  if ((MTI='0200') or (MTI='0400') or (MTI='0800')) and (chkTO.State=cbUnchecked) then
                     //myDidyThread := ExecuteThreadSynch(tpTimeCritical,MTI,TRIM(copy(prosesMessage,5,length(prosesmessage))),ipwIPDaemon1,conID,memReceive,lViewLog,edSend,cbLogAllClientMessages,chkTO,chkLateRespon,konString1);
                  begin
                     //XmlParser := TXmlParser.Create;
                     dataXML:='';
                     //myDidyThread := ExecuteThreadSynch(tpTimeCritical,MTI,TRIM(copy(prosesMessage,5,length(prosesmessage))),ipwIPDaemon1,conID,memReceive,lViewLog,edSend,cbLogAllClientMessages,chkTO,chkLateRespon,vHostUrl,LstparamURL,hasilURL,XMLParser,ansiBuf,dataXML);
                     vIdhttp:=TIdHTTP.Create(nil);
                     vXMLParser:=TXMLParser.Create;
                     vLstparamURL:=Tstringlist.Create;
                     vhasilURL:=Tstringlist.Create;
                     vjmlbln:=1;
                     vCekidpel:=false;
                     vcekidpel1:=false;
                     vjmltagihan:=0;
                     vJmlrek:='1';
                     vCounter:=1;
                     vnolppa:='';
                     vkode_aktif:='';

                     //con1:=TMyConnection.Create(nil);
                     //con2:=TMyConnection.Create(nil);
                     //sSql:=TMyQuery.Create(nil);
                     //sSql1:=TMyQuery.Create(nil);
                     //ssql.Connection:=con1;
                     //ssql1.Connection:=con2;

                     myDidyThread := ExecuteThreadSynch(tpTimeCritical,MTI,TRIM(copy(prosesMessage,5,length(prosesmessage))),ipwIPDaemon1,conID,memReceive,lViewLog,edSend,cbLogAllClientMessages,chkTO,chkLateRespon,konString1,konstring2,vXMLParser,vLstparamURL,vhasilUrl,vAnsibuf,dataXML,vNopelanggan,vIdHttp,vjmltagihan,vbaris,vBulan,vTahun,vkeluar,vjmlbln,vidTransaksi,vCekidpel,vGol,vTotal,vJmlrek,vDatabiling,vDatabiling1,vFaktor,vArrblnTagih,vDecounter,vCounter,vnolppa,vkode_aktif,vkode_loket,sSql,sSql1,adodb1,adodb2,IpRemote,vcekidpel1,vconlokasiid,vconPenambahan,vconmyvmycekidpel,vconmaterai,vcontmp1,vcontmp2,vcondendapokok1,vconkdbiaya1,vcondendapokok2,vconkdbiaya2,vconvblntagih,vconvthntagih,vconvbulan_rek,vconvbeban_tetap,
                                     vconvbiaya_tarif,vconvdenda2,vconvdenda,vconvbiayaket,vconvmaterai,vconvretribusi,
                                     vconvtotal,vconvtunai,vconvkembalian,vconvtanggal_bayar,vconvtanggal,vconvwaktu,
                                     vconvactivite_time,vconvkode_kolektor,vconvdiskon_denda,vconvdiskan_tagihan,
                                     vconvptg_denda,vconvptg_tagihan,vconvbiaya_tambahan,vconvbiaya_lain,vconvstatus,
                                     vconvkode_golongan,vconvno_rek,vconvno_urut,vconvkode_wilayah,vconvsaluran,vbayar,timer3,waktos);
                  end;
           end else
              break;
     end;
  Until (length(text)<=0);
end;

procedure TForm1.ipwIPDaemon1Disconnected(Sender: TObject; ConnectionId,
  StatusCode: Integer; const Description: String);
var
  ketemu : Boolean;
  i,jmlKetemu,found : integer;
  X : TListItem;
  ClientConnectInfo : TServerConnectionStatus;
begin
    Cetak(ipwIPDaemon1.RemoteHost[ConnectionId]+' Disconnected ...');
    // warnai Koneksi Image dan Shape
    X := lvServerActivity.Items.Add;
    X.Caption := 'Disconnected';
    X.SubItems.Add(ipwIPDaemon1.RemoteHost[ConnectionID]);
    X.SubItems.Add(ipwIPDaemon1.RemoteHost[ConnectionID]);
    X.SubItems.Add(IntToStr(ipwIPDaemon1.RemotePort[ConnectionID]));
    X.SubItems.Add(formatdatetime('dd-mm-yyyy hh:nn:ss.zzz',now));
    X.SubItems.Add('OK');

    ketemu := FALSE;
    i := 0;
    jmlKetemu := 0;
    found := -1;
    while (i<High(ServerConnectionStatus)+1) and (jmlKetemu<3) do begin
        if ServerConnectionStatus[i].tcsRemoteAddress =ipwIPDaemon1.RemoteHost[ConnectionId] then begin
           found := i;
           inc(jmlKetemu);
           ketemu := TRUE;
        end;
        inc(i);
    end;
    if (ketemu) and (jmlKetemu=1) then begin
          // Cek pada IPListed
          ketemu := FALSE;
          i := 0;
          while (i<=High(ipListed)) and (not ketemu) do begin
              if ipListed[i]=ipwIPDaemon1.RemoteHost[ConnectionId] then
                 ketemu := TRUE
              else
                 inc(i);
          end;
          dfs.Panels.Items[1].Text:='Middle Dacen Conected [0]';
          arrImage[i].Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'computer_delete.ico');
          arrShape[i].Brush.Color := $0080FFFF;
    end;

    with ServerConnectionStatus[ConnectionId] do
    begin
      tcsActiveConnections := -1;
      tcsScreenName        := 'Empty';
      tcsRemoteAddress     := '0.0.0.0';
      tcsRemotePort        := 0;
      tcsMessage           := '';
    end;
    DisplayConnectionsInfo;
end;

procedure TForm1.ipwIPDaemon1Error(Sender: TObject; ErrorCode: Integer;
  const Description: String);
begin
   Cetak('Socket Error : '+IntToStr(ErrorCode)+' '+Description);
end;

procedure TForm1.btnResetClick(Sender: TObject);
begin
   edMessIn.Value := 0;
   edProses.Value := 0;
   edSend.Value := 0;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i : byte;
  Flag: UINT;
  AppSysMenu: THandle;

begin
   //con1:=TMyConnection.Create(nil);
   //con2:=TMyConnection.Create(nil);
   //con1:=TSQLConnection.Create(nil);
   //con2:=TSQLConnection.Create(nil);

   adodb1:= TADOConnection.Create(nil);
   adodb2:= TADOConnection.Create(nil);
   
   VTGH:=0;
   VTGH1:=0;
   AppSysMenu:=GetSystemMenu(Handle,False);
   Flag:=MF_GRAYED;
   EnableMenuItem(AppSysMenu,SC_CLOSE,MF_BYCOMMAND or Flag);

   Image1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'computer_delete.ico');
   ImageDB1.Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'database_delete.ico');
   with sgServerConnections do begin
      RowCount := maxConnetion+1;
      cells[0,0] := 'ConnID';
      cells[1,0] := 'Host';
      Cells[2,0] := 'IP Address';
      cells[3,0] := 'RemotePort';
   end;
   setlength(ServerConnectionStatus,maxConnetion);
   for i := 0 to high(ServerConnectionStatus) do begin
       ServerConnectionStatus[i].tcsActiveConnections := -1;
       ServerConnectionStatus[i].tcsScreenName := 'Empty';
       ServerConnectionStatus[i].tcsRemoteAddress := '0.0.0.0';
       ServerConnectionStatus[i].tcsRemotePort := 0;
       ServerConnectionStatus[i].tcsMessage := '';
   end;
   // Isi connection Status
   with sgServerConnections do begin
      for i := 0 to high(ServerConnectionStatus) do begin
           cells[0,i+1] := IntToStr(ServerConnectionStatus[i].tcsActiveConnections);
           cells[1,i+1] := ServerConnectionStatus[i].tcsScreenName;
           cells[2,i+1] := ServerConnectionStatus[i].tcsRemoteAddress;
           cells[3,i+1] := IntToStr(ServerConnectionStatus[i].tcsRemotePort);
      end;
   end;

end;

procedure TForm1.ShutdownServer1Click(Sender: TObject);
var
  I : Integer;
  stopYes : Boolean;

begin
      suipassdlg.ValueText := '';
      if suipassdlg.ShowModal=mrOK then begin
         if (suipassdlg.ValueText=defaultpassadmin) or (suipassdlg.ValueText=AdminPass) then begin
            stopYes := FALSE;
            if ipwIPDaemon1.ConnectionCount>0 then begin
               if MessageDlg('Masih ada Client yang aktif, yakin akan Stop Server ?',mtConfirmation,[mbOK,mbCancel],0)=mrOK then
                  stopYes := TRUE;
            end else
               stopYes := TRUE;
            if stopYes then begin
                with ipwIPDaemon1 do
                begin
                  for I := 1 to (ConnectionCount) do
                    if Connected[i] then Connected[i] := FALSE;
                end;
                //if ADOdb1.Connected then
                //   ADOdb1.Connected := FALSE;
                //if ADOdb2.Connected then
                //   ADOdb2.Connected := FALSE;

                Application.Terminate;
            end;
         end;
      end;
end;

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ShortCutToText(ShortCut(Key, Shift)) = 'Ctrl+S') then begin
      suipassdlg.ValueText := '';
      if suipassdlg.ShowModal=mrOK then begin
         if (suipassdlg.ValueText=defaultpassadmin) or (suipassdlg.ValueText=AdminPass) then
             //frmSetting.ShowModal;

      end;
  end else if (ShortCutToText(ShortCut(Key, Shift)) = 'Ctrl+T') then begin
      suipassdlg.ValueText := '';
      if not gbServerSettings.Enabled then begin
          if suipassdlg.ShowModal=mrOK then begin
             if (suipassdlg.ValueText=defaultpassadmin) or (suipassdlg.ValueText=AdminPass) then
                 gbServerSettings.Enabled := TRUE;
          end;
      end else
         gbServerSettings.Enabled := FALSE;

  end else if (ShortCutToText(ShortCut(Key, Shift)) = 'Ctrl+M') then  begin
      //CoolTray.HideMainForm;
      //CoolTray.StartMinimized := TRUE
  end else if (ShortCutToText(ShortCut(Key, Shift)) = 'Ctrl+X') then
      ShutdownServer1Click(self);
end;

procedure TForm1.lViewLogDblClick(Sender: TObject);
begin
   Clipboard.AsText := lViewLog.Selected.SubItems[1];
end;

procedure TForm1.btnServerCloseClick(Sender: TObject);
begin
  try
    ipwipdaemon1.Listening:=false;
  except
    on E:Exception do
      //cetak('Error closed'+e.message);
  end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);

begin

dfs.Panels.Items[2].Text:= '[TANGGAL ] [ '+FormatDateTime('YYYY-MM-DD'+' ] [ '+'HH:MM:SS'+' ]', NOW);
tmptglhariini:=formatDateTime('yyyy-mm-dd',now);

    //timer3.Enabled:=true;
    //timer3.Interval:=1000;
end;


procedure TForm1.Timer3Timer(Sender: TObject);

   {tempat function bacaiplisted}
   function BacaIpListed2:Boolean;
   var
     strIp : TStringList;
     i : integer;
   begin
       if FileExists(ExtractFilePath(Application.ExeName)+'iplisted.txt') then begin
          try
             strIp := TStringList.Create;
             strIp.LoadFromFile(ExtractFilePath(Application.ExeName)+'iplisted.txt');
             setlength(iplisted,strIp.Count);
             setlength(arrShape,strIp.Count);
             setlength(arrImage,strIp.Count);
            // for i := 0 to high(iplisted)-1 do begin
             for i := 0 to high(iplisted) do begin
                ipListed[i] := strIp.Strings[i];
                arrShape[i] := TShape.Create(PanelImage);
                arrShape[i].Shape := stRectangle;
                arrShape[i].Brush.Style := bsSolid;
                arrShape[i].Pen.Width := 1;
                arrShape[i].Pen.Style := psClear;
                arrShape[i].Brush.Color := $0080FFFF;
                arrShape[i].Height := 50;
                arrShape[i].Width := 10;
                arrShape[i].Left := (i+1) * 50 ;//+ (i+50);
                arrShape[i].Top := 115;
                arrShape[i].Tag := i+5;
                arrShape[i].Parent := PanelImage;
                arrImage[i] := TImage.Create(PanelImage);
                arrImage[i].Picture.LoadFromFile(ExtractFilePath(Application.ExeName)+'computer_delete.ico');
                arrImage[i].AutoSize := TRUE;
                arrImage[i].ShowHint := TRUE;
                arrImage[i].Hint := strIp.Strings[i];
                arrImage[i].Top := 170;
                arrImage[i].Left := ((i+1) * 40) + (i*10) ;
                arrImage[i].Parent := PanelImage;
            end;
          finally
             result := TRUE;
             freeAndNil(strIp);
          end;
       end else
          result := FALSE;
   end;


begin
   //timer1.Enabled:=true;

   inc(waktos);
   if waktos=2 then begin
     if BisaKonekKeDB then
     begin
       if BacaIpListed2 then begin
          AplikasiOK := TRUE;
          //btnServerOpenClick(self);
         if AplikasiOK then begin
            //CoolTray.HideMainForm;
            //CoolTray.MinimizeToTray := TRUE;
         end;
       end else
          Cetak('Tidak ada IP Client yang terdaftar ...');
       timer3.Enabled:=false;
     end
     else
     begin
       Cetak('Reconnect Koneksi ke Database GAGAL');
       timer3.Enabled:=true;
       waktos:=0;
     end;
   end;
end;

procedure TForm1.Timer4Timer(Sender: TObject);
begin
   //bisakonekkedb;
   //timer4.Enabled:=false;
end;

end.
