with Ada.Text_IO; use Ada.Text_IO;
with pparaula;
use pparaula;
package body diccionari_tr is

   procedure buit (d: out diccionari) is
      root: pnode renames d.root;
   begin
      root:=new node;
      root.all:=(others=>null);
   end buit;

   procedure posa (d: in out diccionari; p: in tparaula) is
      n: index renames d.n;
      a: mem_space renames d.a;
   begin
      if not existeix(d, p) then
         n:= n+1; a(n):=p;
      end if;
   exception
         when storage_error => raise space_overflow;
   end posa;


   function existeix (d: in diccionari; p: in tparaula) return boolean is
      n: index renames d.n;
      a: mem_space renames d.a;
   begin
      for x in a'Range loop
         if a(x)=p then
            return true;
         end if;
      end loop;
      return false;
   end existeix;

end diccionari_tr;
