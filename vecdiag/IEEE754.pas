//  IEEE-754 Support for NANs and INFs.
//  Copyright (C) 1997-1998, 2000 Earl F. Glynn, Overland Park, KS  USA.
//  All Rights Reserved.
//
//  Information about IEEE Arithmetic was taken from
//  "Numerical Computation Guide," Sun Microsystems, 1990.
//
//  Thanks to Jon Shemitz for pointing out an error in the IsInfinity
//  routine and for the Delphi 5 constant definitions and functions.
//  April 2000.

UNIT IEEE754;

INTERFACE




{$J-} // Initialized constants are constants - not initialized variables


// NANSignaling defined in Interface -- all other constants "hidden"
// in implementation.
{$IFDEF VER130}   // Delphi 5
   // Field masks for the 64-bit Double type as suggested by Jon Shemitz
  CONST
    dSignMask     = $8000000000000000;
    dExponentMask = $7FF0000000000000;
    dMantissaMask = $000FFFFFFFFFFFFF;

  // Bit pattern suggested by Jon Shemitz
  CONST
    NANSignalingBits    :  Int64 = dExponentMask OR 1;             // $7FF0000000000001;

  VAR
    NANSignaling       :  DOUBLE ABSOLUTE NANSignalingBits;

{$ELSE}           // Delphi 1-4

{$IFDEF VER120}   // Delphi 4
  CONST
    NANSignalingBits:  Int64 = $7FF0000000000001;
  VAR
    // With $J- directive above and Absolute reference below, this
    // value cannot be changed
    NANSignaling    :  DOUBLE ABSOLUTE NANSignalingBits;
{$ELSE}           // Delphi 1-3
  CONST
    NANSignalingBits:  ARRAY[1..2] OF LongInt = ($00000001, $7FF00000);
  VAR
    NANSignaling    :  DOUBLE ABSOLUTE NANSignalingBits;
{$ENDIF}

{$ENDIF}


  FUNCTION NAN:  DOUBLE;                // The "Quiet" Nan

  FUNCTION PositiveInfinity:  DOUBLE;   //  INF
  FUNCTION NegativeInfinity:  DOUBLE;   // -INF

  // "Is" functions
  FUNCTION IsNAN(CONST d:  DOUBLE):  BOOLEAN;
  FUNCTION IsInfinity(CONST d:  DOUBLE): BOOLEAN;

  // Hex String Conversions
  FUNCTION DoubleToHex(CONST d:  DOUBLE):  STRING;
  FUNCTION HexToDouble(CONST hex:  STRING):  DOUBLE;


IMPLEMENTATION

  USES
    SysUtils;    // IntToHex

  TYPE
    EIEEEMath = class(Exception);

{$IFDEF VER130}   // Delphi 5

  // Bit patterns for the NAN & INF constants suggested by Jon Shemitz
  CONST
    NANQuietBits        :  Int64 = dExponentMask OR dMantissaMask; // $7FFFFFFFFFFFFFFF;
    PositiveInfinityBits:  Int64 = dExponentMask;                  // $7FF0000000000000;
    NegativeInfinityBits:  Int64 = dExponentMask OR dSignMask;     // $FFF0000000000000;

  VAR
    dNANQuiet           :  DOUBLE ABSOLUTE NANQuietBits;
    dPositiveInfinity   :  DOUBLE ABSOLUTE PositiveInfinityBits;
    dNegativeInfinity   :  DOUBLE ABSOLUTE NegativeInfinityBits;

  // Since a NAN is not a single, unique value, a special function is needed
  // for this test
  FUNCTION IsNAN(CONST D:  DOUBLE):  BOOLEAN;   // By Jon Shemitz
    VAR
      Overlay:  Int64 ABSOLUTE d;
  BEGIN
    RESULT := ((Overlay AND dExponentMask) =  dExponentMask)  AND
              ((Overlay AND dMantissaMask) <> 0)
  END {IsNAN};


  FUNCTION IsInfinity(CONST d:  DOUBLE):  BOOLEAN;   // By Jon Shemtiz
    var
      Overlay:  Int64 ABSOLUTE d;
  BEGIN
    Result := ((Overlay AND dExponentMask) = dExponentMask)  AND
              ((Overlay AND dMantissaMask) = 0)
  END {IsInfinity};


{$ELSE}   // Delphi 1-4

{$IFDEF VER120}   // Delphi 4
  // With Int64s, the logical order of the floating point values isn't
  // obfuscated by the "little endian" physical order
  CONST
    NANQuietBits        :  Int64 = $7FFFFFFFFFFFFFFF;
    PositiveInfinityBits:  Int64 = $7FF0000000000000;
    NegativeInfinityBits:  Int64 = $FFF0000000000000;

  VAR
    dNANQuiet           :  DOUBLE ABSOLUTE NANQuietBits;
    dPositiveInfinity   :  DOUBLE ABSOLUTE PositiveInfinityBits;
    dNegativeInfinity   :  DOUBLE ABSOLUTE NegativeInfinityBits;

  // Since a NAN is not a single, unique value, a special function is needed
  // for this test
  FUNCTION IsNAN(CONST d:  DOUBLE):  BOOLEAN;
    VAR
      Overlay:  Int64 ABSOLUTE d;
  BEGIN
    RESULT := ((Overlay AND $7FF0000000000000) =  $7FF0000000000000) AND
              ((Overlay AND $000FFFFFFFFFFFFF) <> $0000000000000000)
  END {IsNAN};


  FUNCTION IsInfinity(CONST d:  DOUBLE):  BOOLEAN;
    VAR
      Overlay:  Int64 ABSOLUTE d;
  BEGIN
    RESULT := ((Overlay AND $7FF0000000000000) = $7FF0000000000000) AND
              ((Overlay AND $000FFFFFFFFFFFFF) = $0000000000000000)   // Thanks to Jon Shemitz
  END {IsInfinity};


