with Ada.Text_IO, pparaula, Ada.Containers, Ada.Strings.Hash, diccionari_tr_memory;
use Ada.Text_IO, pparaula, Ada.Strings, diccionari_tr_memory;

package body diccionari_hs is

   procedure buit (d: out diccionari) is
      dt: dispersion_table renames d.dt;
      dicc: diccionari_tr_memory.diccionari;
   begin
      for i in hash_index loop
         diccionari_tr_memory.buit(dt(i));
      end loop;
   end buit;

   procedure posa (d: in out diccionari; par: in tparaula) is
      dt: dispersion_table renames d.dt;
      i: hash_type;
      llargar: integer := llargaria(par);
      paraula: string (1..llargar);
   begin
      paraula:= toString(par);
      i:= hash(paraula) mod b;
      diccionari_tr_memory.posa(dt(i), par);
   end posa;

   function existeix (d: in diccionari; par: in tparaula) return boolean is
      dt: dispersion_table renames d.dt;
      i: hash_type;
      llargar: integer := llargaria(par);
      paraula: string (1..llargar);
   begin
      paraula:= toString(par);
      i:= hash(paraula) mod b;
      return diccionari_tr_memory.existeix(dt(i), par);
   end existeix;

end diccionari_hs;
