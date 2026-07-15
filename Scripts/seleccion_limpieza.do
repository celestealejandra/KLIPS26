******************************************************
*** 04 ETIQUETADO DE BASE MAESTRA *****************
******************************************************

use "path\general\master1_26.dta", clear
// tamaño de muestra original 
//37,039

*****************************************
*** OLA DE ENTRADA VS HWAVEENT **********
*****************************************
tab ola_entrada
tab hwaveent 
tab ola_entrada hwaveent 
//
//ola_entrada |      Freq.     Percent        Cum.
//------------+-----------------------------------
//          1 |     13,319       35.96       35.96
//          2 |        789        2.13       38.09
//          3 |        432        1.17       39.26
//          4 |        471        1.27       40.53
//          5 |        407        1.10       41.63
//          6 |        552        1.49       43.12
//          7 |        443        1.20       44.31
//          8 |        385        1.04       45.35
//          9 |        394        1.06       46.42
//         10 |        396        1.07       47.49
//         11 |        390        1.05       48.54
//         12 |      3,112        8.40       56.94
//         13 |        512        1.38       58.32
//         14 |        453        1.22       59.55
//         15 |        412        1.11       60.66
//         16 |        342        0.92       61.58
//         17 |        115        0.31       61.89
//         18 |        513        1.39       63.28
//         19 |        367        0.99       64.27
//         20 |        340        0.92       65.19
//         21 |      9,868       26.64       91.83
//         22 |        728        1.97       93.79
//         23 |        466        1.26       95.05
//         24 |        607        1.64       96.69
//         25 |        700        1.89       98.58
//         26 |        526        1.42      100.00
//------------+-----------------------------------
//      Total |     37,039      100.00



******************************************
******************SEXO********************
******************************************

egen sexo = rowmax( ///
sex_01 ///
sex_02 ///
sex_03 ///
sex_04 ///
sex_05 ///
sex_06 ///
sex_07 ///
sex_08 ///
sex_09 ///
sex_10 ///
sex_11 ///
sex_12 ///
sex_13 ///
sex_14 ///
sex_15 ///
sex_16 ///
sex_17 ///
sex_18 ///
sex_19 ///
sex_20 ///
sex_21 ///
sex_22 ///
sex_23 ///
sex_24 ///
sex_25 ///
sex_26 )
label variable sexo "Sexo"

label define sexo ///
1 "Hombre" ///
2 "Mujer" 
label values sexo sexo 


///       Sexo |      Freq.     Percent        Cum.
///------------+-----------------------------------
///     Hombre |     18,108       48.89       48.89
///      Mujer |     18,931       51.11      100.00
///------------+-----------------------------------
///      Total |     37,039      100.00
///


//


 
*********************************************
****** FECHA DE NACIMIENTO ******************
*********************************************
egen y_birth = rowmax( ///
b_cohort_01 ///
b_cohort_02 ///
b_cohort_03 ///
b_cohort_04 ///
b_cohort_05 ///
b_cohort_06 ///
b_cohort_07 ///
b_cohort_08 ///
b_cohort_09 ///
b_cohort_10 ///
b_cohort_11 ///
b_cohort_12 ///
b_cohort_13 ///
b_cohort_14 ///
b_cohort_15 ///
b_cohort_16 ///
b_cohort_17 ///
b_cohort_18 ///
b_cohort_19 ///
b_cohort_20 ///
b_cohort_21 ///
b_cohort_22 ///
b_cohort_23 ///
b_cohort_24 ///
b_cohort_25 ///
b_cohort_26 )


egen m_birth = rowmax( ///
birth_month_01 ///
birth_month_02 ///
birth_month_03 ///
birth_month_04 ///
birth_month_05 ///
birth_month_06 ///
birth_month_07 ///
birth_month_08 ///
birth_month_09 ///
birth_month_10 ///
birth_month_11 ///
birth_month_12 ///
birth_month_13 ///
birth_month_14 ///
birth_month_15 ///
birth_month_16 ///
birth_month_17 ///
birth_month_18 ///
birth_month_19 ///
birth_month_20 ///
birth_month_21 ///
birth_month_22 ///
birth_month_23 ///
birth_month_24 ///
birth_month_25 ///
birth_month_26 )


