//log using "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\merge_waves_1_26.smcl", replace

************************************
***********MERGE MASIVO*************
************************************

**#Olas 1 a la 2
 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave1_clean.dta",  clear
gen ola_entrada = 1
merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave2_clean.dta"
//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 

replace ola_entrada = 2 if _merge == 2

drop _merge

save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 

**#Ola 3 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave3_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 

replace ola_entrada = 3 if _merge == 2

drop _merge

save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 

**#Ola 4 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave4_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 

replace ola_entrada = 4 if _merge == 2

drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 

**#Ola 5 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave5_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 5 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 

**#Ola 6 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave6_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 6 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 

**#Ola 7 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave7_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 7 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 

**#Ola 8 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave8_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 8 if _merge == 2

drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 

**#Ola 9 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave9_clean.dta"

//Atrición
count if _merge == 1 
count if _merge == 2 
count if _merge == 3 
replace ola_entrada = 9 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 

**#Ola 10
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave10_clean.dta"

count if _merge == 1 
count if _merge == 2 
count if _merge == 3 
replace ola_entrada = 10 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 

**#Ola 11 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave11_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 11 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 


**#Ola 12 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave12_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 12 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 


**#Ola 13 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave13_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 13 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 


**#Ola 14 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave14_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 14 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 


**#Ola 15 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave15_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 15 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 


**#Ola 16 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave16_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 16 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 


**#Ola 17 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave17_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 17 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 


**#Ola 18 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave18_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 18 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 


**#Ola 19 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave19_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 19 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 

**#Ola 20 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave20_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 20 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 


**#Ola 21 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave21_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 21 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 


**#Ola 22 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave22_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 22 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 


**#Ola 23 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave23_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 23 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 


**#Ola 24 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave24_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 24 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 


**#Ola 25 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave25_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 25 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 


**#Ola 26 
use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta",  clear

merge 1:1 pid using  "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\wave26_clean.dta"

//Atrición
count if _merge == 1 
// Muestra nueva
count if _merge == 2 
// Permanencia
count if _merge == 3 
replace ola_entrada = 26 if _merge == 2
drop _merge
save "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\DOCUMENTACION\hazards\general\master1_26.dta", replace 

//log close 
