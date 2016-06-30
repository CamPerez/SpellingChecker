with pparaula;
use pparaula;

package diccionari_tr_memory is

   type diccionari is limited private;

   bad_use: exception;
   space_overflow: exception;

   procedure buit (d: out diccionari);
   procedure posa (d: in out diccionari; par: in tparaula);
   function existeix (d: in diccionari; par: in tparaula) return boolean;

private

   type node;
   type pnode is access node;

   type node is
      record
         kc: character;
         is_final: boolean;
         child: pnode;
         sibling: pnode;
      end record;

   type diccionari is
      record
         root:pnode;
      end record;

end diccionari_tr_memory;