gen ym_bday = ym(y_birth, m_birth)
replace ym_bday = .i if missing(ym_bday)
/// 54 missing values por falta de mes de nacimiento 


count if y_birth == .i
// todos tienen año 
replace m_birth = .i if m_birth == .
count if m_birth == .i
// 54 no tienen mes 

******************************************
**********TIEMPO AL MATRIMONIO************
******************************************
 
// unión = si es casado, separado, divorciado o viudo
egen union = rowmax( ///
unido_01 ///
unido_02 ///
unido_03 ///
unido_04 ///
unido_05 ///
unido_06 ///
unido_07 ///
unido_08 ///
unido_09 ///
unido_10 ///
unido_11 ///
unido_12 ///
unido_13 ///
unido_14 ///
unido_15 ///
unido_16 ///
unido_17 ///
unido_18 ///
unido_19 ///
unido_20 ///
unido_21 ///
unido_22 ///
unido_23 ///
unido_24 ///
unido_25 ///
unido_26 )


label variable union "Alguna vez unido"
label define union ///
1 "Alguna Vez Unido" ///
0 "Nunca Unido"
label values union union

// tengo 10,087 nunca unidos 
// 26,952 unidos 



//máximo valor en las variables por ola 
egen primer_matrimonio = rowmax( ///
primer_matrimonio_01 ///
primer_matrimonio_02 ///
primer_matrimonio_03 ///
primer_matrimonio_04 ///
primer_matrimonio_05 ///
primer_matrimonio_06 ///
primer_matrimonio_07 ///
primer_matrimonio_08 ///
primer_matrimonio_09 ///
primer_matrimonio_10 ///
primer_matrimonio_11 ///
primer_matrimonio_12 ///
primer_matrimonio_13 ///
primer_matrimonio_14 ///
primer_matrimonio_15 ///
primer_matrimonio_16 ///
primer_matrimonio_17 ///
primer_matrimonio_18 ///
primer_matrimonio_19 ///
primer_matrimonio_20 ///
primer_matrimonio_21 ///
primer_matrimonio_22 ///
primer_matrimonio_23 ///
primer_matrimonio_24 ///
primer_matrimonio_25 ///
primer_matrimonio_26 )

label variable primer_matrimonio "Ocurrencia histórica de primer matrimonio"
label define primer_matrimonio ///
1 "Ya le ocurrió el primer matrimonio" ///
0 "No le ha ocurrido el primer matrimonio"
label values primer_matrimonio primer_matrimonio



tab primer_matrimonio union, mi



replace primer_matrimonio = .i if union == 1 & primer_matrimonio == 0
replace primer_matrimonio = .i if union == 1 & primer_matrimonio == .
tab union primer_matrimonio, mi


***********************************
**Tiempo de ocurrencia del evento**
***********************************
///Año
gen y_marriage = . 
replace y_marriage = y_change_01 if primer_matrimonio_01 == 1 & missing(y_marriage)
replace y_marriage = y_change_02 if primer_matrimonio_02 == 1 & missing(y_marriage)
replace y_marriage = y_change_03 if primer_matrimonio_03 == 1 & missing(y_marriage)
replace y_marriage = y_change_04 if primer_matrimonio_04 == 1 & missing(y_marriage)
replace y_marriage = y_change_05 if primer_matrimonio_05 == 1 & missing(y_marriage)
replace y_marriage = y_change_06 if primer_matrimonio_06 == 1 & missing(y_marriage)
replace y_marriage = y_change_07 if primer_matrimonio_07 == 1 & missing(y_marriage)
replace y_marriage = y_change_08 if primer_matrimonio_08 == 1 & missing(y_marriage)
replace y_marriage = y_change_09 if primer_matrimonio_09 == 1 & missing(y_marriage)
replace y_marriage = y_change_10 if primer_matrimonio_10 == 1 & missing(y_marriage)
replace y_marriage = y_change_11 if primer_matrimonio_11 == 1 & missing(y_marriage)
replace y_marriage = y_change_12 if primer_matrimonio_12 == 1 & missing(y_marriage)
replace y_marriage = y_change_13 if primer_matrimonio_13 == 1 & missing(y_marriage)
replace y_marriage = y_change_14 if primer_matrimonio_14 == 1 & missing(y_marriage)
replace y_marriage = y_change_15 if primer_matrimonio_15 == 1 & missing(y_marriage)
replace y_marriage = y_change_16 if primer_matrimonio_16 == 1 & missing(y_marriage)
replace y_marriage = y_change_17 if primer_matrimonio_17 == 1 & missing(y_marriage)
replace y_marriage = y_change_18 if primer_matrimonio_18 == 1 & missing(y_marriage)
replace y_marriage = y_change_19 if primer_matrimonio_19 == 1 & missing(y_marriage)
replace y_marriage = y_change_20 if primer_matrimonio_20 == 1 & missing(y_marriage)
replace y_marriage = y_change_21 if primer_matrimonio_21 == 1 & missing(y_marriage)
replace y_marriage = y_change_22 if primer_matrimonio_22 == 1 & missing(y_marriage)
replace y_marriage = y_change_23 if primer_matrimonio_23 == 1 & missing(y_marriage)
replace y_marriage = y_change_24 if primer_matrimonio_24 == 1 & missing(y_marriage)
replace y_marriage = y_change_25 if primer_matrimonio_25 == 1 & missing(y_marriage)
replace y_marriage = y_change_26 if primer_matrimonio_26 == 1 & missing(y_marriage)

