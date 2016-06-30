with Ada.Sequential_IO, Ada.Text_IO, Ada.Calendar, pparaula, diccionari_simple, diccionari_hs,diccionari_tr, diccionari_tr_memory;
use Ada.Text_IO, Ada.Calendar, pparaula, diccionari_tr, diccionari_tr_memory;

procedure Main is
   F_Temps: Ada.Text_IO.File_Type;

   Start_Time : Ada.Calendar.Time;

   nom_fichero_dicc: String (1..14);
   nom_fichero_texto: String (1..8);
   num_paraules: Natural;

   origen: OrigenParaules;
   p: tparaula;

   linia: integer;
   columna: integer;

   map: mapping;

   function paraulesDiccionari(nom_fichero_dicc: in String) return Natural is
      num_paraules: Natural:=0;
      fitxer: File_Type;
      c: character;
   begin
      Open(fitxer, In_File, nom_fichero_dicc);
      while not End_Of_File(fitxer) loop
         get(fitxer, c);

         if c= ' ' then
            --Botar blancs
            while c =' ' and not End_Of_File(fitxer) loop
               get(fitxer, c);
            end loop;
         end if;
         while not End_Of_File(fitxer) and c /= ' ' loop
            exit when End_Of_Line(fitxer);
            get(fitxer, c);
         end loop;
         num_paraules:= num_paraules + 1;

      end loop;
      Close(fitxer);
      return num_paraules;
   end paraulesDiccionari;

   procedure mainActionSimple(num_paraules : in Natural) is
      package diccio is new diccionari_simple (num_paraules); use diccio;
      dicc: diccio.diccionari;
      F    : Ada.Text_IO.File_Type;
   begin
      open(origen,nom_fichero_dicc);
      buit(dicc);
      get(origen, p, linia, columna, map);
      while not buida(p) loop
         posa(dicc, p); --cream l'estructura diccionari
         get(origen, p, linia, columna, map);
      end loop;
      close(origen); --tancam el fitxer del diccionari

      nom_fichero_texto:="text.txt";
      open(origen,nom_fichero_texto); --obrim el fitxer que conté el texto

      Start_Time:= Ada.Calendar.Clock; -- agafam el temps abans de començar el procés de comparació

      reiniciarFila(origen); --Reiniciamos el valor de la columna para el nuevo fichero
      reiniciarColumna(origen); --Reiniciamos el valor de la columna para el nuevo fichero
      linia:=1;
      columna:=1;

      Create(F, Ada.Text_IO.Out_File, "mainActionSimple.txt");

      get(origen, p, linia, columna, map);

      while not buida(p) loop
         if not existeix(dicc, p) then -- miran si NO existeix la paraula dins del diccionari
            Put_line(F,toString(p) & " - NO existeix");
            Put_line(F,"fila: " & linia'Img & " - columna: " & columna'Img);
            Put_line(F,"");
         end if;
         get(origen, p, linia, columna, map);
      end loop;

      Put_line(F,"El fitxer acaba aquí");

      --Cerramos el fichero donde imprimimos las palabras que no están
      Close(F);
      --Creamos el fichero donde guardaremos los tiempos que tardan nuestras estructuras
      Create(F_Temps, Ada.Text_IO.Out_File, "tiempos.txt");
      Put_line(F_Temps, "-------------------------------------------");
      Put_line(F_Temps, "----------------- CURSOR ------------------");
      Put_line(F_Temps, "-------------------------------------------");
      Put_line(F_Temps, Duration'Image((Ada.Calendar.Clock - Start_Time)/60) & " minuts"); -- imprimir el temps que ha tardat (minuts)
      Put_line(F_Temps, Duration'Image(Ada.Calendar.Clock - Start_Time) & " segons"); -- imprimir el temps que ha tardat (segons)
      Put_line(F_Temps, Duration'Image((Ada.Calendar.Clock - Start_Time)*1000) & " mil·lèsimes"); -- imprimir el temps que ha tardat (mil·lèsimes)

      close(origen);
   end mainActionSimple;

   procedure mainActionTrie is
      dicc: diccionari_tr.diccionari;
      F    : Ada.Text_IO.File_Type;
   begin
      open(origen,nom_fichero_dicc);
      buit(dicc);
      get(origen, p, linia, columna, map);
      while not buida(p) loop
         posa(dicc, p, map); --cream l'estructura diccionari
         get(origen, p, linia, columna, map);
      end loop;
      close(origen); --tancam el fitxer del diccionari

      nom_fichero_texto:="text.txt";
      open(origen,nom_fichero_texto); --obrim el fitxer que conté el texto

      Start_Time:= Ada.Calendar.Clock; -- agafam el temps abans de començar el procés de comparació

      reiniciarFila(origen); --Reiniciamos el valor de la columna para el nuevo fichero
      reiniciarColumna(origen); --Reiniciamos el valor de la columna para el nuevo fichero
      linia:=1;
      columna:=1;

      Create(F, Ada.Text_IO.Out_File, "mainActionTrie.txt");

      get(origen, p, linia, columna, map);

      while not buida(p) loop
         if not existeix(dicc, p, map) then -- miran si NO existeix la paraula dins del diccionari
            Put_line(F,toString(p) & " - NO existeix");
            Put_line(F,"fila: " & linia'Img & " - columna: " & columna'Img);
            Put_line(F,"");
         end if;
         get(origen, p, linia, columna, map);
      end loop;

      Put_line(F,"El fitxer acaba aquí");

      --Cerramos el fichero donde imprimimos las palabras que no están
      Close(F);

      --Metemos en el fichero del tiempo, el cual ya se ecncuentra abierto
      Put_line(F_Temps, "-------------------------------------------");
      Put_line(F_Temps, "----------------- TRIE SIMPLE -------------");
      Put_line(F_Temps, "-------------------------------------------");
      Put_line(F_Temps, Duration'Image((Ada.Calendar.Clock - Start_Time)/60) & " minuts"); -- imprimir el temps que ha tardat (minuts)
      Put_line(F_Temps, Duration'Image(Ada.Calendar.Clock - Start_Time) & " segons"); -- imprimir el temps que ha tardat (segons)
      Put_line(F_Temps, Duration'Image((Ada.Calendar.Clock - Start_Time)*1000) & " mil·lèsimes"); -- imprimir el temps que ha tardat (mil·lèsimes)

      close(origen);
   end mainActionTrie;


   procedure mainActionTrieCompacte is
      dicc: diccionari_tr_memory.diccionari;
      F    : Ada.Text_IO.File_Type;
   begin
      open(origen,nom_fichero_dicc);
      buit(dicc);
      get(origen, p, linia, columna, map);
      while not buida(p) loop
         posa(dicc, p); --cream l'estructura diccionari
         get(origen, p, linia, columna, map);
      end loop;
      close(origen); --tancam el fitxer del diccionari

      nom_fichero_texto:="text.txt";
      open(origen,nom_fichero_texto); --obrim el fitxer que conté el texto

      Start_Time:= Ada.Calendar.Clock; -- agafam el temps abans de començar el procés de comparació

      reiniciarFila(origen); --Reiniciamos el valor de la columna para el nuevo fichero
      reiniciarColumna(origen); --Reiniciamos el valor de la columna para el nuevo fichero
      linia:=1;
      columna:=1;

      Create(F, Ada.Text_IO.Out_File, "mainActionTrieCompacte.txt");
      get(origen, p, linia, columna, map);

      while not buida(p) loop
         if not existeix(dicc, p) then -- miran si NO existeix la paraula dins del diccionari
            Put_line(F,toString(p) & " - NO existeix");
            Put_line(F,"fila: " & linia'Img & " - columna: " & columna'Img);
            Put_line(F,"");
         end if;
         get(origen, p, linia, columna, map);
      end loop;

      Put_line(F,"El fitxer acaba aquí");

      --Cerramos el fichero donde imprimimos las palabras que no están
      Close(F);
      --Metemos en el fichero del tiempo, el cual ya se ecncuentra abierto
      Put_line(F_Temps, "-------------------------------------------");
      Put_line(F_Temps, "--------------- TRIE COMPACTE -------------");
      Put_line(F_Temps, "-------------------------------------------");
      Put_line(F_Temps, Duration'Image((Ada.Calendar.Clock - Start_Time)/60) & " minuts"); -- imprimir el temps que ha tardat (minuts)
      Put_line(F_Temps, Duration'Image(Ada.Calendar.Clock - Start_Time) & " segons"); -- imprimir el temps que ha tardat (segons)
      Put_line(F_Temps, Duration'Image((Ada.Calendar.Clock - Start_Time)*1000) & " mil·lèsimes"); -- imprimir el temps que ha tardat (mil·lèsimes)

      close(origen);
   end mainActionTrieCompacte;


   procedure mainActionHs(num_paraules : in Natural) is
      package diccio_hs is new diccionari_hs (num_paraules); use diccio_hs;
      dicc: diccio_hs.diccionari;
      F    : Ada.Text_IO.File_Type;
   begin
      open(origen,nom_fichero_dicc);
      buit(dicc);
      get(origen, p, linia, columna, map);
      while not buida(p) loop
         posa(dicc, p); --cream l'estructura diccionari
         get(origen, p, linia, columna, map);
      end loop;
      close(origen); --tancam el fitxer del diccionari

      nom_fichero_texto:="text.txt";
      open(origen,nom_fichero_texto); --obrim el fitxer que conté el texto

      Start_Time:= Ada.Calendar.Clock; -- agafam el temps abans de començar el procés de comparació

      reiniciarFila(origen); --Reiniciamos el valor de la columna para el nuevo fichero
      reiniciarColumna(origen); --Reiniciamos el valor de la columna para el nuevo fichero
      linia:=1;
      columna:=1;

      Create(F, Ada.Text_IO.Out_File, "mainActionHs.txt");

      get(origen, p, linia, columna, map);

      while not buida(p) loop
         if not existeix(dicc, p) then -- miran si NO existeix la paraula dins del diccionari
            Put_line(F,toString(p) & " - NO existeix");
            Put_line(F,"fila: " & linia'Img & " - columna: " & columna'Img);
            Put_line(F,"");
         end if;
         get(origen, p, linia, columna, map);
      end loop;

      Put_line(F,"El fitxer acaba aquí");

       --Cerramos el fichero donde imprimimos las palabras que no están
      Close(F);

      --Metemos en el fichero del tiempo, el cual ya se ecncuentra abierto
      Put_line(F_Temps, "-------------------------------------------");
      Put_line(F_Temps, "----------------- HASHING -----------------");
      Put_line(F_Temps, "-------------------------------------------");
      Put_line(F_Temps, Duration'Image((Ada.Calendar.Clock - Start_Time)/60) & " minuts"); -- imprimir el temps que ha tardat (minuts)
      Put_line(F_Temps, Duration'Image(Ada.Calendar.Clock - Start_Time) & " segons"); -- imprimir el temps que ha tardat (segons)
      Put_line(F_Temps, Duration'Image((Ada.Calendar.Clock - Start_Time)*1000) & " mil·lèsimes"); -- imprimir el temps que ha tardat (mil·lèsimes)

      close(origen);
   end mainActionHs;



begin

   create_mapping(map);

   nom_fichero_dicc:="diccionari.dic";
   num_paraules := paraulesDiccionari(nom_fichero_dicc);
   put_line("Hay " & num_paraules'Img & " palabras en el diccionario.");
   --CURSORS
   mainActionSimple(num_paraules);
   --TRIE SIMPLE
   mainActionTrie;
   --TRIE COMPACTE
   mainActionTrieCompacte;
   --HASHING
   mainActionHs(5000);




end Main;
