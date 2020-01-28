unit dstruct;

(******************************************************************)
(*                                                                *)
(*                        D S T R U C T                           *)
(*                                                                *)
(*                    SDL Component Suite 6.0                     *)
(*                                                                *)
(*     (C) 1997..2001 H. Lohninger                    Oct. 1997   *)
(*                    Vienna, Austria, Europe                     *)
(*                    helpdesk@lohninger.com                      *)
(*                                                                *)
(*     Last Update: Jul-19, 2001                                  *)
(*                                                                *)
(******************************************************************)

{ revision history:

1.0   [Jun-01, 1998]

1.1   [Apr-09, 1998]
      Logic operators of CombineWith extended by loANDNot, loORNot, and loXORNot
      new method of FIFO: ForceByte
      RLEncoder implemented
      NextCombination implemented
      DSTRUCT now available for C++Builder 3.0

1.2   [Aug-13, 1998]
      DSTRUCT is now available for Delphi 4.0

1.3   [Feb-18, 1999]
      DSTRUCT no longer available for Delphi 1.0
      class TStringArray implemented

1.4   [Mar-23, 1999]
      DSTRUCT is now available for C++Builder 4.0

5.0   [Oct-02, 1999]
      DSTRUCT is now available for Delphi 5.0
      method AsNumber of class TStringArray implemented
      method TStringArray.ColumnEmpty and TStringArray.RowEmpty implemented
      method TStringArray.FindCell implemented
      TStringArray - bug fix: deallocation of memory works now correctly
      property TStringArray.RowAttrib implemented
      TStringArray: sorting no longer discriminates between lowercase and uppercase letters
      TStringArray.AddRow implemented
      TStringArray.RemoveRow implemented
      TStringArray.InsertRow implemented
      bug fix in TStringArray.Sort: sort no longer hangs if only one row in string array
      bug fix in TStringArray.Sort: sort no longer hangs for arrays with more than 2^16 rows

5.5   [May-21, 2000]
      available for C++Builder 5.0
      TStringArray: new property SortOrder implemented
      property TStringArray.ColAttrib implemented
      function FindCellInSortedColumn implemneted
      CRC routines implemented (CCITT and 32 bit CRC used in Ethernet LANs)
      bug fix in RL-Encoder (caused faulty compression under rare circumstances)

6.0   [Aug-06, 2001]
      available for Delphi 6.0
      EncodeASCII85 and DecodeASCII85 implemented
      bug fix in FindCell: algorithm works correctly for multi-column searches
      FindCellExact implemented
      property Bit of TBitFld is now default property
      TStringArray.SortOrder is now writable

6.5   [XXX-XX, 2001]
      LoadFromXMLFile, ReadFromOpenXMLFile, SaveAsXMLFile, WriteToOpenXMLFile implemented

}


{$O+}
{$F+}

{$IFNDEF SDLBATCH}
  {$IFDEF VER110}
  {$ObjExportAll On}   { this switch is necessary for C++Builder 3.0 }
  {$ENDIF}
  {$IFDEF VER125}
  {$ObjExportAll On}   { this switch is necessary for C++Builder 4.0 }
  {$ENDIF}
  {$IFDEF VER135}
  {$ObjExportAll On}   { this switch is necessary for C++Builder 5.0 }
  {$ENDIF}
{$ENDIF}

{------------------------------------------------------------------}
{-$DEFINE SHAREWARE}
{ This switch is only for testing during the development phase.
  It should be turned off for normal operation                     }
{------------------------------------------------------------------}


(*----------------------------------------------------------------*)
interface
(*----------------------------------------------------------------*)

uses
  sysutils, classes;

const
  SABuffSize = 32768;                              { size of string buffer }


type
  TLogicOp = (loAND, loOR, loXOR, loANDNot, loORNot, loXORNot);
  TCombination  = array[0..255] of byte;
  TCRC16Mode = (crcZModem, crcCCITT);
  TBitFld = class(TObject)
            private
              FSize     : longint;                  { size of bit field }
              FBitArray : pointer;               { pointer to bit field }
              procedure SetSize (s: longint);
              procedure SetBit (ix: longint; value: boolean);
              function  GetBit (ix: longint): boolean;
            public
              constructor Create (Sz: longint);
              destructor  Destroy; override;
              procedure Clear;
              function  CountTrueBits: longint;
              procedure ToggleBit (ix: longint);
              procedure CombineWith (SecondBArray: TBitFld; Operation: TLogicOp);
              procedure Invert;
              procedure RandomFill (Percent: double);
              property  Size: longint read FSize write SetSize;
              property  Bit[ix: longint]: boolean read GetBit write SetBit; default;
            end;

  TFifo = class(TObject)
          private
            FInPoi  : longint;                           { input pointer }
            FOutPoi : longint;                          { output pointer }
            FLength : longint;                          { length of Fifo }
            FData   : pointer;                            { data element }
          public
            constructor Create (FifoLeng: longint);
            destructor  Destroy; override;
            procedure   Clear;
            function    PutByte (InByte: byte): boolean;
            function    LoadBack (InByte: Byte): boolean;
            function    ForceByte (InByte: byte): boolean;
            function    GetByte (var OutByte: byte): boolean;
            function    SenseByte (ix: longint;
                          var OutByte: byte): boolean;
            function    CountBytes: longint;
          end;


  TDecodeSt = (rlData, rlLeadin, rlCnt);
  TRLEncoder = class (TComponent)
    private
      FBufLeng  : integer;              { length of encoding buffer }
      FBuffer   : pointer;                        { encoding buffer }
      FBufPoi   : integer;
      FLeadInByte : byte;            { lead-in byte for RL encoding }
      FDecodeSt   : TDecodeSt;                      { decoder state }
      FCount      : byte;            { byte counter for en/decoding }
      FLastB      : byte;                     { last byte container }
      procedure SetBufLeng (leng: integer);
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure Reset;
      function  Decode (InByte: byte): boolean;
      function  Encode (var InBuf: array of byte; NumBytes: integer): boolean;
      procedure GetResult (var OutBuf: array of byte);
      function  Finish (var OutBuf: array of byte): integer;
    published
      property BufLeng: integer read FBufLeng write SetBufLeng;
    end;

  TStringArray =
        class (TObject)
        private
          FNCol        : longint;                      { number of columns }
          FNRow        : longint;                         { number of rows }
          FAllocRowsBy : longint;         { number of rows to be allocated }
          FRAllocated  : longint;     { number of rows currently allocated }
          FNumPoolAddr : integer;          { number of string pool buffers }
          FFirstFree   : pointer;   { offset of first free byte in buffers }
          FPoiArray    : pointer;            { array of pointers to string }
          FStgPool     : pointer;                            { string pool }
          FPooladdr    : pointer;       { list of pointers to pool buffers }
          FSortIx      : pointer;                     { current sort index }
          FRowAttrib   : pointer;                         { row attributes }
          FColAttrib   : pointer;                      { column attributes }
          FOnChange    : TNotifyEvent;
          {$IFDEF DEBUG}
          procedure GetDebugInfo (var SL: TStringList);
          {$ENDIF}

          function  GetAsNumber (c, r: longint): double;
          function  GetSortOrder (ix: longint): longint;
          function  GetString (c,r: longint): Shortstring;
          procedure SetString (c,r: longint; s: Shortstring);
          function  GetRowAttrib (r: longint): byte;
          procedure SetRowAttrib (r: longint; b: byte);
          function  GetColAttrib (c: longint): byte;
          procedure SetColAttrib (c: longint; b: byte);
          procedure SetNrCols (NrCols: longint);
          procedure SetNrRows (NrRows: longint);
          procedure SetSortOrder (ix: longint; position: longint);
          procedure SetAllocRowsBy (NrAllocRows: longint);
          function  FindCellIntern (FindStr: string; MatchCase: boolean;
                         ColLow, ColHigh, RowLow, RowHigh: longint; var Col, row: longint; Exact: boolean): boolean;
        public
          constructor Create (Nc, Nr, AllocRowsBy: longint);
          destructor  Destroy; override;
          function  AddRow: longint;
          property  AsNumber [ACol, ARow: longint]: double read GetAsNumber;
          procedure Changed;
          procedure Clear;
          property  ColAttrib [c: longint]: byte read GetColAttrib write SetColAttrib;
          function  ColumnEmpty (ACol: longint): boolean;
          property  Elem [c,r: longint]: ShortString read GetString write SetString; default;
          procedure Fill (s: ShortString);
          function  FindCell (FindStr: string; MatchCase: boolean;
                      ColLow, ColHigh, RowLow, RowHigh: longint; var Col, row: longint): boolean;
          function  FindCellExact (FindStr: string; MatchCase: boolean;
                      ColLow, ColHigh, RowLow, RowHigh: longint; var Col, row: longint): boolean;
          function  FindCellInSortedColumn (FindStr: string; MatchCase: boolean; ColIx, RowLow,
                      RowHigh: longint; ColIsAscending: boolean; var row: longint): boolean;
          procedure GarbageCollection;
          procedure InsertRow (r: longint);
(**)          function  LoadFromXMLFile (FName: string; DataID: string): boolean;
          property  NrOfColumns: longint read FNCol write SetNrCols;
          property  NrOfRows: longint read FNRow write SetNrRows;
          property  NumBuffers: integer read FNumPoolAddr;
(**)          function  ReadFromOpenXMLFile (var InFile: TextFile; DataID: string): boolean;
          procedure RemoveRow (r: longint);
          function  Resize (Nc, Nr: longint): boolean;
          property  RowAttrib [r: longint]: byte read GetRowAttrib write SetRowAttrib;
          function  RowEmpty (ARow: longint): boolean;
(**)          procedure SaveAsXMLFile (FName: string; DataID: string);
(**)          procedure WriteToOpenXMLFile (var OutFile : TextFile; CreateHeader: boolean; DataID: string);
          property  AllocRowsBy: longint read FAllocRowsBy write SetAllocRowsBy;
          procedure Sort (Col: longint; Ascending: boolean);
          property  SortOrder[ix: longint]: longint read GetSortOrder write SetSortOrder;
          procedure UnSort;
          property  OnChange: TNotifyEvent read FOnChange write FOnChange;
        end;


  function  NextCombination
   (var CurrentCombi : TCombination;                     { current combination }
              MaxVal : integer)                              { range of digits }
                     : boolean;                  { FALSE: no more combinations }
  function CalcNextCRC16
             (inbyte : byte;                       { next byte of input stream }
                 crc : word)                                    { CRC register }
                     : word;                                   { resulting CRC }
  function CalcNextCRC32
             (inbyte : byte;                       { next byte of input stream }
                 crc : longint)                                 { CRC register }
                     : longint;                                { resulting CRC }
  function CRC16ofBuffer
             (BufPoi : pointer;                      { pointer to input buffer }
             NumData : integer;
           CRC16Mode : TCRC16Mode)           { number of bytes in input buffer }
                     : word;                                      { CRC result }
  function CRC32ofBuffer
             (BufPoi : pointer;                      { pointer to input buffer }
             NumData : integer)              { number of bytes in input buffer }
                     : longint;                                   { CRC result }
  function DecodeASCII85
           (InStream,                           { ASCII85 stream to be decoded }
           OutStream : TStream)                                 { decoded data }
                     : integer;                                 { error number }
  procedure EncodeASCII85
           (InStream,                       { data stream to be BASE85 encoded }
           OutStream : TStream);                                { encoded data }

  procedure Register;


(*----------------------------------------------------------------*)
implementation
(*----------------------------------------------------------------*)

{$R-}

uses
  wintypes, winprocs, math1, stringl {$IFDEF SHAREWARE}, dialogs {$ENDIF};

type
{$IFDEF VER100}
  longword = longint; // Delphi 3.0 does not know about the longword data type
{$ENDIF}
{$IFDEF VER110}
  longword = longint; // CBuilder 3.0 does not know about the longword data type
{$ENDIF}
  TXmlTag = (xmlNumCols, xmlNumRows, xmlCell, xmlEndStrArray, xmlInvalid);