replace y_marriage = .i if primer_matrimonio == 1 & y_marriage == . 
replace y_marriage = .i if primer_matrimonio == .i 

// 83 missings casos inválidos 
// 578 missings en año de ocurrencia pero primer_matrimonio == 1 

// 1.7%

///Mes 
gen m_marriage = . 
replace m_marriage = m_change_01 if primer_matrimonio_01 == 1 & missing(m_marriage)
replace m_marriage = m_change_02 if primer_matrimonio_02 == 1 & missing(m_marriage)
replace m_marriage = m_change_03 if primer_matrimonio_03 == 1 & missing(m_marriage)
replace m_marriage = m_change_04 if primer_matrimonio_04 == 1 & missing(m_marriage)
replace m_marriage = m_change_05 if primer_matrimonio_05 == 1 & missing(m_marriage)
replace m_marriage = m_change_06 if primer_matrimonio_06 == 1 & missing(m_marriage)
replace m_marriage = m_change_07 if primer_matrimonio_07 == 1 & missing(m_marriage)
replace m_marriage = m_change_08 if primer_matrimonio_08 == 1 & missing(m_marriage)
replace m_marriage = m_change_09 if primer_matrimonio_09 == 1 & missing(m_marriage)
replace m_marriage = m_change_10 if primer_matrimonio_10 == 1 & missing(m_marriage)
replace m_marriage = m_change_11 if primer_matrimonio_11 == 1 & missing(m_marriage)
replace m_marriage = m_change_12 if primer_matrimonio_12 == 1 & missing(m_marriage)
replace m_marriage = m_change_13 if primer_matrimonio_13 == 1 & missing(m_marriage)
replace m_marriage = m_change_14 if primer_matrimonio_14 == 1 & missing(m_marriage)
replace m_marriage = m_change_15 if primer_matrimonio_15 == 1 & missing(m_marriage)
replace m_marriage = m_change_16 if primer_matrimonio_16 == 1 & missing(m_marriage)
replace m_marriage = m_change_17 if primer_matrimonio_17 == 1 & missing(m_marriage)
replace m_marriage = m_change_18 if primer_matrimonio_18 == 1 & missing(m_marriage)
replace m_marriage = m_change_19 if primer_matrimonio_19 == 1 & missing(m_marriage)
replace m_marriage = m_change_20 if primer_matrimonio_20 == 1 & missing(m_marriage)
replace m_marriage = m_change_21 if primer_matrimonio_21 == 1 & missing(m_marriage)
replace m_marriage = m_change_22 if primer_matrimonio_22 == 1 & missing(m_marriage)
replace m_marriage = m_change_23 if primer_matrimonio_23 == 1 & missing(m_marriage)
replace m_marriage = m_change_24 if primer_matrimonio_24 == 1 & missing(m_marriage)
replace m_marriage = m_change_25 if primer_matrimonio_25 == 1 & missing(m_marriage)
replace m_marriage = m_change_26 if primer_matrimonio_26 == 1 & missing(m_marriage)

