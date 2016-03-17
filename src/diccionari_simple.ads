--llista implementada amb cursors.

generic

   size: positive;
   --type pparaula is private;
   with function "<" (x1, x2: in item) return boolean;
   with function ">" (x1, x2: in item) return boolean;

package d_diccionari_simple is

   type diccionari is limited private;

   bad_use: exception;
   space_overflow: exception;

   procedure buit (d: out diccionari);
   procedure posa (d: in out diccionari;p: in tparaula);
   function existeix (d: in diccionari; p: in tparaula) return boolean;

private

   type mem_space is array(1..size) of tparaula;

   type diccionari is
      record
         a: mem_space;
         n: natural;
      end record;

end d_diccionari_simple;
