--llista implementada amb cursors.
with pparaula;
use pparaula;


package diccionari_simple is

   type diccionari is limited private;

   bad_use: exception;
   space_overflow: exception;

   procedure buit (d: out diccionari);
   procedure posa (d: in out diccionari; paraula: in tparaula);
   function existeix (d: in diccionari; paraula: in tparaula) return boolean;

private

   type index is new integer range 0..100;

   type diccionari is
      record
         first: index;
      end record;

end diccionari_simple;