const                                   {xml tag names}
  xmlTagIds : array[xmlNumCols..xmlInValid] of string =
               ('numcols', 'numrows', 'cell', '/strarray', 'dummy');

  defBfSize = 100;                     { default size of bit array }
  defRLEBufSize = 256;
  Power85 : array[0..4] of cardinal = (1, 85, 7225, 614125, 52200625);

  crc_CCITT_tab: array[0..255] of word =  // CRC-16 = X^16+X^12+X^5+1
   ($0000,  $1021,  $2042,  $3063,  $4084,  $50A5,  $60C6,  $70E7,
    $8108,  $9129,  $A14A,  $B16B,  $C18C,  $D1AD,  $E1CE,  $F1EF,
    $1231,  $0210,  $3273,  $2252,  $52B5,  $4294,  $72F7,  $62D6,
    $9339,  $8318,  $B37B,  $A35A,  $D3BD,  $C39C,  $F3FF,  $E3DE,
    $2462,  $3443,  $0420,  $1401,  $64E6,  $74C7,  $44A4,  $5485,
    $A56A,  $B54B,  $8528,  $9509,  $E5EE,  $F5CF,  $C5AC,  $D58D,
    $3653,  $2672,  $1611,  $0630,  $76D7,  $66F6,  $5695,  $46B4,
    $B75B,  $A77A,  $9719,  $8738,  $F7DF,  $E7FE,  $D79D,  $C7BC,
    $48C4,  $58E5,  $6886,  $78A7,  $0840,  $1861,  $2802,  $3823,
    $C9CC,  $D9ED,  $E98E,  $F9AF,  $8948,  $9969,  $A90A,  $B92B,
    $5AF5,  $4AD4,  $7AB7,  $6A96,  $1A71,  $0A50,  $3A33,  $2A12,
    $DBFD,  $CBDC,  $FBBF,  $EB9E,  $9B79,  $8B58,  $BB3B,  $AB1A,
    $6CA6,  $7C87,  $4CE4,  $5CC5,  $2C22,  $3C03,  $0C60,  $1C41,
    $EDAE,  $FD8F,  $CDEC,  $DDCD,  $AD2A,  $BD0B,  $8D68,  $9D49,
    $7E97,  $6EB6,  $5ED5,  $4EF4,  $3E13,  $2E32,  $1E51,  $0E70,
    $FF9F,  $EFBE,  $DFDD,  $CFFC,  $BF1B,  $AF3A,  $9F59,  $8F78,
    $9188,  $81A9,  $B1CA,  $A1EB,  $D10C,  $C12D,  $F14E,  $E16F,
    $1080,  $00A1,  $30C2,  $20E3,  $5004,  $4025,  $7046,  $6067,
    $83B9,  $9398,  $A3FB,  $B3DA,  $C33D,  $D31C,  $E37F,  $F35E,
    $02B1,  $1290,  $22F3,  $32D2,  $4235,  $5214,  $6277,  $7256,
    $B5EA,  $A5CB,  $95A8,  $8589,  $F56E,  $E54F,  $D52C,  $C50D,
    $34E2,  $24C3,  $14A0,  $0481,  $7466,  $6447,  $5424,  $4405,
    $A7DB,  $B7FA,  $8799,  $97B8,  $E75F,  $F77E,  $C71D,  $D73C,
    $26D3,  $36F2,  $0691,  $16B0,  $6657,  $7676,  $4615,  $5634,
    $D94C,  $C96D,  $F90E,  $E92F,  $99C8,  $89E9,  $B98A,  $A9AB,
    $5844,  $4865,  $7806,  $6827,  $18C0,  $08E1,  $3882,  $28A3,
    $CB7D,  $DB5C,  $EB3F,  $FB1E,  $8BF9,  $9BD8,  $ABBB,  $BB9A,
    $4A75,  $5A54,  $6A37,  $7A16,  $0AF1,  $1AD0,  $2AB3,  $3A92,
    $FD2E,  $ED0F,  $DD6C,  $CD4D,  $BDAA,  $AD8B,  $9DE8,  $8DC9,
    $7C26,  $6C07,  $5C64,  $4C45,  $3CA2,  $2C83,  $1CE0,  $0CC1,
    $EF1F,  $FF3E,  $CF5D,  $DF7C,  $AF9B,  $BFBA,  $8FD9,  $9FF8,
    $6E17,  $7E36,  $4E55,  $5E74,  $2E93,  $3EB2,  $0ED1,  $1EF0);

  crc_32_tab: array[0..255] of longword =  // CRC-32 = X^32+X^26+X^23+X^22+X^16+X^12+X^11+X^10+X^8+X^7+X^5+X^4+X^2+X+1
   ($00000000, $77073096, $EE0E612C, $990951BA, $076DC419, $706AF48F, $E963A535, $9E6495A3,
    $0EDB8832, $79DCB8A4, $E0D5E91E, $97D2D988, $09B64C2B, $7EB17CBD, $E7B82D07, $90BF1D91,
    $1DB71064, $6AB020F2, $F3B97148, $84BE41DE, $1ADAD47D, $6DDDE4EB, $F4D4B551, $83D385C7,
    $136C9856, $646BA8C0, $FD62F97A, $8A65C9EC, $14015C4F, $63066CD9, $FA0F3D63, $8D080DF5,
    $3B6E20C8, $4C69105E, $D56041E4, $A2677172, $3C03E4D1, $4B04D447, $D20D85FD, $A50AB56B,
    $35B5A8FA, $42B2986C, $DBBBC9D6, $ACBCF940, $32D86CE3, $45DF5C75, $DCD60DCF, $ABD13D59,
    $26D930AC, $51DE003A, $C8D75180, $BFD06116, $21B4F4B5, $56B3C423, $CFBA9599, $B8BDA50F,
    $2802B89E, $5F058808, $C60CD9B2, $B10BE924, $2F6F7C87, $58684C11, $C1611DAB, $B6662D3D,
    $76DC4190, $01DB7106, $98D220BC, $EFD5102A, $71B18589, $06B6B51F, $9FBFE4A5, $E8B8D433,
    $7807C9A2, $0F00F934, $9609A88E, $E10E9818, $7F6A0DBB, $086D3D2D, $91646C97, $E6635C01,
    $6B6B51F4, $1C6C6162, $856530D8, $F262004E, $6C0695ED, $1B01A57B, $8208F4C1, $F50FC457,
    $65B0D9C6, $12B7E950, $8BBEB8EA, $FCB9887C, $62DD1DDF, $15DA2D49, $8CD37CF3, $FBD44C65,
    $4DB26158, $3AB551CE, $A3BC0074, $D4BB30E2, $4ADFA541, $3DD895D7, $A4D1C46D, $D3D6F4FB,
    $4369E96A, $346ED9FC, $AD678846, $DA60B8D0, $44042D73, $33031DE5, $AA0A4C5F, $DD0D7CC9,
    $5005713C, $270241AA, $BE0B1010, $C90C2086, $5768B525, $206F85B3, $B966D409, $CE61E49F,
    $5EDEF90E, $29D9C998, $B0D09822, $C7D7A8B4, $59B33D17, $2EB40D81, $B7BD5C3B, $C0BA6CAD,
    $EDB88320, $9ABFB3B6, $03B6E20C, $74B1D29A, $EAD54739, $9DD277AF, $04DB2615, $73DC1683,
    $E3630B12, $94643B84, $0D6D6A3E, $7A6A5AA8, $E40ECF0B, $9309FF9D, $0A00AE27, $7D079EB1,
    $F00F9344, $8708A3D2, $1E01F268, $6906C2FE, $F762575D, $806567CB, $196C3671, $6E6B06E7,
    $FED41B76, $89D32BE0, $10DA7A5A, $67DD4ACC, $F9B9DF6F, $8EBEEFF9, $17B7BE43, $60B08ED5,
    $D6D6A3E8, $A1D1937E, $38D8C2C4, $4FDFF252, $D1BB67F1, $A6BC5767, $3FB506DD, $48B2364B,
    $D80D2BDA, $AF0A1B4C, $36034AF6, $41047A60, $DF60EFC3, $A867DF55, $316E8EEF, $4669BE79,
    $CB61B38C, $BC66831A, $256FD2A0, $5268E236, $CC0C7795, $BB0B4703, $220216B9, $5505262F,
    $C5BA3BBE, $B2BD0B28, $2BB45A92, $5CB36A04, $C2D7FFA7, $B5D0CF31, $2CD99E8B, $5BDEAE1D,
    $9B64C2B0, $EC63F226, $756AA39C, $026D930A, $9C0906A9, $EB0E363F, $72076785, $05005713,
    $95BF4A82, $E2B87A14, $7BB12BAE, $0CB61B38, $92D28E9B, $E5D5BE0D, $7CDCEFB7, $0BDBDF21,
    $86D3D2D4, $F1D4E242, $68DDB3F8, $1FDA836E, $81BE16CD, $F6B9265B, $6FB077E1, $18B74777,
    $88085AE6, $FF0F6A70, $66063BCA, $11010B5C, $8F659EFF, $F862AE69, $616BFFD3, $166CCF45,
    $A00AE278, $D70DD2EE, $4E048354, $3903B3C2, $A7672661, $D06016F7, $4969474D, $3E6E77DB,
    $AED16A4A, $D9D65ADC, $40DF0B66, $37D83BF0, $A9BCAE53, $DEBB9EC5, $47B2CF7F, $30B5FFE9,
    $BDBDF21C, $CABAC28A, $53B39330, $24B4A3A6, $BAD03605, $CDD70693, $54DE5729, $23D967BF,
    $B3667A2E, $C4614AB8, $5D681B02, $2A6F2B94, $B40BBE37, $C30C8EA1, $5A05DF1B, $2D02EF8D);

type
  Array1D0Byte = array[0..0] of byte;
  ESDLDStructError = class(Exception);     { exception type to indicate errors }
  Array1L = array[1..1] of longint;
  Array1P = array[1..1] of pointer;
  Array1C = array[1..1] of char;
  Array1B = array[1..1] of byte;


{$IFDEF SHAREWARE}
{$I sharwinc\DELFRUN.INC}
{$I sharwinc\dstruct_ct.inc}
{$ENDIF}

{$I stripblk.inc}


(*********************************************************)
constructor TRLEncoder.Create(AOwner: TComponent);
(*********************************************************)


begin
inherited Create (AOwner);
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  FBuffer := NIL;
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}
FBufLeng := DefRLEBufSize;
GetMem (FBuffer, 4*FBufLeng);
if (FBuffer = NIL) then
  raise ESDLDstructError.Create ('DSTRUCT: RLEncoder - not enough memory on heap');
fillchar (FBuffer^, 4*FBufLeng, 0);
FBufPoi := 1;
FCount := 0;
FLastB := 0;
FLeadInByte := $A5;
FDecodeSt := rlData;
end;

(*********************************************************)
destructor TRLEncoder.Destroy;
(*********************************************************)

begin
if FBuffer <> NIL then
  FreeMem (FBuffer, 4*FBufLeng);
FBuffer := NIL;
inherited Destroy;
end;

(*********************************************************)
function TRLEncoder.Decode (InByte: byte): boolean;
(*********************************************************)

var
  NextSTate : TDecodeSt;
  i         : integer;

begin
NextState := FDecodeSt;
case FDecodeSt of
    rlData : begin
             if Inbyte = FLeadInByte
               then NextState := rlLeadin
               else begin
                    Array1B(FBuffer^)[FBufPoi] := Inbyte;
                    inc (FBufPoi);
                    end;
             end;
  rlLeadin : begin
             FCount := InByte;
             NextSTate := rlCnt;
             end;
     rlCnt : begin
             for i:=1 to FCount do
               begin
               Array1B(FBuffer^)[FBufPoi] := Inbyte;
               inc (FBufPoi);
               end;
             NextSTate := rlData;
             FCount := 0;
             end;
