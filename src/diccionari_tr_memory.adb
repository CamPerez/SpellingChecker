with Ada.Text_IO; use Ada.Text_IO;
with pparaula;
use pparaula;
package body diccionari_tr_memory is

   procedure buit (d: out diccionari) is
      root: pnode renames d.root;
   begin
      root:=null;
   end buit;


   procedure posa (d: in out diccionari; par: in tparaula) is
      root: pnode renames d.root;
      p, r: pnode;
      c: character;
      i: integer;
      llargar: integer := llargaria(par);
      paraula: string (1..llargar);
      is_desc: boolean;
   begin
      p:=root;
      paraula:= toString(par);
      is_desc:= false;
      i:=1;
      c:=paraula(i);
      if p=null then
         r:= new node;
         r.all:=(c, false, null, null);
         root:=r;
         p:=r;
         i:=i+1;
         is_desc:=true;
      end if;
      while i<= llargar loop
         c:=paraula(i);
         if not is_desc then
            while p.kc/=c and p.sibling/=null loop
               p:=p.sibling;
            end loop;

            if p.sibling=null and p.kc/=c then
               r:= new node;
               r.all:=(c, false, null, null);
               p.sibling:= r;
               p:=r;
            end if;
            if p.child/=null then
               p:=p.child;
               is_desc:=false;
            else
               is_desc:=true;
            end if;
         else
            r:= new node;
            r.all:=(c, false, null, null);
            p.child:=r;
            p:=r;
         end if;
         i:=i+1;
      end loop;
      p.is_final:=true;
   exception
         when storage_error => raise space_overflow;
   end posa;


   function existeix (d: in diccionari; par: in tparaula) return boolean is
      root: pnode renames d.root;
      p: pnode;
      c: character;
      llargar: integer := llargaria(par);
      paraula: string (1..llargar);
   begin
      paraula:= toString(par);
      p:= root;
      if p=null then
         return false;
      end if;

      for i in 1..llargar loop
         c:= paraula(i);
         while p.kc/=c and p.sibling/=null loop
            p:= p.sibling;
         end loop;
         if i=llargar and then p.is_final and then p.kc=c then
            return true;
         end if;
         if p.sibling=null and p.kc/=c then return false; end if;
         if p.child=null then return false; end if;
         p:= p.child;
      end loop;
      return false;
   end existeix;

end diccionari_tr_memory;
