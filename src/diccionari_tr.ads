with pparaula;
use pparaula;

package diccionari_tr is

   type diccionari is limited private;

   --type key_component is ('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z');

   bad_use: exception;
   space_overflow: exception;

   procedure buit (d: out diccionari);
   procedure posa (d: in out diccionari; par: in tparaula);
   function existeix (d: in diccionari; par: in tparaula) return boolean;

private

   type node;
   type pnode is access node;

   type cell is
      record
         punter: pnode;
         is_in: boolean;
      end record;

   type node is array (character) of cell;

   type diccionari is
      record
         root:pnode;
      end record;

end diccionari_tr;