end;
FDecodeSt := NextState;
if FBufPoi > FBufLeng
  then Decode := true
  else Decode := false;
end;


(*********************************************************)
function TRLEncoder.Encode (var InBuf: array of byte;
                            NumBytes: integer): boolean;
(*********************************************************)



procedure EncodeIt (b: byte);
(*-------------------------*)

begin
if (FCount = 0)
  then begin
       inc(FCount);
       FLastB := b;
       end
  else begin
       if FLastB = b
         then begin
              inc(FCount);
              if (FCount = 255) then
                begin   { output [LEADIN][FCount][FLastB] }
                Array1B(FBuffer^)[FBufPoi] := FLeadInByte;
                Array1B(FBuffer^)[FBufPoi+1] := FCount;
                Array1B(FBuffer^)[FBufPoi+2] := FLastB;
                inc (FBufPoi, 3);
                FCount := 0;
                end;
              end
         else begin
              if ((FCount = 1) and (FLastB <> FLeadinByte))
                then begin
                     Array1B(FBuffer^)[FBufPoi] := FLastB;
                     inc (FBufPoi);
                     end
                else begin
                     if ((FCount = 2) and (FLastB <> FLeadinByte))
                       then begin
                            Array1B(FBuffer^)[FBufPoi] := FLastB;
                            inc (FBufPoi);
                            Array1B(FBuffer^)[FBufPoi] := FLastB;
                            inc (FBufPoi);
                            end
                       else begin
                            Array1B(FBuffer^)[FBufPoi] := FLeadInByte;  { output [LEADIN][FCount][FLastB] }
                            Array1B(FBuffer^)[FBufPoi+1] := FCount;
                            Array1B(FBuffer^)[FBufPoi+2] := FLastB;
                            inc (FBufPoi, 3);
                            end;
                     end;
              FCount := 1;
              FLastB := b;
              end;
       end;

end;


var
  i : integer;

begin
for i:=1 to Numbytes do
  begin
  EncodeIt (Inbuf[i-1]);
  end;
if FBufPoi > FBufLeng
  then Encode := true
  else Encode := false;
end;


(*********************************************************)
procedure TRLEncoder.GetResult (var OutBuf: array of byte);
(*********************************************************)

var
  i : integer;

begin
if FBufPoi > FBufLeng then
  begin
  for i:=1 to FBufLeng do
    OutBuf[i-1] := Array1B(FBuffer^)[i];
  for i:=FBufLeng+1 to FBufPoi do
    Array1B(FBuffer^)[i-FBufLeng] := Array1B(FBuffer^)[i];
  FBufPoi := FBufPoi - FBufLeng;
  end;
end;

(*********************************************************)
function TRLEncoder.Finish (var OutBuf: array of byte): integer;
(*********************************************************)

var
  i : integer;

begin
Array1B(FBuffer^)[FBufPoi] := FLeadInByte;  { output [LEADIN][FCount][FLastB] }
Array1B(FBuffer^)[FBufPoi+1] := FCount;
Array1B(FBuffer^)[FBufPoi+2] := FLastB;
inc (FBufPoi, 3);
FCount := 0;
if FBufPoi > FBufLeng
  then begin
       for i:=1 to FBufLeng do
         OutBuf[i-1] := Array1B(FBuffer^)[i];
       for i:=FBufLeng+1 to FBufPoi do
         Array1B(FBuffer^)[i-FBufLeng] := Array1B(FBuffer^)[i];
       FBufPoi := FBufPoi - FBufLeng;
       Finish := FBufLeng;
       end
  else begin
       for i:=1 to FBufPoi do
         OutBuf[i-1] := Array1B(FBuffer^)[i];
       Finish := FBufPoi-1;
       FBufPoi := 1;
       end;
end;

(*********************************************************)
procedure TRLEncoder.Reset;
(*********************************************************)

begin
FBufPoi := 1;
FCount := 0;
FLastB := 0;
FDecodeSt := rlData;
end;



(*********************************************************)
procedure TRLEncoder.SetBufLeng (leng: integer);
(*********************************************************)

var
  FBuffer2 : pointer;

begin
if (FBuffer <> NIL) then
  if leng <> FBufLeng then
    begin
    FreeMem (FBuffer, 4*FBufLeng);
    FBufLeng := leng;
    GetMem (FBuffer2, 4*FBufLeng);
    if (FBuffer2 = NIL)
      then raise ESDLDstructError.Create ('DSTRUCT: RLEncoder - not enough memory on heap')
      else FBuffer := FBuffer2;
    fillchar (FBuffer^, 4*FBufLeng, 0);
    end;
end;


(******************************************************************)
constructor TBitFld.Create (Sz: longint);
(******************************************************************)

begin
inherited Create;
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  FBitArray := NIL;
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}

FSize := defBfSize;
if sz <= 0
  then raise ESDLDstructError.Create ('DSTRUCT: bit field size is negative or zero')
  else FSize := sz;
{$IFDEF VER80}      { restrict only in 16-Bit version }
if (FSize div 8) > 65500 then
  raise ESDLDstructError.Create ('DSTRUCT: bit field too large');
{$ENDIF}
GetMem (FBitArray, 1+(FSize div 8));
if (FBitArray = NIL)
  then raise ESDLDstructError.Create ('DSTRUCT: TBitFld - not enough memory on heap')
  else FillChar (FBitArray^,1+(FSize div 8),0);
end;


(******************************************************************)
destructor TBitFld.Destroy;
(******************************************************************)

begin
if FBitArray <> NIL then
  FreeMem (FBitArray, 1+(FSize div 8));
FBitArray := NIL;
end;


(******************************************************************)
procedure TBitFld.SetSize (s: longint);
(******************************************************************
  ENTRY:  s ...... new number of elements

  EXIT:   Data are not destroyed, if possible; new bit cells are
          filled with zero values.
 ******************************************************************)

var
  MinElem : longint;
  AuxVec  : pointer;
  i       : longint;

begin
if {$IFDEF VER80} (s div 8 <= 65500) and {$ENDIF} (s > 0) then
  begin
  GetMem (AuxVec, 1+(s div 8));               { allocate new bit array }
  if (AuxVec <> NIL) then
    begin
    MinElem := FSize;
    if s < MinElem then
      MinElem := s;
    for i:=0 to (MinElem shr 3) do                { copy existing data }
      Array1D0Byte(AuxVec^)[i] := Array1D0Byte(FBitArray^)[i];
    if (MinElem shr 3) < (s shr 3) then   { fill rest with zero values }
      for i:=1+(MinElem shr 3) to (s shr 3) do
        Array1D0Byte(AuxVec^)[i] := 0;
    FreeMem (FBitArray, 1+(FSize div 8));          { dispose old array }
    FSize := s;
    FBitArray := AuxVec;                    { set pointer to new array }
    end;
  end;
end;



(******************************************************************)
function TBitFld.CountTrueBits: longint;
(******************************************************************)

const
  BitCnt : array[0..255] of byte =
             (0,1,1,2,1,2,2,3,1,2,2,3,2,3,3,4,    { 0...15}
              1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5,    { 16...31}
              1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5,    { 32...47}
              2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,    { 48...63}
              1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5,    { 64...79}
              2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,    { 80...95}
              2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,    { 96...111}
              3,4,4,5,4,5,5,6,4,5,5,6,5,6,6,7,    { 112...127}
              1,2,2,3,2,3,3,4,2,3,3,4,3,4,4,5,    { 128...143}
              2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,    { 144...159}
              2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,    { 160...175}
              3,4,4,5,4,5,5,6,4,5,5,6,5,6,6,7,    { 176...191}
              2,3,3,4,3,4,4,5,3,4,4,5,4,5,5,6,    { 192...207}
              3,4,4,5,4,5,5,6,4,5,5,6,5,6,6,7,    { 208...223}
              3,4,4,5,4,5,5,6,4,5,5,6,5,6,6,7,    { 224...239}
              4,5,5,6,5,6,6,7,5,6,6,7,6,7,7,8);   { 240...255}

var
  cnt       : longint;
  NFullByte : longint;
  i         : longint;
  k         : integer;
  NRestBits : integer;

begin
cnt := 0;
if FBitArray <> NIL then
  begin
  NFullByte := FSize shr 3 - 1;
  for i:=0 to NFullByte do
    cnt := cnt + BitCnt[Array1D0Byte(FBitArray^)[i]];
  NRestBits := FSize and $0007;
  k := Array1D0Byte(FBitArray^)[NFullByte+1];
  for i:=1 to NRestBits do
    begin
    if k and 01 = 01 then
      inc (cnt);
    k := k shr 1;
    end;
  end;
CountTrueBits := cnt;
end;


(******************************************************************)
procedure  TBitFld.Clear;
(******************************************************************)

begin
if FBitArray <> NIL then
  FillChar (FBitArray^,1+(FSize div 8),0);
end;


(******************************************************************)
procedure TBitFld.RandomFill (Percent: double);
(******************************************************************)

var
  cnt    : longint;
  ix     : longint;

begin
if FBitArray <> NIL then
  begin
  if Percent < 0 then
    Percent := 0;
  if Percent > 100.0 then
    Percent := 100.0;
  cnt := round(0.01*Percent*FSize);
  if cnt > (FSize div 2)
    then begin
         cnt := FSize - cnt;
         FillChar (FBitArray^,1+(FSize div 8),255);
         while cnt > 0 do
           begin
           ix := round(FSize*random);
           if GetBit(ix) then
             begin
             SetBit(ix, false);
             dec (cnt);
             end;
           end;
         end
    else begin
         FillChar (FBitArray^,1+(FSize div 8),0);
         while cnt > 0 do
           begin
           ix := round(FSize*random);
           if not GetBit(ix) then
             begin
             SetBit(ix, true);
             dec (cnt);
             end;
           end;
         end;
  end;
end;


(******************************************************************)
procedure  TBitFld.Invert;
(******************************************************************)

var
  i : longint;

begin
if FBitArray <> NIL then
  begin
  for i:=0 to (FSize shr 3) do
    Array1D0Byte(FBitArray^)[i] := not Array1D0Byte(FBitArray^)[i];
  end;
end;


(******************************************************************)
procedure  TBitFld.CombineWith (SecondBArray: TBitFld;
                                Operation: TLogicOp);
(******************************************************************)

var
  i     : longint;
  nbyte : longint;

begin
if (FBitArray <> NIL) and (SecondBArray.FBitArray <> NIL) and
   (FSize = SecondBArray.Size) then
  begin
  nbyte := FSize shr 3;
  case Operation of
    LoAND   : for i:=0 to nByte do
                Array1D0Byte(FBitArray^)[i] := Array1D0Byte(FBitArray^)[i] and
                                               Array1D0Byte(SecondBArray.FBitArray^)[i];
    LoOR    : for i:=0 to nByte do
                Array1D0Byte(FBitArray^)[i] := Array1D0Byte(FBitArray^)[i] or
                                               Array1D0Byte(SecondBArray.FBitArray^)[i];
    LoXOR   : for i:=0 to nByte do
                Array1D0Byte(FBitArray^)[i] := Array1D0Byte(FBitArray^)[i] xor
                                               Array1D0Byte(SecondBArray.FBitArray^)[i];
    LOANDNOT: FOR I:=0 TO NBYTE DO
                ARRAY1D0BYTE(FBITARRAY^)[I] := ARRAY1D0BYTE(FBITARRAY^)[I] AND NOT
                                               ARRAY1D0BYTE(SECONDBARRAY.FBITARRAY^)[I];
    LOORNOT : FOR I:=0 TO NBYTE DO
                ARRAY1D0BYTE(FBITARRAY^)[I] := ARRAY1D0BYTE(FBITARRAY^)[I] OR NOT
                                               ARRAY1D0BYTE(SECONDBARRAY.FBITARRAY^)[I];
    LOXORNOT: FOR I:=0 TO NBYTE DO
                ARRAY1D0BYTE(FBITARRAY^)[I] := ARRAY1D0BYTE(FBITARRAY^)[I] XOR NOT
                                               ARRAY1D0BYTE(SECONDBARRAY.FBITARRAY^)[I];
  end;
  end;