replace m_marriage = .i if primer_matrimonio == 1 & m_marriage == . 

replace m_marriage = .i if y_marriage == .i & m_marriage == 12 
// tengo una persona que declaró mes pero no declaro año 

tab y_marriage m_marriage, mi
//// Tengo 495 que tienen .i en ambas
count if !missing(y_marriage) & missing(m_marriage)
//898 estimaciones gruesas 



tab y_marriage m_marriage if !missing(y_marriage), mi
/// 26374 eventos  con año 
 
///Discrepancia de 578 entre el primer_matrimonio y total de y_marriage y m_marriage, son los que tienen fecha inválida por omisión

tab y_marriage, mi
// total de perdidos es 578 


//////////////// aquí me quede

// RECAPITULACIÓN ----------------
// Muestra inicial  37, 039
// Ocurrencias año y mes   25,476 
// Ocurrencias solo año   898
// Ocurrencias pero missing en año y mes 495
// Missing en primer_matrimonio por historial conyugal incompleto 83
// No ocurrencias reales 10,087
//dis 25476 + 898 + 495 + 83 + 10087  = 37039
 
// Al final pierdo 578
// 1.5% de la muestra se va por inválido en variable explicativa


//____________________________________
//Aquellos a quienes tengo mes y año 
gen estimacionfina = 1 if !missing(y_marriage) & !missing(m_marriage) 
// le pongo missing válido a aquellos que nunca tuvieron el evento  
replace estimacionfina = .v if primer_matrimonio == 0 
//missings reales 
replace estimacionfina = .i if primer_matrimonio == 1 & missing(y_marriage) & missing(m_marriage)  
replace estimacionfina = .i if primer_matrimonio == 1 & missing(y_marriage) & !missing(m_marriage)  

//____________________________________
//Aquellos que tienen año pero no mes 
gen estimaciongruesa = 1 if !missing(y_marriage) & missing(m_marriage)
replace estimaciongruesa = .v if primer_matrimonio == 0 
replace estimaciongruesa = .i if primer_matrimonio == 1 & missing(y_marriage) & missing(m_marriage)  
replace estimaciongruesa = .i if primer_matrimonio == 1 & missing(y_marriage) & !missing(m_marriage)  
tab estimaciongruesa, mi

replace estimacionfina = 0 if estimaciongruesa == 1
replace estimaciongruesa = 0 if estimacionfina == 1

tab estimacionfina estimaciongruesa, mi


tab primer_matrimonio if !missing(y_marriage) & missing(m_marriage)
// 221 personas que dieron año de matrimonio pero no mes 

tab primer_matrimonio if missing(y_marriage) & missing(m_marriage)
// 228 son porque declararon que ocurrió el primer matrimonio pero no hay fecha válida

count if primer_matrimonio == 1 & estimacionfina == 1
// 12, 363 estimaciones finas 

// se crearon los 12,363 años de matrimonio con estimación fina 


tab estimacionfina estimaciongruesa, mi
// perfecto


*********************************************
******EDAD AL PRIMER MATRIMONIO**************
********************************************* 

gen tmarriage = .

replace estimaciongruesa =1 if primer_matrimonio == 1 & missing(m_birth) & !missing(y_birth)
replace estimacionfina = 0  if primer_matrimonio == 1 & missing(m_birth) & !missing(y_birth)


gen ym_marriage = .
replace ym_marriage = ym(y_marriage, m_marriage) if primer_matrimonio == 1 & estimacionfina == 1  

//ESTIMACIONES 
//25,446 ESTIMACION FINA
//930 ESTIMACION GRUESA
//83 PERDIDOS POR FALSO NEGATIVO 
// 10,087 NO OCURRENCIAS REALES 
//493 PERDIDOS POR FECHA INVÁLIDA 

replace tmarriage  = round((ym_marriage - ym_bday)/12) if primer_matrimonio==1 & estimacionfina == 1
replace tmarriage  = round((y_marriage - y_birth)) if primer_matrimonio==1 & estimaciongruesa == 1
replace tmarriage = .i if estimacionfina == .i & estimaciongruesa == .i

replace tmarriage = .i if primer_matrimonio == .i
replace tmarriage = .v if primer_matrimonio == 0

