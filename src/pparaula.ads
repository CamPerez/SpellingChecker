with Ada.Text_IO, Ada.Wide_Wide_Characters.Handling;
use Ada.Text_IO, Ada.Wide_Wide_Characters.Handling;

-- Package que defineix el tipus tparaula i les operacions
-- que es poden realitzar amb ell.
--
-- Aquest package tamb� defineix el tipus OrigenParaula per poder
-- fer tractaments des de fitxer i teclat independentment.
package pparaula is
   ---------------------------------------------------------
   -- Definicions p�bliques relacionades amb les paraules --
   ---------------------------------------------------------

   -- Nombre m�xim de lletres que poden formar una paraula
   MAXIM : constant integer:= 30;
   -- Rang de llarg�ries que pot tenir una paraula donada
   subtype tllargaria is  integer range 0..MAXIM;
   subtype rang_lletres is tllargaria range 1..tllargaria'LAST;

   -- Definici� del tipus tparaula.
   type tparaula is private;

   -- Procediment per escriure a la pantalla
   procedure put(p : in tparaula);
   -- Procediment per escriure a un fitxer de text
   procedure put(f : in out File_Type; p : in tparaula);
   -- Funci� per comparar dues paraules i determinar si s�n iguals
   function "=" (a, b : in tparaula) return boolean;
   -- Funci� per saber la llarg�ria d'una paraula. �s a dir, el nombre
   -- de lletres que formen la paraula
   function llargaria(p : in tparaula) return tllargaria;
   -- Funci� que indica si la paraula est� buida
   function buida(p : in tparaula) return boolean;
   -- Funci� que torna la lletra que es troba a una posici� determinada
   -- d'una paraula.
   function caracter(p : in tparaula; posicio : in rang_lletres) return character;

   function toString(p: in tparaula) return  String;

   ---------------------------------------------------------------------
   -- Definicions p�bliques relacionades amb l'origen de les paraules --
   ---------------------------------------------------------------------

   -- Procediment que copia una paraula. �s un procediment �til per
   -- utilitzar aquest package PParaules i gen�rics.
   procedure copiar(desti : out tparaula; origen : in tparaula);

   type OrigenParaules is limited private;

   -- Procediment per tractar amb les paraules llegides del teclat
   procedure open(origen : out OrigenParaules);
   -- Procediment per tractar amb les paraules llegides del fitxer nom
   procedure open(origen : out OrigenParaules; nom : in String);
   -- Procediment per tancar l'origen de les paraules
   procedure close(origen : in out OrigenParaules);
   -- Procediment per llegir una paraula des d'un origen de paraules
   procedure get(origen : in out OrigenParaules; p: out tparaula; fila: in out integer; columna: in out integer);



private
   --------------------------------------------------------------
   -- Declaracions privades relacionades amb el tipus tparaula --
   --------------------------------------------------------------

   -- Declaracions per declara l'array de lletres que formaran la paraula
   type taula_lletres is array (rang_lletres) of character;

   -- Declaraci� privada del tipus tparaula.
   type tparaula is record
      lletres : taula_lletres;
      llargaria : tllargaria;
   end record;


   ---------------------------------------------------------------------
   -- Definicions p�bliques relacionades amb l'origen de les paraules --
   ---------------------------------------------------------------------
   type OrigenParaules is record
      defitxer : boolean; -- si el camp �s true es llegeix de fitxer
                          -- si �s false es llegeix del teclat
      fitxer : file_type; -- Si s'ha de llegir del fitxer es fa �s del camp
      lletra : character; -- darrer car�cter llegit
   end record;

end pparaula;
