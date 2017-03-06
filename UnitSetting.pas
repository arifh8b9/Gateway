unit UnitSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, NxCollection, AdvEdBtn, AdvDirectoryEdit, StdCtrls, AdvEdit,
  ExtCtrls, IPEdit,enkripsi;

type
  TfrmSetting = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    edPort: TAdvEdit;
    edFolder: TAdvDirectoryEdit;
    edPass1: TAdvEdit;
    edPass2: TAdvEdit;
    GroupBox2: TGroupBox;
    edDBip: TIPEdit;
    edDBnama: TAdvEdit;
    edDBlogin: TAdvEdit;
    edDBpass: TAdvEdit;
    GroupBox4: TGroupBox;
    Label2: TLabel;
    edDB1ip: TIPEdit;
    edDB1nama: TAdvEdit;
    edDB1login: TAdvEdit;
    edDB1pass: TAdvEdit;
    GroupBox3: TGroupBox;
    btnRekam: TNxButton;
    btnBatal: TNxButton;
    txtHeader: TAdvEdit;
    Label3: TLabel;
    Label4: TLabel;
    txtfooter: TAdvEdit;
    Label5: TLabel;
    Label6: TLabel;
    txtmakstagihan: TAdvEdit;
    Label8: TLabel;
    txtadminpos: TAdvEdit;
    Label1: TLabel;
    txtkode_loket: TAdvEdit;
    Label7: TLabel;
    txtkode_unit: TAdvEdit;
    opt1: TRadioButton;
    opt2: TRadioButton;
    Label9: TLabel;
    procedure btnBatalClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnRekamClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSetting: TfrmSetting;

implementation
uses Unit1;

{$R *.dfm}

procedure TfrmSetting.btnBatalClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmSetting.FormShow(Sender: TObject);
begin
    edPort.Text:= inttostr(portLokal); // .IntValue := portLokal;
    edFolder.Text := dirFileLog;
    edPass1.Text := AdminPass;
    txtheader.Text:=vheaderresi;
    txtfooter.Text:=vfooterresi;
    txtadminpos.Text:=vbeaAdminpos;
    txtmakstagihan.Text:=vmaksjmltagihan;
    edDBip.Text := DBip;
    edDBnama.Text := DBnama;
    edDBlogin.Text := DBuser;
    edDBpass.Text := DBpass;
    if vbayardenda='0' then
      opt1.Checked:=true
    else if vbayardenda='1' then
      opt2.Checked:=true
    else
      opt1.Checked:=true;


end;

procedure TfrmSetting.btnRekamClick(Sender: TObject);

    function isianValid:Boolean;
    var
      sah : Boolean;
    begin
      sah := FALSE;
      if (edPort.IntValue<100) and (edPort.IntValue>99999) then
          MessageDlg('Port Server Tidak valid',mtError,[mbOK],0)
      else if edFolder.Text='' then
          MessageDlg('Folder File Log tidak valid',mtError,[mbOK],0)
      else if length(edPass1.Text)<4 then
          MessageDlg('Password Admin Tidak valid',mtError,[mbOK],0)
      else if edPass1.Text<>edPass2.Text then
          MessageDlg('Kofirmasi password tidak sama',mtError,[mbOK],0)
      //else if edDBip.Text='0.0.0.0' then
      else if edDBip.Text='' then
          MessageDlg('IP DB tidak boleh kosong',mtError,[mbOK],0)
      else if txtheader.Text='' then
          MessageDlg('Header resi tidak boleh kosong',mtError,[mbOK],0)
      else if txtfooter.Text='' then
          MessageDlg('Footer resi tidak boleh kosong',mtError,[mbOK],0)
      else if txtfooter.Text='' then
          MessageDlg('Bea Admin Pos tidak boleh kosong',mtError,[mbOK],0)
      else if txtmakstagihan.Text='' then
          MessageDlg('Maksimal Jumlah Tagihan tidak boleh kosong',mtError,[mbOK],0)
      else if length(edDBnama.Text)<4 then
          MessageDlg('Nama Database Server tidak valid',mtError,[mbOK],0)
      else if length(edDBlogin.Text)<2 then
          MessageDlg('User Database Server tidak valid',mtError,[mbOK],0)
      else if length(edDBpass.Text)<4 then
          MessageDlg('Password Database Server tidak valid',mtError,[mbOK],0)
      else
          sah := TRUE;
      result := sah;
    end;

    procedure RekamSetting;
    var
      strList : TStringList;
    begin
      try
          strList := TStringList.Create;
          strList.Add('[Konf]');
          strList.Add('port='+edPort.Text);
          strList.Add('DirLogFile='+edFolder.Text);
          strList.Add('passAdmin='+EncodePWDEx(edPass1.Text,secureString,0,20));
          strList.Add('[Database]');
          strList.Add('IpDb='+edDBip.Text);
          strList.Add('namaDB='+edDBnama.Text);
          strList.Add('userDB='+edDBlogin.Text);
          strList.Add('passDB='+EncodePWDEx(edDBpass.Text,secureString,0,20));

          strList.Add('[Header]');
          strList.Add('HeaderResi='+txtheader.Text);

          strList.Add('[Footer]');
          strList.Add('FooterResi='+txtfooter.Text);

          strList.Add('[Bea Admin]');
          strList.Add('Bea Admin Pos='+txtadminpos.Text);

          strList.Add('[Maks Jml Tagihan]');
          strList.Add('Maks Jml Tagihan='+txtmakstagihan.Text);

          strList.Add('[Database1]');
          strList.Add('IpDB='+edDB1ip.Text);
          strList.Add('namaDB2='+edDB1nama.Text);
          strList.Add('userDB='+edDB1login.Text);
          strList.Add('passDB='+EncodePWDEx(edDB1pass.Text,secureString,0,20));
          strList.Add('[Kode]');
          strList.Add('Kode loket='+txtkode_loket.Text);
          strList.Add('Kode unit='+txtkode_unit.Text);
          strList.Add('[Denda]');
          if opt1.Checked=true then
             strList.Add('Bayar=0')
          else if opt2.Checked=true then
             strList.Add('Bayar=1');
          portLokal:=strtoint(edPort.Text);
          dirFileLog:=edFolder.Text;
          DBip:=edDBip.Text;
          vheaderResi:=txtheader.Text;
          vfooterResi:=txtfooter.Text;
          vbeaAdminpos:=txtadminpos.Text;
          vmaksjmltagihan:=txtmakstagihan.Text;
          strList.SaveToFile(ExtractFilePath(Application.ExeName)+'param.ini');
          MessageDlg('Setting Konfigurasi sudah direkam',mtInformation,[mbOK],0);
      finally
         freeAndNil(strList);
      end;
    end;

begin
    if isianValid then begin
       Form1.suipassdlg.ValueText := '';
       if Form1.suipassdlg.ShowModal=mrOK then begin
         if (Form1.suipassdlg.ValueText=defaultpassadmin) or (Form1.suipassdlg.ValueText=AdminPass) then
            RekamSetting
         else
            MessageDlg('Password Admin tidak valid',mtError,[mbOK],0)
       end;
    end;
end;

end.