replace tmarriage = .i if tmarriage == . 



tab tmarriage, mi

replace tmarriage = .i if tmarriage < 14

// 90 missings más 


// al final tenía 578 + 90
// 668 missings 


/// ENTONCES
// FECHAS VÁLIDAS :  26,284
// FECHAS INVÁLIDAD 495 + 90 = 585
// Historial conyugal incompleto = 83
// No ocurrencia real =  10,087
dis 26284  + 585  + 83 + 10087
// 37039



egen edad = rowmax( ///
edad_01 ///
edad_02 ///
edad_03 ///
edad_04 ///
edad_05 ///
edad_06 ///
edad_07 ///
edad_08 ///
edad_09 ///
edad_10 ///
edad_11 ///
edad_12 ///
edad_13 ///
edad_14 ///
edad_15 ///
edad_16 ///
edad_17 ///
edad_18 ///
edad_19 ///
edad_20 ///
edad_21 ///
edad_22 ///
edad_23 ///
edad_24 ///
edad_25 ///
edad_26 )
gen tcensoring = . 
replace tcensoring = edad if primer_matrimonio == 0
// 10,087 no ocurrencias del evento 

replace tcensoring = .i if primer_matrimonio == .i

 
 
gen tobs = tcensoring if primer_matrimonio == 0 
replace tobs = tmarriage if primer_matrimonio == 1 


dis 668 / 37039 * 100
// 1.8 % de la muestra se pierde por información inválida en evento, fecha de nacimiento y/o historial conyugal 

*********************************************************
********************* Cohorte Decenal *******************
*********************************************************

recode y_birth ///
(min/1949 = 1 "1949 o antes") ///
(1950/1959 = 2 "1950-1959") ///
(1960/1969 = 3 "1960-1969") ///
(1970/1979 = 4 "1970-1979") ///
(1980/1989 = 5 "1980-1989") ///
(1990/max = 6 "1990 o después"), gen(cohorte_dec)

*********************************************************
********************* HERMANOS **************************
*********************************************************


egen female_sibs = rowmax( ///
female_sibs_06 ///
female_sibs_07 ///
female_sibs_08 ///
female_sibs_09 ///
female_sibs_10 ///
female_sibs_11 ///
female_sibs_12 ///
female_sibs_13 ///
female_sibs_14 ///
female_sibs_15 ///
female_sibs_16 ///
female_sibs_17 ///
female_sibs_18 ///
female_sibs_19 ///
female_sibs_20 ///
female_sibs_21 ///
female_sibs_22 ///
female_sibs_23 ///
female_sibs_24 ///
female_sibs_25 ///
female_sibs_26 )

egen male_sibs = rowmax( ///
male_sibs_06 ///
male_sibs_07 ///
male_sibs_08 ///
male_sibs_09 ///
male_sibs_10 ///
male_sibs_11 ///
male_sibs_12 ///
male_sibs_13 ///
male_sibs_14 ///
male_sibs_15 ///
male_sibs_16 ///
male_sibs_17 ///
male_sibs_18 ///
male_sibs_19 ///
male_sibs_20 ///
male_sibs_21 ///
male_sibs_22 ///
male_sibs_23 ///
male_sibs_24 ///
male_sibs_25 ///
male_sibs_26 )

egen siblings = rowmax( ///
siblings_06 ///
siblings_07 ///
siblings_08 ///
siblings_09 ///
siblings_10 ///
siblings_11 ///
siblings_12 ///
siblings_13 ///
siblings_14 ///
siblings_15 ///
siblings_16 ///
siblings_17 ///
siblings_18 ///
siblings_19 ///
siblings_20 ///
siblings_21 ///
siblings_22 ///
siblings_23 ///
siblings_24 ///
siblings_25 ///
siblings_26 )


egen seniority = rowmax( ///
seniority_06 ///
seniority_07 ///
seniority_08 ///
seniority_09 ///
seniority_10 ///
seniority_11 ///
seniority_12 ///
seniority_13 ///
seniority_14 ///
seniority_15 ///
seniority_16 ///
seniority_17 ///
seniority_18 ///
seniority_19 ///
seniority_20 ///
seniority_21 ///
seniority_22 ///
seniority_23 ///
seniority_24 ///
seniority_25 ///
seniority_26 )