end;


(******************************************************************)
procedure  TBitFld.SetBit (ix: longint; value: boolean);
(******************************************************************)

var
  Mask : byte;
  s    : longint;
  o    : byte;

begin
if (FBitArray <> NIL) and (ix >= 0) and (Ix <= FSize) then
  begin
  s := ix shr 3;
  o := ix and $0007;
  Mask := 1;
  Mask := Mask shl o;
  if value
    then Array1D0Byte(FBitArray^)[s] := Array1D0Byte(FBitArray^)[s] or Mask
    else Array1D0Byte(FBitArray^)[s] := Array1D0Byte(FBitArray^)[s] and not Mask;
  end;
end;


(******************************************************************)
procedure  TBitFld.ToggleBit (ix: longint);
(******************************************************************)

var
  Mask : byte;
  s    : longint;
  o    : byte;

begin
if (FBitArray <> NIL) and (ix >= 0) and (Ix <= FSize) then
  begin
  s := ix shr 3;
  o := ix and $0007;
  Mask := 1;
  Mask := Mask shl o;
  Array1D0Byte(FBitArray^)[s] := Array1D0Byte(FBitArray^)[s] xor Mask;
  end;
end;


(******************************************************************)
function TBitFld.GetBit (ix: longint): boolean;
(******************************************************************)

var
  Mask : byte;
  s    : longint;
  o    : byte;

begin
if (FBitArray <> NIL) and
   (ix >= 0) and (Ix <= FSize)
  then begin
       s := ix shr 3;
       o := ix and $0007;
       Mask := 1;
       Mask := Mask shl o;
       if (Array1D0Byte(FBitArray^)[s] and Mask) <> 0
         then GetBit := true
         else GetBit := False;
       end
  else GetBit := False;
end;



(******************************************************************)
constructor TFifo.Create (FifoLeng: longint);
(******************************************************************
   ENTRY:   FifoLeng ... length of this FIFO

   EXIT:    Fifo is created
 ******************************************************************)

begin
inherited Create;
FData := NIL;
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  FData := NIL;
  ShowMessagePos (GetVisMsgStr, 100,100);
  Exit;
  end;
{$ENDIF}
if FifoLeng <= 1
  then raise ESDLDstructError.Create ('DSTRUCT: FIFO size is negative or too small')
  else begin
       GetMem (FData, FifoLeng);
       if FData = NIL
         then raise ESDLDstructError.Create ('DSTRUCT: FIFO structure too large')
         else begin
              FillChar (FData^, FifoLeng, 0);
              FLength := FifoLeng;
              FInPoi := 1;
              FOutPoi := 1;
              end;
       end;
end;


(******************************************************************)
destructor TFifo.Destroy;
(******************************************************************
   ENTRY:   ....

   EXIT:    Object FIFO is removed from heap.
 ******************************************************************)

begin
if FData <> NIL then
  FreeMem (FData, FLength);
FData := NIL;
end;


(******************************************************************)
function TFifo.PutByte (InByte: byte): boolean;
(******************************************************************
  ENTRY: InByte ... byte to enter into FIFO

  EXIT:  TRUE if byte is entered successfully
         FALSE if any error condition occured
 ******************************************************************)

var
  dist : longint;

begin
if FData <> NIL
  then begin
       dist := FOutPoi-FInPoi;    (* check if fifo full *)
       if dist <= 0 then
         dist := dist + FLength;
       if dist = 1
         then PutByte := False
         else begin
              Array1B(FData^)[FInPoi] := InByte;   (* enter byte *)
              inc (FInPoi);
              if (FInPoi > FLength) then
                FInPoi := 1;
              PutByte := True;
              end;
       end
  else PutByte := false;
end;


(******************************************************************)
function TFifo.ForceByte (InByte: byte): boolean;
(******************************************************************
  ENTRY: InByte ... byte to enter into FIFO

  EXIT:  InByte is stored in FIFO
         TRUE if the oldest byte has been discarded
         FALSE if there was still place in the FIFO buffer
 ******************************************************************)

var
  dist : longint;

begin
if FData <> NIL
  then begin
       dist := FOutPoi-FInPoi;                   { check if FIFO full }
       if dist <= 0 then
         dist := dist + FLength;
       if dist = 1
         then begin                                    { FIFO is full }
              ForceByte := true;
              inc (FOutPoi);
              if (FOutPoi > FLength) then
                FOutPoi := 1;
              end
         else ForceByte := false;
       Array1B(FData^)[FInPoi] := InByte;            { enter byte }
       inc (FInPoi);
       if (FInPoi > FLength) then
         FInPoi := 1;
       end
  else ForceByte := false;
end;

(******************************************************************)
function TFifo.LoadBack (InByte: Byte): boolean;
(******************************************************************
  ENTRY: InByte ..... Byte to enter at Head of FIFO in order to
         function as a LIFO (stack)

  EXIT:  TRUE if byte is entered successfully
         FALSE if any error condition occured
 ******************************************************************)

begin
if FData <> NIL
  then begin
       dec (FOutPoi);
       if (FOutPoi < 1) then
         FOutPoi := FLength;
       Array1B(FData^)[FOutPoi] := InByte;
       LoadBack := True;
       end
  else LoadBack := false;
end;


(******************************************************************)
function TFifo.GetByte (var OutByte: byte): boolean;
(******************************************************************
  ENTRY: OutByte ... Byte to enter

  EXIT:  TRUE if byte is valid
         FALSE if FIFO is empty
 ******************************************************************)

var
  reslt : boolean;

begin
reslt := false;
if Fdata <> NIL then
  begin
  if (FInPoi <> FOutPoi) then
    begin
    OutByte := Array1B(FData^)[FOutPoi];
    inc (FOutPoi);
    if (FOutPoi > FLength) then
      FOutPoi := 1;
    reslt := True;
    end;
  end;
GetByte := reslt;
end;


(******************************************************************)
function  TFifo.SenseByte (ix: longint; var OutByte: byte): boolean;
(******************************************************************
  ENTRY: ix ........ index relative to output pointer (0 = eldest
                     byte in FIFO)
         OutByte ... byte to get from FIFO

  EXIT:  TRUE if byte is valid
         FALSE if index greater than number of bytes in FIFO
 ******************************************************************)

var
  reslt  : boolean;
  newix  : longint;
  NrFill : longint;

begin
reslt := false;
if FData <> NIL then
  begin
  NrFill := FInpoi - FOutpoi;
  if NrFill < 0 then
    NrFill := NrFill + FLength;
  if (ix < NrFill) then
    begin
    newix := FOutPoi+ix;
    if newix > FLength then
      newix := newix - FLength;
    OutByte := Array1B(FData^)[newix];
    reslt := True;
    end;
  end;
SenseByte := reslt;
end;


(******************************************************************)
procedure TFifo.Clear;
(******************************************************************
  ENTRY: --
  EXIT:  Fifo is cleared
 ******************************************************************)

begin
if FData <> NIL then
  begin
  FInPoi := 1;
  FOutPoi := 1;
  end
end;

(******************************************************************)
function TFifo.CountBytes: longint;
(******************************************************************
  ENTRY: --
  EXIT:  number of bytes in Fifo
 ******************************************************************)

var
  NrFill : integer;

begin
NrFill := 0;
if Fdata <> NIL then
  begin
  NrFill := FInpoi - FOutpoi;
  if NrFill < 0 then
    NrFill := NrFill + FLength;
  end;
CountBytes := NrFill;
end;



(*******************************************************************)
constructor TStringArray.Create (Nc, Nr, AllocRowsBy: longint);
(*******************************************************************)

var
  success : boolean;
  i,j     : integer;

begin
inherited Create;
if (nc < 0) or (nr <= 0) then
  raise ESDLDStructError.Create ('array dimensions zero or negative');
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  begin
  FPoiArray := NIL;
  ShowMessagePos (GetVisMsgStr, 100,100);
  FNCol := 2;
  FNRow := 2;
  Exit;
  end;
{$ENDIF}
FNCol := Nc;
FNRow := Nr;
FNumPoolAddr := 1;
FAllocRowsBy := AllocRowsBy;
FRAllocated := ((FNRow-1) div FAllocRowsBy + 1)*FAllocRowsBy;
success := true;
GetMem (FPoiArray, sizeof(longint)*(1+FNCol)*FRAllocated);
if FPoiArray = NIL
  then success := False
  else begin
       for i:=0 to FNCol do         { fill PoiArray with nils }
         for j:=1 to FRAllocated do
           Array1L (FPoiArray^)[(j-1)*(FNCol+1)+i+1] := 0;
       GetMem (FSortIx, sizeof(longint)*FRAllocated);
       if FSortIx = NIL
         then success := False
         else begin
              for j:=1 to FRAllocated do        { no sorting }
                Array1L (FSortIx^)[j] := j;
              GetMem (FRowAttrib, sizeof(byte)*FRAllocated);
              if FRowAttrib = NIL
                then success := false
                else begin
                     GetMem (FColAttrib, sizeof(byte)*FNCol);
                     if FColAttrib = NIL
                       then success := false
                       else begin
                            for j:=1 to FRAllocated do        { no selection }
                              Array1B (FRowAttrib^)[j] := 0;
                            Getmem (FFirstFree, sizeof(longint));
                            GetMem (FPoolAddr, sizeof(pointer));
                            if FPoolAddr = NIL
                              then success := False
                              else begin
                                   GetMem (FStgPool, SABuffSize);
                                   if FStgPool = NIL
                                     then success := false
                                     else begin
                                          Array1P(FPoolAddr^)[1] := FStgPool;
                                          Array1L(FFirstFree^)[1] := 1;
                                          end;
                                   end;
                            end;
                     end;
              end;
       end;
if not success
  then begin
       if FPoiArray <> NIL then
         FreeMem (FPoiArray, sizeof(longint)*(FNCol+1)*FRAllocated);
       FPoiArray := nil;

       if FSortIx <> NIL then
         FreeMem (FSortIx, sizeof(longint)*FRAllocated);
       FSortIx := NIL;

       if FRowAttrib <> NIL then
         FreeMem (FRowAttrib, sizeof(byte)*FRAllocated);
       FRowAttrib := NIL;

       if FColAttrib <> NIL then
         FreeMem (FColAttrib, sizeof(byte)*FNCol);
       FColAttrib := NIL;

       if FPoolAddr <> NIL then
         FreeMem (FPoolAddr, sizeof(pointer));
       FPoolAddr := NIL;

       if FFirstFree <> NIL then
         FreeMem (FFirstFree, sizeof(longint));
       FFirstFree := NIL;

       if FStgPool <> NIL then
         FreeMem (FStgPool, SABuffSize);
       FStgPool := NIL;

       Fail;
       raise ESDLDStructError.Create ('TStringArray: failed to initialize string array (out of memory)')
       end

end;

(*******************************************************************)
destructor TStringArray.Destroy;
(*******************************************************************)

var
  i: integer;

begin
if FPoiArray <> NIL then
  FreeMem (FPoiArray, (FNCol+1)*FRAllocated*sizeof(longint));
FPoiArray := nil;

if FSortIx <> NIL then
  FreeMem (FSortIx, sizeof(longint)*FRAllocated);
FSortIx := NIL;

if FRowAttrib <> NIL then
  FreeMem (FRowAttrib, sizeof(byte)*FRAllocated);
FRowAttrib := NIL;

if FColAttrib <> NIL then
  FreeMem (FColAttrib, sizeof(byte)*FNCol);
FColAttrib := NIL;

