with pparaula, diccionari_tr_memory, Ada.Containers, diccionari_tr_memory;
use pparaula, Ada.Containers, diccionari_tr_memory;

generic
   max: natural;
package diccionari_hs is

   type diccionari is limited private;

   bad_use: exception;
   space_overflow: exception;
   already_exists: exception;

   procedure buit (d: out diccionari);
   procedure posa (d: in out diccionari; par: in tparaula);
   function existeix (d: in diccionari; par: in tparaula) return boolean;

private
   b: constant Ada.Containers.Hash_Type:= Ada.Containers.Hash_Type(max);
   subtype hash_index is Ada.Containers.Hash_Type range 0..b-1;

   type dispersion_table is array (hash_index) of diccionari_tr_memory.diccionari;

   type diccionari is
      record
         dt: dispersion_table;
      end record;

end diccionari_hs;
