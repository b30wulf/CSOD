// include file to perform binary search in sparse matrices
// THIS CODE IS NOT REUSABLE !!!
//
// SearchLow is the index of the nearest matched element

SearchLow := 1;
SearchHigh := FSparseNumElem;
while SearchLow < SearchHigh do
  begin
  SearchMid := (SearchLow + SearchHigh) div 2;
  if Nc = ArraySpI(SpMat^)[SearchMid].colidx
    then begin
         if ArraySpI(SpMat^)[SearchMid].rowidx < Nr
           then SearchLow := SearchMid+1
           else SearchHigh := SearchMid;
         end
    else begin
         if ArraySpI(SpMat^)[SearchMid].colidx < Nc
           then SearchLow := SearchMid+1
           else SearchHigh := SearchMid;
         end;
  end;

