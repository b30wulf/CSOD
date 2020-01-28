(*------------------------------------------------------------------------*)
              (* the following constants define the code of the physical
                 parameters stored in the file 'xxxxxxxx.QLB' *)
const
  epNUL       = 0;   { parameter not defined }
  epMeltP     = 1;   { melting point at 1 atm }
  epBoilP     = 2;   { boiling point at 1 atm }
  epDens      = 3;   { density at 20 C, d[4;20] }
  epRefIx     = 4;   { refractive index at 20 C, n[D;20] }
  epKoc       = 5;   { lg(Koc), partition coefficient normalized to organic carbon }
  epActiv     = 6;   { activity coefficient }
  epVanWaalA  = 7;   { constant a in van der Waals equation (see Handbook 57, p. D-178) }
  epVanWaalB  = 8;   { constant b in van der Waals equation }
  epWatSolub  = 9;   { water solubility in g/l }
  epDeltHF0   = 10;  { enthalpy of formation in kJ/mol }
  epDeltFf0   = 11;
  epLogKF     = 12;
  epAbsEntrop = 13;
  epHenryK    = 14;
  epDipolMom  = 15;
  epHeatVap   = 16;
  epMolVol    = 17;  { molar volume }
  epRetIx     = 18;  { retention index }
  epCritTemp  = 19;  { critical temperature }
  epPolari    = 20;  { polarizability }

  PPDefined =  20;  { number of physical parameters defined }
  PPName : array[0..PPDefined] of string[40] =   { names of physical parameters }
             ('',
              'melt. point (1 atm)',
              'boil. point (1 atm)',
              'density d[4;20]',
              'refr.index n[D;20]',
              'lg(Koc)',
              'activity coeff',
              'a in van d''Waals eq.',
              'b in van d''Waals eq.',
              'water solubility',
              'dH(f) (298 K)',
              'dG(f) (298 K)',
              'log Kf0',
              'S(0) (298 K)',
              'log Henry''s constant',
              'dipole moment',
              'heat of vaporization',
              'molecular volume',
              'retention index',
              'critical temperature',
              'polarizability');

  PPUnit : array[0..PPDefined] of string[40] =   { units of physical parameters }
             ('',
              '°C',
              '°C',
              'kg/l',
              '',
              '',
              '',
              '',
              '',
              'g/l',
              'kJ/mol',
              'kcal/mol',
              'kcal/mol',
              'cal/K*mol',
              '',
              '',
              'J/mol',
              'XXX',
              '',
              '°C',
              '');

  PPLabel : array[0..PPDefined] of string[5] =   { short labels used in TRANSPEC }
              ('NULL',
               'MELTP',
               'BOILP',
               'DENSI',
               'REFRX',
               'LGKOC',
               'ACCOF',
               'WAALA',
               'WAALB',
               'WSOLU',
               'DHF0',
               'DFF0',
               'LOGKF',
               'ENTR0',
               'LOGHY',
               'DIPOL',
               'HEATV',
               'MOLVL',
               'RETIX',
               'CRITT',
               'POLAR');

  PPFormat : array[0..PPDefined,1..2] of byte = { format paremeters of phys. params }
               ((0,0),
                (6,1),      { melting point at 1 atm }
                (6,1),      { boiling point at 1 atm }
                (6,4),      { density at 25 C }
                (7,5),      { refractive index at 20 C }
                (5,2),      { Koc, partition coefficient normalized to organic carbon }
                (5,1),      { activity coefficient }
                (6,3),      { a in van der Waals eq. }
                (7,5),      { b in van der Waals eq. }
                (2,5),      { water solubility }
                (2,3),      { enthalpy of formation }
                (2,3),      { free energy of formation }
                (2,4),      { log Kf0 }
                (2,2),      { molar entropy }
                (1,3),      { Henry's constant }
                (1,5),      { dipole moment }
                (1,1),      { heat of vaporization }
                (1,3),      { molar volume }
                (1,1),      { retention index }
                (6,2),      { critical temperature }
                (1,4));     { polarizability }

type
  PhysDatType = record                                   { physical data entry }
                  ID   : byte;
                  Param: single;
                end;

(*------------------------------------------------------------------------*)
