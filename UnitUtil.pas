unit UnitUtil;

interface
uses
  //Windows,classes,SYsUTils,uMySqlClient;
  Windows,classes,SYsUTils;

type
  PmessPay = ^messPay;
  messPay = record
    stanHost   : integer;
    stanMiddle : String[6];
    oriData    : String[255];
end;

Function DecodeMap(parnya: String): String;
function EncodeMap(parnya: String): String;
function waktosGMT:String;
function waktosNonGMT:String;
function BacaDataTeks(Str, Pad: String; Posisi: Byte): String;
function Padding(str:String;posisi,Jumlah:Integer;kar:Char):String;
function BisaKonekMySQL(ipDB,nmDB,userDB,passDB:String;var ErrMess:String):Boolean;
function Petik(par:String):String;

const
   arrISO : array [1..128,0..4] of String =
     (('1','Bit Map Extended','h','16',''),
      ('2','Primary account number (PAN)','n','19','LLVAR'),
      ('3','Precessing code','n','6',''),
      ('4','Amount, transaction','n','12',''),
      ('5','Amount, Settlement','n','12',''),
      ('6','Amount, cardholder billing','n','12',''),
      ('7','Transmission date & time','n','10','mmddhhmmss'),
      ('8','Amount, Cardholder billing fee','n','8',''),
      ('9','Conversion rate, Settlement','n','8',''),
      ('10','Conversion rate, cardholder billing','n','8',''),
      ('11','Systems trace audit number','n','6',''),
      ('12','Time, Local transaction','n','6','hhmmss'),
      ('13','Date, Local transaction','n','4','mmdd'),
      ('14','Date, Expiration','n','4','yymm'),
      ('15','Date, Settlement','n','4','mmdd'),
      ('16','Date, conversion','n','4','mmdd'),
      ('17','Date, capture','n','4','mmdd'),
      ('18','Merchant type','n','4',''),
      ('19','Acquiring institution country code','n','3',''),
      ('20','PAN Extended, country code','n','3',''),
      ('21','Forwarding institution. country code','n','3',''),
      ('22','Point of service entry mode','n','3',''),
      ('23','Application PAN number','n','3',''),
      ('24','Network International identifier','n','3',''),
      ('25','Point of service condition code','n','2',''),
      ('26','Point of service capture code','n','2',''),
      ('27','Authorising identification response length','n','1',''),
      ('28','Amount, transaction fee','n','8',''),
      ('29','Amount. settlement fee','n','8',''),
      ('30','Amount, transaction processing fee','n','8',''),
      ('31','Amount, settlement processing fee','n','8',''),
      ('32','Acquiring institution identification code','n','11','LLVAR'),
      ('33','Forwarding institution identofication code','n','11','LLVAR'),
      ('34','Primary account number, extended','n','28','LLVAR'),
      ('35','Track 2 data','z','37','LLVAR'),
      ('36','Track 3 data','n','104','LLLVAR'),
      ('37','Retrieval reference number','an','12',''),
      ('38','Authorisation identification response','an','6',''),
      ('39','Response code','an','2',''),
      ('40','Service restriction code','an','3',''),
      ('41','Card acceptor terminal identification','ans','16',''),   // normal 8, nurama 16
      ('42','Card acceptor identification code','ans','15',''),
      ('43','Card acceptor name/location','ans','40',''),
      ('44','Additional response data','an','25','LLVAR'),
      ('45','Track 1 Data','an','76','LLVAR'),
      ('46','Additional data - ISO','an','999','LLLVAR'),
      ('47','Additional data - National','an','999','LLLVAR'),
      ('48','Additional data - Private','an','999','LLLVAR'),
      ('49','Currency code, transaction','a','3',''),
      ('50','Currency code, settlement','an','3',''),
      ('51','Currency code, cardholder billing','a','3',''),
      ('52','Personal Identification number data','h','16',''),
      ('53','Security related control information','n','18',''),
      ('54','Additional amounts','an','120',''),
      ('55','Reserved ISO','ans','999','LLLVAR'),
      ('56','Reserved ISO','ans','999','LLLVAR'),
      ('57','Reserved National','ans','999','LLLVAR'),
      ('58','Reserved National','ans','999','LLLVAR'),
      ('59','Reserved for national use','ans','999','LLLVAR'),
      ('60','Advice/reason code (private reserved)','an','7','LLLVAR'),   // telkom neh aneh, harusnya LVAR
      ('61','Reserved Private','ans','999','LLLVAR'),
      ('62','Reserved Private','ans','999','LLLVAR'),
      ('63','Reserved Private','ans','999','LLLVAR'),           // nurama fix 3, harusnya LLLVAR 999
      ('64','Message authentication code (MAC)','h','16',''),
      ('65','Bit map, tertiary','h','16',''),
      ('66','Settlement code','n','1',''),
      ('67','Extended payment code','n','2',''),
      ('68','Receiving institution country code','n','3',''),
      ('69','Settlement institution county code','n','3',''),
      ('70','Network management Information code','n','3',''),
      ('71','Message number','n','4',''),
      ('72','Message number, last','n','4',''),
      ('73','Date, Action','n','6','yymmdd'),
      ('74','Credits, number','n','10',''),
      ('75','Credits, reversal number','n','10',''),
      ('76','Debits, number','n','10',''),
      ('77','Debits, reversal number','n','10',''),
      ('78','Transfer number','n','10',''),
      ('79','Transfer, reversal number','n','10',''),
      ('80','Inquiries number','n','10',''),
      ('81','Authorisations, number','n','10',''),
      ('82','Credits, processsing fee amount','n','12',''),
      ('83','Credits, transaction fee amount','n','12',''),
      ('84','Debits, processing fee amount','n','12',''),
      ('85','Debits, transaction fee amount','n','12',''),
      ('86','Credits, amount','n','15',''),
      ('87','Credits, reversal amount','n','15',''),
      ('88','Debits, amount','n','15',''),
      ('89','Debits, reversal amount','n','15',''),
      ('90','Original data elements','n','42','LLVAR'),         // normal fix 42, nruama LLVAR 31
      ('91','File update code','an','1',''),
      ('92','File security code','n','2',''),
      ('93','Response indicator','n','5',''),
      ('94','Service indicator','an','7',''),
      ('95','Replacement amounts','an','42',''),
      ('96','Message security code','an','8',''),
      ('97','Amount, net settlement','n','16',''),
      ('98','Payee','ans','25',''),
      ('99','Settlement institution identification code','n','11','LLVAR'),
      ('100','Receiving institution identification code','n','11','LLVAR'),
      ('101','File name','ans','17',''),
      ('102','Account identification 1','ans','28','LLVAR'),
      ('103','Account identification 2','ans','28','LLVAR'),
      ('104','Transaction description','ans','100','LLVAR'),
      ('105','Reserved for ISO use','ans','999','LLLVAR'),
      ('106','Reserved for ISO use','ans','999','LLLVAR'),
      ('107','Reserved for ISO use','ans','999','LLLVAR'),
      ('108','Reserved for ISO use','ans','999','LLLVAR'),
      ('109','Reserved for ISO use','ans','999','LLLVAR'),
      ('110','Reserved for ISO use','ans','999','LLLVAR'),
      ('111','Reserved for ISO use','ans','999','LLLVAR'),
      ('112','Reserved for national use','ans','999','LLLVAR'),
      ('113','Authorising agent institution id code','n','11','LLVAR'),
      ('114','Reserved for national use','ans','999','LLLVAR'),
      ('115','Reserved for national use','ans','999','LLLVAR'),
      ('116','Reserved for national use','ans','999','LLLVAR'),
      ('117','Reserved for national use','ans','999','LLLVAR'),
      ('118','Reserved for national use','ans','999','LLLVAR'),
      ('119','Reserved for national use','ans','999','LLLVAR'),
      ('120','Reserved for private use','ans','999','LLLVAR'),
      ('121','Reserved for private use','ans','999','LLLVAR'),
      ('122','Reserved for private use','ans','999','LLLVAR'),
      ('123','Reserved for private use','ans','999','LLLVAR'),
      ('124','Info Text','ans','255','LLLVAR'),
      ('125','Network management information','ans','50','LLLVAR'),
      ('126','Issuer trace id','ans','6','LLLVAR'),
      ('127','Reserved for private use','ans','999','LLLVAR'),
      ('128','Message Authentication code','h','16',''));

