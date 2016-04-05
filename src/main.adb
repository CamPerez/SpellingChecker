with Ada.Sequential_IO, Ada.Text_IO, Ada.Calendar, pparaula, diccionari_simple;
use Ada.Text_IO, Ada.Calendar, pparaula;


procedure Main is

   Start_Time : Ada.Calendar.Time;

   nom_fichero_dicc: String (1..14);
   nom_fichero_texto: String (1..8);
   letra: String(1..2);
   last_letra: Natural;
   --last_fichero: Natural;
   num_paraules: Natural;

   origen: OrigenParaules;
   p: tparaula;

   linia: integer;
   columna: integer;

   function paraulesDiccionari(nom_fichero_dicc: in String) return Natural is
      num_paraules: Natural:=0;
      fitxer: File_Type;
      c: character;
   begin
      Open(fitxer, In_File, nom_fichero_dicc);
      while not End_Of_File(fitxer) loop
         get(fitxer, c);
         if c = ' ' then
            num_paraules := num_paraules + 1;
         end if;
      end loop;
      Close(fitxer);
      return num_paraules + 1;
   end paraulesDiccionari;

   procedure mainAction(num_paraules : in Natural) is
      package diccio is new diccionari_simple (num_paraules); use diccio;
      dicc: diccionari;
   begin
      open(origen,nom_fichero_dicc);
      buit(dicc);
      get(origen, p, linia, columna);
      while not buida(p) loop
         posa(dicc, p); --cream l'estructura diccionari
         get(origen, p, linia, columna);
      end loop;
      close(origen); --tancam el fitxer del diccionari

      nom_fichero_texto:="text.txt";
      open(origen,nom_fichero_texto); --obrim el fitxer que conté el texto

      Start_Time:= Ada.Calendar.Clock; -- agafam el temps abans de començar el procés de comparació

      columna:=1; --Reiniciamos el valor de la columna para el nuevo fichero
      reiniciarColumna(origen); --Reiniciamos el valor de la columna para el nuevo fichero

      put_line("fila: " & linia'Img & " - columna: " & columna'Img);
      get(origen, p, linia, columna);
      while not buida(p) loop
         if existeix(dicc, p)=false then -- miran si NO existeix la paraula dins del diccionari
            put_line(toString(p));
            put_line("");
            put_line("fila: " & linia'Img & " - columna: " & columna'Img);
         end if;
         get(origen, p, linia, columna);
      end loop;

      put_line("A aquesta fila i columna finalitza el teu text");
      Put_Line("");
      Put_line("Ha tardat: ");
      Put_Line(Duration'Image((Ada.Calendar.Clock - Start_Time)/60) & " minuts"); -- imprimir el temps que ha tardat (minuts)
      Put_Line(Duration'Image(Ada.Calendar.Clock - Start_Time) & " segons"); -- imprimir el temps que ha tardat (segons)
      Put_Line(Duration'Image((Ada.Calendar.Clock - Start_Time)*1000) & " mil·lèsimes"); -- imprimir el temps que ha tardat (mil·lèsimes)
      close(origen);
   end mainAction;


begin
   --inicialitzar_diccionari;
   put_line("Escriba 'f' para realizar la lectura desde un fichero o 't' si desea realizar la lectura desde teclado");
   Ada.Text_IO.Get_Line(letra,last_letra);

   if(letra(1..last_letra)="f") then
      nom_fichero_dicc:="diccionari.dic";
      num_paraules := paraulesDiccionari(nom_fichero_dicc);
      mainAction(100);

   elsif(letra(1..last_letra) = "t") then
      open(origen);
   else
      put_Line("No has introducido un argumento válido.");
   end if;


end Main;
