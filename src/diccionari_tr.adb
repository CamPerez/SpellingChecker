with Ada.Text_IO; use Ada.Text_IO;
with pparaula;
use pparaula;
package body diccionari_tr is

   procedure buit (d: out diccionari) is
      root: pnode renames d.root;
   begin
      root:=new node;
      for x in root'Range loop
         root(x).punter:=null;
         root(x).is_in:=false;
      end loop;

   end buit;

   procedure posa (d: in out diccionari; par: in tparaula) is
      root: pnode renames d.root;
      p, r: pnode;
      c: character;
      i: integer;
      llargar: integer := llargaria(par);
      paraula: string (1..llargar);
   begin
      paraula:= toString(par);
      p:= root; i:= 1; c:= paraula(i);
      while i< llargar loop
         if p.all(c).punter = null then
            r:= new node;
            for x in r'Range loop
       	 	r(x).punter:=null;
         	r(x).is_in:=false;
            end loop;
            p.all(c).punter:= r;
         end if;
         p:= p.all(c).punter; i:=i+1; c:= paraula(i);
      end loop;
      p.all(c).is_in:= True;
   exception
         when storage_error => raise space_overflow;
   end posa;


   function existeix (d: in diccionari; par: in tparaula) return boolean is
      root: pnode renames d.root;
      c: character;
      p: pnode;
      llargar: integer := llargaria(par);
      paraula: string (1..llargar);
      i: integer;
   begin
      paraula:= toString(par);
      p:= root; i:= 1; c:= paraula(i);
      while i < llargar and p.all(c).punter /= null loop
         p:= p.all(c).punter; i:=i+1; c:= paraula(i);
      end loop;
      return i = llargar and p.all(c).is_in;
   end existeix;

end diccionari_tr;
