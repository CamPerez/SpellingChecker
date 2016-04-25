with Ada.Text_IO, Ada.Sequential_IO;
use Ada.Text_IO;

package body pparaula is

   -- Procediment per escriure a la pantalla
   procedure put(p : in tparaula) is
   begin
      for i in Integer range 1..p.llargaria loop
         --Put(p.lletres'Image(i));
         null;
      end loop;
   end put;


   -- Procediment per escriure a un fitxer de text
   procedure put (f : in out File_Type; p : in tparaula) is
      begin
         Create(f, Out_File, "fichero_salida.txt");

         for x in 1..p.llargaria loop
            Put(f, p.lletres(x)); -- Fica dins el fitxer cada lletra de la paraula
         end loop;
   end put;

   -- Funció per comparar dues paraules i determinar si són iguals
   function "=" (a, b : in tparaula) return boolean is
   begin
      if a.llargaria = b.llargaria then
         for x in 1..a.llargaria loop
            if a.lletres(x) /= b.lletres(x) then
               return false;
            end if;
         end loop;
      else
         return false;
      end if;
      return true;
   end "=";


   -- Funció per saber la llargària d'una paraula. és a dir, el nombre
   -- de lletres que formen la paraula
   function llargaria(p : in tparaula) return tllargaria is
   begin
      return p.llargaria;
   end llargaria;

   -- Funció que indica si la paraula està buida
   function buida(p : in tparaula) return boolean is
   begin
      return p.llargaria = 0;
   end buida;

   -- Funció que torna la lletra que es troba a una posició determinada
   -- d'una paraula.
   function caracter(p : in tparaula; posicio : in rang_lletres) return character is
   begin
      return p.lletres(posicio);
   end caracter;

   function toString(p: in tparaula) return String is
      paraula: String(1..p.llargaria);
   begin

      for x in 1..p.llargaria loop
         paraula(x) := p.lletres(x);
      end loop;

      return paraula;

   end toString;


   -- Procediment que copia una paraula. és un procediment útil per
   -- utilitzar aquest package PParaules i genérics.
   procedure copiar(desti : out tparaula; origen : in tparaula) is
   begin
      desti:=origen;
   end copiar;

   -- Procediment per tractar amb les paraules llegides del teclat
   procedure open(origen : out OrigenParaules) is
   begin
      origen.defitxer:= false;
      origen.lletra:= ' ';
   end open;

   procedure open(origen : out OrigenParaules; nom : in String) is
   begin
      Open(origen.fitxer,In_File,nom);
      origen.defitxer:= true;
      origen.lletra:= ' ';
   exception
      when Name_Error =>
         put_line("El fichero no se encuentra.");
      when Use_Error =>
         put_line("Fallo de uso");
   end open;

   -- Procediment per tancar l'origen de les paraules
   procedure close(origen : in out OrigenParaules) is
   begin
      Close(origen.fitxer);
   end close;

   -- Procediment per llegir una paraula des d'un origen de paraules
   procedure get(origen : in out OrigenParaules; p: out tparaula; fila: out integer; columna: out integer) is -- siguiente: para indicar si la siguiente palabra es una nueva linea
      letra: character;
      idx, idx_linea: integer;
      lineaTeclado: String(rang_lletres);
      num_car: natural;
   begin
      fila:=origen.f;
      columna:=origen.c;
      --put_line("columnaaaa" & columna'Img);
      if origen.defitxer = true then -- Si la lectura es fa des d'un fitxer
         idx:=0;
         while not End_Of_File(origen.fitxer) loop -- Mentre no arribi al final del fitxer i no sigui final de paraula
            Get(origen.fitxer,letra);
            --if siguiente=true then
            --columna:= 0; --Reiniciamos columna a 0 si la siguiente era la ultima de su linea
            --fila:= fila + 1; --Aumentamos en una la linea si la siguiente era el final de linea
            --   siguiente:=false;
            --end if;

            if End_Of_Line(origen.fitxer) then
               fila:=fila+1;
               origen.f:=fila; --volvemos a introducir el valor en el record
               columna:=0;
               origen.c:=columna; --volvemos a introducir el valor en el record
               -- siguiente:=true;
            end if;
            if letra = ' ' then
               columna:= columna + 1;
               origen.c:=columna; --volvemos a introducir el valor en el record
            end if;
            exit when letra = ' ';
            idx:= idx+1;
            columna:= columna + 1;
            p.lletres(idx):= letra;
            exit when End_Of_Line(origen.fitxer);
         end loop;
         p.llargaria:=idx;
         origen.c:=columna; --volvemos a introducir el valor en el record
      else -- Si la lectura es fa des de teclat
         put_line("Escriu la paraula:");
         Ada.Text_IO.Get_Line(lineaTeclado,num_car);
         idx_linea:=0; idx:=1;
         letra:= lineaTeclado(lineaTeclado'First+idx_linea);

         while letra /=' ' and num_car /= idx_linea loop
            p.lletres(idx):= letra;
            idx:= idx+1;
            idx_linea:=idx_linea+1;
            letra:= lineaTeclado(lineaTeclado'First+idx_linea);
         end loop;
      end if;

   end get;

   procedure reiniciarColumna(origen : in out OrigenParaules) is
   begin
      origen.c:=1;
   end reiniciarColumna;

end pparaula;
