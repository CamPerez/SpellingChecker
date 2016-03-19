with Ada.Sequential_IO, Ada.Text_IO, pparaula, diccionari_simple;
use Ada.Text_IO, pparaula, diccionari_simple;

procedure Main is


   nom_fichero: String (1..80);
   letra: String(1..2);
   last_letra: Natural;
   last_fichero: Natural;

   origen: OrigenParaules;
   p: tparaula;
   dicc: diccionari;

begin
   put_line("Escriba 'f' para realizar la lectura desde un fichero o 't' si desea realizar la lectura desde teclado");
   Ada.Text_IO.Get_Line(letra,last_letra);

   if(letra(1..last_letra)="f") then
      put_line("Indique el nombre del fichero");
      Ada.Text_IO.Get_Line(nom_fichero,last_fichero);
      open(origen,nom_fichero(1..last_fichero));
      --open(origen,"diccionario.dic");

      buit(dicc);

      get(origen, p);
      while not buida(p) loop
         put_line(toString(p));

         get(origen, p);
      end loop;

   elsif(letra(1..last_letra) = "t") then
      open(origen);
   else
      put_Line("No has introducido un argumento válido.");
   end if;


end Main;
