with pparaula;
use pparaula;

package diccionari_simple is

   type diccionari is limited private;

   bad_use: exception;
   space_overflow: exception;

   procedure buit (d: out diccionari);
   procedure posa (d: in out diccionari; p: in tparaula);
   function existeix (d: in diccionari; p: in tparaula) return boolean;

private

   type node;
   type pnode is access node;
   --type node is array () of pnode;

   type diccionari is
      record
         root:pnode;
      end record;

end diccionari_simple;