for i:=1 to FNumPoolAddr do
  if Array1P(FPoolAddr^)[i] <> NIL then
    FreeMem (Array1P(FPoolAddr^)[i], SABuffSize);
FStgPool := NIL;

if FPoolAddr <> NIL then
  FreeMem (FPoolAddr, sizeof(pointer)*FNumPoolAddr);
FPoolAddr := NIL;

if FFirstFree <> NIL then
  FreeMem (FFirstFree, sizeof(longint)*FNumPoolAddr);
FFirstFree := NIL;

inherited Destroy;
end;



(***********************************************************************)
function TStringArray.GetSortOrder (ix: longint): longint;
(***********************************************************************)

begin
if (ix < 1) or (ix > FNRow)
  then GetSortOrder := -1
  else GetSortOrder := Array1L (FSortIx^)[ix];
end;


(***********************************************************************)
procedure TStringArray.SetSortOrder (ix: longint; position: longint);
(***********************************************************************)

begin
if (ix >= 1) and (ix <= FNRow) and (position >= 1) and (position <= FNRow) then
  Array1L (FSortIx^)[ix] := position;
end;


(***********************************************************************)
procedure TStringArray.Changed;
(***********************************************************************)

begin
if Assigned(FOnChange) then
  FOnChange(Self);
end;

(*******************************************************************)
procedure TStringArray.SetNrCols (NrCols: longint);
(*******************************************************************)

begin
Resize (NrCols, FNRow);
end;

(*******************************************************************)
procedure TStringArray.SetNrRows (NrRows: longint);
(*******************************************************************)

begin
Resize (FNCol, NrRows);
end;

(*******************************************************************)
procedure TStringArray.SetAllocRowsBy (NrAllocRows: longint);
(*******************************************************************)

begin
FAllocRowsBy := NrAllocRows;
end;


(*******************************************************************)
function TStringArray.GetRowAttrib (r: longint): byte;
(*******************************************************************
  retrieve row attribute of row r
 *******************************************************************)

var
  bb : byte;

begin
bb := 0;
if (r >= 1) and (r <= FNRow) then
  begin
  r := Array1L(FSortIx^)[r];                   { sort order }
  bb := Array1B(FRowAttrib^)[r];
  end;
GetRowAttrib := bb;
end;



(*******************************************************************)
procedure TStringArray.SetRowAttrib (r: longint; b: byte);
(*******************************************************************
  set attribute of row r
 *******************************************************************)

begin
if (r >= 1) and (r <= FNRow) then
  begin
  r := Array1L(FSortIx^)[r];                                      { sort order }
  Array1B(FRowAttrib^)[r] := b;
  Changed;
  end;
end;

(*******************************************************************)
function TStringArray.GetColAttrib (c: longint): byte;
(*******************************************************************
  retrieve Col attribute of Col c
 *******************************************************************)

var
  bb : byte;

begin
bb := 0;
if (c >= 1) and (c <= FNCol) then
  bb := Array1B(FColAttrib^)[c];
GetColAttrib := bb;
end;



(*******************************************************************)
procedure TStringArray.SetColAttrib (c: longint; b: byte);
(*******************************************************************
  set attribute of Col c
 *******************************************************************)

begin
if (c >= 1) and (c <= FNCol) then
  begin
  Array1B(FColAttrib^)[c] := b;
  Changed;
  end;
end;






(*******************************************************************)
function TStringArray.GetString (c,r: longint): Shortstring;
(*******************************************************************
  retrieve string at position [r,c]
 *******************************************************************)

var
  spoi      : longint;
  buffnum   : word;
  offset    : word;
  PoolPoi   : pointer;
  strg      : ShortString;

begin
strg := '';
if (r >= 1) and (r <= FNRow) and
   (c >= 0) and (c <= FNCol) then
  begin
  r := Array1L(FSortIx^)[r];                   { sort order }
  spoi := Array1L(FPoiArray^)[(r-1)*(FNCol+1)+c+1];  { string pointer }
  if spoi <> 0 then                            { no string assigned ?? }
    begin
    buffnum := ($FFFF0000 and spoi) shr 16;     { string pool number }
    offset := $0000FFFF and spoi;                { offset in pool }
    poolPoi := Array1P(FPoolAddr^)[buffnum];    { pool pointer }
    Move (Array1C(poolpoi^)[offset], strg, 1+Array1B(poolpoi^)[offset]); { copy to string }
    end;
  end;
GetSTring := strg;
end;


(******************************************************************)
function TStringArray.GetAsNumber (c, r: longint): double;
(******************************************************************)

var
  rslt   : double;
  status : integer;

begin
val (StripLTBLanks(GetString(c,r)), rslt, status);
if status <> 0 then
  raise ESDLDStructError.Create ('TStringList: Invalid numeric string: ['+IntToStr(c)+','+
                                 IntToStr(r)+']: '+GetString(c,r));
Result := rslt;
end;



(*******************************************************************)
procedure TStringArray.SetString (c,r: longint; s: Shortstring);
(*******************************************************************
  sets string s at position [c,r]
 *******************************************************************)

var
  spoi      : longint;
  buffnum   : word;
  offset    : word;
  PoolPoi   : pointer;
  AuxPoi    : pointer;
  ix        : longint;


procedure AppendNewString;
(*----------------------*)

var
  i         : longint;

begin
ix:=0;
repeat
  inc (ix);
  offset := Array1L(FFirstFree^)[ix];
until (ix = FNumPoolAddr) or (SABuffSize-offset > length(s));
if SABuffSize-offset > length(s)
  then begin                     { there is room in chunk ix }
       Array1L(FPoiArray^)[(r-1)*(FNCol+1)+c+1] := (ix shl 16) + offset;
       Array1L(FFirstFree^)[ix] := offset + length(s) + 1;
       poolPoi := Array1P(FPoolAddr^)[ix];    { pool pointer }
       Move (s, Array1C(poolpoi^)[offset], 1+length(s)); { copy string }
       end
  else begin          { create a new chunk and store new string there }
       inc (FNumPoolAddr);
       GetMem (AuxPoi, FNumPoolAddr*sizeof(pointer));
       for i:=1 to FNumPoolAddr-1 do  // copy existing pointers
         Array1P(AuxPoi^)[i] := Array1P(FPoolAddr^)[i];
       FreeMem (FPoolAddr, (FNumPoolAddr-1)*SizeOf(pointer));
       FPoolAddr := AuxPoi;

       GetMem (AuxPoi, FNumPoolAddr*sizeof(longint));
       for i:=1 to FNumPoolAddr-1 do  // copy existing offsets
         Array1L(AuxPoi^)[i] := Array1L(FFirstFree^)[i];
       FreeMem (FFirstFree, (FNumPoolAddr-1)*SizeOf(longint));
       FFirstFree := AuxPoi;

       GetMem (FStgPool, SABuffSize);
       Array1P(FPoolAddr^)[FNumPoolAddr] := FStgPool;
       Array1L(FPoiArray^)[(r-1)*(FNCol+1)+c+1] := (FNumPoolAddr shl 16) + 1;
       Array1L(FFirstFree^)[FNumPoolAddr] := length(s) + 2;
       Move (s, Array1C(FStgPool^)[1], 1+length(s)); { copy string }
       end;
end;

begin
if (r >= 1) and (r <= FNRow) and
   (c >= 0) and (c <= FNCol) then
  begin
  r := Array1L(FSortIx^)[r];                                      { sort order }
  spoi := Array1L(FPoiArray^)[(r-1)*(FNCol+1)+c+1];           { string pointer }
  if spoi <> 0                                         { no string assigned ?? }
    then begin                                      // overwrite existing string
         buffnum := ($FFFF0000 and spoi) shr 16;          { string pool number }
         offset := $0000FFFF and spoi;                        { offset in pool }
         poolPoi := Array1P(FPoolAddr^)[buffnum];               { pool pointer }
         if length(s) > Array1B(poolpoi^)[offset]
           then begin  // new string is longer than existing --> delete and append
                AppendNewString; // s is appended; old string is dangling garbage
                end
           else begin  // new string is shorter --> overwrite
                Move (s, Array1C(poolpoi^)[offset], 1+length(s)); { copy to string }
                end;
         end
    else begin   // append new string;
         AppendNewString;
         end;
  Changed;
  end;
end;



(*********************************************************)
function TStringArray.Resize (Nc, Nr: longint): boolean;
(*********************************************************
  ENTRY:  Nc, Nr .... number of columns and rows

  EXIT:   function returns TRUE if resizing has been completed
          successfully.  Data are not destroyed, if possible;
          new cells are empty.

  Remark: Resizing of string array fast if number of columns
          does not change and number of rows is within current
          allocation
 *********************************************************)


function NormalResize (nc, nr: longint): boolean;
(*---------------------------------------------*)

var
  reslt           : boolean;
  NewFRAllocated  : longint;
  AuxPoiArray     : pointer;
  AuxSortIx       : pointer;
  AuxRowAttrib    : pointer;
  AuxColAttrib    : pointer;
  i,j             : integer;
  MinCol          : integer;
  MinRow          : integer;


begin
NewFRAllocated := ((nr-1) div FAllocRowsBy + 1)*FAllocRowsBy;
reslt := false;
GetMem (AuxPoiArray, (nc+1)*NewFRAllocated*SizeOf(longint));
if (AuxPoiArray <> NIL) then
  begin
  for i:=0 to nc do   // fill PoiArray with nils
    for j:=1 to nr do
      Array1L (AuxPoiArray^)[(j-1)*(nc+1)+i+1] := 0;
  MinCol := nc;
  if FNCol < MinCol then
    MinCol := FNCol;
  MinRow := nr;
  if FNRow < MinRow then
    MinRow := FNRow;
  for i:=0 to MinCol do   // copy existing data into auxiliary array
    for j:=1 to MinRow do
      Array1L (AuxPoiArray^)[(j-1)*(nc+1)+i+1] := Array1L (FPoiArray^)[(j-1)*(FNCol+1)+i+1];
  FreeMem (FPoiArray, (FNCol+1)*FRAllocated*SizeOf(longint));
  FPoiArray := AuxPoiArray;   // FPoiArray is now aux. array

  GetMem (AuxRowAttrib, sizeof(byte)*NewFRAllocated);
  if AuxRowAttrib <> NIL then
    begin
    for j:=1 to nr do        { no attrib }
      Array1B (AuxRowAttrib^)[j] := 0;
    MinRow := nr;
    if FNRow < MinRow then
      MinRow := FNRow;
    for i:=1 to MinRow do   // copy existing row attributes into auxiliary array
      Array1B (AuxRowAttrib^)[i] := Array1B (FRowAttrib^)[i];
    FreeMem (FRowAttrib, FRAllocated*SizeOf(byte));
    FRowAttrib := AuxRowAttrib;   // FRowAttrib is now aux. array

    GetMem (AuxColAttrib, sizeof(byte)*nc);
    if AuxColAttrib <> NIL then
      begin
      for j:=1 to nc do        { no attrib }
        Array1B (AuxColAttrib^)[j] := 0;
      MinCol := nc;
      if FNCol < MinCol then
        MinCol := FNCol;
      for i:=1 to MinCol do   // copy existing Col attributes into auxiliary array
        Array1B (AuxColAttrib^)[i] := Array1B (FColAttrib^)[i];
      FreeMem (FColAttrib, FNCol*SizeOf(byte));
      FColAttrib := AuxColAttrib;   // FColAttrib is now aux. array

      GetMem (AuxSortIx, sizeof(longint)*NewFRAllocated);
      if AuxSortIx <> NIL then
        begin
        for j:=1 to nr do        { no sorting }
          Array1L (AuxSortIx^)[j] := j;
        MinRow := nr;
        if FNRow < MinRow then
          MinRow := FNRow;
        for i:=1 to MinRow do   // copy existing sort index into auxiliary array
          Array1L (AuxSortIx^)[i] := Array1L (FSortIx^)[i];
        FreeMem (FSortIx, FRAllocated*SizeOf(longint));
        FSortIx := AuxSortIx;   // FSortIx is now aux. array

        FNCol := nc;
        FNRow := nr;
        FRAllocated := NewFRAllocated;
        reslt := true;
        end;
      end;
    end;
  end;
