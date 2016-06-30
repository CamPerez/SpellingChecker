with pparaula;
use pparaula;

package diccionari_tr is

   type diccionari is limited private;

   bad_use: exception;
   space_overflow: exception;

   procedure buit (d: out diccionari);
   procedure posa (d: in out diccionari; par: in tparaula; map: in mapping);
   function existeix (d: in diccionari; par: in tparaula; map: in mapping) return boolean;

private

   type node;
   type pnode is access node;

   type cell is
      record
         punter: pnode;
         is_in: boolean;
      end record;

   type node is array (key) of cell;

   type diccionari is
      record
         root: pnode;
      end record;


end diccionari_tr;
