with Ada.Text_IO, Ada.Sequential_IO, diccionari_tr;
use Ada.Text_IO, diccionari_tr;

package body pparaula is

   -- Procediment per escriure a la pantalla
   procedure put(p : in tparaula) is
   begin
      put_line(toString(p));
   end put;


   -- Procediment per escriure a un fitxer de text
   procedure put (f : in out File_Type; p : in tparaula) is
      begin
         Create(f, Out_File, "fichero_salida.txt");
         for x in 1..p.llargaria loop
            Put(f, p.lletres(x)); -- Fica dins el fitxer cada lletra de la paraula
         end loop;
   end put;

   -- Funci� per comparar dues paraules i determinar si s�n iguals
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


   -- Funci� per saber la llarg�ria d'una paraula. �s a dir, el nombre
   -- de lletres que formen la paraula
   function llargaria(p : in tparaula) return tllargaria is
   begin
      return p.llargaria;
   end llargaria;

   -- Funci� que indica si la paraula est� buida
   function buida(p : in tparaula) return boolean is
   begin
      return p.llargaria = 0;
   end buida;

   -- Funci� que torna la lletra que es troba a una posici� determinada
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


   -- Procediment que copia una paraula. �s un procediment �til per
   -- utilitzar aquest package PParaules i gen�rics.
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
      origen.lletra:= Character'Val(0);
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
   procedure get(origen : in out OrigenParaules; p: out tparaula; fila: out integer; columna: out integer; map: in mapping) is -- siguiente: para indicar si la siguiente palabra es una nueva linea
      letra: character;
      idx, idx_linea: integer;
      lineaTeclado: String(rang_lletres);
      num_car: natural;
   begin
      if End_Of_File(origen.fitxer) then
         idx:=0;
         p.llargaria:=idx;
      else

         fila:=origen.f;
         columna:=origen.c;
         if origen.defitxer = true then -- Si la lectura es fa des d'un fitxer
            if origen.lletra = Character'Val(0) then
               --Si no hay caracter predecesor es que es el principio de una linea
               idx:=0;
            else
               idx:=1;
               p.lletres(idx):= origen.lletra;
               --Recuperamos la letra de la anterior iteraci�n
               --la cual ser� la primera letra de nuestra palabra
            end if;


            Get(origen.fitxer,letra);
            origen.c:= origen.c + 1;

            while not End_Of_File(origen.fitxer) and get_key(letra, map)/= -1 loop -- Mentre no arribi al final del fitxer i no sigui final de paraula
               if End_Of_Line(origen.fitxer) then
                  origen.f:=origen.f+1;
                  --origen.f:=fila; --volvemos a introducir el valor en el record
                  origen.c:=1;
                  origen.c:=origen.c; --volvemos a introducir el valor en el record
                  idx:= idx+1;
                  p.lletres(idx):= letra;
                  exit;
               end if;

               idx:= idx+1;
               p.lletres(idx):= letra;

               Get(origen.fitxer,letra);
               origen.c:= origen.c + 1;

            end loop;

            if End_Of_Line(origen.fitxer) and get_key(letra, map) = -1 then --Si es un caracter desconocido y adema� es salto de linea
               origen.f:=origen.f+1;
               --origen.f:=fila; --volvemos a introducir el valor en el record
               origen.c:=1;
               --origen.c:=columna; --volvemos a introducir el valor en el record
            end if;

            if get_key(letra, map)=-1 then
               --Botar blancs
               while get_key(letra, map)=-1 and not End_Of_File(origen.fitxer) loop
                  Get(origen.fitxer,letra);
                  origen.c:= origen.c + 1;
               end loop;
            end if;

            --Si es final de fichero y no hay blancos guardamos la letra
            if End_Of_File(origen.fitxer) and get_key(letra, map)/=-1 then
               idx:= idx+1;
               p.lletres(idx):= letra;
            end if;

            --Miramos si es final de linea para saber si hemos de eliminar la letra anterior
            if End_Of_Line(origen.fitxer) then
               origen.lletra := Character'Val(0);
            else
               origen.lletra:= letra;
            end if;

            p.llargaria:=idx;
            --origen.c:=columna; --volvemos a introducir el valor en el record

         else -- Si la lectura es fa des de teclat
            put_line("Escriu la paraula:");
            Ada.Text_IO.Get_Line(lineaTeclado,num_car);
            idx_linea:=0; idx:=1;
            letra:= lineaTeclado(lineaTeclado'First+idx_linea);

            while get_key(letra, map)=-1 and num_car /= idx_linea loop
               p.lletres(idx):= letra;
               idx:= idx+1;
               idx_linea:=idx_linea+1;
               letra:= lineaTeclado(lineaTeclado'First+idx_linea);
            end loop;
         end if;
      end if;
   end get;

   procedure reiniciarColumna(origen : in out OrigenParaules) is
   begin
      origen.c:=1;
   end reiniciarColumna;

   procedure reiniciarFila(origen : in out OrigenParaules) is
   begin
      origen.f:=1;
   end reiniciarFila;

   procedure create_mapping(map: in out mapping) is
      j: natural;
   begin

      map:= (others => -1);

      j:= 0;
      for i in character range 'a' .. 'z' loop
         map(i):= j;
         j:= j+1;
      end loop;

      for i in character range 'A' .. 'Z' loop
         map(i):= j;
         j:= j+1;
      end loop;

      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; j:=j+1;
      map('�'):=j; --j:=j+1;
    --  map('�'):=j; j:=j+1;
     -- map('?'):=j; j:=j+1;
     -- map('!'):=j; j:=j+1;
     -- map('�'):=j; j:=j+1;
    --  map('"'):=j; j:=j+1;
     -- map('.'):=j; j:=j+1;
     -- map(','):=j; j:=j+1;
    --  map(';'):=j;

   end create_mapping;

   function get_key(c: in character; map: in mapping) return integer is
      pos: integer;
   begin
      pos:= map(c);
      return pos;
   end get_key;


end pparaula;