NormalResize := reslt;
end;


var
  reslt       : boolean;
  i,j         : integer;

begin
reslt := true;
if (nc <> FNCol) or (nr <> FNRow) then
  begin
  reslt := FALSE;
  if (nc > 0) and (nr > 0) then
    begin
    if nc <> FNCol
      then reslt := NormalResize (nc, nr)
      else begin
           if nr <= FRAllocated
              then begin       { extend rows without copying }
                   for i:=0 to FNCol do
                     for j:=FNRow+1 to nr do
                       Array1L (FPoiArray^)[(j-1)*(FNCol+1)+i+1] := 0;
                   for j:=FNRow+1 to nr do
                     begin
                     Array1L (FSortIx^)[j] := j;
                     Array1B (FRowAttrib^)[j] := 0;
                     end;
                   FNRow := nr;
                   reslt := true;
                   end
              else reslt := NormalResize (nc, nr)
           end;
    Changed;
    end;
  end;
Resize := reslt;
end;


(*******************************************************************)
procedure TStringArray.GarbageCollection;
(*******************************************************************)

var
  bnum     : integer;
  i,j      : integer;
  spoi     : longint;
  buffnum  : longint;
  offset   : longint;
  poolPoi  : pointer;
  sleng    : byte;
  FStgPool : pointer;
  NewFFree : longint;
  NewOffset: longint;

begin
for bnum:=1 to FNumPoolAddr do     // for each buffer
  begin
  GetMem (FStgPool, SABuffSize);   // create empty string buffer
  NewFFree := 1;                   // new buffer is empty
  for i:=1 to FNCol do
    for j:=1 to FNRow do           // now check all string entries for that buffer bnum
      begin
      spoi := Array1L(FPoiArray^)[(j-1)*(FNCol+1)+i+1];  { string pointer }
      if spoi <> 0 then                            { no string assigned ?? }
        begin
        buffnum := ($FFFF0000 and spoi) shr 16;     { string pool number }
        if BuffNum = bnum then
          begin
          offset := $0000FFFF and spoi;                { offset in pool }
          poolPoi := Array1P(FPoolAddr^)[buffnum];    { pool pointer }
          Sleng := Array1B(poolpoi^)[offset];         { length of string }
          newoffset := NewFFree;                      { offset in new buffer }
          Move (Array1C(poolpoi^)[offset], Array1C(FStgPool^)[newoffset], 1+SLeng); { copy string }
          Array1L(FPoiArray^)[(j-1)*(FNCol+1)+i+1] := longint($FFFF0000 and spoi) + newoffset; { enter string pointer }
          NewFFree := NewFFree+SLeng+1;               { increase free pointer by length of string }
          end;
        end;
      end;
  FreeMem (Array1P(FPoolAddr^)[bnum], SABuffSize); { deallocate the old buffer }
  Array1L(FFirstFree^)[bnum] := NewFFree;          { enter the new buffer }
  Array1P(FPoolAddr^)[bnum] := FStgPool;
  end;
end;


(*******************************************************************)
procedure TStringArray.Clear;
(*******************************************************************
  remove all string entries
 *******************************************************************)

var
  i,j       : longint;
  AuxPoi    : pointer;

begin
for i:=0 to FNCol do   // fill PoiArray with nils
  for j:=1 to FNRow do
    Array1L (FPoiArray^)[(j-1)*(FNCol+1)+i+1] := 0;
for j:=1 to FNRow do        { no sorting }
  Array1L (FSortIx^)[j] := j;
for j:=1 to FNRow do        { clear attributes }
  Array1B (FRowAttrib^)[j] := 0;
for j:=1 to FNCol do        { clear attributes }
  Array1B (FColAttrib^)[j] := 0;
if FNumPoolAddr > 1 then
  begin  // remove all excess string pools
  for i:=2 to FNumPoolAddr do
    if Array1P(FPoolAddr^)[i] <> NIL then
      FreeMem (Array1P(FPoolAddr^)[i], SABuffSize);

  GetMem (AuxPoi, sizeof(pointer));
  Array1P(AuxPoi^)[1] := Array1P(FPoolAddr^)[1];
  FreeMem (FPoolAddr, sizeof(pointer)*FNumPoolAddr);
  FPoolAddr := AuxPoi;

  Getmem (AuxPoi, sizeof(longint));
  Array1L(AuxPoi^)[1] := Array1L(FFirstFree^)[1];
  FreeMem (FFirstFree, sizeof(longint)*FNumPoolAddr);
  FFirstFree := AuxPoi;

  FNumPoolAddr := 1;
  end;
Array1L(FFirstFree^)[1] := 1;
end;

(*******************************************************************)
procedure TStringArray.Fill (s: ShortString);
(*******************************************************************
  remove all string entries
 *******************************************************************)

var
  i,j       : longint;

begin
if s = ''
  then Clear     // clear strings if fill string is empty (remove spare buffers)
  else begin
       for i:=0 to FNCol do   // fill PoiArray with nils
         for j:=1 to FNRow do
           SetString (i,j, s);
       end;
end;


(*********************************************************)
function TStringArray.ColumnEmpty (ACol: longint): boolean;
(*********************************************************
  ENTRY:  Acol .... column number to be checked

  EXIT:   returns True if all elements of column ACol are
          empty (= empty or filled with spaces)
 *********************************************************)

var
  empty     : boolean;
  astr      : string;
  i, j      : integer;
  AllBlanks : boolean;

begin
empty := true;
for i:=1 to FNRow do
  begin
  astr := GetString (ACol,i);
  if astr <> '' then
    begin
    AllBlanks := true;
    for j:=1 to length(astr) do
      if astr[j] <> ' ' then
        AllBlanks := false;
    if not AllBlanks then
      empty := false;
    end;
  end;
ColumnEmpty := empty;
end;


(*********************************************************)
function TStringArray.FindCellIntern (FindStr: string; MatchCase: boolean;
                         ColLow, ColHigh, RowLow, RowHigh: longint;
                         var Col, row: longint; Exact: boolean): boolean;
(*********************************************************)


var
  ldummy   : longint;
  i, j     : longint;
  found    : boolean;
  astr     : string;

begin
if not MatchCase then
  FindStr := lowercase(FindStr);
if (ColLow = -1) or (ColHigh = -1) then
  begin
  ColLow := 0;
  ColHigh := FNCol;
  end;
if (RowLow = -1) and (RowHigh = -1) then
  begin
  RowLow := 1;
  RowHigh := FNRow;
  end;
if ColLow < 0 then
  ColLow := 0;
if ColLow > FNCol then
  ColLow := FNCol;
if ColHigh < 0 then
  ColHigh := 0;
if ColHigh > FNCol then
  ColHigh := FNCol;
if ColLow > ColHigh then
  begin
  ldummy := ColHigh;
  ColHigh := ColLow;
  ColLow := ldummy;
  end;
if RowLow < 1 then
  RowLow := 1;
if RowLow > FNRow then
  RowLow := FNRow;
if RowHigh < 1 then
  RowHigh := 1;
if RowHigh > FNRow then
  RowHigh := FNRow;
if RowLow > RowHigh then
  begin
  ldummy := RowHigh;
  RowHigh := RowLow;
  RowLow := ldummy;
  end;

found := false;
i:=ColLow-1;
while not found and (i < ColHigh) do
  begin
  inc (i);
  j:=RowLow-1;
  while not found and (j < RowHigh) do
    begin
    inc (j);
    astr := GetString (i,j);
    if not MatchCase then
      astr := lowercase(astr);
    if Exact
      then begin
           if (FindStr = astr) then
             begin
             found := true;
             Col := i;
             Row := j;
             end;
           end
      else begin
           if (pos (FindStr, astr) > 0) then
             begin
             found := true;
             Col := i;
             Row := j;
             end;
           end;
    end;
  end;
FindCellIntern := found;
end;



(*********************************************************)
function TStringArray.FindCell (FindStr: string; MatchCase: boolean;
                                ColLow, ColHigh, RowLow, RowHigh: longint;
                                var Col, row: longint): boolean;
(*********************************************************
  ENTRY: FindStr ....... string to be searched
         MatchCase ..... TRUE: match case
         ColLow, ColHigh
         RowLow, RowHigh ... columns or rows to restrict search
                             (-1 means all columns/rows)

  EXIT:  col, row ... cell coordinates of found cell
         function returns TRUE if cell has been found
 *********************************************************)

begin
FindCell := FindCellIntern (FindStr, MatchCase, ColLow, ColHigh, RowLow, RowHigh, Col, row, false);
end;


(*********************************************************)
function TStringArray.FindCellExact (FindStr: string; MatchCase: boolean;
                                ColLow, ColHigh, RowLow, RowHigh: longint;
                                var Col, row: longint): boolean;
(*********************************************************
  ENTRY: FindStr ....... string to be searched
         MatchCase ..... TRUE: match case
         ColLow, ColHigh
         RowLow, RowHigh ... columns or rows to restrict search
                             (-1 means all columns/rows)

  EXIT:  col, row ... cell coordinates of found cell
         function returns TRUE if cell has been found
 *********************************************************)

begin
FindCellExact := FindCellIntern (FindStr, MatchCase, ColLow, ColHigh, RowLow, RowHigh, Col, row, true);
end;


(*********************************************************)
function TStringArray.FindCellInSortedColumn (FindStr: string;
            MatchCase: boolean; ColIx, RowLow, RowHigh: longint;
            ColIsAscending: boolean; var row: longint): boolean;
(*********************************************************
  ENTRY:  FindStr .......... string to be searched
          MatchCase ........ TRUE: match case
          ColIx ............ column to be used for search
          ColIsAscending ... TRUE if column is sorted in ascending order
          RowLow, RowHigh .. rows to restrict search
                              (-1 means all rows)

  EXIT:   row .............. row index of found cell
          function returns TRUE if cell has been found

  REMARK: Search is carried out by binary search
 *********************************************************)

var
  ldummy   : longint;
  found    : boolean;
  astr     : string;

begin
if not MatchCase then
  FindStr := lowercase(FindStr);
if (RowLow = -1) and (RowHigh = -1) then
  begin
  RowLow := 1;
  RowHigh := FNRow;
  end;
if ColIx < 0 then
  ColIx := 0;
if ColIx > FNCol then
  ColIx := FNCol;
if RowLow < 1 then
  RowLow := 1;
if RowLow > FNRow then
  RowLow := FNRow;
if RowHigh < 1 then
  RowHigh := 1;
if RowHigh > FNRow then
  RowHigh := FNRow;
if RowLow > RowHigh then
  begin
  ldummy := RowHigh;
  RowHigh := RowLow;
  RowLow := ldummy;
  end;

found := false;
row := (RowHigh + RowLow) div 2;
while not found and (RowLow <> RowHigh) do
  begin
  row := (RowHigh + RowLow) div 2;
  astr := GetString (ColIx,row);
  if not MatchCase then
    astr := lowercase(astr);
  if astr = FindStr
    then found := true
    else begin
         if (FindStr < astr) xor ColIsAscending
           then RowLow := row+1
           else RowHigh := row;
         end;
  end;
FindCellInSortedColumn := found;
end;


(*********************************************************)
function TStringArray.RowEmpty (ARow: longint): boolean;
(*********************************************************
  ENTRY:  ARow .... row number to be checked

  EXIT:   returns True if all elements of row ARow are
          empty (= empty or filled with spaces)
 *********************************************************)

var
  empty     : boolean;
  astr      : string;
  i, j      : integer;
  AllBlanks : boolean;

