# P170B115 Skaitiniai metodai ir algoritmai (6 kr.)
### II projektinė užduotis
### 11 variantas

Bendrieji reikalavimai namų darbams Ataskaitos keliamos į Moodle iki gynimo dienos. Ataskaitoje pateikiama užduotis, rezultatai, programų kodai.

Visais atvejais atsiskaitymo metu galima naudotis namų užduotyje ir laboratorinių darbų metu nagrinėtomis programomis.

Gynimo metu studentas privalo paaiškinti bet kurią programos išeities teksto eilutę; jeigu to padaryti nesugeba, darbas vertinamas 0.

## I užduotis. Interpoliavimas daugianariu.
1 lentelėje duota interpoliuojamos funkcijos analitinė išraiška. Pateikite interpoliacinės funkcijos išraišką, kai:  a. Taškai pasiskirstę tolygiai. b. Taškai apskaičiuojami naudojant Čiobyševo abscises.  Interpoliavimo taškų skaičių parinkite laisvai, bet jis turėtų neviršyti 30. Pateikite du grafikus, kai interpoliacinės funkcijos apskaičiuojamos naudojant skirtingas abscises. Tame pačiame grafike vaizduokite duotąją funkciją, interpoliacinę funkciją ir netiktį.

### Interpoliuojamos funkcijos išraiška:
cos(2 * x) * (sin(2 * x) + 1.5) + cos(x); -2 <= x <= 3; Vienanarių

## II užduotis. Parametrinis interpoliavimas. 
Naudodami 2 lentelėje nurodytą parametrinio interpoliavimo metodą parinkite interpoliavimo taškus taip, kad interpoliuojančios kreivės suformuotų 3 lentelėje pavaizduotos figūros išorinį kontūrą. Kontūro interpoliavimui galima naudoti daugiau nei vieną kreivę. Lyginiams variantams figūros numeris sutampa su varianto numeriu, nelyginiams figūros numeris apskaičiuojamas pagal formulę 31-(varianto numeris). Suderinus su dėstytoju galima naudoti ir savo pasirinktą figūrą.

### Parametrinio interpoliavimo metodas:
Pirmos eilės defekto splainas (globalus)

## III užduotis. Aproksimavimas - Haro bangelės (lyginiams variantų numeriams) arba diskrečioji Furje aproksimacija (nelyginiams variantų numeriams)
Haro bangelės. Aproksimacijos taškai parenkami iš paveikslėlio (suformuojamos 3 lentelėje pateiktos figūros viršutinį kontūrą aprašančios X ir Y reikšmės). Reikia atlikti duotų taškų aproksimaciją naudojant Haro bangeles. Suskaičiuokite bangelių koeficientus ir aproksimuotos funkcijos reikšmes. Aproksimacijos rezultatus pateikite grafiškai. Įvertinkite, kaip kinta atkuriamo vaizdo tikslumas, jeigu vaizdas atkuriamas iki skirtingų detalumo lygių (tarkime, koeficientai skaičiuojami iki 10 detalumo lygių, o vaizdas atkuriamas iki 5 arba 7 lygio). Diskrečioji Furje aproksimacija.  4 lentelėje duota analitinė periodinės funkcijos F(t) = G(t) + R(t) išraiška, kur G(t) –signalas, R(t) – triukšmas. Reikia atlikti funkcijos F(t) aproksimavimą diskrečiąja Furje transformacija ir išskirti G(t) dviem būdais:  atmetant harmonines dedamąsias pagal amplitudės slenkstį;  atmetant harmonines dedamąsias pagal dažnio slenkstį.  Ataskaitoje pateikite 1) funkcijų F(t), G(t) ir R(t) grafikus; 2) funkcijos F(t) Furje aproksimacijos harmonikų amplitudes. 3) aproksimuotų funkcijų panaudojant amplitudės slenkstį ir dažnių slenkstį grafikus su paskaičiuota netiktimi. Netiktis skaičiuojama lyginant aproksimuojančią funkciją su G(t) funkcija.

### Paveikslėliai Haro bangelių aproksimacijai
WTF???( tai gal nereikia)

## IV užduotis. Paprastųjų diferencialinių lygčių ir jų sistemų sprendimas.
1. Faile PDL_uzdaviniai pateikti uždaviniai paprastųjų diferencialinių lygčių sistemų sprendimui. Remdamiesi tame pačiame faile pateiktų fizikinių dėsnių aprašymais, nurodytam variantui sudarykite diferencialinę lygtį arba lygčių sistemą. Lygties ar lygčių sistemos sudarymą paaiškinkite ataskaitoje ir išspręskite pasirinktu skaitiniu metodu. Atsakykite į uždavinyje pateiktus klausimus. 
2. Keisdami metodo žingsnį įsitikinkite, kad gavote tikslų sprendinį. Sprendinius, gautus naudojant skirtingus žingsnius, pavaizduokite grafike.
3. Keisdami metodo žingsnį nustatykite didžiausią žingsnį, su kuriuo metodas išlieka stabilus. Sprendinius, gautus naudojant skirtingus žingsnius, pavaizduokite grafike.
4. Patikrinkite gautą sprendinį su MATLAB standartine funkcija ode45 ar kitais išoriniais šaltiniais. 

### Funkcijos diskrečiajai Furjė transformacijai

G(t) = sign((2 * PI) * (t / T)) * cos((2 * PI) * ((3 * t) / T)) + 0.1
R(t) = 0.05 * cos((2 * PI) * ((130 * t) / T)) + 0.018 * cos((2 * PI) * ((40 * t) / T)) 
