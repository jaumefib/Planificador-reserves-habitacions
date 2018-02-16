# Planificador de reserves d'habitacions

El programa organitza les reserves que pot tenir un hotel/hostal/pensió durant un mes.



Per executar el programa per generar el fitxer del problema se l'hi ha de donar privilegis d'execució amb la comanda:
    
   $ chmod +x generadorHotel.py

i després executar-lo amb la comanda:

   $ ./generadorHotel.py



La carpeta Metric-FF conté el Metric Fast Forward. Per poder executar el metric-ff has de estar en el directori Metric-FF i executar la comanda següent:

   $ ./ff -o pathDomini/domini.pddl -f pathProblema/problema.pddl

A on :

    pathDomini: és el camí per arribar a on es troba el fitxer del domini
    domini.pddl: és el fitxer que conté el domini de l'exercici
    pathProblema: és el camí per arribar a on es troba el fitxer del problema
    problema.pddl: és el fitxer que conté les inicialitzacions i objectius de l'exercici