begin
empty := true;
for i:=1 to FNCol do
  begin
  astr := GetString (i,ARow);
  if astr <> '' then
    begin
    AllBlanks := true;
    for j:=1 to length(astr) do
      if astr[j] <> ' ' then
        AllBlanks := false;
    if not AllBlanks then
      empty := false;
    end;
  end;
RowEmpty := empty;
end;

(*********************************************************)
procedure TStringArray.RemoveRow (r: longint);
(*********************************************************
  ENTRY: r ... index of row to be removed
  EXIT:  row r is removed, length of string array is
         decreased by one row
 *********************************************************)

var
  i, j       : longint;
  FSortIxBak : pointer;
  rorg       : longint;

begin
if (r>=1) and (r <= FNRow) then
  begin
  rorg := r;
  r := Array1L (FSortIx^)[r];
  GetMem (FSortIxBak, sizeof(longint)*FRAllocated);
  for i:=1 to FNRow do   // backup sort order and unsort
    begin
    Array1L (FSortIxBak^)[i] := Array1L (FSortIx^)[i];
    Array1L (FSortIx^)[i] := i;
    end;
  for i:=r+1 to FNRow do  // copy rows one position down
    begin
    for j:=0 to FNCol do
      SetString (j,i-1,GetString(j,i));
    SetRowAttrib (i-1, GetRowAttrib(i));
    end;
  for i:=1 to FNRow do    // restore sort order
    Array1L (FSortIx^)[i] := Array1L (FSortIxBak^)[i];
  if FSortIxBak <> NIL then
    FreeMem (FSortIxBak, sizeof(longint)*FRAllocated);
  for i:=rorg+1 to FNRow do  // adjust sort index
    Array1L (FSortIx^)[i-1] := Array1L (FSortIx^)[i];
  for i:=1 to FNRow do
    if Array1L (FSortIx^)[i] >= r then
      Array1L (FSortIx^)[i] := Array1L (FSortIx^)[i]-1;
  SetNrRows (FNRow-1);      // decrease array size
  end;
end;


(*********************************************************)
procedure TStringArray.InsertRow (r: longint);
(*********************************************************
  ENTRY: r ... index of row for insertion of empty row
  EXIT:  row is inerted at index r, length of string array is
         increased by one row
 *********************************************************)

var
  i, j       : longint;
  FSortIxBak : pointer;
  rorg       : longint;

begin
if (r>=1) and (r <= FNRow) then
  begin
  rorg := r;
  r := Array1L (FSortIx^)[r];
  SetNrRows (FNRow+1);         // increase string array
  GetMem (FSortIxBak, sizeof(longint)*FRAllocated);
  for i:=1 to FNRow do         // backup sort order and unsort
    begin
    Array1L (FSortIxBak^)[i] := Array1L (FSortIx^)[i];
    Array1L (FSortIx^)[i] := i;
    end;
  for i:=FNRow downto r+1 do  // copy rows one position up
    begin
    for j:=0 to FNCol do
      SetString (j,i,GetString(j,i-1));
    SetRowAttrib (i, GetRowAttrib(i-1));
    end;
  for j:=0 to FNCol do        // clear inserted row
    SetString (j,r,'');
  SetRowAttrib (r, 0);
  for i:=1 to FNRow do        // restore original sort order
    Array1L (FSortIx^)[i] := Array1L (FSortIxBak^)[i];
  if FSortIxBak <> NIL then
    FreeMem (FSortIxBak, sizeof(longint)*FRAllocated);
  for i:=FNRow downto rorg+1 do  // adjust sort index
    Array1L (FSortIx^)[i] := Array1L (FSortIx^)[i-1];
  for i:=1 to FNRow do
    if Array1L (FSortIx^)[i] >= r then
      Array1L (FSortIx^)[i] := Array1L (FSortIx^)[i]+1;
  Array1L (FSortIx^)[rorg] := rorg;
  end;
end;



(*********************************************************)
procedure TSTringArray.Sort (Col: longint; Ascending: boolean);
(*********************************************************
  ENTRY: Co ......... index of column to be taken as
                      sorting criterion
         Ascending .. type of sorting (FALSE = descending,
                                       TRUE ascending)

  EXIT:  array sorted according to column 'Col'.

  REMARK: algorithm used for sorting: compsort (modified bubble sort)
 *********************************************************)

const
  ShrinkFac = 1.3;

var
  JumpWidth : longint;
  ix        : integer;
  exchngd   : boolean;
  ldummy    : longint;


begin
JumpWidth := FNRow;
if JumpWidth > 1 then
  begin
  if Ascending
    then begin
         repeat
           JumpWidth := trunc(JumpWidth/ShrinkFac);
           if JumpWidth = 0 then
             JumpWidth := 1;
           ix := 1;
           exchngd := False;
           repeat
             if lowercase(GetString(col, ix)) > lowercase(GetString (col, ix+JumpWidth)) then
               begin
               ldummy := Array1L(FSortIx^)[ix];
               Array1L(FSortIx^)[ix] := Array1L(FSortIx^)[ix+JumpWidth];
               Array1L(FSortIx^)[ix+JumpWidth] := ldummy;
               exchngd := True;
               end;
             inc (ix);
           until (ix+JumpWidth > FNRow);
         until ((JumpWidth = 1) and not exchngd);
         end
    else begin
         repeat
           JumpWidth := trunc(JumpWidth/ShrinkFac);
           if JumpWidth = 0 then
             JumpWidth := 1;
           ix := 1;
           exchngd := False;
           repeat
             if lowercase(GetString (col,ix)) < lowercase(GetString (col,ix+JumpWidth)) then
               begin
               ldummy := Array1L(FSortIx^)[ix];
               Array1L(FSortIx^)[ix] := Array1L(FSortIx^)[ix+JumpWidth];
               Array1L(FSortIx^)[ix+JumpWidth] := ldummy;
               exchngd := True;
               end;
             inc (ix);
           until (ix+JumpWidth > FNRow);
         until ((JumpWidth = 1) and not exchngd);
         end;
  Changed;
  end;
end;

(*********************************************************)
procedure TStringArray.UnSort;
(*********************************************************
  EXIT:  arrange rows in original order (unsorted)
 *********************************************************)

var
  i         : integer;

begin
for i:=1 to FNRow do
  Array1L(FSortIx^)[i] := i;
Changed;
end;


