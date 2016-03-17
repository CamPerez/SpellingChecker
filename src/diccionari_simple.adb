with Ada.Text_IO; use Ada.Text_IO;
package body d_heap is

   procedure buit dq: out diccionari) is
      n: natural renames q.n;
   begin
      n:= 0;
   end buit;

   procedure posa (d: in out diccionari; p: in tparaula); is
      a: mem_space renames d.a;
      n: natural renames d.n;
   begin
      if n=size then raise space_overflow; end if;
      n:= n+1; --aumentamos el número del montículo
      a(n):= p;
   end posa;


   function existeix (d: in diccionari; p: in tparaula) return boolean is
      a: mem_space renames d.a;
      n: natural renames d.n;
      h: boolean:=true;
   begin
      for idx in 1..p.llargaria loop
         if (p.lletres(idx)=a(n).lletres(idx)) then
            h:=true;
         else
            h:=false;
         end if;

      return true;

   end existeix;