{$ELSE}           // Delphi 1-3

  // The order of integers is "reversed" because of "Little Endian" order.
  // With "Little Endian," the 2nd array element in physical order is the
  // 1st array element in "logical" order.
  CONST
    NANQuietBits         :  ARRAY[1..2] OF LongInt = ($FFFFFFFF, $7FFFFFFF);
    PositiveInfinityBits :  ARRAY[1..2] OF LongInt = ($00000000, $7FF00000);
    NegativeInfinityBits :  ARRAY[1..2] OF LongInt = ($00000000, $FFF00000);

  VAR
    // NEVER MODIFY THESE VARIABLES
    // "Absolute" cannot be used in CONST defintions.

    dNANQuiet             :  DOUBLE ABSOLUTE NANQuietBits;
    dPositiveInfinity     :  DOUBLE ABSOLUTE PositiveInfinityBits;
    dNegativeInfinity     :  DOUBLE ABSOLUTE NegativeInfinityBits;


  // Since a NAN is not a single, unique value, a special function is needed
  // for this test
  FUNCTION IsNAN(CONST d:  DOUBLE):  BOOLEAN;
    VAR
      Overlay:  ARRAY[1..4] OF WORD ABSOLUTE d;
  BEGIN
    RESULT := ((Overlay[4] AND $7FF0) = $7FF0) AND
              ((Overlay[1] <> 0) OR (Overlay[2] <> 0) OR (Overlay[3] <> 0))
  END {IsNAN};


  FUNCTION IsInfinity(CONST d:  DOUBLE):  BOOLEAN;
    VAR
      Overlay:  ARRAY[1..2] OF LongInt ABSOLUTE d;
  BEGIN
    RESULT := ( (Overlay[2] AND $7FF00000) = $7FF00000) AND
                (Overlay[1] = 0 )
  END {IsInfinity};

{$ENDIF}
{$ENDIF}



{$IFDEF VER130}   // Delphi 5

//  The following was a tempting "improvement" in Delphi 4, BUT
//  there was no longer zero padding on the left.
//  This bug was fixed and works fine in Delphi 5.

  FUNCTION DoubleToHex(CONST d:  DOUBLE):  STRING;
    VAR
      Overlay:  Int64 ABSOLUTE d;
  BEGIN
    RESULT := IntToHex(Overlay, 16)
  END {DoubleToHex};


//  The following was a tempting "improvement" in Delphi 4-5, BUT
//  the constant for -0, $8000000000000000 generated an error
//  "not a valid integer value."
//  This bug was fixed in Delphi 5.
//  FUNCTION HexToDouble(CONST hex:  STRING):  DOUBLE;
//    VAR
//      i:  Int64;
//      d:  Double absolute i;
//  BEGIN
//    IF   LENGTH(hex) <> 16
//    THEN raise EIEEEMath.Create('Invalid hex string for HexToDouble');
//
//    i := StrToInt('$' + hex);
//    RESULT := d;
//  END {HexToDouble};

  FUNCTION HexToDouble(CONST hex:  STRING):  DOUBLE;
    VAR
      d      :  DOUBLE;
      Overlay:  ARRAY[1..2] OF LongInt ABSOLUTE d;
  BEGIN
    IF   LENGTH(hex) <> 16
    THEN raise EIEEEMath.Create('Invalid hex string for HexToDouble');

    Overlay[1] := StrToInt('$' + COPY(hex, 9, 8));
    Overlay[2] := StrToInt('$' + Copy(hex, 1, 8));

    RESULT := d
  END {HexToDouble};


 {$ELSE}     // Delphi 1-4

  FUNCTION DoubleToHex(CONST d:  DOUBLE):  STRING;
    VAR
      Overlay:  ARRAY[1..2] OF LongInt ABSOLUTE d;
  BEGIN
    // Look at element 2 before element 1 because of "Little Endian" order.
    RESULT := IntToHex(Overlay[2],8) + IntToHex(Overlay[1],8);
  END {DoubleToHex};


  FUNCTION HexToDouble(CONST hex:  STRING):  DOUBLE;
    VAR
      d      :  DOUBLE;
      Overlay:  ARRAY[1..2] OF LongInt ABSOLUTE d;
  BEGIN
    IF   LENGTH(hex) <> 16
    THEN raise EIEEEMath.Create('Invalid hex string for HexToDouble');

    Overlay[1] := StrToInt('$' + COPY(hex, 9, 8));
    Overlay[2] := StrToInt('$' + Copy(hex, 1, 8));

    RESULT := d
  END {HexToDouble};
{$ENDIF}


  // Use functions to make sure values can never be changed.
  FUNCTION NAN:  DOUBLE;
  BEGIN
    RESULT := dNANQuiet
  END {NAN};


  FUNCTION PositiveInfinity:  DOUBLE;
  BEGIN
    RESULT := dPositiveInfinity
  END {NAN};


  FUNCTION NegativeInfinity:  DOUBLE;
  BEGIN
    RESULT := dNegativeInfinity
  END {NAN};


END.