(******************************************************************************)
function TStringArray.ReadFromOpenXMLFile (var InFile: TextFile; DataID: string): boolean;
(******************************************************************************
  ENTRY: InFile ......... text file to be read (must be already open)
         DataID ......... if not empty: InFile is read until "id" attribute of <strarray>
                                tag matches DataID
                          if empty: next <strarray> of InFile is read (disregarding
                                the "id" attribute

  EXIT:  report list view is configured and filled according to the data stored
         as <strarray> XML tag. The function returns TRUE if a valid <strarray>
         tag has been found.
 ******************************************************************************)



function MatchTags (Instring: string): TXmlTag;
(*-------------------------------------------*)

var
  i  : TXmlTag;

begin
instring := lowercase(instring);
i := xmlNumCols;
while (instring <> xmlTagIds[i]) and (i < xmlInvalid) do
  inc (i);
MatchTags := i;
end;




function ReadNextTag (var attrib, contents: string): TxmlTag;
(*---------------------------------------------------------*)

var
  cc      : char;
  xmltag  : string;
  ix      : integer;

begin
attrib := '';
contents := '';
read (InFile, cc);
while not eof(InFile) and (cc <> '<') do  // read starting tag
  read(InFile, cc);
xmltag := '';
while not eof(InFile) and (cc <> '>') do
  begin
  read(InFile, cc);
  xmltag := xmltag  + cc;
  end;
if pos ('/>', xmltag) > 0
  then begin  // empty tag
       ix := pos (' ', xmltag);
       attrib := StripLTBlanks(copy (xmltag, ix+1, length(xmlTag)-ix-2));
       delete (xmltag, ix, length(xmlTag)-ix+1);
       result := MatchTags(xmlTag);
       end
  else begin  // get tag
       ix := pos (' ', xmltag);
       if ix > 0 then
         begin
         attrib := StripLTBlanks(copy (xmltag, ix+1, length(xmlTag)-ix-1));
         delete (xmltag, ix, length(xmlTag)-ix);
         end;
       delete (xmltag, length(xmlTag), 1);
       result := MatchTags(xmlTag);
       cc := ' ';
       while not eof(InFile) and (cc <> '>') do
         begin
         read(InFile, cc);
         contents := contents + cc;
         end;
       ix := pos ('</', contents);
       if ix > 0 then
         begin
         delete (contents, ix, length(contents)-ix);
         end;
       delete (contents, length(contents), 1);
       end;
end;



var
  astr   : string;
  id     : string;
  found  : boolean;
  ix, iy : longint;
  iz     : longint;
  done   : boolean;
  xmltag : TxmlTag;
  cont   : string;
  attr   : string;
  nr, nc : longint;

begin
result := false;
DataID := lowercase(DataID);
repeat
  readln (InFile, astr);
  astr := lowercase(astr);
  ix := pos ('<strarray', astr);
  found := (ix > 0);
  if found then
    found := (pos('sdlcsuite', astr) > 0);
  if found and (DataID <> '') then
    begin
    id := '';
    iy := pos ('id="', astr);
    if iy > 0 then
      begin
      iz := NumberedPos ('"', astr, iy, 2, false);
      id := StripLtBlanks(copy(astr, iy+4, iz-iy-4));
      end;
    if (id <> DataId) then
      found := false;
    end;
until found or eof(InFile);
if found then
  begin
  done := false;
  Unsort;
  while not done do
    begin
    xmltag := ReadNextTag (attr, cont);
    case xmltag of
     xmlEndStrarray : begin
                      done := true;
                      result := true;
                      end;
         xmlNumCols : begin
                      ix := 1;
                      nc := ScanDecimal(cont, ix);
                      if nc > 0 then
                        SetNrCols (nc);
                      end;
         xmlNumRows : begin
                      ix := 1;
                      nr := ScanDecimal(cont, ix);
                      if nr > 0 then
                        SetNrRows (nr);
                      end;
            xmlCell : begin
                      ix := pos ('ix="', attr)+4;
                      nc := ScanDecimal(attr, ix);
                      iy := pos ('iy="', attr)+4;
                      nr := ScanDecimal(attr, iy);
                      SetString (nc, nr, cont);
                      end;
    end;
    end;
  Changed;
  end;
end;





(******************************************************************************)
function TStringArray.LoadFromXMLFile (FName: string; DataID: string): boolean;
(******************************************************************************
  ENTRY: FName .......... name of file to be read
         DataID ......... if not empty: InFile is read until "id" attribute of <strarray>
                                tag matches DataID
                          if empty: next <strarray> of InFile is read (disregarding
                                the "id" attribute

  EXIT:  report list view is configured and filled according to the data stored
         as <strarray> XML tag. The function returns TRUE if a valid <strarray>
         tag has been found.
 ******************************************************************************)

var
  InFile : TextFile;

begin
result := false;
assignFile (InFile, FName);
{$I-} reset (InFile); {$I+}
if IOResult = 0 then
  begin
  result := ReadFromOpenXMLFile (InFile, DataID);
  closeFile (InFile);
  end;
end;



(******************************************************************************)
procedure TStringArray.WriteToOpenXMLFile (var OutFile : TextFile;
                  CreateHeader: boolean; DataID: string);
(******************************************************************************
  ENTRY: OutFile .......... text file to be written (must be already open)
         CreateHeader ... TRUE: simple XML header is created
         DataID ......... ID of ReportList component

  EXIT:  Data of TStringArray is exported to the text file OutFile
 ******************************************************************************)


var
  i,j   : integer;
  astr  : string;

begin
if CreateHeader then
  begin
  writeln (OutFile, '<?xml version="1.0"?>');
  end;
writeln (OutFile);
writeln (OutFile, '<!-- TStringArray / SDL Component Suite -->');
writeln (OutFile, '<strarray sig="SDLCSuite" vers="1.0" id="'+DataID+'">');
writeln (OutFile, '<numcols>',FNCol,'</numcols>');
writeln (OutFile, '<numrows>',FNRow,'</numrows>');
for j:=1 to FNRow do
  for i:=0 to FNCol do
    begin
    astr := GetString(i,j);
    if (astr <> '') then
      begin
      write (OutFile, '<cell ix="',i,'" iy="',j,'"');
      write (OutFile, '>',astr);
      writeln (OutFile, '</cell>');  //all nonzero elements: x,y,string
      end;
    end;
writeln (OutFile, '</strarray>');
end;


(******************************************************************************)
procedure TStringArray.SaveAsXMLFile (FName: string; DataID: string);
(******************************************************************************
  ENTRY: FName .......... name of text file to be written
         DataID ......... ID of ReportList component

  EXIT:  Data of TStringArray is exported to the XML file FName
 ******************************************************************************)

var
  OutFile : TextFile;

begin
assignFile (OutFile, FName);
rewrite (OutFile);
WriteToOpenXMLFile (OutFile, true, DataID);
closeFile (OutFile);
end;



(******************************************************************)
function TStringArray.AddRow: longint;
(******************************************************************)

begin
SetNrRows (FNRow+1);
AddRow := FNRow;      // the new row count
end;


{$IFDEF DEBUG}
(*********************************************************)
procedure TStringArray.GetDebugInfo (var SL: TStringList);
(*********************************************************
  this routine is intended for debugging purposes only
 *********************************************************)

var
  i : integer;
  astr : string;

begin
SL.Clear;
SL.Add ('no.cols: '+intTostr(FNcol));
SL.Add ('no.rows: '+intTostr(FNRow));
SL.Add ('no.pool chunks: '+intTostr(FNumPoolAddr));
SL.Add ('chunk info: ');
for i:=1 to FNumPoolAddr do
  begin
  astr := IntToStr (i);
  astr := astr + ' ';
  astr := astr + IntToStr (Array1L(FFirstFree^)[i]) +'  '+IntToStr(Array1L(FPoolAddr^)[i]);
  SL.Add (astr);
  end;
end;
{$ENDIF}

(******************************************************************)
function NextCombination (var CurrentCombi: TCombination; MaxVal: integer): boolean;
(******************************************************************
  ENTRY:  CurrentCombi .... current combination
          MaxVal .......... maximum number of the cell value

  EXIT:   function returns the next combination of n numbers which is
          within 1 and MaxVals and has no doublet entries. The number
          of places n is determined by the CurrentCombi variable
          (CurrentCombi[0]).
 ******************************************************************)

var
  jj : integer;


function IncElem (level: integer): boolean;
(*---------------------------------------*)

var
  reslt : boolean;
  i     : integer;

begin
reslt := true;
if CurrentCombi[Level] < MaxVal-CurrentCombi[0]+level
  then begin
       inc (CurrentCombi[Level]);
       jj := CurrentCombi[Level];
       for i:=Level+1 to CurrentCombi[0] do
         begin
         inc (jj);
         CurrentCombi[i] := jj;
         end;
       end
  else begin
       if level = 1
         then reslt := false
         else reslt := IncElem(Level-1);
       end;
IncElem := reslt;
end;

begin
NextCombination :=IncElem(CurrentCombi[0]);
end;


(******************************************************************************)
function CalcNextCRC16 (inbyte: byte; crc: word): word;
(******************************************************************************)

begin
CalcNextCRC16 := ( crc shl 8 ) XOR crc_ccitt_tab[( crc shr 8 ) XOR inbyte];
end;


(******************************************************************************)
function CRC16ofBuffer (BufPoi: pointer; NumData: integer; CRC16Mode: TCRC16Mode): word;
(******************************************************************************)

var
  i: integer;

begin
if CRC16Mode = crcZModem
  then result := 0
  else result := $FFFF;                     // initialize according to type of CRC
for i:= 1 to NumData do
  result:= CalcNextCRC16 (Array1B(BufPoi^)[i], result);
end;


(******************************************************************************)
function CalcNextCRC32 (inbyte: byte; crc: longint): longint;
(******************************************************************************)


begin
CalcNextCRC32 := crc_32_tab[BYTE(crc xor LONGINT(inbyte))] xor (longword(crc shr 8));
end;


(******************************************************************************)
function CRC32ofBuffer (BufPoi: pointer; NumData: integer): longint;
(******************************************************************************)

var
  i: integer;

begin
result:= -1;                // initialize the CRC variable to $FFFFFFFF
for i:= 1 to NumData do
  result:= CalcNextCRC32 (Array1B(BufPoi^)[i], result);
result := result xor longint($FFFFFFFF);
end;


(******************************************************************************)
procedure EncodeASCII85 (InStream, OutStream: TStream);
(******************************************************************************
  ENTRY: InStream ...... Stream containing data to be encoded; data are
                         read from the current position

  EXIT:  OutStream ..... ASCII85 encoded data are appended to stream OutStream

  REMARKS: description of ASCII85 encoding (copy of Adobe PDF specification):

      ASCII base-85 encoding produces five ASCII printing characters from
      every four bytes of binary data. Each group of four binary bytes
      (b1 b2 b3 b4) is converted to a group of five encoded characters
      (c1 c2 c3 c4 c5) using the relation
           b1*256^3 + b2*256^2 + b3*256^1 + b4 =
           c1*85^4 + c2*85^3 + c3*85^2 + c4*85^1 + c5
      The five digits of the encoded base-85 number are converted to printable
      ASCII characters by adding 33 (the ASCII code for !) to each. The resulting
      data contains only printable ASCII characters with codes in the range 33
      (!)to 117(u). Two special cases occur during encoding. First, if all five
      encoded digits are zero, they are represented by the character code 122 (z),
      instead of by a series of five exclamation points (!!!!!). In addition,
      if the length of the binary data to be encoded is not a multiple of four
      bytes, the last partial 4-tuple is used to produce a last, partial output
      5-tuple. Given n (1, 2, or 3) bytes of binary data, the encoding first
      appends 4 -n zero bytes to make a complete 4-tuple. This 4-tuple is encoded
      in the usual way, but without applying the special z case. Finally, only
      the first n + 1 characters of the resulting 5-tuple are written out. Those
      characters are immediately followed by the EOD marker, which is the
      two-character sequence ~>.
 ******************************************************************************)

var
  InBuf  : array[1..4] of byte;
  InNum  : cardinal absolute InBuf;
  OutBuf : array[1..5] of byte;
  count  : integer;
  i      : integer;
  x, y   : cardinal;

begin
count := 4;
while count = 4 do
  begin
  count := Instream.Read (Inbuf, 4);      // read four bytes of input stream
  if count > 0 then
    begin
    if count < 4 then
      begin
      i := count;                         // complete 4-tuple
      repeat
        inc (i);
        InBuf[i] := 0;
      until i = 4;
      end;
    if (InNum = 0) and (count = 4)
      then begin
           OutBuf[1] := ord('z');         // output 122 for 4 zero values
           OutStream.Write (OutBuf, 1);
           end
      else begin
           y := 0;
           for i:=1 to count do
             y := (y shl 8) + Inbuf[i];
           for i:=count+1 downto 1 do               // calculate quintuple
             begin
             x := y div Power85[i-1];
             y := y - x*Power85[i-1];
             OutBuf[count-i+2] := x + 33;
             end;
           OutStream.Write (OutBuf, count+1); // output (partial) quintuple
           end;
    end;
  end;
OutBuf[1] := ord ('~');                   // final EOD marker
OutBuf[2] := ord ('>');
OutStream.Write (OutBuf, 2);
end;



(******************************************************************************)
function DecodeASCII85 (InStream, OutStream: TStream): integer;
(******************************************************************************
  ENTRY: InStream ...... Stream containing the ASCII85 encoded data; data are
                         read from the current position

  EXIT:  OutStream ..... decoded data are appended to stream OutStream
         function returns the following error codes:
                  0 .... no error
                 -1 .... invalid character in input stream
                 -2 .... 'z' in middle of quintuple

  REMARKS: In addition to the original Adobe definition DecodeASCII85 accepts CR
           (ASCII 13) and LF (ASCII10) in the input stream. These characters are
           discarded.

  description of ASCII85 encoding (copy of Adobe PDF specification):
      ASCII base-85 encoding produces five ASCII printing characters from
      every four bytes of binary data. Each group of four binary bytes
      (b1 b2 b3 b4) is converted to a group of five encoded characters
      (c1 c2 c3 c4 c5) using the relation
           b1*256^3 + b2*256^2 + b3*256^1 + b4 =
           c1*85^4 + c2*85^3 + c3*85^2 + c4*85^1 + c5
      The five digits of the encoded base-85 number are converted to printable
      ASCII characters by adding 33 (the ASCII code for !) to each. The resulting
      data contains only printable ASCII characters with codes in the range 33
      (!)to 117(u). Two special cases occur during encoding. First, if all five
      encoded digits are zero, they are represented by the character code 122 (z),
      instead of by a series of five exclamation points (!!!!!). In addition,
      if the length of the binary data to be encoded is not a multiple of four
      bytes, the last partial 4-tuple is used to produce a last, partial output
      5-tuple. Given n (1, 2, or 3) bytes of binary data, the encoding first
      appends 4 -n zero bytes to make a complete 4-tuple. This 4-tuple is encoded
      in the usual way, but without applying the special z case. Finally, only
      the first n + 1 characters of the resulting 5-tuple are written out. Those
      characters are immediately followed by the EOD marker, which is the
      two-character sequence ~>.
 ******************************************************************************)

var
  eod    : boolean;
  InBuf  : array[1..5] of byte;
  OutBuf : array[1..4] of byte;
  Mirror : array[1..4] of byte;
  OutNum : cardinal absolute OutBuf;
  count  : integer;
  i      : integer;
  eodix  : integer;
  errnum : integer;

begin
errnum := 0;
eod := false;
while not eod do
  begin
  repeat
    count := Instream.Read (Inbuf, 1);        // read first character of ASCII85 stream
  until (count = 0) or ((InBuf[1] <> 13) and (InBuf[1] <> 10));
  if (count = 0)
    then eod := true
    else begin
         if InBuf[1] = ord('z')             // 'z' means 4 zero bytes;
           then begin
                for i:=1 to 4 do
                  OutBuf[i] := 0;
                OutStream.Write (OutBuf, 4);
                end
           else begin
                i := 1;
                repeat
                  inc (i);
                  repeat
                    count := Instream.Read (InBuf[i], 1);  // get rest of ASCII85 quintuple
                  until (count = 0) or ((InBuf[i] <> 13) and (InBuf[i] <> 10));
                until (count = 0) or (i = 5);
                if i < 5 then
                  eod := true;
                eodix := i + 1;
                for i:=1 to 5 do            // end of data ?
                  if Inbuf[i] = ord ('~') then
                    begin
                    eod := true;
                    eodix := i;
                    end;
                OutNum := 0;
                for i:=1 to eodix-1 do
                  begin
                  if (InBuf[i] < 33) or (InBuf[i] > 117) then  // valid characters ?
                    begin
                    errnum := -1;
                    if InBuf[i] = ord('z') then
                      errnum := -2;
                    end;
                  OutNum := OutNum * 85 + InBuf[i] - 33;     // convert
                  end;
                for i:=1 to eodix-2 do
                  Mirror[i] := OutBuf[eodix-i-1];
                OutStream.Write (Mirror, eodix-2);
                end;
         end;
  end;
DecodeASCII85 := errnum;
end;


(***********************************************************************)
procedure Register;
(***********************************************************************)

begin
RegisterComponents ('SDL', [TRLEncoder]);
end;

(**************************************************************************)
(*                              INIT                                      *)
(**************************************************************************)

begin
{$IFDEF SHAREWARE}
if not DelphiIsRunning then
  ShowMessagePos (GetVisMsgStr, 100,100);
{$ENDIF}
end.