replace seniority = .i if seniority == 0 


clonevar birth_order = seniority

recode birth_order ///
(1 = 1 ) ///
(2 = 2) ///
(3/20 = 3)

label variable birth_order "Orden de Nacimiento (tres categorias)"
label define birth_order ///
1 "Primogénito" ///
2 "Segundo hijo" ///
3 "Tercer hijo en adelante"
label values birth_order birth_order 


gen primo = 0 
replace primo = 1 if seniority == 1 
 

clonevar sibsize = siblings

recode sibsize ///
(0/2 = 1 ) ///
(3 = 2) ///
(4/20 = 3) 

label variable sibsize "Número de hermanos (Topado a 3)"
label define sibsize ///
1 "Dos hermanos o menos" ///
2 "Tres Hermanos" ///
3 "Cuatro Hermanos o más "
label values sibsize sibsize 

**********************************************
************* EDUCACION DEL PADRE ************
**********************************************
egen fathers_edu = rowmax( ///
fathers_edu_01 ///
fathers_edu_02 ///
fathers_edu_03 ///
fathers_edu_04 ///
fathers_edu_05 ///
fathers_edu_06 ///
fathers_edu_06 ///
fathers_edu_07 ///
fathers_edu_08 ///
fathers_edu_09 ///
fathers_edu_10 ///
fathers_edu_11 ///
fathers_edu_12 ///
fathers_edu_13 ///
fathers_edu_14 ///
fathers_edu_15 ///
fathers_edu_16 ///
fathers_edu_17 ///
fathers_edu_18 ///
fathers_edu_19 ///
fathers_edu_20 ///
fathers_edu_21 ///
fathers_edu_22 ///
fathers_edu_23 ///
fathers_edu_24 ///
fathers_edu_25 ///
fathers_edu_26 )
label variable fathers_edu "Educación del padre"

tab fathers_edu, mi
replace fathers_edu = .i if fathers_edu == .
tab fathers_edu, mi

// 1074 missings en educación del padre 
// 2.9% de la muestra 

tab fathers_edu tobs if tobs == .i , mi 
//35 missings en educación del padre y tiempo de observación 

count if fathers_edu == .i & ym_bday == .i
// 2 comparten missing con el missing de la fecha de nacimiento

label define fathers_edu ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu fathers_edu

**********************************************
************* EDUCACION DE LA MADRE **********
**********************************************
egen mothers_edu = rowmax( ///
mothers_edu_04 ///
mothers_edu_05 ///
mothers_edu_06 ///
mothers_edu_06 ///
mothers_edu_07 ///
mothers_edu_08 ///
mothers_edu_09 ///
mothers_edu_10 ///
mothers_edu_11 ///
mothers_edu_12 ///
mothers_edu_13 ///
mothers_edu_14 ///
mothers_edu_15 ///
mothers_edu_16 ///
mothers_edu_17 ///
mothers_edu_18 ///
mothers_edu_19 ///
mothers_edu_20 ///
mothers_edu_21 ///
mothers_edu_22 ///
mothers_edu_23 ///
mothers_edu_24 ///
mothers_edu_25 ///
mothers_edu_26 )
label variable mothers_edu "Educación de la madre"

tab mothers_edu, mi
replace mothers_edu = .i if mothers_edu == .
replace mothers_edu = .i if mothers_edu == -1
tab mothers_edu, mi

// 3967 missings en educación de la madre 
// 11.6% de la muestra 

tab fathers_edu mothers_edu, chi2


/// se rechaza la hipótesis nula de que la educación de la madre y la educación del padre son independientes. 
///La prueba χ² de independencia muestra una asociación estadísticamente significativa entre el nivel educativo del padre y de la madre (χ² = 46,000; p < 0.001). La distribución de frecuencias evidencia una fuerte concentración en la diagonal de la tabla de contingencia, lo que indica que los padres tienden a compartir niveles educativos similares. Este patrón sugiere la presencia de homogamia educativa en la generación parental.
replace fathers_edu = mothers_edu if missing(fathers_edu) & !missing(mothers_edu)

*******************************************
**************** NSE 14********************
*******************************************