var
  //MyDB : TMysqlClient;
  //QResult : TMysqlResult;
  ARecord : PMesspay;

implementation

function Petik(par:String):String;
begin
    result := QuotedStr(par);
end;

function BisaKonekMySQL(ipDB,nmDB,userDB,passDB:String;var ErrMess:String):Boolean;
begin
{      MyDB.Host := ipDB;
      MyDB.Db := nmDB;
      MyDB.User := userDB;
      MyDB.Password := PassDB;
      MyDB.Port := 3306;
      MyDB.ShouldReconnect := TRUE;
      MyDB.ConnectTimeout := 50;
      MyDB.Compress := TRUE;
      MyDb.UseSSL := FALSE;
      try
         MyDB.connect;
         errMess := '';
         result := TRUE;
      except
         on E:Exception do begin
            ErrMess := E.Message;
            result := FALSE;
         end;
      end;
}
end;


function BacaDataTeks(Str, Pad: String; Posisi: Byte): String;
var
  Hasil : String;
  i : Byte;
begin
  if Posisi = 1 then
     Hasil := Copy(Str,0,Pos(Pad,Str)-1)
  else begin
      for i := 1 to Posisi-1 do begin
         Hasil := Copy(Str, Pos(Pad,Str)+1,length(Str));
         Str := Hasil;
      end;
      if Pos(Pad,Str) > 0 then
         Hasil := Copy(Str,0,Pos(Pad,Str)-1)
      else
         Hasil := Copy(Str,0,length(Str));
  end;
  Result := Hasil;
