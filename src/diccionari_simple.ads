with pparaula;
use pparaula;

generic
   max: natural;
package diccionari_simple is

   type diccionari is limited private;

   bad_use: exception;
   space_overflow: exception;

   procedure buit (d: out diccionari);
   procedure posa (d: in out diccionari; p: in tparaula);
   function existeix (d: in diccionari; p: in tparaula) return boolean;

private

   type index is new integer range 0..max;
   type mem_space is array(index range 1..index'last) of tparaula;

   type diccionari is
      record
         a: mem_space;
         n: index;
      end record;

end diccionari_simple;