egen nse14 = rowmax( ///
nse14_08 ///
nse14_09 ///
nse14_10 ///
nse14_11 ///
nse14_12 ///
nse14_13 ///
nse14_14 ///
nse14_15 ///
nse14_16 ///
nse14_17 ///
nse14_18 ///
nse14_19 ///
nse14_20 ///
nse14_21 ///
nse14_22 ///
nse14_23 ///
nse14_24 ///
nse14_25 ///
nse14_26 )
label variable nse14 "Nivel Socioeconómico a la edad 14"

tab nse14, mi
replace nse14 = .i if nse14 == -1
replace nse14 = .i if nse14 == .
tab nse14, mi
//  5,397 missings en educación del padre 
// Esta variable se fue al carajo porque sesga la muestra 



***********************************************
**************** EDUCACION ********************
***********************************************


egen edu = rowmax( ///
edu_01 ///
edu_02 ///
edu_03 ///
edu_04 ///
edu_05 ///
edu_06 ///
edu_06 ///
edu_07 ///
edu_08 ///
edu_09 ///
edu_10 ///
edu_11 ///
edu_12 ///
edu_13 ///
edu_14 ///
edu_15 ///
edu_16 ///
edu_17 ///
edu_18 ///
edu_19 ///
edu_20 ///
edu_21 ///
edu_22 ///
edu_23 ///
edu_24 ///
edu_25 ///
edu_26 )
label variable edu "Nivel Educativo"

label define edu ///
1 "Antes de edad escolar" ///
2 "Sin Educación"  ///
3 "Primaria" ///
4 "Secundaria" ///
5 "Preparatoria" ///
6 "Superior técnica" ///
7 "Universidad" ///
8 "Maestría" ///
9 "Doctorado"
label values edu edu

 
gen education = edu

recode education ///
(1/3 = 1) ///
(4 = 2) ///
(5 = 3) ///
(6/9 = 4) 

label define education ///
1 "Primaria o menos" ///
2 "Secundaria" ///
3 "Preparatoria" ///
4 "Universidad"
label values education education

 ///(1) Before school age 
 ///(2) No schooling  
 ///(3) elementary school 
 ///(4) Lower secondary 
 ///(5) Upper secondary 
 ///(6) 2-years college, vocational, technical, associate degree 
 ///(7) University (4 years or more) 
 ///(8) Graduate school (master's) 
 ///(9) Graduate school (doctoral) 

 tab education, mi

 gen education3c = edu

recode education3c ///
(1/4 = 1) ///
(5 = 2) ///
(6/9 = 3) 

label define education3c ///
1 "Secundaria o menos" ///
2 "Preparatoria" ///
3 "Universidad"
label values education3c education3c

 ///(1) Before school age 
 ///(2) No schooling  
 ///(3) elementary school 
 ///(4) Lower secondary 
 ///(5) Upper secondary 
 ///(6) 2-years college, vocational, technical, associate degree 
 ///(7) University (4 years or more) 
 ///(8) Graduate school (master's) 
 ///(9) Graduate school (doctoral) 

 tab education, mi
 ////SALIDA DE LA ESCUELA 
 
 

egen grad = rowmax( ///
grad_01 ///
grad_02 ///
grad_03 ///
grad_04 ///
grad_05 ///
grad_06 ///
grad_06 ///
grad_07 ///
grad_08 ///
grad_09 ///
grad_10 ///
grad_11 ///
grad_12 ///
grad_13 ///
grad_14 ///
grad_15 ///
grad_16 ///
grad_17 ///
grad_18 ///
grad_19 ///
grad_20 ///
grad_21 ///
grad_22 ///
grad_23 ///
grad_24 ///
grad_25 ///
grad_26 )

 
egen y_dropout = rowmax( ///
y_dropout_05 ///
y_dropout_06 ///
y_dropout_07 ///
y_dropout_08 ///
y_dropout_09 ///
y_dropout_10 ///
y_dropout_11 ///
y_dropout_12 ///
y_dropout_13 ///
y_dropout_14 ///
y_dropout_15 ///
y_dropout_16 ///
y_dropout_17 ///
y_dropout_18 ///
y_dropout_19 ///
y_dropout_20 ///
y_dropout_21 ///
y_dropout_22 ///
y_dropout_23 ///
y_dropout_24 ///
y_dropout_25 ///
y_dropout_26 )