end;

function Padding(str:String;posisi,Jumlah:Integer;kar:Char):String;
begin
   if length(str)>=Jumlah then
      Padding := Copy(Str,0,Jumlah)
   else if Posisi = 0 then
      Padding := StringofChar(kar,Jumlah-length(str))+Str
   else
      Padding := Str+StringOfChar(kar,Jumlah-length(str));
end;

function waktosGMT:String;
var
    waktos1,waktos2 : String;
begin
    waktos1 := FormatDateTime('hh',now);
    waktos1 := IntToStr(StrToInt(waktos1)-7);
    if StrToInt(waktos1)<0 then begin
       waktos1 := IntToStr(StrToInt(waktos1) + 24);
       result := FormatDateTime('mmdd',now-1)+padding(waktos1,0,2,'0')+formatdatetime('nnss',now);
    end else
       result := FormatDateTime('mmdd',now)+padding(waktos1,0,2,'0')+formatdatetime('nnss',now);
end;


function waktosNonGMT:String;
var
    waktos1,waktos2 : String;
begin
    waktos1 := FormatDateTime('dd-mm-yyyy hh:mm:ss ',now);

       result := waktos1;
end;


function EncodeMap(parnya: String): String;
var
     hasil : String;
     i : word;
const
     arrbitmap : array [0..15,0..1] of String =
               (('0000','0'),
                ('0001','1'),
                ('0010','2'),
                ('0011','3'),
                ('0100','4'),
                ('0101','5'),
                ('0110','6'),
                ('0111','7'),
                ('1000','8'),
                ('1001','9'),
                ('1010','A'),
                ('1011','B'),
                ('1100','C'),
                ('1101','D'),
                ('1110','E'),
                ('1111','F'));

       function CekBitMap(par:String):String;
       var
         i : byte;
       begin
          i := 0;
          while (i<16) and (arrBitmap[i,0]<>par) do
             inc(i);
         result := arrbitmap[i,1];
       end;

  begin
       hasil := '';
       i := 1;
       while i<65 do begin
            hasil := hasil + CekBitmap(Copy(parnya,i,4));
            i := i + 4;
       end;
       result := hasil;
end;


Function DecodeMap(parnya: String): String;
var
     hasil : String;
     i : word;
const
     arrbitmap : array [0..15,0..1] of String =
               (('0000','0'),
                ('0001','1'),
                ('0010','2'),
                ('0011','3'),
                ('0100','4'),
                ('0101','5'),
                ('0110','6'),
                ('0111','7'),
                ('1000','8'),
                ('1001','9'),
                ('1010','A'),
                ('1011','B'),
                ('1100','C'),
                ('1101','D'),
                ('1110','E'),
                ('1111','F'));

       function CekBitMap(par:String):String;
       var
         i : byte;
       begin
          i := 0;
          while (i<16) and (arrBitmap[i,1]<>par) do
             inc(i);
         result := arrbitmap[i,0];
       end;

  begin
       hasil := '';
       for i := 1 to length(parnya) do begin
            hasil := hasil + CekBitMap(copy(parnya,i,1));
       end;
       result := hasil;
end;

end.
