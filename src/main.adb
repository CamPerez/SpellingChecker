with Ada.Sequential_IO, Ada.Text_IO, Ada.Calendar, pparaula, diccionari_simple;
use Ada.Text_IO, Ada.Calendar, pparaula, diccionari_simple;

procedure Main is

   Start_Time : Ada.Calendar.Time;

   nom_fichero_dicc: String (1..80);
   nom_fichero_texto: String (1..80);
   letra: String(1..2);
   last_letra: Natural;
   last_fichero: Natural;

   origen: OrigenParaules;
   p: tparaula;
   dicc: diccionari;

   linia: integer:= 1;
   columna: integer:= 1;
   siguiente: boolean:= false;

begin
   put_line("Escriba 'f' para realizar la lectura desde un fichero o 't' si desea realizar la lectura desde teclado");
   Ada.Text_IO.Get_Line(letra,last_letra);

   if(letra(1..last_letra)="f") then
      put_line("Indique el nombre del fichero que contiene el diccionario");
      Ada.Text_IO.Get_Line(nom_fichero_dicc,last_fichero);
      open(origen,nom_fichero_dicc(1..last_fichero)); --abrimos el fichero que contiene el diccionario
      --open(origen,"diccionario.dic");

      buit(dicc);

      get(origen, p, linia, columna, siguiente);
      while not buida(p) loop
         --put_line(toString(p));
	 posa(dicc, p); --creamos la estructura de diccionario
         get(origen, p, linia, columna, siguiente);
      end loop;

      close(origen); --cerramos el fichero del diccionario

      put_line("Indique el nombre del fichero de texto");
      Ada.Text_IO.Get_Line(nom_fichero_texto,last_fichero);
      open(origen,nom_fichero_texto(1..last_fichero)); --abrimos el fichero que contiene el texto

      Start_Time:= Ada.Calendar.Clock; --Cogemos el tiempo antes de empezar el proceso de comparación


      linia:= 1; --Reiniciamos el valor de la linea para el nuevo fichero
      columna:= 0; --Reiniciamos el valor de la columna para el nuevo fichero
      siguiente:= false; --Reiniciamos el valor del booleano siguiente para el nuevo fichero

      get(origen, p, linia, columna, siguiente);
      while not buida(p) loop
         if existeix(dicc, p)=false then--miramos si NO existe la palabra dentro del diccionario
             put_line(toString(p) & " - fila: " & linia'Img & " - columna: " & columna'Img);
         end if;
         get(origen, p, linia, columna, siguiente);
      end loop;

      Put_Line("");
      Put_line("Ha tardado: ");
      Put_Line(Duration'Image(Ada.Calendar.Clock - Start_Time) & " segundos"); -- Imprimimos el tiempo que ha tardado

      close(origen); --cerramos el fichero de texto

   elsif(letra(1..last_letra) = "t") then
      open(origen);
   else
      put_Line("No has introducido un argumento válido.");
   end if;


end Main;