egen m_dropout = rowmax( ///
m_dropout_05 ///
m_dropout_06 ///
m_dropout_07 ///
m_dropout_08 ///
m_dropout_09 ///
m_dropout_10 ///
m_dropout_11 ///
m_dropout_12 ///
m_dropout_13 ///
m_dropout_14 ///
m_dropout_15 ///
m_dropout_16 ///
m_dropout_17 ///
m_dropout_18 ///
m_dropout_19 ///
m_dropout_20 ///
m_dropout_21 ///
m_dropout_22 ///
m_dropout_23 ///
m_dropout_24 ///
m_dropout_25 ///
m_dropout_26 )

gen ym_dropout = .
replace ym_dropout = ym(y_dropout, m_dropout) if inrange(grad,1,3)
 
gen tescuela = round(((ym_dropout - ym_bday)/12)) 

replace tescuela = edad if inrange(grad,4,5)
replace tescuela = .i if tescuela < 0 
 
 
 

***********************************************
**************** OCUPACION14 ******************
***********************************************

egen parents_ocupation = rowmax( ///
parents_ocupation_01 ///
parents_ocupation_02 ///
parents_ocupation_03 ///
parents_ocupation_04 ///
parents_ocupation_05 ///
parents_ocupation_06 ///
parents_ocupation_06 ///
parents_ocupation_07 ///
parents_ocupation_08 ///
parents_ocupation_09 ///
parents_ocupation_10 ///
parents_ocupation_11 ///
parents_ocupation_12 ///
parents_ocupation_13 ///
parents_ocupation_14 ///
parents_ocupation_15 ///
parents_ocupation_16 ///
parents_ocupation_17 ///
parents_ocupation_18 ///
parents_ocupation_19 ///
parents_ocupation_20 ///
parents_ocupation_21 ///
parents_ocupation_22 ///
parents_ocupation_23 ///
parents_ocupation_24 ///
parents_ocupation_25 ///
parents_ocupation_26 )


label variable parents_ocupation "Ocupación del sostén del hogar a la edad 14"

* Missings -> categoría explícita
replace parents_ocupation = .i if parents_ocupation == -1 
replace parents_ocupation = .i if missing(parents_ocupation)

gen parents_ksco_major = real(substr(string(parents_ocupation),1,1))

gen parents_ocupation14 = .

* 1 = Collar blanco (0–3)
replace parents_ocupation14 = 1 if inrange(parents_ksco_major,0,3)

* 2 = Collar azul (6–9)
replace parents_ocupation14 = 2 if inrange(parents_ksco_major,6,9)

* 3 = Servicios (4–5)
replace parents_ocupation14 = 3 if inrange(parents_ksco_major,4,5)

* 4 = No sabe / No contesta
replace parents_ocupation14 = 4 if parents_ocupation == .i




label define parents_ocupation14 ///
1 "Collar blanco" ///
2 "Collar azul" ///
3 "Servicios" ///
4 "No sabe / No contesta"

label values parents_ocupation14 parents_ocupation14


***********************************************
****************ACTIVIDAD14 ******************
***********************************************

egen parents_activity = rowmax( ///
parents_activity_01 ///
parents_activity_02 ///
parents_activity_03 ///
parents_activity_04 ///
parents_activity_05 ///
parents_activity_06 ///
parents_activity_06 ///
parents_activity_07 ///
parents_activity_08 ///
parents_activity_09 ///
parents_activity_10 ///
parents_activity_11 ///
parents_activity_12 ///
parents_activity_13 ///
parents_activity_14 ///
parents_activity_15 ///
parents_activity_16 ///
parents_activity_17 ///
parents_activity_18 ///
parents_activity_19 ///
parents_activity_20 ///
parents_activity_21 ///
parents_activity_22 ///
parents_activity_23 ///
parents_activity_24 ///
parents_activity_25 ///
parents_activity_26 )
label variable parents_activity "Actividad economica del sosten del hogar a la edad 14"

replace parents_activity = .i if parents_activity == -1 
replace parents_activity = .i if parents_activity == .

label define parents_activity ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity parents_activity


save "path\general\master_labelled.dta", replace
