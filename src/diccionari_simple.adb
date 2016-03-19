with Ada.Text_IO; use Ada.Text_IO;
with pparaula;
use pparaula;
package body diccionari_simple is

   type block is
      record
         p: tparaula;
         next: index;
      end record;

   type mem_space is array(index range 1..index'last) of block;

   ms: mem_space;
   free: index;

   procedure prep_mem_space is
   begin
      for i in index range 1..index'Last-1 loop
         ms(i).next:=i+1;
      end loop;
      ms(index'Last).next:=0;
      free:=1;
   end prep_mem_space;

   function get_block return index is
      r:index;
   begin
      if free=0 then raise space_overflow; end if;
      r:=free; free:=ms(free).next; ms(r).next:=0;
      return r;
   end get_block;

   procedure release_block(r: in out index) is
   begin
      ms(r).next:=free;
      free:= r; r:=0;
   end release_block;

   procedure buit (d: out diccionari) is
   begin
      d.first:=0;
   end buit;

   procedure posa (d: in out diccionari; paraula: in tparaula) is
      r, p: index;
      first: index renames d.first;
   begin
      r:= get_block;
      ms(r):=(paraula,0);
      if first=0 then  --la lista esta vacia
         first:=r;
      else
         p:=first;
         while ms(p).next /=0 loop
            p:= ms(p).next;
         end loop;
         ms(p).next:=r;
      end if;
   end posa;


   function existeix (d: in diccionari; paraula: in tparaula) return boolean is
      first: index renames d.first;
      idx: index;
   begin
      if first=0 then return false;
      else
         idx:= first;
         while ms(idx).next /=0 loop
            if ms(idx).p=paraula then return true; end if;
            idx:= ms(idx).next;
         end loop;
         return false;
      end if;

   end existeix;



begin
   prep_mem_space;

end diccionari_simple;

