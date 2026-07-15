********************************************************************
* Código de Mineria de datos para limpieza de encuesta longitudinal*
********************************************************************
////Fuente: Korean Labor and Income Panel Survey, Centro de Investigaciones
** Laborales de Korea//
// Creación:  ‎7‎ de ‎marzo‎ de ‎2026 01:19:10 p. m
// Última modificación: 14‎ de ‎marzo‎ de ‎2026 02:12:02 p. m.
// Universo de Estudio: Hombres y Mujeres nacidos entre 1960 y 1980 
// Técnica Estadística: Análisis de historia de eventos en tiempo discreto
// Evento: Transición al Primer Matrimonio
***************************************************
**#* OLA 1 *****************************************
***************************************************
use "path\data\klips01p.dta", clear 
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_01  = p010104
replace cohorte_01 = .i if cohorte_01 == -1

gen cohorte5_01 = p010104
replace cohorte5_01 = .i if cohorte5_01 == -1

recode cohorte_01 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_01 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

 gen birth_month_01 = p010105
replace birth_month_01 = .i if birth_month_01 == -1

 
***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_01 = p015501
replace edo_conyug_01 = .i if edo_conyug_01 == -1

// aquí se que todos mis cambios son primer matrimonio pero quiero que todo este homogeneo
gen y_change_01 = p015541
replace y_change_01 = .i if y_change_01 == -1


gen m_change_01 = p015542
replace m_change_01 = .i if m_change_01 == -1


gen unido_01 = 0
replace unido_01 = 1 if inrange(edo_conyug_01,2,5) 

gen primer_matrimonio_01 = 0
replace primer_matrimonio_01 = 1 if unido_01 == 1 

***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_01 = 1998

gen b_cohort_01 = p010104
replace b_cohort_01 = .i if b_cohort_01 == -1

gen sex_01 = p010101
replace sex_01 = .i if sex_01 == -1

gen edu_01 = p010110
replace edu_01 = .i if edu_01 == -1

gen grad_01 = p010111
replace grad_01 = .i if grad_01 == -1

gen edad_01 = p010107
replace edad_01 = .i if edad_01 == -1

gen wrkstatus_01 = p010314
replace wrkstatus_01 = .i if wrkstatus_01 == -1

gen wrkhrs_01 = p010315
replace wrkhrs_01 = .i if wrkhrs_01 == -1

gen ksco_01 = p010350
replace ksco_01 = .i if ksco_01 == -1


***************************************************
*** PESOS *****************************************
***************************************************

gen weight_c_01 = w01p
replace weight_c_01 = .i if weight_c_01 == -1

***************************************************
*** ORÍGEN SOCIAL *********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_01 = p019051 
label variable fathers_edu_01 "Educación máxima del padre reportada en la ola 1"
recode fathers_edu_01 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_01 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_01 

/// EDUCACIÓN DE LA MADRE 
/// OLA 4 

//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p019055, mi
clonevar sosten_01 = p019055
label define sosten_01 ///
1 "Padre" ///
2 "Madre" 
label values sosten_01 sosten_01

replace sosten_01 = .i if sosten_01 == -1 

gen parents_activity_01 = p019059

// 143 missing values 
label define parents_activity_01 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_01 parents_activity_01


gen parents_ocupation_01 = p019064

///** VOY A USAR LA CLASIFICACIÓN KSCO 5 PORQUE ES LA QUE ESTÁ DISPONIBLE EN TODAS LAS OLAS
// SI AL FINAL LA OCUPO HAGO LA CORRESPONDENCIA DE LA KSCO5 A LA 6 Y DE AHÍ A LA 7 
/// ** USO PARENTS OCUPATION Y DESPUÉS DEL MERGE DISTINGO SI ES DEL PADRE O MADRE 

***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_01 sex_01 cohorte_01 cohorte5_01 edad_01 year_01 ///
birth_month_01 edo_conyug_01 y_change_01 m_change_01 primer_matrimonio_01 ///
edu_01 grad_01  wrkhrs_01 wrkstatus_01 ksco_01 ///
 weight_c_01 fathers_edu_01 unido_01 hwaveent ///
 sosten_01 parents_activity_01 parents_ocupation_01
 


***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 1"
label variable b_cohort_01 "Cohorte de nacimiento en la ola 1"
label variable sex_01 "Sexo en la ola 1"
label variable cohorte_01 "Cohorte decenal en la ola 1"
label variable cohorte5_01 "Cohorte quinquenal en la ola 1"
label variable edad_01 "Edad en la ola 1"
label variable year_01 "Año de la encuesta en la ola 1"
label variable birth_month_01 "Mes de nacimiento en la ola 1"
label variable edo_conyug_01 "Estado conyugal en la ola 1"
label variable y_change_01 "Año del cambio conyugal en la ola 1"
label variable m_change_01 "Mes del cambio conyugal en la ola 1"
label variable primer_matrimonio_01 "Ocurrencia de primer matrimonio en la ola 1"
label variable edu_01 "Educación en la ola 1"
label variable grad_01 "Obtención de grado en la ola 1"
label variable wrkhrs_01 "Horas trabajadas en la ola 1"
label variable wrkstatus_01 "Estatus laboral en la ola 1"
label variable ksco_01 "Ocupación KSCO en la ola 1"
label variable weight_c_01 "Peso transversal en la ola 1"
label variable unido_01 "Alguna vez Unido"

tab primer_matrimonio_01 unido_01
replace fathers_edu_01 =.i if fathers_edu_01 == -1 
count if inrange(b_cohort_01, 1960, 1989)
count
save "path\wave1_clean.dta", replace

***************************************************
**#* OLA 2 *****************************************
***************************************************

use "path\data\klips02p.dta", clear 
count


***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_02  = p020104
replace cohorte_02 = .i if cohorte_02 == -1

gen cohorte5_02 = p020104
replace cohorte5_02 = .i if cohorte5_02 == -1

recode cohorte_02 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_02 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

 gen birth_month_02 = p020105
replace birth_month_02 = .i if birth_month_02 == -1

 
***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_02 = p025501
replace edo_conyug_02 = .i if edo_conyug_02 == -1

// aquí se que todos mis cambios son primer matrimonio pero quiero que todo este homogeneo
gen y_change_02 = p025541
replace y_change_02 = .i if y_change_02 == -1

gen m_change_02 = p025542
replace m_change_02 = .i if m_change_02 == -1


gen unido_02 = 0
replace unido_02 = 1 if inrange(edo_conyug_02,2,5)

gen primer_matrimonio_02 = 0
replace primer_matrimonio_02 = 1 if unido_02 == 1 

***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_02 = 1999

gen b_cohort_02 = p020104
replace b_cohort_02 = .i if b_cohort_02 == -1

gen sex_02 = p020101
replace sex_02 = .i if sex_02 == -1

gen edu_02 = p020110
replace edu_02 = .i if edu_02 == -1

gen grad_02 = p020111
replace grad_02 = .i if grad_02 == -1

gen edad_02 = p020107
replace edad_02 = .i if edad_02 == -1

gen wrkstatus_02 = p020314
replace wrkstatus_02 = .i if wrkstatus_02 == -1

gen wrkhrs_02 = p020315
replace wrkhrs_02 = .i if wrkhrs_02 == -1

gen ksco_02 = p020350
replace ksco_02 = .i if ksco_02 == -1


***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_02 = w02p_l
replace weight_l_02 = .i if weight_l_02 == -1

gen weight_c_02 = w02p_c
replace weight_c_02 = .i if weight_c_02 == -1

***************************************************
*** ORÍGEN SOCIAL *********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_02 = p029051 
label variable fathers_edu_02 "Educación máxima del padre reportada en la ola 2"
recode fathers_edu_02 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_02 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_02 fathers_edu_02

/// EDUCACIÓN DE LA MADRE 
/// OLA 4 

//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p029055, mi
clonevar sosten_02 = p029055
label define sosten_02 ///
1 "Padre" ///
2 "Madre" 
label values sosten_02 sosten_02

replace sosten_02 = .i if sosten_02 == -1 

gen parents_activity_02 = p029059

// 143 missing values 
label define parents_activity_02 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_02 parents_activity_02


gen parents_ocupation_02 = p029064



///** VOY A USAR LA CLASIFICACIÓN KSCO 5 PORQUE ES LA QUE ESTÁ DISPONIBLE EN TODAS LAS OLAS
// SI AL FINAL LA OCUPO HAGO LA CORRESPONDENCIA DE LA KSCO5 A LA 6 Y DE AHÍ A LA 7 
/// ** USO PARENTS OCUPATION Y DESPUÉS DEL MERGE DISTINGO SI ES DEL PADRE O MADRE 


***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_02 sex_02 cohorte_02 cohorte5_02 edad_02 year_02 ///
birth_month_02 edo_conyug_02 y_change_02 m_change_02 primer_matrimonio_02 ///
edu_02 grad_02  wrkhrs_02 wrkstatus_02 ksco_02 ///
 weight_l_02 weight_c_02 fathers_edu_02 unido_02 hwaveent ///
 sosten_02 parents_activity_02 parents_ocupation_02

***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 2"
label variable b_cohort_02 "Cohorte de nacimiento en la ola 2"
label variable sex_02 "Sexo en la ola 2"
label variable cohorte_02 "Cohorte decenal en la ola 2"
label variable cohorte5_02 "Cohorte quinquenal en la ola 2"
label variable edad_02 "Edad en la ola 2"
label variable year_02 "Año de la encuesta en la ola 2"
label variable birth_month_02 "Mes de nacimiento en la ola 2"
label variable edo_conyug_02 "Estado conyugal en la ola 2"
label variable y_change_02 "Año del cambio conyugal en la ola 2"
label variable m_change_02 "Mes del cambio conyugal en la ola 2"
label variable primer_matrimonio_02 "Ocurrencia de primer matrimonio en la ola 2"
label variable edu_02 "Educación en la ola 2"
label variable grad_02 "Obtención de grado en la ola 2"
label variable wrkhrs_02 "Horas trabajadas en la ola 2"
label variable wrkstatus_02 "Estatus laboral en la ola 2"
label variable ksco_02 "Ocupación KSCO en la ola 2"
label variable weight_l_02 "Peso longitudinal en la ola 2"
label variable weight_c_02 "Peso transversal en la ola 2"

replace fathers_edu_02 = .i if fathers_edu_02 == -1 
tab fathers_edu if hwaveent == 2, mi
count if inrange(b_cohort_02, 1960, 1989)
count

save "path\wave2_clean.dta", replace

***************************************************
**#* OLA 3  ****************************************
***************************************************
use "path\data\klips03p.dta", clear
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_03  = p030104
replace cohorte_03 = .i if cohorte_03 == -1

gen cohorte5_03 = p030104
replace cohorte5_03 = .i if cohorte5_03 == -1

recode cohorte_03 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_03 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_03 = p030105
replace birth_month_03 = .i if birth_month_03 == -1


***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_03 = p035501
replace edo_conyug_03 = .i if edo_conyug_03 == -1

gen change_edo_03 = p035502
replace change_edo_03 = .i if change_edo_03 == -1

gen type_changeedo_03 = p035504
replace type_changeedo_03 = .i if type_changeedo_03 == -1

gen y_change_03 = p035505
replace y_change_03 = .i if y_change_03 == -1
replace y_change_03 = .v if type_changeedo_03 ==! 1

gen m_change_03 = p035506
replace m_change_03 = .i if m_change_03 == -1
replace m_change_03 = .v if type_changeedo_03 ==! 1

gen unido_03 = 0
replace unido_03 = 1 if inrange(edo_conyug_03,2,5)

gen primer_matrimonio_03 = 0
replace primer_matrimonio_03 = 1 if unido_03 == 1  & type_changeedo_03 == 1 


***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_03 = 2000

gen b_cohort_03 = p030104
replace b_cohort_03 = .i if b_cohort_03 == -1

gen sex_03 = p030101
replace sex_03 = .i if sex_03 == -1

gen edu_03 = p030110
replace edu_03 = .i if edu_03 == -1

gen grad_03 = p030111
replace grad_03 = .i if grad_03 == -1

gen main_act_03 = p030202
replace main_act_03 = .i if main_act_03 == -1

gen edad_03 = p030107
replace edad_03 = .i if edad_03 == -1

gen wrkstatus_03 = p030314
replace wrkstatus_03 = .i if wrkstatus_03 == -1

gen wrkhrs_03 = p030315
replace wrkhrs_03 = .i if wrkhrs_03 == -1

gen ksco_03 = p030350
replace ksco_03 = .i if ksco_03 == -1


***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_03 = w03p_l
replace weight_l_03 = .i if weight_l_03 == -1

gen weight_c_03 = w03p_c
replace weight_c_03 = .i if weight_c_03 == -1

***************************************************
*** ORÍGEN SOCIAL *********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_03 = p039051 
label variable fathers_edu_03 "Educación máxima del padre reportada en la ola 3"
recode fathers_edu_03 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_03 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_03 fathers_edu_03

/// EDUCACIÓN DE LA MADRE 
/// OLA 4 

//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p039055, mi
clonevar sosten_03 = p039055
label define sosten_03 ///
1 "Padre" ///
2 "Madre" 
label values sosten_03 sosten_03

replace sosten_03 = .i if sosten_03 == -1 

gen parents_activity_03 = p039059

// 143 missing values 
label define parents_activity_03 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_03 parents_activity_03


gen parents_ocupation_03 = p039064


***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_03 sex_03 cohorte_03 cohorte5_03 edad_03 year_03 ///
birth_month_03 edo_conyug_03 y_change_03 m_change_03 primer_matrimonio_03 change_edo_03 type_changeedo_03 ///
edu_03 grad_03  wrkhrs_03 wrkstatus_03 ksco_03 main_act_03 ///
 weight_c_03 weight_l_03 fathers_edu_03 unido_03 hwaveent ///
 sosten_03 parents_activity_03 parents_ocupation_03



***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 3"
label variable b_cohort_03 "Cohorte de nacimiento en la ola 3"
label variable sex_03 "Sexo en la ola 3"
label variable cohorte_03 "Cohorte decenal en la ola 3"
label variable cohorte5_03 "Cohorte quinquenal en la ola 3"
label variable edad_03 "Edad en la ola 3"
label variable year_03 "Año de la encuesta en la ola 3"
label variable birth_month_03 "Mes de nacimiento en la ola 3"
label variable edo_conyug_03 "Estado conyugal en la ola 3"
label variable change_edo_03 "Cambio de estado conyugal en la ola 3"
label variable type_changeedo_03 "Tipo de cambio conyugal en la ola 3"
label variable y_change_03 "Año del cambio conyugal en la ola 3"
label variable m_change_03 "Mes del cambio conyugal en la ola 3"
label variable primer_matrimonio_03 "Ocurrencia de primer matrimonio en la ola 3"
label variable edu_03 "Educación en la ola 3"
label variable grad_03 "Obtención de grado en la ola 3"
label variable main_act_03 "Actividad principal en la ola 3"
label variable wrkhrs_03 "Horas trabajadas en la ola 3"
label variable wrkstatus_03 "Estatus laboral en la ola 3"
label variable ksco_03 "Ocupación KSCO en la ola 3"
label variable weight_l_03 "Peso longitudinal en la ola 3"
label variable weight_c_03 "Peso transversal en la ola 3"

tab primer_matrimonio_03 unido_03 if hwaveent == 3
replace fathers_edu_03 = .i if fathers_edu_03 == -1
tab fathers_edu if hwaveent == 3, mi
count if inrange(b_cohort, 1960, 1989)

save "path\wave3_clean.dta", replace
***************************************************
**#* OLA 4 *****************************************
***************************************************
use "path\data\klips04p.dta", clear
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_04  = p040104
replace cohorte_04 = .i if cohorte_04 == -1

gen cohorte5_04 = p040104
replace cohorte5_04 = .i if cohorte5_04 == -1

recode cohorte_04 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_04 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_04 = p040105
replace birth_month_04 = .i if birth_month_04 == -1


***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_04 = p045501
replace edo_conyug_04 = .i if edo_conyug_04 == -1

gen change_edo_04 = p045502
replace change_edo_04 = .i if change_edo_04 == -1

gen type_changeedo_04 = p045504
replace type_changeedo_04 = .i if type_changeedo_04 == -1

gen y_change_04 = p045505
replace y_change_04 = .i if y_change_04 == -1
replace y_change_04 = .v if type_changeedo_04 ==! 1

gen m_change_04 = p045506
replace m_change_04 = .i if m_change_04 == -1
replace m_change_04 = .v if type_changeedo_04 ==! 1

gen unido_04 = 0
replace unido_04 = 1 if inrange(edo_conyug_04,2,5)

gen primer_matrimonio_04 = 0
replace primer_matrimonio_04 = 1 if unido_04 == 1 & type_changeedo_04 == 1


***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_04 = 2001

gen b_cohort_04 = p040104
replace b_cohort_04 = .i if b_cohort_04 == -1

gen sex_04 = p040101
replace sex_04 = .i if sex_04 == -1

gen edu_04 = p040110
replace edu_04 = .i if edu_04 == -1

gen grad_04 = p040111
replace grad_04 = .i if grad_04 == -1

gen main_act_04 = p040202
replace main_act_04 = .i if main_act_04 == -1

gen edad_04 = p040107
replace edad_04 = .i if edad_04 == -1

gen wrkstatus_04 = p040314
replace wrkstatus_04 = .i if wrkstatus_04 == -1

gen wrkhrs_04 = p040315
replace wrkhrs_04 = .i if wrkhrs_04 == -1

gen ksco_04 = p040350
replace ksco_04 = .i if ksco_04 == -1


***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_04 = w04p_l
replace weight_l_04 = .i if weight_l_04 == -1

gen weight_c_04 = w04p_c
replace weight_c_04 = .i if weight_c_04 == -1

***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_04 = p049051 
label variable fathers_edu_04 "Educación máxima del padre reportada en la ola 4"
recode fathers_edu_04 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_04 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_04 fathers_edu_04

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_04 = p049053 
label variable mothers_edu_04 "Educación máxima de la madre reportada en la ola 4"
recode mothers_edu_04 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_04 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_04 mothers_edu_04


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p049055, mi
clonevar sosten_04 = p049055
label define sosten_04 ///
1 "Padre" ///
2 "Madre" 
label values sosten_04 sosten_04

replace sosten_04 = .i if sosten_04 == -1 

gen parents_activity_04 = p049059

// 143 missing values 
label define parents_activity_04 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_04 parents_activity_04

gen parents_ocupation_04 = p049064

***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_04 sex_04 cohorte_04 cohorte5_04 edad_04 year_04 ///
birth_month_04 ///
edo_conyug_04 change_edo_04 type_changeedo_04 y_change_04 m_change_04 ///
primer_matrimonio_04 ///
edu_04 grad_04 main_act_04 wrkhrs_04 wrkstatus_04 ksco_04 ///
weight_l_04 weight_c_04 fathers_edu_04 unido_04 hwaveent ///
 sosten_04 parents_activity_04 parents_ocupation_04


***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 4"
label variable b_cohort_04 "Cohorte de nacimiento en la ola 4"
label variable sex_04 "Sexo en la ola 4"
label variable cohorte_04 "Cohorte decenal en la ola 4"
label variable cohorte5_04 "Cohorte quinquenal en la ola 4"
label variable edad_04 "Edad en la ola 4"
label variable year_04 "Año de la encuesta en la ola 4"
label variable birth_month_04 "Mes de nacimiento en la ola 4"
label variable edo_conyug_04 "Estado conyugal en la ola 4"
label variable change_edo_04 "Cambio de estado conyugal en la ola 4"
label variable type_changeedo_04 "Tipo de cambio conyugal en la ola 4"
label variable y_change_04 "Año del cambio conyugal en la ola 4"
label variable m_change_04 "Mes del cambio conyugal en la ola 4"
label variable primer_matrimonio_04 "Ocurrencia de primer matrimonio en la ola 4"
label variable edu_04 "Educación en la ola 4"
label variable grad_04 "Obtención de grado en la ola 4"
label variable main_act_04 "Actividad principal en la ola 4"
label variable wrkhrs_04 "Horas trabajadas en la ola 4"
label variable wrkstatus_04 "Estatus laboral en la ola 4"
label variable ksco_04 "Ocupación KSCO en la ola 4"
label variable weight_l_04 "Peso longitudinal en la ola 4"
label variable weight_c_04 "Peso transversal en la ola 4"

tab primer_matrimonio_04 unido_04 if hwaveent == 4
replace fathers_edu_04 = .i if fathers_edu_04 == -1
tab fathers_edu if hwaveent == 4, mi
count if inrange(b_cohort, 1960, 1989)

save "path\general\wave4_clean.dta", replace

***************************************************
**#* OLA 5 *****************************************
***************************************************
use "path\data\klips05p.dta", clear
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_05  = p050104
replace cohorte_05 = .i if cohorte_05 == -1

gen cohorte5_05 = p050104
replace cohorte5_05 = .i if cohorte5_05 == -1

recode cohorte_05 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_05 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_05 = p050105
replace birth_month_05 = .i if birth_month_05 == -1


***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_05 = p055501
replace edo_conyug_05 = .i if edo_conyug_05 == -1

gen change_edo_05 = p055502
replace change_edo_05 = .i if change_edo_05 == -1

gen type_changeedo_05 = p055504
replace type_changeedo_05 = .i if type_changeedo_05 == -1

gen y_change_05 = p055505
replace y_change_05 = .i if y_change_05 == -1
replace y_change_05 = .v if type_changeedo_05 ==! 1

gen m_change_05 = p055506
replace m_change_05 = .i if m_change_05 == -1
replace m_change_05 = .v if type_changeedo_05 ==! 1

gen unido_05 = 0
replace unido_05 = 1 if inrange(edo_conyug_05,2,5)

gen primer_matrimonio_05 = 0
replace primer_matrimonio_05 = 1 if unido_05 == 1 & type_changeedo_05 == 1 


***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_05 = 2002

gen b_cohort_05 = p050104
replace b_cohort_05 = .i if b_cohort_05 == -1

gen sex_05 = p050101
replace sex_05 = .i if sex_05 == -1

gen edu_05 = p050110
replace edu_05 = .i if edu_05 == -1

gen grad_05 = p050111
replace grad_05 = .i if grad_05 == -1

gen main_act_05 = p050202
replace main_act_05 = .i if main_act_05 == -1

gen edad_05 = p050107
replace edad_05 = .i if edad_05 == -1

gen wrkstatus_05 = p050314
replace wrkstatus_05 = .i if wrkstatus_05 == -1

gen wrkhrs_05 = p050315
replace wrkhrs_05 = .i if wrkhrs_05 == -1

gen ksco_05 = p050350
replace ksco_05 = .i if ksco_05 == -1


***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_05 = w05p_l
replace weight_l_05 = .i if weight_l_05 == -1

gen weight_c_05 = w05p_c
replace weight_c_05 = .i if weight_c_05 == -1
***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_05 = p059051 
label variable fathers_edu_05 "Educación máxima del padre reportada en la ola 5"
recode fathers_edu_05 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_05 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_05 fathers_edu_05

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_05 = p059053 
label variable mothers_edu_05 "Educación máxima de la madre reportada en la ola 5"
recode mothers_edu_05 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_05 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_05 mothers_edu_05


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p059055, mi
clonevar sosten_05 = p059055
label define sosten_05 ///
1 "Padre" ///
2 "Madre" 
label values sosten_05 sosten_05

replace sosten_05 = .i if sosten_05 == -1 

gen parents_activity_05 = p059059

// 143 missing values 
label define parents_activity_05 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_05 parents_activity_05


gen parents_ocupation_05 = p059064



***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_05 =p050114 
gen m_dropout_05 =p050115 




***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_05 sex_05 cohorte_05 cohorte5_05 edad_05 year_05 ///
birth_month_05 ///
edo_conyug_05 change_edo_05 type_changeedo_05 y_change_05 m_change_05 ///
primer_matrimonio_05 ///
edu_05 grad_05 main_act_05 wrkhrs_05 wrkstatus_05 ksco_05 ///
weight_l_05 weight_c_05 fathers_edu_05 unido_05 hwaveent ///
sosten_05 parents_activity_05 parents_ocupation_05 //
y_dropout_05 m_dropout_05


***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 5"
label variable b_cohort_05 "Cohorte de nacimiento en la ola 5"
label variable sex_05 "Sexo en la ola 5"
label variable cohorte_05 "Cohorte decenal en la ola 5"
label variable cohorte5_05 "Cohorte quinquenal en la ola 5"
label variable edad_05 "Edad en la ola 5"
label variable year_05 "Año de la encuesta en la ola 5"
label variable birth_month_05 "Mes de nacimiento en la ola 5"
label variable edo_conyug_05 "Estado conyugal en la ola 5"
label variable change_edo_05 "Cambio de estado conyugal en la ola 5"
label variable type_changeedo_05 "Tipo de cambio conyugal en la ola 5"
label variable y_change_05 "Año del cambio conyugal en la ola 5"
label variable m_change_05 "Mes del cambio conyugal en la ola 5"
label variable primer_matrimonio_05 "Ocurrencia de primer matrimonio en la ola 5"
label variable edu_05 "Educación en la ola 5"
label variable grad_05 "Obtención de grado en la ola 5"
label variable main_act_05 "Actividad principal en la ola 5"
label variable wrkhrs_05 "Horas trabajadas en la ola 5"
label variable wrkstatus_05 "Estatus laboral en la ola 5"
label variable ksco_05 "Ocupación KSCO en la ola 5"
label variable weight_l_05 "Peso longitudinal en la ola 5"
label variable weight_c_05 "Peso transversal en la ola 5"

count 
tab primer_matrimonio_05 unido_05 if hwaveent == 5
replace fathers_edu_05 = .i if fathers_edu_05 == -1
tab fathers_edu if hwaveent == 5, mi
count if inrange(b_cohort_05, 1960, 1989)

save "path\general\wave5_clean.dta", replace


***************************************************
**#* OLA 6   ***************************************
***************************************************
use "path\data\klips06p.dta", clear
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_06  = p060104
replace cohorte_06 = .i if cohorte_06 == -1

gen cohorte5_06 = p060104
replace cohorte5_06 = .i if cohorte5_06 == -1

recode cohorte_06 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_06 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

 gen birth_month_06 = p060105
replace birth_month_06 = .i if birth_month_06 == -1

***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_06   = p069021
replace male_sibs_06 = .i if male_sibs_06 == -1

gen female_sibs_06 = p069022
replace female_sibs_06 = .i if female_sibs_06 == -1

egen siblings_06 = rowtotal(male_sibs_06 female_sibs_06) if !missing(male_sibs_06) | !missing(female_sibs_06)  

gen seniority_06 = p069023
replace seniority_06 = .i if seniority_06 == -1

***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_06 = p065501
replace edo_conyug_06 = .i if edo_conyug_06 == -1

gen change_edo_06 = p065502
replace change_edo_06 = .i if change_edo_06 == -1

gen type_changeedo_06 = p065504
replace type_changeedo_06 = .i if type_changeedo_06 == -1

gen y_change_06 = p065505
replace y_change_06 = .i if y_change_06 == -1
replace y_change_06 = .v if type_changeedo_06 ==! 1

gen m_change_06 = p065506
replace m_change_06 = .i if m_change_06 == -1
replace m_change_06 = .v if type_changeedo_06 ==! 1

gen unido_06 = 0
replace unido_06 = 1 if inrange(edo_conyug_06,2,5)

gen primer_matrimonio_06 = 0
replace primer_matrimonio_06 = 1 if unido_06 == 1 & type_changeedo_06 == 1 


***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_06 = 2003

gen b_cohort_06 = p060104
replace b_cohort_06 = .i if b_cohort_06 == -1

gen sex_06 = p060101
replace sex_06 = .i if sex_06 == -1

gen edu_06 = p060110
replace edu_06 = .i if edu_06 == -1

gen grad_06 = p060111
replace grad_06 = .i if grad_06 == -1

gen main_act_06 = p060202
replace main_act_06 = .i if main_act_06 == -1

gen edad_06 = p060107
replace edad_06 = .i if edad_06 == -1

gen wrkstatus_06 = p060314
replace wrkstatus_06 = .i if wrkstatus_06 == -1

gen wrkhrs_06 = p060315
replace wrkhrs_06 = .i if wrkhrs_06 == -1

gen ksco_06 = p060350
replace ksco_06 = .i if ksco_06 == -1


***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_06 = w06p_l
replace weight_l_06 = .i if weight_l_06 == -1

gen weight_c_06 = w06p_c
replace weight_c_06 = .i if weight_c_06 == -1

***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_06 = p069051 
label variable fathers_edu_06 "Educación máxima del padre reportada en la ola 6"
recode fathers_edu_06 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_06 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_06 fathers_edu_06

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_06 = p069053 
label variable mothers_edu_06 "Educación máxima de la madre reportada en la ola 6"
recode mothers_edu_06 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_06 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_06 mothers_edu_06


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p069055, mi
clonevar sosten_06 = p069055
label define sosten_06 ///
1 "Padre" ///
2 "Madre" 
label values sosten_06 sosten_06

replace sosten_06 = .i if sosten_06 == -1 

gen parents_activity_06 = p069059

// 143 missing values 
label define parents_activity_06 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_06 parents_activity_06


gen parents_ocupation_06 = p069064

***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_06 =p060114 
gen m_dropout_06 =p060115 

***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_06 sex_06 cohorte_06 cohorte5_06 edad_06 year_06 ///
birth_month_06 male_sibs_06 female_sibs_06 siblings_06 ///
edo_conyug_06 change_edo_06 type_changeedo_06 y_change_06 m_change_06 ///
primer_matrimonio_06 seniority_06 ///
edu_06 grad_06 main_act_06 wrkhrs_06 wrkstatus_06 ksco_06 ///
weight_l_06 weight_c_06 unido_06 fathers_edu_06 mothers_edu_06 hwaveent ///
sosten_06 parents_activity_06 parents_ocupation_06 y_dropout_06 m_dropout_06


***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 6"
label variable b_cohort_06 "Cohorte de nacimiento en la ola 6"
label variable sex_06 "Sexo en la ola 6"
label variable cohorte_06 "Cohorte decenal en la ola 6"
label variable cohorte5_06 "Cohorte quinquenal en la ola 6"
label variable edad_06 "Edad en la ola 6"
label variable year_06 "Año de la encuesta en la ola 6"
label variable birth_month_06 "Mes de nacimiento en la ola 6"
label variable male_sibs_06 "Número de hermanos varones en la ola 6"
label variable female_sibs_06 "Número de hermanas mujeres en la ola 6"
label variable siblings_06 "Número total de hermanos en la ola 6"
label variable edo_conyug_06 "Estado conyugal en la ola 6"
label variable change_edo_06 "Cambio de estado conyugal en la ola 6"
label variable type_changeedo_06 "Tipo de cambio conyugal en la ola 6"
label variable y_change_06 "Año del cambio conyugal en la ola 6"
label variable m_change_06 "Mes del cambio conyugal en la ola 6"
label variable primer_matrimonio_06 "Ocurrencia de primer matrimonio en la ola 6"
label variable seniority_06 "Orden de nacimiento entre hermanos en la ola 6"
label variable edu_06 "Educación en la ola 6"
label variable grad_06 "Obtención de grado en la ola 6"
label variable main_act_06 "Actividad principal en la ola 6"
label variable wrkhrs_06 "Horas trabajadas en la ola 6"
label variable wrkstatus_06 "Estatus laboral en la ola 6"
label variable ksco_06 "Ocupación KSCO en la ola 6"
label variable weight_l_06 "Peso longitudinal en la ola 6"
label variable weight_c_06 "Peso transversal en la ola 6"

count 
tab primer_matrimonio_06 unido_06 if hwaveent == 6, mi
replace fathers_edu_06 = .i if fathers_edu_06 == -1
tab fathers_edu_06  if hwaveent == 6, mi
tab siblings_06, mi
count if inrange(b_cohort_06, 1960, 1989)
save "path\general\wave6_clean.dta", replace
***************************************************
**# OLA 7 *****************************************
***************************************************
use "path\data\klips07p.dta", clear
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_07  = p070104
replace cohorte_07 = .i if cohorte_07 == -1

gen cohorte5_07 = p070104
replace cohorte5_07 = .i if cohorte5_07 == -1

recode cohorte_07 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_07 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_07 = p070105
replace birth_month_07 = .i if birth_month_07 == -1
// 4 missings en mes de nacimiento 
// rescatables para estimación gruesa 

***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_07   = p079021
replace male_sibs_07 = .i if male_sibs_07 == -1

gen female_sibs_07 = p079022
replace female_sibs_07 = .i if female_sibs_07 == -1

egen siblings_07 = rowtotal(male_sibs_07 female_sibs_07) if !missing(male_sibs_07) | !missing(female_sibs_07)  

gen seniority_07 = p079023
replace seniority_07 = .i if seniority_07 == -1
// 3 missings 
replace siblings_07 = .i if siblings_07 == . & hwaveent == 7
// 156 missings
replace siblings_07 = .v if siblings_07 == . & hwaveent ==! 7 
***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_07 = p075501
replace edo_conyug_07 = .i if edo_conyug_07 == -1

gen change_edo_07 = p075502
replace change_edo_07 = .i if change_edo_07 == -1

gen type_changeedo_07 = p075504
replace type_changeedo_07 = .i if type_changeedo_07 == -1

gen y_change_07 = p075505
replace y_change_07 = .i if y_change_07 == -1
replace y_change_07 = .v if type_changeedo_07 ==! 1

gen m_change_07 = p075506
replace m_change_07 = .i if m_change_07 == -1
replace m_change_07 = .v if type_changeedo_07 ==! 1

gen unido_07 = 0
replace unido_07 = 1 if inrange(edo_conyug_07,2,5)

gen primer_matrimonio_07 = 0
replace primer_matrimonio_07 = 1 if unido_07 == 1 & type_changeedo_07 == 1 

tab primer_matrimonio_07, mi
// 340 primeros matrimonios 
tab primer_matrimonio_07 if hwaveent == 7 
// tengo 139 matrimonios de las personas que entraron
tab primer_matrimonio_07 if inrange(hwaveent, 1,6) 
// de las personas anteriores tengo 201 matrimonios nuevos 

// quitamos falsos negativos por historial conyugal incompleto
replace primer_matrimonio_07 = .i if unido_07 == 1 & primer_matrimonio_07 == 0 & hwaveent == 7 
// 42 falsos negativos 
// los revisé y en efecto es historial incompleto

// los que entran casados pero no reportaron los cambios en el orden correcto 
replace primer_matrimonio_07 = .v if unido_07 == 1 & primer_matrimonio_07 == 0 & inrange(hwaveent, 1, 6)
/// si a estos les sumo los matrimonios me da -87 a los matrimonios en la ola 6, lo cuál bien podría ser atrittion 

tab primer_matrimonio_07 unido_07, mi

//TODO CUADRA
***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_07 = 2004

gen b_cohort_07 = p070104
replace b_cohort_07 = .i if b_cohort_07 == -1

gen sex_07 = p070101
replace sex_07 = .i if sex_07 == -1

gen edu_07 = p070110
replace edu_07 = .i if edu_07 == -1

gen grad_07 = p070111
replace grad_07 = .i if grad_07 == -1

gen main_act_07 = p070202
replace main_act_07 = .i if main_act_07 == -1

gen edad_07 = p070107
replace edad_07 = .i if edad_07 == -1

gen wrkstatus_07 = p070314
replace wrkstatus_07 = .i if wrkstatus_07 == -1

gen wrkhrs_07 = p070315
replace wrkhrs_07 = .i if wrkhrs_07 == -1

gen ksco_07 = p070350
replace ksco_07 = .i if ksco_07 == -1


***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_07 = w07p_l
replace weight_l_07 = .i if weight_l_07 == -1

gen weight_c_07 = w07p_c
replace weight_c_07 = .i if weight_c_07 == -1

***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_07 = p079051 
label variable fathers_edu_07 "Educación máxima del padre reportada en la ola 7"
recode fathers_edu_07 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_07 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_07 fathers_edu_07

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_07 = p079053 
label variable mothers_edu_07 "Educación máxima de la madre reportada en la ola 7"
recode mothers_edu_07 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_07 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_07 mothers_edu_07


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p079055, mi
clonevar sosten_07 = p079055
label define sosten_07 ///
1 "Padre" ///
2 "Madre" 
label values sosten_07 sosten_07

replace sosten_07 = .i if sosten_07 == -1 

gen parents_activity_07 = p079059

// 143 missing values 
label define parents_activity_07 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_07 parents_activity_07


gen parents_ocupation_07 = p079064
***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_07 =p070114 
gen m_dropout_07 =p070115 

***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_07 sex_07 cohorte_07 cohorte5_07 edad_07 year_07 ///
birth_month_07 male_sibs_07 female_sibs_07 siblings_07 ///
edo_conyug_07 change_edo_07 type_changeedo_07 y_change_07 m_change_07 ///
primer_matrimonio_07 seniority_07 ///
edu_07 grad_07 main_act_07 wrkhrs_07 wrkstatus_07 ksco_07 ///
weight_l_07 weight_c_07 unido_07 fathers_edu_07 mothers_edu_07 hwaveent ///
sosten_07 parents_activity_07 parents_ocupation_07 y_dropout_07 m_dropout_07


 //N = 11,656

 ***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 7"
label variable b_cohort_07 "Cohorte de nacimiento en la ola 7"
label variable sex_07 "Sexo en la ola 7"
label variable cohorte_07 "Cohorte decenal en la ola 7"
label variable cohorte5_07 "Cohorte quinquenal en la ola 7"
label variable edad_07 "Edad en la ola 7"
label variable year_07 "Año de la encuesta en la ola 7"
label variable birth_month_07 "Mes de nacimiento en la ola 7"
label variable male_sibs_07 "Número de hermanos varones en la ola 7"
label variable female_sibs_07 "Número de hermanas mujeres en la ola 7"
label variable siblings_07 "Número total de hermanos en la ola 7"
label variable edo_conyug_07 "Estado conyugal en la ola 7"
label variable change_edo_07 "Cambio de estado conyugal en la ola 7"
label variable type_changeedo_07 "Tipo de cambio conyugal en la ola 7"
label variable y_change_07 "Año del cambio conyugal en la ola 7"
label variable m_change_07 "Mes del cambio conyugal en la ola 7"
label variable primer_matrimonio_07 "Ocurrencia de primer matrimonio en la ola 7"
label variable seniority_07 "Orden de nacimiento entre hermanos en la ola 7"
label variable edu_07 "Educación en la ola 7"
label variable grad_07 "Obtención de grado en la ola 7"
label variable main_act_07 "Actividad principal en la ola 7"
label variable wrkhrs_07 "Horas trabajadas en la ola 7"
label variable wrkstatus_07 "Estatus laboral en la ola 7"
label variable ksco_07 "Ocupación KSCO en la ola 7"
label variable weight_l_07 "Peso longitudinal en la ola 7"
label variable weight_c_07 "Peso transversal en la ola 7"

count 
tab primer_matrimonio_07 unido_07 if hwaveent == 7, mi
replace fathers_edu_07 = .i if fathers_edu_07 == -1
tab fathers_edu_07  if hwaveent == 7, mi
tab siblings_07 if hwaveent == 7, mi
count if inrange(b_cohort_07, 1960, 1989)

save "path\general\wave7_clean.dta", replace
***************************************************
**# OLA 8 *****************************************
***************************************************
use "path\data\klips08p.dta", clear
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_08  = p080104
replace cohorte_08 = .i if cohorte_08 == -1

gen cohorte5_08 = p080104
replace cohorte5_08 = .i if cohorte5_08 == -1

recode cohorte_08 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_08 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_08 = p080105
replace birth_month_08 = .i if birth_month_08 == -1
// missings en mes de nacimiento 
// rescatables para estimación gruesa 


***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_08   = p089021
replace male_sibs_08 = .i if male_sibs_08 == -1

gen female_sibs_08 = p089022
replace female_sibs_08 = .i if female_sibs_08 == -1

egen siblings_08 = rowtotal(male_sibs_08 female_sibs_08) if !missing(male_sibs_08) | !missing(female_sibs_08)  

gen seniority_08 = p089023
replace seniority_08 = .i if seniority_08 == -1
// 1 missing
replace siblings_08 = .i if siblings_08 == . & hwaveent == 8
// 144 missings
replace siblings_08 = .v if siblings_08 == . & hwaveent ==! 8 


***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_08 = p085501
replace edo_conyug_08 = .i if edo_conyug_08 == -1

gen change_edo_08 = p085502
replace change_edo_08 = .i if change_edo_08 == -1

gen type_changeedo_08 = p085504
replace type_changeedo_08 = .i if type_changeedo_08 == -1

gen y_change_08 = p085505
replace y_change_08 = .i if y_change_08 == -1
replace y_change_08 = .v if type_changeedo_08 ==! 1

gen m_change_08 = p085506
replace m_change_08 = .i if m_change_08 == -1
replace m_change_08 = .v if type_changeedo_08 ==! 1

gen unido_08 = 0
replace unido_08 = 1 if inrange(edo_conyug_08,2,5)

gen primer_matrimonio_08 = 0
replace primer_matrimonio_08 = 1 if unido_08 == 1 & type_changeedo_08 == 1 

tab primer_matrimonio_08, mi
// 285 matrimonios nuevos
tab primer_matrimonio_08 if hwaveent == 8 
// 133 de los que entraron 
tab primer_matrimonio_08 if inrange(hwaveent, 1,7) 
// 152 de los que ya seguíamos 
// quitamos falsos negativos por historial conyugal incompleto
replace primer_matrimonio_08 = .i if unido_08 == 1 & primer_matrimonio_08 == 0 & hwaveent == 8 
// 28 falsos negativos 
// los que entran casados pero no reportaron los cambios en el orden correcto 
replace primer_matrimonio_08 = .v if unido_08 == 1 & primer_matrimonio_08 == 0 & inrange(hwaveent, 1, 7)
// missing válido de a quienes ya les había ocurrido el evento en otra ola 


tab primer_matrimonio_08 unido_08, mi

***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_08 = 2005

gen b_cohort_08 = p080104
replace b_cohort_08 = .i if b_cohort_08 == -1

gen sex_08 = p080101
replace sex_08 = .i if sex_08 == -1

gen edu_08 = p080110
replace edu_08 = .i if edu_08 == -1

gen grad_08 = p080111
replace grad_08 = .i if grad_08 == -1

gen main_act_08 = p080202
replace main_act_08 = .i if main_act_08 == -1

gen edad_08 = p080107
replace edad_08 = .i if edad_08 == -1

gen wrkstatus_08 = p080314
replace wrkstatus_08 = .i if wrkstatus_08 == -1

gen wrkhrs_08 = p080315
replace wrkhrs_08 = .i if wrkhrs_08 == -1

gen ksco_08 = p080350
replace ksco_08 = .i if ksco_08 == -1


***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_08 = w08p_l
replace weight_l_08 = .i if weight_l_08 == -1

gen weight_c_08 = w08p_c
replace weight_c_08 = .i if weight_c_08 == -1

***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_08 = p089051 
label variable fathers_edu_08 "Educación máxima del padre reportada en la ola 8"
recode fathers_edu_08 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_08 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_08 fathers_edu_08

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_08 = p089053 
label variable mothers_edu_08 "Educación máxima de la madre reportada en la ola 8"
recode mothers_edu_08 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_08 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_08 mothers_edu_08


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p089055, mi
clonevar sosten_08 = p089055
label define sosten_08 ///
1 "Padre" ///
2 "Madre" 
label values sosten_08 sosten_08

replace sosten_08 = .i if sosten_08 == -1 

gen parents_activity_08 = p089059

// 143 missing values 
label define parents_activity_08 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_08 parents_activity_08


gen parents_ocupation_08 = p089064

************************************************
*** NSE A LA EDAD 14 ***************************
************************************************
clonevar nse14_08 = p089006 
label variable nse14_08 "Nivel Socioeconómico a los 14 (proxy. IOS)"
tab nse14_08, mi

***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_08 =p080114 
gen m_dropout_08 =p080115 

***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_08 sex_08 cohorte_08 cohorte5_08 edad_08 year_08 ///
birth_month_08 male_sibs_08 female_sibs_08 siblings_08 ///
edo_conyug_08 change_edo_08 type_changeedo_08 y_change_08 m_change_08 ///
primer_matrimonio_08 seniority_08 ///
edu_08 grad_08 main_act_08 wrkhrs_08 wrkstatus_08 ksco_08 ///
weight_l_08 weight_c_08 unido_08 fathers_edu_08 mothers_edu_08 hwaveent ///
sosten_08 parents_activity_08 parents_ocupation_08 ///
nse14_08 y_dropout_08 m_dropout_08


***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 8"
label variable b_cohort_08 "Cohorte de nacimiento en la ola 8"
label variable sex_08 "Sexo en la ola 8"
label variable cohorte_08 "Cohorte decenal en la ola 8"
label variable cohorte5_08 "Cohorte quinquenal en la ola 8"
label variable edad_08 "Edad en la ola 8"
label variable year_08 "Año de la encuesta en la ola 8"
label variable birth_month_08 "Mes de nacimiento en la ola 8"
label variable male_sibs_08 "Número de hermanos varones en la ola 8"
label variable female_sibs_08 "Número de hermanas mujeres en la ola 8"
label variable siblings_08 "Número total de hermanos en la ola 8"
label variable edo_conyug_08 "Estado conyugal en la ola 8"
label variable change_edo_08 "Cambio de estado conyugal en la ola 8"
label variable type_changeedo_08 "Tipo de cambio conyugal en la ola 8"
label variable y_change_08 "Año del cambio conyugal en la ola 8"
label variable m_change_08 "Mes del cambio conyugal en la ola 8"
label variable primer_matrimonio_08 "Ocurrencia de primer matrimonio en la ola 8"
label variable seniority_08 "Orden de nacimiento entre hermanos en la ola 8"
label variable edu_08 "Educación en la ola 8"
label variable grad_08 "Obtención de grado en la ola 8"
label variable main_act_08 "Actividad principal en la ola 8"
label variable wrkhrs_08 "Horas trabajadas en la ola 8"
label variable wrkstatus_08 "Estatus laboral en la ola 8"
label variable ksco_08 "Ocupación KSCO en la ola 8"
label variable weight_l_08 "Peso longitudinal en la ola 8"
label variable weight_c_08 "Peso transversal en la ola 8"

count 
tab primer_matrimonio_08 unido_08 if hwaveent == 8, mi
replace fathers_edu_08 = .i if fathers_edu_08 == -1
tab fathers_edu_08  if hwaveent == 8, mi
tab siblings_08 if hwaveent == 8, mi
tab nse14_08 if hwaveent == 8, mi
count if inrange(b_cohort_08, 1960, 1989)


save "path\general\wave8_clean.dta", replace
***************************************************
**#* OLA 9 **************************************
***************************************************

use "path\data\klips09p.dta", clear

***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_09  = p090104
replace cohorte_09 = .i if cohorte_09 == -1

gen cohorte5_09 = p090104
replace cohorte5_09 = .i if cohorte5_09 == -1

recode cohorte_09 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_09 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_09 = p090105
replace birth_month_09 = .i if birth_month_09 == -1
// uno perdido por mes de nacimiento

***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_09   = p099021
replace male_sibs_09 = .i if male_sibs_09 == -1

gen female_sibs_09 = p099022
replace female_sibs_09 = .i if female_sibs_09 == -1

egen siblings_09 = rowtotal(male_sibs_09 female_sibs_09) if !missing(male_sibs_09) | !missing(female_sibs_09)

gen seniority_09 = p099023
replace seniority_09 = .i if seniority_09 == -1

replace siblings_09 = .i if siblings_09 == . & hwaveent == 9
replace siblings_09 = .v if siblings_09 == . & hwaveent != 9
// 145 missings reales 

***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_09 = p095501
replace edo_conyug_09 = .i if edo_conyug_09 == -1

gen change_edo_09 = p095502
replace change_edo_09 = .i if change_edo_09 == -1

gen type_changeedo_09 = p095504
replace type_changeedo_09 = .i if type_changeedo_09 == -1

gen y_change_09 = p095505
replace y_change_09 = .i if y_change_09 == -1
replace y_change_09 = .v if type_changeedo_09 != 1

gen m_change_09 = p095506
replace m_change_09 = .i if m_change_09 == -1
replace m_change_09 = .v if type_changeedo_09 != 1

gen unido_09 = 0
replace unido_09 = 1 if inrange(edo_conyug_09,2,5)

gen primer_matrimonio_09 = 0
replace primer_matrimonio_09 = 1 if unido_09 == 1 & type_changeedo_09 == 1

replace primer_matrimonio_09 = .i if unido_09 == 1 & primer_matrimonio_09 == 0 & hwaveent == 9
replace primer_matrimonio_09 = .v if unido_09 == 1 & primer_matrimonio_09 == 0 & inrange(hwaveent, 1, 8)

tab primer_matrimonio_09 unido_09, mi
/// 23 falsos negativos 
// 298 eventos 


***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_09 = 2006

gen b_cohort_09 = p090104
replace b_cohort_09 = .i if b_cohort_09 == -1

gen sex_09 = p090101
replace sex_09 = .i if sex_09 == -1

gen edu_09 = p090110
replace edu_09 = .i if edu_09 == -1

gen grad_09 = p090111
replace grad_09 = .i if grad_09 == -1

gen main_act_09 = p090202
replace main_act_09 = .i if main_act_09 == -1

gen edad_09 = p090107
replace edad_09 = .i if edad_09 == -1

gen wrkstatus_09 = p090314
replace wrkstatus_09 = .i if wrkstatus_09 == -1

gen wrkhrs_09 = p090315
replace wrkhrs_09 = .i if wrkhrs_09 == -1

gen ksco_09 = p090350
replace ksco_09 = .i if ksco_09 == -1


***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_09 = w09p_l
replace weight_l_09 = .i if weight_l_09 == -1

gen weight_c_09 = w09p_c
replace weight_c_09 = .i if weight_c_09 == -1

***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_09 = p099051 
label variable fathers_edu_09 "Educación máxima del padre reportada en la ola 9"
recode fathers_edu_09 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_09 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_09 fathers_edu_09

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_09 = p099053 
label variable mothers_edu_09 "Educación máxima de la madre reportada en la ola 9"
recode mothers_edu_09 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_09 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_09 mothers_edu_09


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p099055, mi
clonevar sosten_09 = p099055
label define sosten_09 ///
1 "Padre" ///
2 "Madre" 
label values sosten_09 sosten_09

replace sosten_09 = .i if sosten_09 == -1 

gen parents_activity_09 = p099059

// 143 missing values 
label define parents_activity_09 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_09 parents_activity_09


gen parents_ocupation_09 = p099064

************************************************
*** NSE A LA EDAD 14 ***************************
************************************************
clonevar nse14_09 = p099006 
label variable nse14_09 "Nivel Socioeconómico a los 14 (proxy. IOS)"
tab nse14_09, mi
***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_09 =p090114 
gen m_dropout_09 =p090115 


***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_09 sex_09 cohorte_09 cohorte5_09 edad_09 year_09 ///
birth_month_09 male_sibs_09 female_sibs_09 siblings_09 ///
edo_conyug_09 change_edo_09 type_changeedo_09 y_change_09 m_change_09 ///
primer_matrimonio_09 seniority_09 ///
edu_09 grad_09 main_act_09 wrkhrs_09 wrkstatus_09 ksco_09 ///
weight_l_09 weight_c_09 unido_09 fathers_edu_09 mothers_edu_09 hwaveent ///
sosten_09 parents_activity_09 parents_ocupation_09 ///
nse14_09 y_dropout_09 m_dropout_09


***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 9"
label variable b_cohort_09 "Cohorte de nacimiento en la ola 9"
label variable sex_09 "Sexo en la ola 9"
label variable cohorte_09 "Cohorte decenal en la ola 9"
label variable cohorte5_09 "Cohorte quinquenal en la ola 9"
label variable edad_09 "Edad en la ola 9"
label variable year_09 "Año de la encuesta en la ola 9"
label variable birth_month_09 "Mes de nacimiento en la ola 9"
label variable male_sibs_09 "Número de hermanos varones en la ola 9"
label variable female_sibs_09 "Número de hermanas mujeres en la ola 9"
label variable siblings_09 "Número total de hermanos en la ola 9"
label variable edo_conyug_09 "Estado conyugal en la ola 9"
label variable change_edo_09 "Cambio de estado conyugal en la ola 9"
label variable type_changeedo_09 "Tipo de cambio conyugal en la ola 9"
label variable y_change_09 "Año del cambio conyugal en la ola 9"
label variable m_change_09 "Mes del cambio conyugal en la ola 9"
label variable primer_matrimonio_09 "Ocurrencia de primer matrimonio en la ola 9"
label variable seniority_09 "Orden de nacimiento entre hermanos en la ola 9"
label variable edu_09 "Educación en la ola 9"
label variable grad_09 "Obtención de grado en la ola 9"
label variable main_act_09 "Actividad principal en la ola 9"
label variable wrkhrs_09 "Horas trabajadas en la ola 9"
label variable wrkstatus_09 "Estatus laboral en la ola 9"
label variable ksco_09 "Ocupación KSCO en la ola 9"
label variable weight_l_09 "Peso longitudinal en la ola 9"
label variable weight_c_09 "Peso transversal en la ola 9"

count 
tab primer_matrimonio_09 unido_09 if hwaveent == 9, mi
replace fathers_edu_09 = .i if fathers_edu_09 == -1
tab fathers_edu_09  if hwaveent == 9, mi
tab siblings_09 if hwaveent == 9, mi
tab nse14_09 if hwaveent == 9, mi
count if inrange(b_cohort_09, 1960, 1989)


save "path\general\wave9_clean.dta", replace
***************************************************
**#* OLA 10 **************************************
***************************************************

use "path\data\klips10p.dta", clear

***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_10  = p100104
replace cohorte_10 = .i if cohorte_10 == -1

gen cohorte5_10 = p100104
replace cohorte5_10 = .i if cohorte5_10 == -1

recode cohorte_10 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_10 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_10 = p100105
replace birth_month_10 = .i if birth_month_10 == -1
// 2 missings reales 

***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_10   = p109021
replace male_sibs_10 = .i if male_sibs_10 == -1

gen female_sibs_10 = p109022
replace female_sibs_10 = .i if female_sibs_10 == -1

egen siblings_10 = rowtotal(male_sibs_10 female_sibs_10) if !missing(male_sibs_10) | !missing(female_sibs_10)

gen seniority_10 = p109023
replace seniority_10 = .i if seniority_10 == -1

replace siblings_10 = .i if siblings_10 == . & hwaveent == 10
replace siblings_10 = .v if siblings_10 == . & hwaveent != 10
// 122 missings reales 

***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_10 = p105501
replace edo_conyug_10 = .i if edo_conyug_10 == -1

gen change_edo_10 = p105502
replace change_edo_10 = .i if change_edo_10 == -1

gen type_changeedo_10 = p105504
replace type_changeedo_10 = .i if type_changeedo_10 == -1

gen y_change_10 = p105505
replace y_change_10 = .i if y_change_10 == -1
replace y_change_10 = .v if type_changeedo_10 != 1

gen m_change_10 = p105506
replace m_change_10 = .i if m_change_10 == -1
replace m_change_10 = .v if type_changeedo_10 != 1

gen unido_10 = 0
replace unido_10 = 1 if inrange(edo_conyug_10,2,5)

gen primer_matrimonio_10 = 0
replace primer_matrimonio_10 = 1 if unido_10 == 1 & type_changeedo_10 == 1

replace primer_matrimonio_10 = .i if unido_10 == 1 & primer_matrimonio_10 == 0 & hwaveent == 10
replace primer_matrimonio_10 = .v if unido_10 == 1 & primer_matrimonio_10 == 0 & inrange(hwaveent, 1, 9)

tab primer_matrimonio_10 unido_10, mi

// 9 falsos negativos 

***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_10 = 2007

gen b_cohort_10 = p100104
replace b_cohort_10 = .i if b_cohort_10 == -1

gen sex_10 = p100101
replace sex_10 = .i if sex_10 == -1

gen edu_10 = p100110
replace edu_10 = .i if edu_10 == -1

gen grad_10 = p100111
replace grad_10 = .i if grad_10 == -1

gen main_act_10 = p100202
replace main_act_10 = .i if main_act_10 == -1

gen edad_10 = p100107
replace edad_10 = .i if edad_10 == -1

gen wrkstatus_10 = p100314
replace wrkstatus_10 = .i if wrkstatus_10 == -1

gen wrkhrs_10 = p100315
replace wrkhrs_10 = .i if wrkhrs_10 == -1

gen ksco_10 = p100350
replace ksco_10 = .i if ksco_10 == -1


***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_10 = w10p_l
replace weight_l_10 = .i if weight_l_10 == -1

gen weight_c_10 = w10p_c
replace weight_c_10 = .i if weight_c_10 == -1


***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_10 = p109051 
label variable fathers_edu_10 "Educación máxima del padre reportada en la ola 10"
recode fathers_edu_10 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_10 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_10 fathers_edu_10

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_10 = p109053 
label variable mothers_edu_10 "Educación máxima de la madre reportada en la ola 10"
recode mothers_edu_10 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_10 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_10 mothers_edu_10


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p109055, mi
clonevar sosten_10 = p109055
label define sosten_10 ///
1 "Padre" ///
2 "Madre" 
label values sosten_10 sosten_10

replace sosten_10 = .i if sosten_10 == -1 

gen parents_activity_10 = p109059

// 143 missing values 
label define parents_activity_10 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_10 parents_activity_10


gen parents_ocupation_10 = p109064

************************************************
*** NSE A LA EDAD 14 ***************************
************************************************
clonevar nse14_10 = p109006 
label variable nse14_10 "Nivel Socioeconómico a los 14 (proxy. IOS)"
tab nse14_10, mi

***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_10 =p100114 
gen m_dropout_10 =p100115 

***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_10 sex_10 cohorte_10 cohorte5_10 edad_10 year_10 ///
birth_month_10 male_sibs_10 female_sibs_10 siblings_10 ///
edo_conyug_10 change_edo_10 type_changeedo_10 y_change_10 m_change_10 ///
primer_matrimonio_10 seniority_10 ///
edu_10 grad_10 main_act_10 wrkhrs_10 wrkstatus_10 ksco_10 ///
weight_l_10 weight_c_10 unido_10 fathers_edu_10 mothers_edu_10 hwaveent ///
sosten_10 parents_activity_10 parents_ocupation_10 ///
nse14_10 y_dropout_10 m_dropout_10

***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 10"
label variable b_cohort_10 "Cohorte de nacimiento en la ola 10"
label variable sex_10 "Sexo en la ola 10"
label variable cohorte_10 "Cohorte decenal en la ola 10"
label variable cohorte5_10 "Cohorte quinquenal en la ola 10"
label variable edad_10 "Edad en la ola 10"
label variable year_10 "Año de la encuesta en la ola 10"
label variable birth_month_10 "Mes de nacimiento en la ola 10"
label variable male_sibs_10 "Número de hermanos varones en la ola 10"
label variable female_sibs_10 "Número de hermanas mujeres en la ola 10"
label variable siblings_10 "Número total de hermanos en la ola 10"
label variable edo_conyug_10 "Estado conyugal en la ola 10"
label variable change_edo_10 "Cambio de estado conyugal en la ola 10"
label variable type_changeedo_10 "Tipo de cambio conyugal en la ola 10"
label variable y_change_10 "Año del cambio conyugal en la ola 10"
label variable m_change_10 "Mes del cambio conyugal en la ola 10"
label variable primer_matrimonio_10 "Ocurrencia de primer matrimonio en la ola 10"
label variable seniority_10 "Orden de nacimiento entre hermanos en la ola 10"
label variable edu_10 "Educación en la ola 10"
label variable grad_10 "Obtención de grado en la ola 10"
label variable main_act_10 "Actividad principal en la ola 10"
label variable wrkhrs_10 "Horas trabajadas en la ola 10"
label variable wrkstatus_10 "Estatus laboral en la ola 10"
label variable ksco_10 "Ocupación KSCO en la ola 10"
label variable weight_l_10 "Peso longitudinal en la ola 10"
label variable weight_c_10 "Peso transversal en la ola 10"

count 
tab primer_matrimonio_10 unido_10 if hwaveent ==10, mi
replace fathers_edu_10 = .i if fathers_edu_10 == -1
tab fathers_edu_10  if hwaveent ==10, mi
tab siblings_10 if hwaveent ==10, mi
tab nse14_10 if hwaveent ==10, mi
count if inrange(b_cohort_10, 1960, 1989)


save "path\general\wave10_clean.dta", replace
***************************************************
**#* OLA 11 **************************************
***************************************************

use "path\data\klips11p.dta", clear

***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_11  = p110104
replace cohorte_11 = .i if cohorte_11 == -1

gen cohorte5_11 = p110104
replace cohorte5_11 = .i if cohorte5_11 == -1

recode cohorte_11 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_11 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_11 = p110105
replace birth_month_11 = .i if birth_month_11 == -1


***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_11   = p119021
replace male_sibs_11 = .i if male_sibs_11 == -1

gen female_sibs_11 = p119022
replace female_sibs_11 = .i if female_sibs_11 == -1

egen siblings_11 = rowtotal(male_sibs_11 female_sibs_11) if !missing(male_sibs_11) | !missing(female_sibs_11)

gen seniority_11 = p119023
replace seniority_11 = .i if seniority_11 == -1

replace siblings_11 = .i if siblings_11 == . & hwaveent == 11
replace siblings_11 = .v if siblings_11 == . & hwaveent != 11


***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_11 = p115501
replace edo_conyug_11 = .i if edo_conyug_11 == -1

gen change_edo_11 = p115502
replace change_edo_11 = .i if change_edo_11 == -1

gen type_changeedo_11 = p115504
replace type_changeedo_11 = .i if type_changeedo_11 == -1

gen y_change_11 = p115505
replace y_change_11 = .i if y_change_11 == -1
replace y_change_11 = .v if type_changeedo_11 != 1

gen m_change_11 = p115506
replace m_change_11 = .i if m_change_11 == -1
replace m_change_11 = .v if type_changeedo_11 != 1

gen unido_11 = 0
replace unido_11 = 1 if inrange(edo_conyug_11,2,5)

gen primer_matrimonio_11 = 0
replace primer_matrimonio_11 = 1 if unido_11 == 1 & type_changeedo_11 == 1

replace primer_matrimonio_11 = .i if unido_11 == 1 & primer_matrimonio_11 == 0 & hwaveent == 11
replace primer_matrimonio_11 = .v if unido_11 == 1 & primer_matrimonio_11 == 0 & inrange(hwaveent, 1, 10)

tab primer_matrimonio_11 unido_11, mi


***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_11 = 2008

gen b_cohort_11 = p110104
replace b_cohort_11 = .i if b_cohort_11 == -1

gen sex_11 = p110101
replace sex_11 = .i if sex_11 == -1

gen edu_11 = p110110
replace edu_11 = .i if edu_11 == -1

gen grad_11 = p110111
replace grad_11 = .i if grad_11 == -1

gen main_act_11 = p110202
replace main_act_11 = .i if main_act_11 == -1

gen edad_11 = p110107
replace edad_11 = .i if edad_11 == -1

gen wrkstatus_11 = p110314
replace wrkstatus_11 = .i if wrkstatus_11 == -1

gen wrkhrs_11 = p110315
replace wrkhrs_11 = .i if wrkhrs_11 == -1

gen ksco_11 = p110350
replace ksco_11 = .i if ksco_11 == -1


***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_11 = w11p_l
replace weight_l_11 = .i if weight_l_11 == -1

gen weight_c_11 = w11p_c
replace weight_c_11 = .i if weight_c_11 == -1

***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_11 = p119051 
label variable fathers_edu_11 "Educación máxima del padre reportada en la ola 11"
recode fathers_edu_11 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_11 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_11 fathers_edu_11

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_11 = p119053 
label variable mothers_edu_11 "Educación máxima de la madre reportada en la ola 11"
recode mothers_edu_11 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_11 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_11 mothers_edu_11


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p119055, mi
clonevar sosten_11 = p119055
label define sosten_11 ///
1 "Padre" ///
2 "Madre" 
label values sosten_11 sosten_11

replace sosten_11 = .i if sosten_11 == -1 

gen parents_activity_11 = p119059

// 143 missing values 
label define parents_activity_11 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_11 parents_activity_11


gen parents_ocupation_11 = p119064

************************************************
*** NSE A LA EDAD 14 ***************************
************************************************
clonevar nse14_11 = p119006 
label variable nse14_11 "Nivel Socioeconómico a los 14 (proxy. IOS)"
tab nse14_11, mi

***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_11 =p110114 
gen m_dropout_11 =p110115 

***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_11 sex_11 cohorte_11 cohorte5_11 edad_11 year_11 ///
birth_month_11 male_sibs_11 female_sibs_11 siblings_11 ///
edo_conyug_11 change_edo_11 type_changeedo_11 y_change_11 m_change_11 ///
primer_matrimonio_11 seniority_11 ///
edu_11 grad_11 main_act_11 wrkhrs_11 wrkstatus_11 ksco_11 ///
weight_l_11 weight_c_11 unido_11 fathers_edu_11 mothers_edu_11 hwaveent ///
sosten_11 parents_activity_11 parents_ocupation_11 ///
nse14_11 y_dropout_11 m_dropout_11

***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 11"
label variable b_cohort_11 "Cohorte de nacimiento en la ola 11"
label variable sex_11 "Sexo en la ola 11"
label variable cohorte_11 "Cohorte decenal en la ola 11"
label variable cohorte5_11 "Cohorte quinquenal en la ola 11"
label variable edad_11 "Edad en la ola 11"
label variable year_11 "Año de la encuesta en la ola 11"
label variable birth_month_11 "Mes de nacimiento en la ola 11"
label variable male_sibs_11 "Número de hermanos varones en la ola 11"
label variable female_sibs_11 "Número de hermanas mujeres en la ola 11"
label variable siblings_11 "Número total de hermanos en la ola 11"
label variable edo_conyug_11 "Estado conyugal en la ola 11"
label variable change_edo_11 "Cambio de estado conyugal en la ola 11"
label variable type_changeedo_11 "Tipo de cambio conyugal en la ola 11"
label variable y_change_11 "Año del cambio conyugal en la ola 11"
label variable m_change_11 "Mes del cambio conyugal en la ola 11"
label variable primer_matrimonio_11 "Ocurrencia de primer matrimonio en la ola 11"
label variable seniority_11 "Orden de nacimiento entre hermanos en la ola 11"
label variable edu_11 "Educación en la ola 11"
label variable grad_11 "Obtención de grado en la ola 11"
label variable main_act_11 "Actividad principal en la ola 11"
label variable wrkhrs_11 "Horas trabajadas en la ola 11"
label variable wrkstatus_11 "Estatus laboral en la ola 11"
label variable ksco_11 "Ocupación KSCO en la ola 11"
label variable weight_l_11 "Peso longitudinal en la ola 11"
label variable weight_c_11 "Peso transversal en la ola 11"

count 
tab primer_matrimonio_11 unido_11 if hwaveent ==11, mi
replace fathers_edu_11 = .i if fathers_edu_11 == -1
tab fathers_edu_11  if hwaveent ==11, mi
tab siblings_11 if hwaveent ==11, mi
tab nse14_11 if hwaveent ==11, mi
count if inrange(b_cohort_11, 1960, 1989)

save "path\general\wave11_clean.dta", replace


***************************************************
**#* OLA 12  **************************************
***************************************************
use "path\data\klips12p.dta", clear
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_12  = p120104
replace cohorte_12 = .i if cohorte_12 == -1

gen cohorte5_12 = p120104
replace cohorte5_12 = .i if cohorte5_12 == -1

recode cohorte_12 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_12 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_12 = p120105
replace birth_month_12 = .i if birth_month_12 == -1
// 3 missings reales 

***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_12   = p129021
replace male_sibs_12 = .i if male_sibs_12 == -1

gen female_sibs_12 = p129022
replace female_sibs_12 = .i if female_sibs_12 == -1

egen siblings_12 = rowtotal(male_sibs_12 female_sibs_12) if !missing(male_sibs_12) | !missing(female_sibs_12)

gen seniority_12 = p129023
replace seniority_12 = .i if seniority_12 == -1

replace siblings_12 = .i if siblings_12 == . & hwaveent == 12
replace siblings_12 = .v if siblings_12 == . & hwaveent != 12

/// 139 missings reales 

***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_12 = p125501
replace edo_conyug_12 = .i if edo_conyug_12 == -1

gen change_edo_12 = p125502
replace change_edo_12 = .i if change_edo_12 == -1

gen type_changeedo_12 = p125504
replace type_changeedo_12 = .i if type_changeedo_12 == -1

gen y_change_12 = p125505
replace y_change_12 = .i if y_change_12 == -1
replace y_change_12 = .v if type_changeedo_12 != 1

gen m_change_12 = p125506
replace m_change_12 = .i if m_change_12 == -1
replace m_change_12 = .v if type_changeedo_12 != 1

gen unido_12 = 0
replace unido_12 = 1 if inrange(edo_conyug_12,2,5)

gen primer_matrimonio_12 = 0
replace primer_matrimonio_12 = 1 if unido_12 == 1 & type_changeedo_12 == 1

replace primer_matrimonio_12 = .i if unido_12 == 1 & primer_matrimonio_12 == 0 & hwaveent == 12
replace primer_matrimonio_12 = .v if unido_12 == 1 & primer_matrimonio_12 == 0 & inrange(hwaveent, 1, 11)

tab primer_matrimonio_12 unido_12, mi
// 14 missings reales 

***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_12 = 2009

gen b_cohort_12 = p120104
replace b_cohort_12 = .i if b_cohort_12 == -1

gen sex_12 = p120101
replace sex_12 = .i if sex_12 == -1

gen edu_12 = p120110
replace edu_12 = .i if edu_12 == -1

gen grad_12 = p120111
replace grad_12 = .i if grad_12 == -1

gen main_act_12 = p120202
replace main_act_12 = .i if main_act_12 == -1

gen edad_12 = p120107
replace edad_12 = .i if edad_12 == -1

gen wrkstatus_12 = p120314
replace wrkstatus_12 = .i if wrkstatus_12 == -1

gen wrkhrs_12 = p120315
replace wrkhrs_12 = .i if wrkhrs_12 == -1

gen ksco_12 = p120350
replace ksco_12 = .i if ksco_12 == -1


***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_12 = w12p_l
replace weight_l_12 = .i if weight_l_12 == -1

gen weight_c_12 = w12p_c
replace weight_c_12 = .i if weight_c_12 == -1

***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_12 = p129051 
label variable fathers_edu_12 "Educación máxima del padre reportada en la ola 12"
recode fathers_edu_12 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_12 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_12 fathers_edu_12

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_12 = p129053 
label variable mothers_edu_12 "Educación máxima de la madre reportada en la ola 12"
recode mothers_edu_12 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_12 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_12 mothers_edu_12


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p129055, mi
clonevar sosten_12 = p129055
label define sosten_12 ///
1 "Padre" ///
2 "Madre" 
label values sosten_12 sosten_12

replace sosten_12 = .i if sosten_12 == -1 

gen parents_activity_12 = p129059

// 143 missing values 
label define parents_activity_12 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_12 parents_activity_12


gen parents_ocupation_12 = p129064

************************************************
*** NSE A LA EDAD 14 ***************************
************************************************
clonevar nse14_12 = p129006 
label variable nse14_12 "Nivel Socioeconómico a los 14 (proxy. IOS)"
tab nse14_12, mi
***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_12 =p120114 
gen m_dropout_12 =p120115 

***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_12 sex_12 cohorte_12 cohorte5_12 edad_12 year_12 ///
birth_month_12 male_sibs_12 female_sibs_12 siblings_12 ///
edo_conyug_12 change_edo_12 type_changeedo_12 y_change_12 m_change_12 ///
primer_matrimonio_12 seniority_12 ///
edu_12 grad_12 main_act_12 wrkhrs_12 wrkstatus_12 ksco_12 ///
weight_l_12 weight_c_12 unido_12 fathers_edu_12 mothers_edu_12 hwaveent ///
sosten_12 parents_activity_12 parents_ocupation_12 ///
nse14_12 y_dropout_12 m_dropout_12

***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 12"
label variable b_cohort_12 "Cohorte de nacimiento en la ola 12"
label variable sex_12 "Sexo en la ola 12"
label variable cohorte_12 "Cohorte decenal en la ola 12"
label variable cohorte5_12 "Cohorte quinquenal en la ola 12"
label variable edad_12 "Edad en la ola 12"
label variable year_12 "Año de la encuesta en la ola 12"
label variable birth_month_12 "Mes de nacimiento en la ola 12"
label variable male_sibs_12 "Número de hermanos varones en la ola 12"
label variable female_sibs_12 "Número de hermanas mujeres en la ola 12"
label variable siblings_12 "Número total de hermanos en la ola 12"
label variable edo_conyug_12 "Estado conyugal en la ola 12"
label variable change_edo_12 "Cambio de estado conyugal en la ola 12"
label variable type_changeedo_12 "Tipo de cambio conyugal en la ola 12"
label variable y_change_12 "Año del cambio conyugal en la ola 12"
label variable m_change_12 "Mes del cambio conyugal en la ola 12"
label variable primer_matrimonio_12 "Ocurrencia de primer matrimonio en la ola 12"
label variable seniority_12 "Orden de nacimiento entre hermanos en la ola 12"
label variable edu_12 "Educación en la ola 12"
label variable grad_12 "Obtención de grado en la ola 12"
label variable main_act_12 "Actividad principal en la ola 12"
label variable wrkhrs_12 "Horas trabajadas en la ola 12"
label variable wrkstatus_12 "Estatus laboral en la ola 12"
label variable ksco_12 "Ocupación KSCO en la ola 12"
label variable weight_l_12 "Peso longitudinal en la ola 12"
label variable weight_c_12 "Peso transversal en la ola 12"

count
tab primer_matrimonio_12 unido_12 if hwaveent == 12, mi
replace fathers_edu_12 = .i if fathers_edu_12 == -1
tab fathers_edu_12 if hwaveent == 12, mi
tab siblings_12 if hwaveent == 12, mi
tab nse14_12 if hwaveent == 12, mi
count if inrange(b_cohort_12, 1960, 1989)
save "path\general\wave11_clean.dta", replace


***************************************************
**#* OLA 13 **************************************
***************************************************
use "path\data\klips13p.dta", clear
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_13  = p130104
replace cohorte_13 = .i if cohorte_13 == -1

gen cohorte5_13 = p130104
replace cohorte5_13 = .i if cohorte5_13 == -1

recode cohorte_13 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_13 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_13 = p130105
replace birth_month_13 = .i if birth_month_13 == -1
// 2 missings reales 

***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_13   = p139021
replace male_sibs_13 = .i if male_sibs_13 == -1

gen female_sibs_13 = p139022
replace female_sibs_13 = .i if female_sibs_13 == -1

egen siblings_13 = rowtotal(male_sibs_13 female_sibs_13) if !missing(male_sibs_13) | !missing(female_sibs_13)

gen seniority_13 = p139023
replace seniority_13 = .i if seniority_13 == -1

replace siblings_13 = .i if siblings_13 == . & hwaveent == 13
replace siblings_13 = .v if siblings_13 == . & hwaveent != 13
// 184 missings reales 

***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_13 = p135501
replace edo_conyug_13 = .i if edo_conyug_13 == -1

gen change_edo_13 = p135502
replace change_edo_13 = .i if change_edo_13 == -1

gen type_changeedo_13 = p135504
replace type_changeedo_13 = .i if type_changeedo_13 == -1

gen y_change_13 = p135505
replace y_change_13 = .i if y_change_13 == -1
replace y_change_13 = .v if type_changeedo_13 != 1

gen m_change_13 = p135506
replace m_change_13 = .i if m_change_13 == -1
replace m_change_13 = .v if type_changeedo_13 != 1

gen unido_13 = 0
replace unido_13 = 1 if inrange(edo_conyug_13,2,5)

gen primer_matrimonio_13 = 0
replace primer_matrimonio_13 = 1 if unido_13 == 1 & type_changeedo_13 == 1

replace primer_matrimonio_13 = .i if unido_13 == 1 & primer_matrimonio_13 == 0 & hwaveent == 13
replace primer_matrimonio_13 = .v if unido_13 == 1 & primer_matrimonio_13 == 0 & inrange(hwaveent, 1, 12)

tab primer_matrimonio_13 unido_13, mi

// 39 falsos negativos
// recuerda que estos son por historial conyugal incompleto / inconsistente 

***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_13 = 2010

gen b_cohort_13 = p130104
replace b_cohort_13 = .i if b_cohort_13 == -1

gen sex_13 = p130101
replace sex_13 = .i if sex_13 == -1

gen edu_13 = p130110
replace edu_13 = .i if edu_13 == -1

gen grad_13 = p130111
replace grad_13 = .i if grad_13 == -1

gen main_act_13 = p130202
replace main_act_13 = .i if main_act_13 == -1

gen edad_13 = p130107
replace edad_13 = .i if edad_13 == -1

gen wrkstatus_13 = p130314
replace wrkstatus_13 = .i if wrkstatus_13 == -1

gen wrkhrs_13 = p130315
replace wrkhrs_13 = .i if wrkhrs_13 == -1

gen ksco_13 = p130350
replace ksco_13 = .i if ksco_13 == -1


***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_13 = w13p_l
replace weight_l_13 = .i if weight_l_13 == -1

gen weight_c_13 = w13p_c
replace weight_c_13 = .i if weight_c_13 == -1
***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_13 = p139051 
label variable fathers_edu_13 "Educación máxima del padre reportada en la ola 13"
recode fathers_edu_13 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_13 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_13 fathers_edu_13

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_13 = p139053 
label variable mothers_edu_13 "Educación máxima de la madre reportada en la ola 13"
recode mothers_edu_13 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_13 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_13 mothers_edu_13


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p139055, mi
clonevar sosten_13 = p139055
label define sosten_13 ///
1 "Padre" ///
2 "Madre" 
label values sosten_13 sosten_13

replace sosten_13 = .i if sosten_13 == -1 

gen parents_activity_13 = p139059

// 143 missing values 
label define parents_activity_13 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_13 parents_activity_13


gen parents_ocupation_13 = p139064

************************************************
*** NSE A LA EDAD 14 ***************************
************************************************
clonevar nse14_13 = p139006 
label variable nse14_13 "Nivel Socioeconómico a los 14 (proxy. IOS)"
tab nse14_13, mi
***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_13 =p130114 
gen m_dropout_13 =p130115 

***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_13 sex_13 cohorte_13 cohorte5_13 edad_13 year_13 ///
birth_month_13 male_sibs_13 female_sibs_13 siblings_13 ///
edo_conyug_13 change_edo_13 type_changeedo_13 y_change_13 m_change_13 ///
primer_matrimonio_13 seniority_13 ///
edu_13 grad_13 main_act_13 wrkhrs_13 wrkstatus_13 ksco_13 ///
weight_l_13 weight_c_13 unido_13 fathers_edu_13 mothers_edu_13 hwaveent ///
sosten_13 parents_activity_13 parents_ocupation_13 ///
nse14_13 y_dropout_13 m_dropout_13


***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 13"
label variable b_cohort_13 "Cohorte de nacimiento en la ola 13"
label variable sex_13 "Sexo en la ola 13"
label variable cohorte_13 "Cohorte decenal en la ola 13"
label variable cohorte5_13 "Cohorte quinquenal en la ola 13"
label variable edad_13 "Edad en la ola 13"
label variable year_13 "Año de la encuesta en la ola 13"
label variable birth_month_13 "Mes de nacimiento en la ola 13"
label variable male_sibs_13 "Número de hermanos varones en la ola 13"
label variable female_sibs_13 "Número de hermanas mujeres en la ola 13"
label variable siblings_13 "Número total de hermanos en la ola 13"
label variable edo_conyug_13 "Estado conyugal en la ola 13"
label variable change_edo_13 "Cambio de estado conyugal en la ola 13"
label variable type_changeedo_13 "Tipo de cambio conyugal en la ola 13"
label variable y_change_13 "Año del cambio conyugal en la ola 13"
label variable m_change_13 "Mes del cambio conyugal en la ola 13"
label variable primer_matrimonio_13 "Ocurrencia de primer matrimonio en la ola 13"
label variable seniority_13 "Orden de nacimiento entre hermanos en la ola 13"
label variable edu_13 "Educación en la ola 13"
label variable grad_13 "Obtención de grado en la ola 13"
label variable main_act_13 "Actividad principal en la ola 13"
label variable wrkhrs_13 "Horas trabajadas en la ola 13"
label variable wrkstatus_13 "Estatus laboral en la ola 13"
label variable ksco_13 "Ocupación KSCO en la ola 13"
label variable weight_l_13 "Peso longitudinal en la ola 13"
label variable weight_c_13 "Peso transversal en la ola 13"


count
tab primer_matrimonio_13 unido_13 if hwaveent == 13, mi
replace fathers_edu_13 = .i if fathers_edu_13 == -1
tab fathers_edu_13 if hwaveent == 13, mi
tab siblings_13 if hwaveent == 13, mi
tab nse14_13 if hwaveent == 13, mi
count if inrange(b_cohort_13, 1960, 1989)


save "path\general\wave13_clean.dta", replace


***************************************************
**#* OLA 14 **************************************
***************************************************
use "path\data\klips14p.dta", clear
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_14  = p140104
replace cohorte_14 = .i if cohorte_14 == -1

gen cohorte5_14 = p140104
replace cohorte5_14 = .i if cohorte5_14 == -1

recode cohorte_14 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_14 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_14 = p140105
replace birth_month_14 = .i if birth_month_14 == -1
// 2 missings reales 

***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_14   = p149021
replace male_sibs_14 = .i if male_sibs_14 == -1

gen female_sibs_14 = p149022
replace female_sibs_14 = .i if female_sibs_14 == -1

egen siblings_14 = rowtotal(male_sibs_14 female_sibs_14) if !missing(male_sibs_14) | !missing(female_sibs_14)

gen seniority_14 = p149023
replace seniority_14 = .i if seniority_14 == -1

replace siblings_14 = .i if siblings_14 == . & hwaveent == 14
replace siblings_14 = .v if siblings_14 == . & hwaveent != 14
// 450 datos nuevos
// 0 missings reales

***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_14 = p145501
replace edo_conyug_14 = .i if edo_conyug_14 == -1

gen change_edo_14 = p145502
replace change_edo_14 = .i if change_edo_14 == -1

gen type_changeedo_14 = p145504
replace type_changeedo_14 = .i if type_changeedo_14 == -1

gen y_change_14 = p145505
replace y_change_14 = .i if y_change_14 == -1
replace y_change_14 = .v if type_changeedo_14 != 1

gen m_change_14 = p145506
replace m_change_14 = .i if m_change_14 == -1
replace m_change_14 = .v if type_changeedo_14 != 1

gen unido_14 = 0
replace unido_14 = 1 if inrange(edo_conyug_14,2,5)

gen primer_matrimonio_14 = 0
replace primer_matrimonio_14 = 1 if unido_14 == 1 & type_changeedo_14 == 1

replace primer_matrimonio_14 = .i if unido_14 == 1 & primer_matrimonio_14 == 0 & hwaveent == 14
replace primer_matrimonio_14 = .v if unido_14 == 1 & primer_matrimonio_14 == 0 & inrange(hwaveent, 1, 13)

tab primer_matrimonio_14 unido_14, mi
// 13 falsos negativos 

***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_14 = 2011

gen b_cohort_14 = p140104
replace b_cohort_14 = .i if b_cohort_14 == -1

gen sex_14 = p140101
replace sex_14 = .i if sex_14 == -1

gen edu_14 = p140110
replace edu_14 = .i if edu_14 == -1

gen grad_14 = p140111
replace grad_14 = .i if grad_14 == -1

gen main_act_14 = p140202
replace main_act_14 = .i if main_act_14 == -1

gen edad_14 = p140107
replace edad_14 = .i if edad_14 == -1

gen wrkstatus_14 = p140314
replace wrkstatus_14 = .i if wrkstatus_14 == -1

gen wrkhrs_14 = p140315
replace wrkhrs_14 = .i if wrkhrs_14 == -1

gen ksco_14 = p140350
replace ksco_14 = .i if ksco_14 == -1


***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_14 = w14p_l
replace weight_l_14 = .i if weight_l_14 == -1

gen weight_c_14 = w14p_c
replace weight_c_14 = .i if weight_c_14 == -1

***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_14 = p149051 
label variable fathers_edu_14 "Educación máxima del padre reportada en la ola 14"
recode fathers_edu_14 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_14 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_14 fathers_edu_14

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_14 = p149053 
label variable mothers_edu_14 "Educación máxima de la madre reportada en la ola 14"
recode mothers_edu_14 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_14 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_14 mothers_edu_14


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p149055, mi
clonevar sosten_14 = p149055
label define sosten_14 ///
1 "Padre" ///
2 "Madre" 
label values sosten_14 sosten_14

replace sosten_14 = .i if sosten_14 == -1 

gen parents_activity_14 = p149059

// 143 missing values 
label define parents_activity_14 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_14 parents_activity_14


gen parents_ocupation_14 = p149064

************************************************
*** NSE A LA EDAD 14 ***************************
************************************************
clonevar nse14_14 = p149006 
label variable nse14_14 "Nivel Socioeconómico a los 14 (proxy. IOS)"
tab nse14_14, mi
***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_14 =p140114 
gen m_dropout_14 =p140115 

***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_14 sex_14 cohorte_14 cohorte5_14 edad_14 year_14 ///
birth_month_14 male_sibs_14 female_sibs_14 siblings_14 ///
edo_conyug_14 change_edo_14 type_changeedo_14 y_change_14 m_change_14 ///
primer_matrimonio_14 seniority_14 ///
edu_14 grad_14 main_act_14 wrkhrs_14 wrkstatus_14 ksco_14 ///
weight_l_14 weight_c_14 unido_14 fathers_edu_14 mothers_edu_14 hwaveent ///
sosten_14 parents_activity_14 parents_ocupation_14 ///
nse14_14 y_dropout_14 m_dropout_14
***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 14"
label variable b_cohort_14 "Cohorte de nacimiento en la ola 14"
label variable sex_14 "Sexo en la ola 14"
label variable cohorte_14 "Cohorte decenal en la ola 14"
label variable cohorte5_14 "Cohorte quinquenal en la ola 14"
label variable edad_14 "Edad en la ola 14"
label variable year_14 "Año de la encuesta en la ola 14"
label variable birth_month_14 "Mes de nacimiento en la ola 14"
label variable male_sibs_14 "Número de hermanos varones en la ola 14"
label variable female_sibs_14 "Número de hermanas mujeres en la ola 14"
label variable siblings_14 "Número total de hermanos en la ola 14"
label variable edo_conyug_14 "Estado conyugal en la ola 14"
label variable change_edo_14 "Cambio de estado conyugal en la ola 14"
label variable type_changeedo_14 "Tipo de cambio conyugal en la ola 14"
label variable y_change_14 "Año del cambio conyugal en la ola 14"
label variable m_change_14 "Mes del cambio conyugal en la ola 14"
label variable primer_matrimonio_14 "Ocurrencia de primer matrimonio en la ola 14"
label variable seniority_14 "Orden de nacimiento entre hermanos en la ola 14"
label variable edu_14 "Educación en la ola 14"
label variable grad_14 "Obtención de grado en la ola 14"
label variable main_act_14 "Actividad principal en la ola 14"
label variable wrkhrs_14 "Horas trabajadas en la ola 14"
label variable wrkstatus_14 "Estatus laboral en la ola 14"
label variable ksco_14 "Ocupación KSCO en la ola 14"
label variable weight_l_14 "Peso longitudinal en la ola 14"
label variable weight_c_14 "Peso transversal en la ola 14"

count
tab primer_matrimonio_14 unido_14 if hwaveent == 14, mi
replace fathers_edu_14 = .i if fathers_edu_14 == -1
tab fathers_edu_14 if hwaveent == 14, mi
tab siblings_14 if hwaveent == 14, mi
tab nse14_14 if hwaveent == 14, mi
count if inrange(b_cohort_14, 1960, 1989)

save "path\general\wave14_clean.dta", replace

***************************************************
**#* OLA 15 **************************************
***************************************************
use "path\data\klips15p.dta", clear
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_15  = p150104
replace cohorte_15 = .i if cohorte_15 == -1

gen cohorte5_15 = p150104
replace cohorte5_15 = .i if cohorte5_15 == -1

recode cohorte_15 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_15 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_15 = p150105
replace birth_month_15 = .i if birth_month_15 == -1
// 3 missings  reales 

***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_15   = p159021
replace male_sibs_15 = .i if male_sibs_15 == -1

gen female_sibs_15 = p159022
replace female_sibs_15 = .i if female_sibs_15 == -1

egen siblings_15 = rowtotal(male_sibs_15 female_sibs_15) if !missing(male_sibs_15) | !missing(female_sibs_15)

gen seniority_15 = p159023
replace seniority_15 = .i if seniority_15 == -1

replace siblings_15 = .i if siblings_15 == . & hwaveent == 15
replace siblings_15 = .v if siblings_15 == . & hwaveent != 15
// 111 missings reales 
// 410 datos nuevos 

***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_15 = p155501
replace edo_conyug_15 = .i if edo_conyug_15 == -1

gen change_edo_15 = p155502
replace change_edo_15 = .i if change_edo_15 == -1

gen type_changeedo_15 = p155504
replace type_changeedo_15 = .i if type_changeedo_15 == -1

gen y_change_15 = p155505
replace y_change_15 = .i if y_change_15 == -1
replace y_change_15 = .v if type_changeedo_15 != 1

gen m_change_15 = p155506
replace m_change_15 = .i if m_change_15 == -1
replace m_change_15 = .v if type_changeedo_15 != 1

gen unido_15 = 0
replace unido_15 = 1 if inrange(edo_conyug_15,2,5)

gen primer_matrimonio_15 = 0
replace primer_matrimonio_15 = 1 if unido_15 == 1 & type_changeedo_15 == 1

replace primer_matrimonio_15 = .i if unido_15 == 1 & primer_matrimonio_15 == 0 & hwaveent == 15
replace primer_matrimonio_15 = .v if unido_15 == 1 & primer_matrimonio_15 == 0 & inrange(hwaveent, 1, 14)

tab primer_matrimonio_15 unido_15, mi

// 20 falsos negativos

***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_15 = 2012

gen b_cohort_15 = p150104
replace b_cohort_15 = .i if b_cohort_15 == -1

gen sex_15 = p150101
replace sex_15 = .i if sex_15 == -1

gen edu_15 = p150110
replace edu_15 = .i if edu_15 == -1

gen grad_15 = p150111
replace grad_15 = .i if grad_15 == -1

gen main_act_15 = p150202
replace main_act_15 = .i if main_act_15 == -1

gen edad_15 = p150107
replace edad_15 = .i if edad_15 == -1

gen wrkstatus_15 = p150314
replace wrkstatus_15 = .i if wrkstatus_15 == -1

gen wrkhrs_15 = p150315
replace wrkhrs_15 = .i if wrkhrs_15 == -1

gen ksco_15 = p150350
replace ksco_15 = .i if ksco_15 == -1


***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_15 = w15p_l
replace weight_l_15 = .i if weight_l_15 == -1

gen weight_c_15 = w15p_c
replace weight_c_15 = .i if weight_c_15 == -1

***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_15 = p159051 
label variable fathers_edu_15 "Educación máxima del padre reportada en la ola 15"
recode fathers_edu_15 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_15 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_15 fathers_edu_15

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_15 = p159053 
label variable mothers_edu_15 "Educación máxima de la madre reportada en la ola 15"
recode mothers_edu_15 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_15 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_15 mothers_edu_15


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p159055, mi
clonevar sosten_15 = p159055
label define sosten_15 ///
1 "Padre" ///
2 "Madre" 
label values sosten_15 sosten_15

replace sosten_15 = .i if sosten_15 == -1 

gen parents_activity_15 = p159059

// 143 missing values 
label define parents_activity_15 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_15 parents_activity_15


gen parents_ocupation_15 = p159064

************************************************
*** NSE A LA EDAD 14 ***************************
************************************************
clonevar nse14_15 = p159006 
label variable nse14_15 "Nivel Socioeconómico a los 14 (proxy. IOS)"
tab nse14_15, mi

***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_15 =p150114 
gen m_dropout_15 =p150115 

***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_15 sex_15 cohorte_15 cohorte5_15 edad_15 year_15 ///
birth_month_15 male_sibs_15 female_sibs_15 siblings_15 ///
edo_conyug_15 change_edo_15 type_changeedo_15 y_change_15 m_change_15 ///
primer_matrimonio_15 seniority_15 ///
edu_15 grad_15 main_act_15 wrkhrs_15 wrkstatus_15 ksco_15 ///
weight_l_15 weight_c_15 unido_15 fathers_edu_15 mothers_edu_15 hwaveent ///
sosten_15 parents_activity_15 parents_ocupation_15 ///
nse14_15 y_dropout_15 m_dropout_15

***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 15"
label variable b_cohort_15 "Cohorte de nacimiento en la ola 15"
label variable sex_15 "Sexo en la ola 15"
label variable cohorte_15 "Cohorte decenal en la ola 15"
label variable cohorte5_15 "Cohorte quinquenal en la ola 15"
label variable edad_15 "Edad en la ola 15"
label variable year_15 "Año de la encuesta en la ola 15"
label variable birth_month_15 "Mes de nacimiento en la ola 15"
label variable male_sibs_15 "Número de hermanos varones en la ola 15"
label variable female_sibs_15 "Número de hermanas mujeres en la ola 15"
label variable siblings_15 "Número total de hermanos en la ola 15"
label variable edo_conyug_15 "Estado conyugal en la ola 15"
label variable change_edo_15 "Cambio de estado conyugal en la ola 15"
label variable type_changeedo_15 "Tipo de cambio conyugal en la ola 15"
label variable y_change_15 "Año del cambio conyugal en la ola 15"
label variable m_change_15 "Mes del cambio conyugal en la ola 15"
label variable primer_matrimonio_15 "Ocurrencia de primer matrimonio en la ola 15"
label variable seniority_15 "Orden de nacimiento entre hermanos en la ola 15"
label variable edu_15 "Educación en la ola 15"
label variable grad_15 "Obtención de grado en la ola 15"
label variable main_act_15 "Actividad principal en la ola 15"
label variable wrkhrs_15 "Horas trabajadas en la ola 15"
label variable wrkstatus_15 "Estatus laboral en la ola 15"
label variable ksco_15 "Ocupación KSCO en la ola 15"
label variable weight_l_15 "Peso longitudinal en la ola 15"
label variable weight_c_15 "Peso transversal en la ola 15"

count
tab primer_matrimonio_15 unido_15 if hwaveent == 15, mi
replace fathers_edu_15 = .i if fathers_edu_15 == -1
tab fathers_edu_15 if hwaveent == 15, mi
tab siblings_15 if hwaveent == 15, mi
tab nse14_15 if hwaveent == 15, mi
count if inrange(b_cohort_15, 1960, 1989)

save "path\general\wave15_clean.dta", replace

***************************************************
**#* OLA 16 **************************************
***************************************************
use "path\data\klips16p.dta", clear
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_16  = p160104
replace cohorte_16 = .i if cohorte_16 == -1

gen cohorte5_16 = p160104
replace cohorte5_16 = .i if cohorte5_16 == -1

recode cohorte_16 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_16 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_16 = p160105
replace birth_month_16 = .i if birth_month_16 == -1
// 4 missings reales 

***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_16   = p169021
replace male_sibs_16 = .i if male_sibs_16 == -1

gen female_sibs_16 = p169022
replace female_sibs_16 = .i if female_sibs_16 == -1

egen siblings_16 = rowtotal(male_sibs_16 female_sibs_16) if !missing(male_sibs_16) | !missing(female_sibs_16)

gen seniority_16 = p169023
replace seniority_16 = .i if seniority_16 == -1

replace siblings_16 = .i if siblings_16 == . & hwaveent == 16
replace siblings_16 = .v if siblings_16 == . & hwaveent != 16
// 120 missings reales 
//340 datos nuevos 

***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_16 = p165501
replace edo_conyug_16 = .i if edo_conyug_16 == -1

gen change_edo_16 = p165502
replace change_edo_16 = .i if change_edo_16 == -1

gen type_changeedo_16 = p165504
replace type_changeedo_16 = .i if type_changeedo_16 == -1

gen y_change_16 = p165505
replace y_change_16 = .i if y_change_16 == -1
replace y_change_16 = .v if type_changeedo_16 != 1

gen m_change_16 = p165506
replace m_change_16 = .i if m_change_16 == -1
replace m_change_16 = .v if type_changeedo_16 != 1

gen unido_16 = 0
replace unido_16 = 1 if inrange(edo_conyug_16,2,5)

gen primer_matrimonio_16 = 0
replace primer_matrimonio_16 = 1 if unido_16 == 1 & type_changeedo_16 == 1

replace primer_matrimonio_16 = .i if unido_16 == 1 & primer_matrimonio_16 == 0 & hwaveent == 16
replace primer_matrimonio_16 = .v if unido_16 == 1 & primer_matrimonio_16 == 0 & inrange(hwaveent, 1, 15)

tab primer_matrimonio_16 unido_16, mi
// 10 falsos negativos 
***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_16 = 2013

gen b_cohort_16 = p160104
replace b_cohort_16 = .i if b_cohort_16 == -1

gen sex_16 = p160101
replace sex_16 = .i if sex_16 == -1

gen edu_16 = p160110
replace edu_16 = .i if edu_16 == -1

gen grad_16 = p160111
replace grad_16 = .i if grad_16 == -1

gen main_act_16 = p160202
replace main_act_16 = .i if main_act_16 == -1

gen edad_16 = p160107
replace edad_16 = .i if edad_16 == -1

gen wrkstatus_16 = p160314
replace wrkstatus_16 = .i if wrkstatus_16 == -1

gen wrkhrs_16 = p160315
replace wrkhrs_16 = .i if wrkhrs_16 == -1

gen ksco_16 = p160350
replace ksco_16 = .i if ksco_16 == -1


***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_16 = w16p_l
replace weight_l_16 = .i if weight_l_16 == -1

gen weight_c_16 = w16p_c
replace weight_c_16 = .i if weight_c_16 == -1

***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_16 = p169051 
label variable fathers_edu_16 "Educación máxima del padre reportada en la ola 16"
recode fathers_edu_16 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_16 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_16 fathers_edu_16

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_16 = p169053 
label variable mothers_edu_16 "Educación máxima de la madre reportada en la ola 16"
recode mothers_edu_16 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_16 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_16 mothers_edu_16


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p169055, mi
clonevar sosten_16 = p169055
label define sosten_16 ///
1 "Padre" ///
2 "Madre" 
label values sosten_16 sosten_16

replace sosten_16 = .i if sosten_16 == -1 

gen parents_activity_16 = p169059

// 143 missing values 
label define parents_activity_16 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_16 parents_activity_16


gen parents_ocupation_16 = p169064

************************************************
*** NSE A LA EDAD 14 ***************************
************************************************
clonevar nse14_16 = p169006 
label variable nse14_16 "Nivel Socioeconómico a los 14 (proxy. IOS)"
tab nse14_16, mi
***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_16 =p160114 
gen m_dropout_16 =p160115 

***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_16 sex_16 cohorte_16 cohorte5_16 edad_16 year_16 ///
birth_month_16 male_sibs_16 female_sibs_16 siblings_16 ///
edo_conyug_16 change_edo_16 type_changeedo_16 y_change_16 m_change_16 ///
primer_matrimonio_16 seniority_16 ///
edu_16 grad_16 main_act_16 wrkhrs_16 wrkstatus_16 ksco_16 ///
weight_l_16 weight_c_16 unido_16 fathers_edu_16 mothers_edu_16 hwaveent ///
sosten_16 parents_activity_16 parents_ocupation_16 ///
nse14_16 y_dropout_16 m_dropout_16



***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 16"
label variable b_cohort_16 "Cohorte de nacimiento en la ola 16"
label variable sex_16 "Sexo en la ola 16"
label variable cohorte_16 "Cohorte decenal en la ola 16"
label variable cohorte5_16 "Cohorte quinquenal en la ola 16"
label variable edad_16 "Edad en la ola 16"
label variable year_16 "Año de la encuesta en la ola 16"
label variable birth_month_16 "Mes de nacimiento en la ola 16"
label variable male_sibs_16 "Número de hermanos varones en la ola 16"
label variable female_sibs_16 "Número de hermanas mujeres en la ola 16"
label variable siblings_16 "Número total de hermanos en la ola 16"
label variable edo_conyug_16 "Estado conyugal en la ola 16"
label variable change_edo_16 "Cambio de estado conyugal en la ola 16"
label variable type_changeedo_16 "Tipo de cambio conyugal en la ola 16"
label variable y_change_16 "Año del cambio conyugal en la ola 16"
label variable m_change_16 "Mes del cambio conyugal en la ola 16"
label variable primer_matrimonio_16 "Ocurrencia de primer matrimonio en la ola 16"
label variable seniority_16 "Orden de nacimiento entre hermanos en la ola 16"
label variable edu_16 "Educación en la ola 16"
label variable grad_16 "Obtención de grado en la ola 16"
label variable main_act_16 "Actividad principal en la ola 16"
label variable wrkhrs_16 "Horas trabajadas en la ola 16"
label variable wrkstatus_16 "Estatus laboral en la ola 16"
label variable ksco_16 "Ocupación KSCO en la ola 16"
label variable weight_l_16 "Peso longitudinal en la ola 16"
label variable weight_c_16 "Peso transversal en la ola 16"

count
tab primer_matrimonio_16 unido_16 if hwaveent == 16, mi
replace fathers_edu_16 = .i if fathers_edu_16 == -1
tab fathers_edu_16 if hwaveent == 16, mi
tab siblings_16 if hwaveent == 16, mi
tab nse14_16 if hwaveent == 16, mi
count if inrange(b_cohort_16, 1960, 1989)

save "path\general\wave15_clean.dta", replace

***************************************************
**#* OLA 17 **************************************
***************************************************
use "path\data\klips17p.dta", clear
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_17  = p170104
replace cohorte_17 = .i if cohorte_17 == -1

gen cohorte5_17 = p170104
replace cohorte5_17 = .i if cohorte5_17 == -1

recode cohorte_17 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_17 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_17 = p170105
replace birth_month_17 = .i if birth_month_17 == -1
// 5 missings reales 

***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_17   = p179021
replace male_sibs_17 = .i if male_sibs_17 == -1

gen female_sibs_17 = p179022
replace female_sibs_17 = .i if female_sibs_17 == -1

egen siblings_17 = rowtotal(male_sibs_17 female_sibs_17) if !missing(male_sibs_17) | !missing(female_sibs_17)

gen seniority_17 = p179023
replace seniority_17 = .i if seniority_17 == -1

replace siblings_17 = .i if siblings_17 == . & hwaveent == 17
replace siblings_17 = .v if siblings_17 == . & hwaveent != 17
// 114 datos nuevos 
// 90 missings reales 

***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_17 = p175501
replace edo_conyug_17 = .i if edo_conyug_17 == -1

gen change_edo_17 = p175502
replace change_edo_17 = .i if change_edo_17 == -1

gen type_changeedo_17 = p175504
replace type_changeedo_17 = .i if type_changeedo_17 == -1

gen y_change_17 = p175505
replace y_change_17 = .i if y_change_17 == -1
replace y_change_17 = .v if type_changeedo_17 != 1

gen m_change_17 = p175506
replace m_change_17 = .i if m_change_17 == -1
replace m_change_17 = .v if type_changeedo_17 != 1

gen unido_17 = 0
replace unido_17 = 1 if inrange(edo_conyug_17,2,5)

gen primer_matrimonio_17 = 0
replace primer_matrimonio_17 = 1 if unido_17 == 1 & type_changeedo_17 == 1

replace primer_matrimonio_17 = .i if unido_17 == 1 & primer_matrimonio_17 == 0 & hwaveent == 17
replace primer_matrimonio_17 = .v if unido_17 == 1 & primer_matrimonio_17 == 0 & inrange(hwaveent, 1, 16)

tab primer_matrimonio_17 unido_17, mi

// 9 falsos negativos 


***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_17 = 2014

gen b_cohort_17 = p170104
replace b_cohort_17 = .i if b_cohort_17 == -1

gen sex_17 = p170101
replace sex_17 = .i if sex_17 == -1

gen edu_17 = p170110
replace edu_17 = .i if edu_17 == -1

gen grad_17 = p170111
replace grad_17 = .i if grad_17 == -1

gen main_act_17 = p170202
replace main_act_17 = .i if main_act_17 == -1

gen edad_17 = p170107
replace edad_17 = .i if edad_17 == -1

gen wrkstatus_17 = p170314
replace wrkstatus_17 = .i if wrkstatus_17 == -1

gen wrkhrs_17 = p170315
replace wrkhrs_17 = .i if wrkhrs_17 == -1

gen ksco_17 = p170350
replace ksco_17 = .i if ksco_17 == -1


***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_17 = w17p_l
replace weight_l_17 = .i if weight_l_17 == -1

gen weight_c_17 = w17p_c
replace weight_c_17 = .i if weight_c_17 == -1

***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_17 = p179051 
label variable fathers_edu_17 "Educación máxima del padre reportada en la ola 17"
recode fathers_edu_17 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_17 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_17 fathers_edu_17

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_17 = p179053 
label variable mothers_edu_17 "Educación máxima de la madre reportada en la ola 17"
recode mothers_edu_17 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_17 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_17 mothers_edu_17


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p179055, mi
clonevar sosten_17 = p179055
label define sosten_17 ///
1 "Padre" ///
2 "Madre" 
label values sosten_17 sosten_17

replace sosten_17 = .i if sosten_17 == -1 

gen parents_activity_17 = p179059

// 143 missing values 
label define parents_activity_17 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_17 parents_activity_17


gen parents_ocupation_17 = p179064

************************************************
*** NSE A LA EDAD 14 ***************************
************************************************
clonevar nse14_17 = p179006 
label variable nse14_17 "Nivel Socioeconómico a los 14 (proxy. IOS)"
tab nse14_17, mi
***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_17 =p170114 
gen m_dropout_17 =p170115 

***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_17 sex_17 cohorte_17 cohorte5_17 edad_17 year_17 ///
birth_month_17 male_sibs_17 female_sibs_17 siblings_17 ///
edo_conyug_17 change_edo_17 type_changeedo_17 y_change_17 m_change_17 ///
primer_matrimonio_17 seniority_17 ///
edu_17 grad_17 main_act_17 wrkhrs_17 wrkstatus_17 ksco_17 ///
weight_l_17 weight_c_17 unido_17 fathers_edu_17 mothers_edu_17 hwaveent ///
sosten_17 parents_activity_17 parents_ocupation_17 ///
nse14_17 y_dropout_17 m_dropout_17


***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 17"
label variable b_cohort_17 "Cohorte de nacimiento en la ola 17"
label variable sex_17 "Sexo en la ola 17"
label variable cohorte_17 "Cohorte decenal en la ola 17"
label variable cohorte5_17 "Cohorte quinquenal en la ola 17"
label variable edad_17 "Edad en la ola 17"
label variable year_17 "Año de la encuesta en la ola 17"
label variable birth_month_17 "Mes de nacimiento en la ola 17"
label variable male_sibs_17 "Número de hermanos varones en la ola 17"
label variable female_sibs_17 "Número de hermanas mujeres en la ola 17"
label variable siblings_17 "Número total de hermanos en la ola 17"
label variable edo_conyug_17 "Estado conyugal en la ola 17"
label variable change_edo_17 "Cambio de estado conyugal en la ola 17"
label variable type_changeedo_17 "Tipo de cambio conyugal en la ola 17"
label variable y_change_17 "Año del cambio conyugal en la ola 17"
label variable m_change_17 "Mes del cambio conyugal en la ola 17"
label variable primer_matrimonio_17 "Ocurrencia de primer matrimonio en la ola 17"
label variable seniority_17 "Orden de nacimiento entre hermanos en la ola 17"
label variable edu_17 "Educación en la ola 17"
label variable grad_17 "Obtención de grado en la ola 17"
label variable main_act_17 "Actividad principal en la ola 17"
label variable wrkhrs_17 "Horas trabajadas en la ola 17"
label variable wrkstatus_17 "Estatus laboral en la ola 17"
label variable ksco_17 "Ocupación KSCO en la ola 17"
label variable weight_l_17 "Peso longitudinal en la ola 17"
label variable weight_c_17 "Peso transversal en la ola 17"

count
tab primer_matrimonio_17 unido_17 if hwaveent == 17, mi
replace fathers_edu_17 = .i if fathers_edu_17 == -1
tab fathers_edu_17 if hwaveent == 17, mi
tab siblings_17 if hwaveent == 17, mi
tab nse14_17 if hwaveent == 17, mi
count if inrange(b_cohort_17, 1960, 1989)


save "path\general\wave17_clean.dta", replace

***************************************************
**#* OLA 18 **************************************
***************************************************
use "path\data\klips18p.dta", clear
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_18  = p180104
replace cohorte_18 = .i if cohorte_18 == -1

gen cohorte5_18 = p180104
replace cohorte5_18 = .i if cohorte5_18 == -1

recode cohorte_18 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_18 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_18 = p180105
replace birth_month_18 = .i if birth_month_18 == -1
// 5 missings reales 
***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_18   = p189021
replace male_sibs_18 = .i if male_sibs_18 == -1

gen female_sibs_18 = p189022
replace female_sibs_18 = .i if female_sibs_18 == -1

egen siblings_18 = rowtotal(male_sibs_18 female_sibs_18) if !missing(male_sibs_18) | !missing(female_sibs_18)

gen seniority_18 = p189023
replace seniority_18 = .i if seniority_18 == -1

replace siblings_18 = .i if siblings_18 == . & hwaveent == 18
replace siblings_18 = .v if siblings_18 == . & hwaveent != 18
// 510 datos nuevos 
// 119 missings reales 
***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_18 = p185501
replace edo_conyug_18 = .i if edo_conyug_18 == -1

gen change_edo_18 = p185502
replace change_edo_18 = .i if change_edo_18 == -1

gen type_changeedo_18 = p185504
replace type_changeedo_18 = .i if type_changeedo_18 == -1

gen y_change_18 = p185505
replace y_change_18 = .i if y_change_18 == -1
replace y_change_18 = .v if type_changeedo_18 != 1

gen m_change_18 = p185506
replace m_change_18 = .i if m_change_18 == -1
replace m_change_18 = .v if type_changeedo_18 != 1

gen unido_18 = 0
replace unido_18 = 1 if inrange(edo_conyug_18,2,5)

gen primer_matrimonio_18 = 0
replace primer_matrimonio_18 = 1 if unido_18 == 1 & type_changeedo_18 == 1

replace primer_matrimonio_18 = .i if unido_18 == 1 & primer_matrimonio_18 == 0 & hwaveent == 18
replace primer_matrimonio_18 = .v if unido_18 == 1 & primer_matrimonio_18 == 0 & inrange(hwaveent, 1, 17)

tab primer_matrimonio_18 unido_18, mi

// 13 falsos negativos 

***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_18 = 2015

gen b_cohort_18 = p180104
replace b_cohort_18 = .i if b_cohort_18 == -1

gen sex_18 = p180101
replace sex_18 = .i if sex_18 == -1

gen edu_18 = p180110
replace edu_18 = .i if edu_18 == -1

gen grad_18 = p180111
replace grad_18 = .i if grad_18 == -1

gen main_act_18 = p180202
replace main_act_18 = .i if main_act_18 == -1

gen edad_18 = p180107
replace edad_18 = .i if edad_18 == -1

gen wrkstatus_18 = p180314
replace wrkstatus_18 = .i if wrkstatus_18 == -1

gen wrkhrs_18 = p180315
replace wrkhrs_18 = .i if wrkhrs_18 == -1

gen ksco_18 = p180350
replace ksco_18 = .i if ksco_18 == -1


***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_18 = w18p_l
replace weight_l_18 = .i if weight_l_18 == -1

gen weight_c_18 = w18p_c
replace weight_c_18 = .i if weight_c_18 == -1

***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_18 = p189051 
label variable fathers_edu_18 "Educación máxima del padre reportada en la ola 18"
recode fathers_edu_18 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_18 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_18 fathers_edu_18

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_18 = p189053 
label variable mothers_edu_18 "Educación máxima de la madre reportada en la ola 18"
recode mothers_edu_18 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_18 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_18 mothers_edu_18


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p189055, mi
clonevar sosten_18 = p189055
label define sosten_18 ///
1 "Padre" ///
2 "Madre" 
label values sosten_18 sosten_18

replace sosten_18 = .i if sosten_18 == -1 

gen parents_activity_18 = p189059

// 143 missing values 
label define parents_activity_18 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_18 parents_activity_18


gen parents_ocupation_18 = p189064

************************************************
*** NSE A LA EDAD 14 ***************************
************************************************
clonevar nse14_18 = p189006 
label variable nse14_18 "Nivel Socioeconómico a los 14 (proxy. IOS)"
tab nse14_18, mi
***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_18 =p180114 
gen m_dropout_18 =p180115 

***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_18 sex_18 cohorte_18 cohorte5_18 edad_18 year_18 ///
birth_month_18 male_sibs_18 female_sibs_18 siblings_18 ///
edo_conyug_18 change_edo_18 type_changeedo_18 y_change_18 m_change_18 ///
primer_matrimonio_18 seniority_18 ///
edu_18 grad_18 main_act_18 wrkhrs_18 wrkstatus_18 ksco_18 ///
weight_l_18 weight_c_18 unido_18 fathers_edu_18 mothers_edu_18 hwaveent ///
sosten_18 parents_activity_18 parents_ocupation_18 ///
nse14_18 y_dropout_18 m_dropout_18


***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 18"
label variable b_cohort_18 "Cohorte de nacimiento en la ola 18"
label variable sex_18 "Sexo en la ola 18"
label variable cohorte_18 "Cohorte decenal en la ola 18"
label variable cohorte5_18 "Cohorte quinquenal en la ola 18"
label variable edad_18 "Edad en la ola 18"
label variable year_18 "Año de la encuesta en la ola 18"
label variable birth_month_18 "Mes de nacimiento en la ola 18"
label variable male_sibs_18 "Número de hermanos varones en la ola 18"
label variable female_sibs_18 "Número de hermanas mujeres en la ola 18"
label variable siblings_18 "Número total de hermanos en la ola 18"
label variable edo_conyug_18 "Estado conyugal en la ola 18"
label variable change_edo_18 "Cambio de estado conyugal en la ola 18"
label variable type_changeedo_18 "Tipo de cambio conyugal en la ola 18"
label variable y_change_18 "Año del cambio conyugal en la ola 18"
label variable m_change_18 "Mes del cambio conyugal en la ola 18"
label variable primer_matrimonio_18 "Ocurrencia de primer matrimonio en la ola 18"
label variable seniority_18 "Orden de nacimiento entre hermanos en la ola 18"
label variable edu_18 "Educación en la ola 18"
label variable grad_18 "Obtención de grado en la ola 18"
label variable main_act_18 "Actividad principal en la ola 18"
label variable wrkhrs_18 "Horas trabajadas en la ola 18"
label variable wrkstatus_18 "Estatus laboral en la ola 18"
label variable ksco_18 "Ocupación KSCO en la ola 18"
label variable weight_l_18 "Peso longitudinal en la ola 18"
label variable weight_c_18 "Peso transversal en la ola 18"

count
tab primer_matrimonio_18 unido_18 if hwaveent == 18, mi
replace fathers_edu_18 = .i if fathers_edu_18 == -1
tab fathers_edu_18 if hwaveent == 18, mi
tab siblings_18 if hwaveent == 18, mi
tab nse14_18 if hwaveent == 18, mi
count if inrange(b_cohort_18, 1960, 1989)

save "path\general\wave18_clean.dta", replace

***************************************************
**#* OLA 19 **************************************
***************************************************
use "path\data\klips19p.dta", clear
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_19  = p190104
replace cohorte_19 = .i if cohorte_19 == -1

gen cohorte5_19 = p190104
replace cohorte5_19 = .i if cohorte5_19 == -1

recode cohorte_19 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_19 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_19 = p190105
replace birth_month_19 = .i if birth_month_19 == -1
// 10 missings reales 
***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_19   = p199021
replace male_sibs_19 = .i if male_sibs_19 == -1

gen female_sibs_19 = p199022
replace female_sibs_19 = .i if female_sibs_19 == -1

egen siblings_19 = rowtotal(male_sibs_19 female_sibs_19) if !missing(male_sibs_19) | !missing(female_sibs_19)

gen seniority_19 = p199023
replace seniority_19 = .i if seniority_19 == -1

replace siblings_19 = .i if siblings_19 == . & hwaveent == 19
replace siblings_19 = .v if siblings_19 == . & hwaveent != 19
// 367 datos nuevos 
// 100 missings reales 
***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_19 = p195501
replace edo_conyug_19 = .i if edo_conyug_19 == -1

gen change_edo_19 = p195502
replace change_edo_19 = .i if change_edo_19 == -1

gen type_changeedo_19 = p195504
replace type_changeedo_19 = .i if type_changeedo_19 == -1

gen y_change_19 = p195505
replace y_change_19 = .i if y_change_19 == -1
replace y_change_19 = .v if type_changeedo_19 != 1

gen m_change_19 = p195506
replace m_change_19 = .i if m_change_19 == -1
replace m_change_19 = .v if type_changeedo_19 != 1

gen unido_19 = 0
replace unido_19 = 1 if inrange(edo_conyug_19,2,5)

gen primer_matrimonio_19 = 0
replace primer_matrimonio_19 = 1 if unido_19 == 1 & type_changeedo_19 == 1

replace primer_matrimonio_19 = .i if unido_19 == 1 & primer_matrimonio_19 == 0 & hwaveent == 19
replace primer_matrimonio_19 = .v if unido_19 == 1 & primer_matrimonio_19 == 0 & inrange(hwaveent, 1, 18)

tab primer_matrimonio_19 unido_19, mi
// 16 falsos negativos

***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_19 = 2016

gen b_cohort_19 = p190104
replace b_cohort_19 = .i if b_cohort_19 == -1

gen sex_19 = p190101
replace sex_19 = .i if sex_19 == -1

gen edu_19 = p190110
replace edu_19 = .i if edu_19 == -1

gen grad_19 = p190111
replace grad_19 = .i if grad_19 == -1

gen main_act_19 = p190202
replace main_act_19 = .i if main_act_19 == -1

gen edad_19 = p190107
replace edad_19 = .i if edad_19 == -1

gen wrkstatus_19 = p190314
replace wrkstatus_19 = .i if wrkstatus_19 == -1

gen wrkhrs_19 = p190315
replace wrkhrs_19 = .i if wrkhrs_19 == -1

gen ksco_19 = p190350
replace ksco_19 = .i if ksco_19 == -1

***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_19 = w19p_l
replace weight_l_19 = .i if weight_l_19 == -1

gen weight_c_19 = w19p_c
replace weight_c_19 = .i if weight_c_19 == -1
***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_19 = p199051 
label variable fathers_edu_19 "Educación máxima del padre reportada en la ola 19"
recode fathers_edu_19 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_19 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_19 fathers_edu_19

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_19 = p199053 
label variable mothers_edu_19 "Educación máxima de la madre reportada en la ola 19"
recode mothers_edu_19 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_19 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_19 mothers_edu_19


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p199055, mi
clonevar sosten_19 = p199055
label define sosten_19 ///
1 "Padre" ///
2 "Madre" 
label values sosten_19 sosten_19

replace sosten_19 = .i if sosten_19 == -1 

gen parents_activity_19 = p199059

// 143 missing values 
label define parents_activity_19 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_19 parents_activity_19


gen parents_ocupation_19 = p199064

************************************************
*** NSE A LA EDAD 14 ***************************
************************************************
clonevar nse14_19 = p199006 
label variable nse14_19 "Nivel Socioeconómico a los 14 (proxy. IOS)"
tab nse14_19, mi
***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_19 =p190114 
gen m_dropout_19 =p190115 

***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_19 sex_19 cohorte_19 cohorte5_19 edad_19 year_19 ///
birth_month_19 male_sibs_19 female_sibs_19 siblings_19 ///
edo_conyug_19 change_edo_19 type_changeedo_19 y_change_19 m_change_19 ///
primer_matrimonio_19 seniority_19 ///
edu_19 grad_19 main_act_19 wrkhrs_19 wrkstatus_19 ksco_19 ///
weight_l_19 weight_c_19 unido_19 fathers_edu_19 mothers_edu_19 hwaveent ///
sosten_19 parents_activity_19 parents_ocupation_19 ///
nse14_19 y_dropout_19 m_dropout_19

***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 19"
label variable b_cohort_19 "Cohorte de nacimiento en la ola 19"
label variable sex_19 "Sexo en la ola 19"
label variable cohorte_19 "Cohorte decenal en la ola 19"
label variable cohorte5_19 "Cohorte quinquenal en la ola 19"
label variable edad_19 "Edad en la ola 19"
label variable year_19 "Año de la encuesta en la ola 19"
label variable birth_month_19 "Mes de nacimiento en la ola 19"
label variable male_sibs_19 "Número de hermanos varones en la ola 19"
label variable female_sibs_19 "Número de hermanas mujeres en la ola 19"
label variable siblings_19 "Número total de hermanos en la ola 19"
label variable edo_conyug_19 "Estado conyugal en la ola 19"
label variable change_edo_19 "Cambio de estado conyugal en la ola 19"
label variable type_changeedo_19 "Tipo de cambio conyugal en la ola 19"
label variable y_change_19 "Año del cambio conyugal en la ola 19"
label variable m_change_19 "Mes del cambio conyugal en la ola 19"
label variable primer_matrimonio_19 "Ocurrencia de primer matrimonio en la ola 19"
label variable seniority_19 "Orden de nacimiento entre hermanos en la ola 19"
label variable edu_19 "Educación en la ola 19"
label variable grad_19 "Obtención de grado en la ola 19"
label variable main_act_19 "Actividad principal en la ola 19"
label variable wrkhrs_19 "Horas trabajadas en la ola 19"
label variable wrkstatus_19 "Estatus laboral en la ola 19"
label variable ksco_19 "Ocupación KSCO en la ola 19"
label variable weight_l_19 "Peso longitudinal en la ola 19"
label variable weight_c_19 "Peso transversal en la ola 19"

count
tab primer_matrimonio_19 unido_19 if hwaveent == 19, mi
replace fathers_edu_19 = .i if fathers_edu_19 == -1
tab fathers_edu_19 if hwaveent == 19, mi
tab siblings_19 if hwaveent == 19, mi
tab nse14_19 if hwaveent == 19, mi
count if inrange(b_cohort_19, 1960, 1989)

save "path\general\wave19_clean.dta", replace

***************************************************
**#* OLA 20 **************************************
***************************************************
use "path\data\klips20p.dta", clear
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_20  = p200104
replace cohorte_20 = .i if cohorte_20 == -1

gen cohorte5_20 = p200104
replace cohorte5_20 = .i if cohorte5_20 == -1

recode cohorte_20 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_20 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_20 = p200105
replace birth_month_20 = .i if birth_month_20 == -1
// 10 missings reales 

***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_20   = p209021
replace male_sibs_20 = .i if male_sibs_20 == -1

gen female_sibs_20 = p209022
replace female_sibs_20 = .i if female_sibs_20 == -1

egen siblings_20 = rowtotal(male_sibs_20 female_sibs_20) if !missing(male_sibs_20) | !missing(female_sibs_20)

gen seniority_20 = p209023
replace seniority_20 = .i if seniority_20 == -1

replace siblings_20 = .i if siblings_20 == . & hwaveent == 20
replace siblings_20 = .v if siblings_20 == . & hwaveent != 20
// 367 datos nuevos 
// 100 missings reales 

***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_20 = p205501
replace edo_conyug_20 = .i if edo_conyug_20 == -1

gen change_edo_20 = p205502
replace change_edo_20 = .i if change_edo_20 == -1

gen type_changeedo_20 = p205504
replace type_changeedo_20 = .i if type_changeedo_20 == -1

gen y_change_20 = p205505
replace y_change_20 = .i if y_change_20 == -1
replace y_change_20 = .v if type_changeedo_20 != 1

gen m_change_20 = p205506
replace m_change_20 = .i if m_change_20 == -1
replace m_change_20 = .v if type_changeedo_20 != 1

gen unido_20 = 0
replace unido_20 = 1 if inrange(edo_conyug_20,2,5)

gen primer_matrimonio_20 = 0
replace primer_matrimonio_20 = 1 if unido_20 == 1 & type_changeedo_20 == 1

replace primer_matrimonio_20 = .i if unido_20 == 1 & primer_matrimonio_20 == 0 & hwaveent == 20
replace primer_matrimonio_20 = .v if unido_20 == 1 & primer_matrimonio_20 == 0 & inrange(hwaveent, 1, 19)

tab primer_matrimonio_20 unido_20, mi
// 16 falsos negativos

***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_20 = 2017

gen b_cohort_20 = p200104
replace b_cohort_20 = .i if b_cohort_20 == -1

gen sex_20 = p200101
replace sex_20 = .i if sex_20 == -1

gen edu_20 = p200110
replace edu_20 = .i if edu_20 == -1

gen grad_20 = p200111
replace grad_20 = .i if grad_20 == -1

gen main_act_20 = p200202
replace main_act_20 = .i if main_act_20 == -1

gen edad_20 = p200107
replace edad_20 = .i if edad_20 == -1

gen wrkstatus_20 = p200314
replace wrkstatus_20 = .i if wrkstatus_20 == -1

gen wrkhrs_20 = p200315
replace wrkhrs_20 = .i if wrkhrs_20 == -1

gen ksco_20 = p200350
replace ksco_20 = .i if ksco_20 == -1

***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_20 = w20p_l
replace weight_l_20 = .i if weight_l_20 == -1

gen weight_c_20 = w20p_c
replace weight_c_20 = .i if weight_c_20 == -1
***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_20 = p209051 
label variable fathers_edu_20 "Educación máxima del padre reportada en la ola 20"
recode fathers_edu_20 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_20 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_20 fathers_edu_20

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_20 = p209053 
label variable mothers_edu_20 "Educación máxima de la madre reportada en la ola 20"
recode mothers_edu_20 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_20 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_20 mothers_edu_20


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p209055, mi
clonevar sosten_20 = p209055
label define sosten_20 ///
1 "Padre" ///
2 "Madre" 
label values sosten_20 sosten_20

replace sosten_20 = .i if sosten_20 == -1 

gen parents_activity_20 = p209059

// 143 missing values 
label define parents_activity_20 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_20 parents_activity_20


gen parents_ocupation_20 = p209064

************************************************
*** NSE A LA EDAD 14 ***************************
************************************************
clonevar nse14_20 = p209006 
label variable nse14_20 "Nivel Socioeconómico a los 14 (proxy. IOS)"
tab nse14_20, mi
***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_20 =p200114 
gen m_dropout_20 =p200115 

***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_20 sex_20 cohorte_20 cohorte5_20 edad_20 year_20 ///
birth_month_20 male_sibs_20 female_sibs_20 siblings_20 ///
edo_conyug_20 change_edo_20 type_changeedo_20 y_change_20 m_change_20 ///
primer_matrimonio_20 seniority_20 ///
edu_20 grad_20 main_act_20 wrkhrs_20 wrkstatus_20 ksco_20 ///
weight_l_20 weight_c_20 unido_20 fathers_edu_20 mothers_edu_20 hwaveent ///
sosten_20 parents_activity_20 parents_ocupation_20 ///
nse14_20 y_dropout_20 m_dropout_20

***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 20"
label variable b_cohort_20 "Cohorte de nacimiento en la ola 20"
label variable sex_20 "Sexo en la ola 20"
label variable cohorte_20 "Cohorte decenal en la ola 20"
label variable cohorte5_20 "Cohorte quinquenal en la ola 20"
label variable edad_20 "Edad en la ola 20"
label variable year_20 "Año de la encuesta en la ola 20"
label variable birth_month_20 "Mes de nacimiento en la ola 20"
label variable male_sibs_20 "Número de hermanos varones en la ola 20"
label variable female_sibs_20 "Número de hermanas mujeres en la ola 20"
label variable siblings_20 "Número total de hermanos en la ola 20"
label variable edo_conyug_20 "Estado conyugal en la ola 20"
label variable change_edo_20 "Cambio de estado conyugal en la ola 20"
label variable type_changeedo_20 "Tipo de cambio conyugal en la ola 20"
label variable y_change_20 "Año del cambio conyugal en la ola 20"
label variable m_change_20 "Mes del cambio conyugal en la ola 20"
label variable primer_matrimonio_20 "Ocurrencia de primer matrimonio en la ola 20"
label variable seniority_20 "Orden de nacimiento entre hermanos en la ola 20"
label variable edu_20 "Educación en la ola 20"
label variable grad_20 "Obtención de grado en la ola 20"
label variable main_act_20 "Actividad principal en la ola 20"
label variable wrkhrs_20 "Horas trabajadas en la ola 20"
label variable wrkstatus_20 "Estatus laboral en la ola 20"
label variable ksco_20 "Ocupación KSCO en la ola 20"
label variable weight_l_20 "Peso longitudinal en la ola 20"
label variable weight_c_20 "Peso transversal en la ola 20"

count
tab primer_matrimonio_20 unido_20 if hwaveent == 20, mi
replace fathers_edu_20 = .i if fathers_edu_20 == -1
tab fathers_edu_20 if hwaveent == 20, mi
tab siblings_20 if hwaveent == 20, mi
tab nse14_20 if hwaveent == 20, mi
count if inrange(b_cohort_20, 1960, 1989)

save "path\general\wave20_clean.dta", replace

***************************************************
**#* OLA 21 **************************************
***************************************************

use "C:\Users\cdiaz\OneDrive - El Colegio de México A.C\TESIS\METODOLOGIA\Rstudio\data\klips21p.dta", clear

***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_21  = p210104
replace cohorte_21 = .i if cohorte_21 == -1

gen cohorte5_21 = p210104
replace cohorte5_21 = .i if cohorte5_21 == -1

recode cohorte_21 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_21 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_21 = p210105
replace birth_month_21 = .i if birth_month_21 == -1
// 27 missings reales 
***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_21   = p219021
replace male_sibs_21 = .i if male_sibs_21 == -1

gen female_sibs_21 = p219022
replace female_sibs_21 = .i if female_sibs_21 == -1

egen siblings_21 = rowtotal(male_sibs_21 female_sibs_21) if !missing(male_sibs_21) | !missing(female_sibs_21)

gen seniority_21 = p219023
replace seniority_21 = .i if seniority_21 == -1

replace siblings_21 = .i if siblings_21 == . & hwaveent == 21
replace siblings_21 = .v if siblings_21 == . & hwaveent != 21
// 9822 datos nuevos
// 154 missings reales 
***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_21 = p215501
replace edo_conyug_21 = .i if edo_conyug_21 == -1

gen change_edo_21 = p215502
replace change_edo_21 = .i if change_edo_21 == -1

gen type_changeedo_21 = p215504
replace type_changeedo_21 = .i if type_changeedo_21 == -1

gen y_change_21 = p215505
replace y_change_21 = .i if y_change_21 == -1
replace y_change_21 = .v if type_changeedo_21 != 1

gen m_change_21 = p215506
replace m_change_21 = .i if m_change_21 == -1
replace m_change_21 = .v if type_changeedo_21 != 1

gen unido_21 = 0
replace unido_21 = 1 if inrange(edo_conyug_21,2,5)

gen primer_matrimonio_21 = 0
replace primer_matrimonio_21 = 1 if unido_21 == 1 & type_changeedo_21 == 1

replace primer_matrimonio_21 = .i if unido_21 == 1 & primer_matrimonio_21 == 0 & hwaveent == 21
replace primer_matrimonio_21 = .v if unido_21 == 1 & primer_matrimonio_21 == 0 & inrange(hwaveent, 1, 20)

tab primer_matrimonio_21 unido_21, mi
// 9 falsos negativos 
***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_21 = 2018

gen b_cohort_21 = p210104
replace b_cohort_21 = .i if b_cohort_21 == -1

gen sex_21 = p210101
replace sex_21 = .i if sex_21 == -1

gen edu_21 = p210110
replace edu_21 = .i if edu_21 == -1

gen grad_21 = p210111
replace grad_21 = .i if grad_21 == -1

gen main_act_21 = p210202
replace main_act_21 = .i if main_act_21 == -1

gen edad_21 = p210107
replace edad_21 = .i if edad_21 == -1

gen wrkstatus_21 = p210314
replace wrkstatus_21 = .i if wrkstatus_21 == -1

gen wrkhrs_21 = p210315
replace wrkhrs_21 = .i if wrkhrs_21 == -1

gen ksco_21 = p210350
replace ksco_21 = .i if ksco_21 == -1

***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_21 = w21p_l
replace weight_l_21 = .i if weight_l_21 == -1

gen weight_c_21 = w21p_c
replace weight_c_21 = .i if weight_c_21 == -1
***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_21 = p219051 
label variable fathers_edu_21 "Educación máxima del padre reportada en la ola 21"
recode fathers_edu_21 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_21 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_21 fathers_edu_21

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_21 = p219053 
label variable mothers_edu_21 "Educación máxima de la madre reportada en la ola 21"
recode mothers_edu_21 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_21 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_21 mothers_edu_21


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p219055, mi
clonevar sosten_21 = p219055
label define sosten_21 ///
1 "Padre" ///
2 "Madre" 
label values sosten_21 sosten_21

replace sosten_21 = .i if sosten_21 == -1 

gen parents_activity_21 = p219059

// 143 missing values 
label define parents_activity_21 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_21 parents_activity_21


gen parents_ocupation_21 = p219064

************************************************
*** NSE A LA EDAD 14 ***************************
************************************************
clonevar nse14_21 = p219006 
label variable nse14_21 "Nivel Socioeconómico a los 14 (proxy. IOS)"
tab nse14_21, mi
***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_21 =p210114 
gen m_dropout_21 =p210115 
***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_21 sex_21 cohorte_21 cohorte5_21 edad_21 year_21 ///
birth_month_21 male_sibs_21 female_sibs_21 siblings_21 ///
edo_conyug_21 change_edo_21 type_changeedo_21 y_change_21 m_change_21 ///
primer_matrimonio_21 seniority_21 ///
edu_21 grad_21 main_act_21 wrkhrs_21 wrkstatus_21 ksco_21 ///
weight_l_21 weight_c_21 unido_21 fathers_edu_21 mothers_edu_21 hwaveent ///
sosten_21 parents_activity_21 parents_ocupation_21 ///
nse14_21 y_dropout_21 m_dropout_21

***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 21"
label variable b_cohort_21 "Cohorte de nacimiento en la ola 21"
label variable sex_21 "Sexo en la ola 21"
label variable cohorte_21 "Cohorte decenal en la ola 21"
label variable cohorte5_21 "Cohorte quinquenal en la ola 21"
label variable edad_21 "Edad en la ola 21"
label variable year_21 "Año de la encuesta en la ola 21"
label variable birth_month_21 "Mes de nacimiento en la ola 21"
label variable male_sibs_21 "Número de hermanos varones en la ola 21"
label variable female_sibs_21 "Número de hermanas mujeres en la ola 21"
label variable siblings_21 "Número total de hermanos en la ola 21"
label variable edo_conyug_21 "Estado conyugal en la ola 21"
label variable change_edo_21 "Cambio de estado conyugal en la ola 21"
label variable type_changeedo_21 "Tipo de cambio conyugal en la ola 21"
label variable y_change_21 "Año del cambio conyugal en la ola 21"
label variable m_change_21 "Mes del cambio conyugal en la ola 21"
label variable primer_matrimonio_21 "Ocurrencia de primer matrimonio en la ola 21"
label variable seniority_21 "Orden de nacimiento entre hermanos en la ola 21"
label variable edu_21 "Educación en la ola 21"
label variable grad_21 "Obtención de grado en la ola 21"
label variable main_act_21 "Actividad principal en la ola 21"
label variable wrkhrs_21 "Horas trabajadas en la ola 21"
label variable wrkstatus_21 "Estatus laboral en la ola 21"
label variable ksco_21 "Ocupación KSCO en la ola 21"
label variable weight_l_21 "Peso longitudinal en la ola 21"
label variable weight_c_21 "Peso transversal en la ola 21"

count
tab primer_matrimonio_21 unido_21 if hwaveent == 21, mi
replace fathers_edu_21 = .i if fathers_edu_21 == -1
tab fathers_edu_21 if hwaveent == 21, mi
tab siblings_21 if hwaveent == 21, mi
tab nse14_21 if hwaveent == 21, mi
count if inrange(b_cohort_21, 1960, 1989)

save "path\general\wave21_clean.dta", replace

***************************************************
**#* OLA 22 **************************************
***************************************************
use "path\data\klips22p.dta", clear
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_22  = p220104
replace cohorte_22 = .i if cohorte_22 == -1

gen cohorte5_22 = p220104
replace cohorte5_22 = .i if cohorte5_22 == -1

recode cohorte_22 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_22 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_22 = p220105
replace birth_month_22 = .i if birth_month_22 == -1

***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_22   = p229021
replace male_sibs_22 = .i if male_sibs_22 == -1

gen female_sibs_22 = p229022
replace female_sibs_22 = .i if female_sibs_22 == -1

egen siblings_22 = rowtotal(male_sibs_22 female_sibs_22) if !missing(male_sibs_22) | !missing(female_sibs_22)

gen seniority_22 = p229023
replace seniority_22 = .i if seniority_22 == -1

replace siblings_22 = .i if siblings_22 == . & hwaveent == 22
replace siblings_22 = .v if siblings_22 == . & hwaveent != 22

***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_22 = p225501
replace edo_conyug_22 = .i if edo_conyug_22 == -1

gen change_edo_22 = p225502
replace change_edo_22 = .i if change_edo_22 == -1

gen type_changeedo_22 = p225504
replace type_changeedo_22 = .i if type_changeedo_22 == -1

gen y_change_22 = p225505
replace y_change_22 = .i if y_change_22 == -1
replace y_change_22 = .v if type_changeedo_22 != 1

gen m_change_22 = p225506
replace m_change_22 = .i if m_change_22 == -1
replace m_change_22 = .v if type_changeedo_22 != 1

gen unido_22 = 0
replace unido_22 = 1 if inrange(edo_conyug_22,2,5)

gen primer_matrimonio_22 = 0
replace primer_matrimonio_22 = 1 if unido_22 == 1 & type_changeedo_22 == 1

replace primer_matrimonio_22 = .i if unido_22 == 1 & primer_matrimonio_22 == 0 & hwaveent == 22
replace primer_matrimonio_22 = .v if unido_22 == 1 & primer_matrimonio_22 == 0 & inrange(hwaveent, 1, 21)

tab primer_matrimonio_22 unido_22, mi

***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_22 = 2019

gen b_cohort_22 = p220104
replace b_cohort_22 = .i if b_cohort_22 == -1

gen sex_22 = p220101
replace sex_22 = .i if sex_22 == -1

gen edu_22 = p220110
replace edu_22 = .i if edu_22 == -1

gen grad_22 = p220111
replace grad_22 = .i if grad_22 == -1

gen main_act_22 = p220202
replace main_act_22 = .i if main_act_22 == -1

gen edad_22 = p220107
replace edad_22 = .i if edad_22 == -1

gen wrkstatus_22 = p220314
replace wrkstatus_22 = .i if wrkstatus_22 == -1

gen wrkhrs_22 = p220315
replace wrkhrs_22 = .i if wrkhrs_22 == -1

gen ksco_22 = p220350
replace ksco_22 = .i if ksco_22 == -1

***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_22 = w22p_l
replace weight_l_22 = .i if weight_l_22 == -1

gen weight_c_22 = w22p_c
replace weight_c_22 = .i if weight_c_22 == -1
***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_22 = p229051 
label variable fathers_edu_22 "Educación máxima del padre reportada en la ola 22"
recode fathers_edu_22 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_22 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_22 fathers_edu_22

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_22 = p229053 
label variable mothers_edu_22 "Educación máxima de la madre reportada en la ola 22"
recode mothers_edu_22 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_22 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_22 mothers_edu_22


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p229055, mi
clonevar sosten_22 = p229055
label define sosten_22 ///
1 "Padre" ///
2 "Madre" 
label values sosten_22 sosten_22

replace sosten_22 = .i if sosten_22 == -1 

gen parents_activity_22 = p229059

// 143 missing values 
label define parents_activity_22 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_22 parents_activity_22


gen parents_ocupation_22 = p229064

************************************************
*** NSE A LA EDAD 14 ***************************
************************************************
clonevar nse14_22 = p229006 
label variable nse14_22 "Nivel Socioeconómico a los 14 (proxy. IOS)"
tab nse14_22, mi
***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_22 =p220114 
gen m_dropout_22 =p220115 
***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_22 sex_22 cohorte_22 cohorte5_22 edad_22 year_22 ///
birth_month_22 male_sibs_22 female_sibs_22 siblings_22 ///
edo_conyug_22 change_edo_22 type_changeedo_22 y_change_22 m_change_22 ///
primer_matrimonio_22 seniority_22 ///
edu_22 grad_22 main_act_22 wrkhrs_22 wrkstatus_22 ksco_22 ///
weight_l_22 weight_c_22 unido_22 fathers_edu_22 mothers_edu_22 hwaveent ///
sosten_22 parents_activity_22 parents_ocupation_22 ///
nse14_22 y_dropout_22 m_dropout_22


***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 22"
label variable b_cohort_22 "Cohorte de nacimiento en la ola 22"
label variable sex_22 "Sexo en la ola 22"
label variable cohorte_22 "Cohorte decenal en la ola 22"
label variable cohorte5_22 "Cohorte quinquenal en la ola 22"
label variable edad_22 "Edad en la ola 22"
label variable year_22 "Año de la encuesta en la ola 22"
label variable birth_month_22 "Mes de nacimiento en la ola 22"
label variable male_sibs_22 "Número de hermanos varones en la ola 22"
label variable female_sibs_22 "Número de hermanas mujeres en la ola 22"
label variable siblings_22 "Número total de hermanos en la ola 22"
label variable edo_conyug_22 "Estado conyugal en la ola 22"
label variable change_edo_22 "Cambio de estado conyugal en la ola 22"
label variable type_changeedo_22 "Tipo de cambio conyugal en la ola 22"
label variable y_change_22 "Año del cambio conyugal en la ola 22"
label variable m_change_22 "Mes del cambio conyugal en la ola 22"
label variable primer_matrimonio_22 "Ocurrencia de primer matrimonio en la ola 22"
label variable seniority_22 "Orden de nacimiento entre hermanos en la ola 22"
label variable edu_22 "Educación en la ola 22"
label variable grad_22 "Obtención de grado en la ola 22"
label variable main_act_22 "Actividad principal en la ola 22"
label variable wrkhrs_22 "Horas trabajadas en la ola 22"
label variable wrkstatus_22 "Estatus laboral en la ola 22"
label variable ksco_22 "Ocupación KSCO en la ola 22"
label variable weight_l_22 "Peso longitudinal en la ola 22"
label variable weight_c_22 "Peso transversal en la ola 22"


count
tab primer_matrimonio_22 unido_22 if hwaveent == 22, mi
replace fathers_edu_22 = .i if fathers_edu_22 == -1
tab fathers_edu_22 if hwaveent == 22, mi
tab siblings_22 if hwaveent == 22, mi
tab nse14_22 if hwaveent == 22, mi
count if inrange(b_cohort_22, 1960, 1989)

save "path\general\wave22_clean.dta", replace

***************************************************
**#* OLA 23 **************************************
***************************************************
use "path\data\klips23p.dta", clear
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_23  = p230104
replace cohorte_23 = .i if cohorte_23 == -1

gen cohorte5_23 = p230104
replace cohorte5_23 = .i if cohorte5_23 == -1

recode cohorte_23 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_23 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_23 = p230105
replace birth_month_23 = .i if birth_month_23 == -1

***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_23   = p239021
replace male_sibs_23 = .i if male_sibs_23 == -1

gen female_sibs_23 = p239022
replace female_sibs_23 = .i if female_sibs_23 == -1

egen siblings_23 = rowtotal(male_sibs_23 female_sibs_23) if !missing(male_sibs_23) | !missing(female_sibs_23)

gen seniority_23 = p239023
replace seniority_23 = .i if seniority_23 == -1

replace siblings_23 = .i if siblings_23 == . & hwaveent == 23
replace siblings_23 = .v if siblings_23 == . & hwaveent != 23

***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_23 = p235501
replace edo_conyug_23 = .i if edo_conyug_23 == -1

gen change_edo_23 = p235502
replace change_edo_23 = .i if change_edo_23 == -1

gen type_changeedo_23 = p235504
replace type_changeedo_23 = .i if type_changeedo_23 == -1

gen y_change_23 = p235505
replace y_change_23 = .i if y_change_23 == -1
replace y_change_23 = .v if type_changeedo_23 != 1

gen m_change_23 = p235506
replace m_change_23 = .i if m_change_23 == -1
replace m_change_23 = .v if type_changeedo_23 != 1

gen unido_23 = 0
replace unido_23 = 1 if inrange(edo_conyug_23,2,5)

gen primer_matrimonio_23 = 0
replace primer_matrimonio_23 = 1 if unido_23 == 1 & type_changeedo_23 == 1

replace primer_matrimonio_23 = .i if unido_23 == 1 & primer_matrimonio_23 == 0 & hwaveent == 23
replace primer_matrimonio_23 = .v if unido_23 == 1 & primer_matrimonio_23 == 0 & inrange(hwaveent, 1, 22)

tab primer_matrimonio_23 unido_23, mi

***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_23 = 2020

gen b_cohort_23 = p230104
replace b_cohort_23 = .i if b_cohort_23 == -1

gen sex_23 = p230101
replace sex_23 = .i if sex_23 == -1

gen edu_23 = p230110
replace edu_23 = .i if edu_23 == -1

gen grad_23 = p230111
replace grad_23 = .i if grad_23 == -1

gen main_act_23 = p230202
replace main_act_23 = .i if main_act_23 == -1

gen edad_23 = p230107
replace edad_23 = .i if edad_23 == -1

gen wrkstatus_23 = p230314
replace wrkstatus_23 = .i if wrkstatus_23 == -1

gen wrkhrs_23 = p230315
replace wrkhrs_23 = .i if wrkhrs_23 == -1

gen ksco_23 = p230350
replace ksco_23 = .i if ksco_23 == -1

***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_23 = w23p_l
replace weight_l_23 = .i if weight_l_23 == -1

gen weight_c_23 = w23p_c
replace weight_c_23 = .i if weight_c_23 == -1
***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_23 = p239051 
label variable fathers_edu_23 "Educación máxima del padre reportada en la ola 23"
recode fathers_edu_23 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_23 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_23 fathers_edu_23

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_23 = p239053 
label variable mothers_edu_23 "Educación máxima de la madre reportada en la ola 23"
recode mothers_edu_23 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_23 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_23 mothers_edu_23


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p239055, mi
clonevar sosten_23 = p239055
label define sosten_23 ///
1 "Padre" ///
2 "Madre" 
label values sosten_23 sosten_23

replace sosten_23 = .i if sosten_23 == -1 

gen parents_activity_23 = p239059

// 143 missing values 
label define parents_activity_23 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_23 parents_activity_23


gen parents_ocupation_23 = p239064

************************************************
*** NSE A LA EDAD 14 ***************************
************************************************
clonevar nse14_23 = p239006 
label variable nse14_23 "Nivel Socioeconómico a los 14 (proxy. IOS)"
tab nse14_23, mi
***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_23 =p230114 
gen m_dropout_23 =p230115 
***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_23 sex_23 cohorte_23 cohorte5_23 edad_23 year_23 ///
birth_month_23 male_sibs_23 female_sibs_23 siblings_23 ///
edo_conyug_23 change_edo_23 type_changeedo_23 y_change_23 m_change_23 ///
primer_matrimonio_23 seniority_23 ///
edu_23 grad_23 main_act_23 wrkhrs_23 wrkstatus_23 ksco_23 ///
weight_l_23 weight_c_23 unido_23 fathers_edu_23 mothers_edu_23 hwaveent ///
sosten_23 parents_activity_23 parents_ocupation_23 ///
nse14_23 y_dropout_23 m_dropout_23


***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 23"
label variable b_cohort_23 "Cohorte de nacimiento en la ola 23"
label variable sex_23 "Sexo en la ola 23"
label variable cohorte_23 "Cohorte decenal en la ola 23"
label variable cohorte5_23 "Cohorte quinquenal en la ola 23"
label variable edad_23 "Edad en la ola 23"
label variable year_23 "Año de la encuesta en la ola 23"
label variable birth_month_23 "Mes de nacimiento en la ola 23"
label variable male_sibs_23 "Número de hermanos varones en la ola 23"
label variable female_sibs_23 "Número de hermanas mujeres en la ola 23"
label variable siblings_23 "Número total de hermanos en la ola 23"
label variable edo_conyug_23 "Estado conyugal en la ola 23"
label variable change_edo_23 "Cambio de estado conyugal en la ola 23"
label variable type_changeedo_23 "Tipo de cambio conyugal en la ola 23"
label variable y_change_23 "Año del cambio conyugal en la ola 23"
label variable m_change_23 "Mes del cambio conyugal en la ola 23"
label variable primer_matrimonio_23 "Ocurrencia de primer matrimonio en la ola 23"
label variable seniority_23 "Orden de nacimiento entre hermanos en la ola 23"
label variable edu_23 "Educación en la ola 23"
label variable grad_23 "Obtención de grado en la ola 23"
label variable main_act_23 "Actividad principal en la ola 23"
label variable wrkhrs_23 "Horas trabajadas en la ola 23"
label variable wrkstatus_23 "Estatus laboral en la ola 23"
label variable ksco_23 "Ocupación KSCO en la ola 23"
label variable weight_l_23 "Peso longitudinal en la ola 23"
label variable weight_c_23 "Peso transversal en la ola 23"

count
tab primer_matrimonio_23 unido_23 if hwaveent == 23, mi
replace fathers_edu_23 = .i if fathers_edu_23 == -1
tab fathers_edu_23 if hwaveent == 23, mi
tab siblings_23 if hwaveent == 23, mi
tab nse14_23 if hwaveent == 23, mi
count if inrange(b_cohort_23, 1960, 1989)

save "path\general\wave23_clean.dta", replace

***************************************************
**#* OLA 24 **************************************
***************************************************
use "path\data\klips24p.dta", clear
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_24  = p240104
replace cohorte_24 = .i if cohorte_24 == -1

gen cohorte5_24 = p240104
replace cohorte5_24 = .i if cohorte5_24 == -1

recode cohorte_24 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_24 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_24 = p240105
replace birth_month_24 = .i if birth_month_24 == -1

***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_24   = p249021
replace male_sibs_24 = .i if male_sibs_24 == -1

gen female_sibs_24 = p249022
replace female_sibs_24 = .i if female_sibs_24 == -1

egen siblings_24 = rowtotal(male_sibs_24 female_sibs_24) if !missing(male_sibs_24) | !missing(female_sibs_24)

gen seniority_24 = p249023
replace seniority_24 = .i if seniority_24 == -1

replace siblings_24 = .i if siblings_24 == . & hwaveent == 24
replace siblings_24 = .v if siblings_24 == . & hwaveent != 24

***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_24 = p245501
replace edo_conyug_24 = .i if edo_conyug_24 == -1

gen change_edo_24 = p245502
replace change_edo_24 = .i if change_edo_24 == -1

gen type_changeedo_24 = p245504
replace type_changeedo_24 = .i if type_changeedo_24 == -1

gen y_change_24 = p245505
replace y_change_24 = .i if y_change_24 == -1
replace y_change_24 = .v if type_changeedo_24 != 1

gen m_change_24 = p245506
replace m_change_24 = .i if m_change_24 == -1
replace m_change_24 = .v if type_changeedo_24 != 1

gen unido_24 = 0
replace unido_24 = 1 if inrange(edo_conyug_24,2,5)

gen primer_matrimonio_24 = 0
replace primer_matrimonio_24 = 1 if unido_24 == 1 & type_changeedo_24 == 1

replace primer_matrimonio_24 = .i if unido_24 == 1 & primer_matrimonio_24 == 0 & hwaveent == 24
replace primer_matrimonio_24 = .v if unido_24 == 1 & primer_matrimonio_24 == 0 & inrange(hwaveent, 1, 23)

tab primer_matrimonio_24 unido_24, mi

***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_24 = 2021

gen b_cohort_24 = p240104
replace b_cohort_24 = .i if b_cohort_24 == -1

gen sex_24 = p240101
replace sex_24 = .i if sex_24 == -1

gen edu_24 = p240110
replace edu_24 = .i if edu_24 == -1

gen grad_24 = p240111
replace grad_24 = .i if grad_24 == -1

gen main_act_24 = p240202
replace main_act_24 = .i if main_act_24 == -1

gen edad_24 = p240107
replace edad_24 = .i if edad_24 == -1

gen wrkstatus_24 = p240314
replace wrkstatus_24 = .i if wrkstatus_24 == -1

gen wrkhrs_24 = p240315
replace wrkhrs_24 = .i if wrkhrs_24 == -1

gen ksco_24 = p240350
replace ksco_24 = .i if ksco_24 == -1

***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_24 = w24p_l
replace weight_l_24 = .i if weight_l_24 == -1

gen weight_c_24 = w24p_c
replace weight_c_24 = .i if weight_c_24 == -1
***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_24 = p249051 
label variable fathers_edu_24 "Educación máxima del padre reportada en la ola 24"
recode fathers_edu_24 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_24 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_24 fathers_edu_24

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_24 = p249053 
label variable mothers_edu_24 "Educación máxima de la madre reportada en la ola 24"
recode mothers_edu_24 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_24 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_24 mothers_edu_24


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p249055, mi
clonevar sosten_24 = p249055
label define sosten_24 ///
1 "Padre" ///
2 "Madre" 
label values sosten_24 sosten_24

replace sosten_24 = .i if sosten_24 == -1 

gen parents_activity_24 = p249059

// 143 missing values 
label define parents_activity_24 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_24 parents_activity_24


gen parents_ocupation_24 = p249064

************************************************
*** NSE A LA EDAD 14 ***************************
************************************************
clonevar nse14_24 = p249006 
label variable nse14_24 "Nivel Socioeconómico a los 14 (proxy. IOS)"
tab nse14_24, mi
***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_24 =p240114 
gen m_dropout_24 =p240115 
***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_24 sex_24 cohorte_24 cohorte5_24 edad_24 year_24 ///
birth_month_24 male_sibs_24 female_sibs_24 siblings_24 ///
edo_conyug_24 change_edo_24 type_changeedo_24 y_change_24 m_change_24 ///
primer_matrimonio_24 seniority_24 ///
edu_24 grad_24 main_act_24 wrkhrs_24 wrkstatus_24 ksco_24 ///
weight_l_24 weight_c_24 unido_24 fathers_edu_24 mothers_edu_24 hwaveent ///
sosten_24 parents_activity_24 parents_ocupation_24 ///
nse14_24 y_dropout_24 m_dropout_24


***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 24"
label variable b_cohort_24 "Cohorte de nacimiento en la ola 24"
label variable sex_24 "Sexo en la ola 24"
label variable cohorte_24 "Cohorte decenal en la ola 24"
label variable cohorte5_24 "Cohorte quinquenal en la ola 24"
label variable edad_24 "Edad en la ola 24"
label variable year_24 "Año de la encuesta en la ola 24"
label variable birth_month_24 "Mes de nacimiento en la ola 24"
label variable male_sibs_24 "Número de hermanos varones en la ola 24"
label variable female_sibs_24 "Número de hermanas mujeres en la ola 24"
label variable siblings_24 "Número total de hermanos en la ola 24"
label variable edo_conyug_24 "Estado conyugal en la ola 24"
label variable change_edo_24 "Cambio de estado conyugal en la ola 24"
label variable type_changeedo_24 "Tipo de cambio conyugal en la ola 24"
label variable y_change_24 "Año del cambio conyugal en la ola 24"
label variable m_change_24 "Mes del cambio conyugal en la ola 24"
label variable primer_matrimonio_24 "Ocurrencia de primer matrimonio en la ola 24"
label variable seniority_24 "Orden de nacimiento entre hermanos en la ola 24"
label variable edu_24 "Educación en la ola 24"
label variable grad_24 "Obtención de grado en la ola 24"
label variable main_act_24 "Actividad principal en la ola 24"
label variable wrkhrs_24 "Horas trabajadas en la ola 24"
label variable wrkstatus_24 "Estatus laboral en la ola 24"
label variable ksco_24 "Ocupación KSCO en la ola 24"
label variable weight_l_24 "Peso longitudinal en la ola 24"
label variable weight_c_24 "Peso transversal en la ola 24"

count
tab primer_matrimonio_24 unido_24 if hwaveent == 24, mi
replace fathers_edu_24 = .i if fathers_edu_24 == -1
tab fathers_edu_24 if hwaveent == 24, mi
tab siblings_24 if hwaveent == 24, mi
tab nse14_24 if hwaveent == 24, mi
count if inrange(b_cohort_24, 1960, 1989)


save "path\general\wave23_clean.dta", replace

***************************************************
**#* OLA 25 **************************************
***************************************************

use "path\data\klips25p.dta", clear
***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_25  = p250104
replace cohorte_25 = .i if cohorte_25 == -1

gen cohorte5_25 = p250104
replace cohorte5_25 = .i if cohorte5_25 == -1

recode cohorte_25 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_25 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_25 = p250105
replace birth_month_25 = .i if birth_month_25 == -1

***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_25   = p259021
replace male_sibs_25 = .i if male_sibs_25 == -1

gen female_sibs_25 = p259022
replace female_sibs_25 = .i if female_sibs_25 == -1

egen siblings_25 = rowtotal(male_sibs_25 female_sibs_25) if !missing(male_sibs_25) | !missing(female_sibs_25)

gen seniority_25 = p259023
replace seniority_25 = .i if seniority_25 == -1

replace siblings_25 = .i if siblings_25 == . & hwaveent == 25
replace siblings_25 = .v if siblings_25 == . & hwaveent != 25

***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_25 = p255501
replace edo_conyug_25 = .i if edo_conyug_25 == -1

gen change_edo_25 = p255502
replace change_edo_25 = .i if change_edo_25 == -1

gen type_changeedo_25 = p255504
replace type_changeedo_25 = .i if type_changeedo_25 == -1

gen y_change_25 = p255505
replace y_change_25 = .i if y_change_25 == -1
replace y_change_25 = .v if type_changeedo_25 != 1

gen m_change_25 = p255506
replace m_change_25 = .i if m_change_25 == -1
replace m_change_25 = .v if type_changeedo_25 != 1

gen unido_25 = 0
replace unido_25 = 1 if inrange(edo_conyug_25,2,5)

gen primer_matrimonio_25 = 0
replace primer_matrimonio_25 = 1 if unido_25 == 1 & type_changeedo_25 == 1

replace primer_matrimonio_25 = .i if unido_25 == 1 & primer_matrimonio_25 == 0 & hwaveent == 25
replace primer_matrimonio_25 = .v if unido_25 == 1 & primer_matrimonio_25 == 0 & inrange(hwaveent, 1, 24)

tab primer_matrimonio_25 unido_25, mi

***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_25 = 2022

gen b_cohort_25 = p250104
replace b_cohort_25 = .i if b_cohort_25 == -1

gen sex_25 = p250101
replace sex_25 = .i if sex_25 == -1

gen edu_25 = p250110
replace edu_25 = .i if edu_25 == -1

gen grad_25 = p250111
replace grad_25 = .i if grad_25 == -1

gen main_act_25 = p250202
replace main_act_25 = .i if main_act_25 == -1

gen edad_25 = p250107
replace edad_25 = .i if edad_25 == -1

gen wrkstatus_25 = p250314
replace wrkstatus_25 = .i if wrkstatus_25 == -1

gen wrkhrs_25 = p250315
replace wrkhrs_25 = .i if wrkhrs_25 == -1

gen ksco_25 = p250350
replace ksco_25 = .i if ksco_25 == -1

***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_25 = w25p_l
replace weight_l_25 = .i if weight_l_25 == -1

gen weight_c_25 = w25p_c
replace weight_c_25 = .i if weight_c_25 == -1
***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_25 = p259051 
label variable fathers_edu_25 "Educación máxima del padre reportada en la ola 25"
recode fathers_edu_25 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_25 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_25 fathers_edu_25

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_25 = p259053 
label variable mothers_edu_25 "Educación máxima de la madre reportada en la ola 25"
recode mothers_edu_25 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_25 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_25 mothers_edu_25


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p259055, mi
clonevar sosten_25 = p259055
label define sosten_25 ///
1 "Padre" ///
2 "Madre" 
label values sosten_25 sosten_25

replace sosten_25 = .i if sosten_25 == -1 

gen parents_activity_25 = p259059

// 143 missing values 
label define parents_activity_25 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_25 parents_activity_25


gen parents_ocupation_25 = p259064

************************************************
*** NSE A LA EDAD 14 ***************************
************************************************
clonevar nse14_25 = p259006 
label variable nse14_25 "Nivel Socioeconómico a los 14 (proxy. IOS)"
tab nse14_25, mi
***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_25 =p250114 
gen m_dropout_25 =p250115 
***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_25 sex_25 cohorte_25 cohorte5_25 edad_25 year_25 ///
birth_month_25 male_sibs_25 female_sibs_25 siblings_25 ///
edo_conyug_25 change_edo_25 type_changeedo_25 y_change_25 m_change_25 ///
primer_matrimonio_25 seniority_25 ///
edu_25 grad_25 main_act_25 wrkhrs_25 wrkstatus_25 ksco_25 ///
weight_l_25 weight_c_25 unido_25 fathers_edu_25 mothers_edu_25 hwaveent ///
sosten_25 parents_activity_25 parents_ocupation_25 ///
nse14_25 y_dropout_25 m_dropout_25


***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 25"
label variable b_cohort_25 "Cohorte de nacimiento en la ola 25"
label variable sex_25 "Sexo en la ola 25"
label variable cohorte_25 "Cohorte decenal en la ola 25"
label variable cohorte5_25 "Cohorte quinquenal en la ola 25"
label variable edad_25 "Edad en la ola 25"
label variable year_25 "Año de la encuesta en la ola 25"
label variable birth_month_25 "Mes de nacimiento en la ola 25"
label variable male_sibs_25 "Número de hermanos varones en la ola 25"
label variable female_sibs_25 "Número de hermanas mujeres en la ola 25"
label variable siblings_25 "Número total de hermanos en la ola 25"
label variable edo_conyug_25 "Estado conyugal en la ola 25"
label variable change_edo_25 "Cambio de estado conyugal en la ola 25"
label variable type_changeedo_25 "Tipo de cambio conyugal en la ola 25"
label variable y_change_25 "Año del cambio conyugal en la ola 25"
label variable m_change_25 "Mes del cambio conyugal en la ola 25"
label variable primer_matrimonio_25 "Ocurrencia de primer matrimonio en la ola 25"
label variable seniority_25 "Orden de nacimiento entre hermanos en la ola 25"
label variable edu_25 "Educación en la ola 25"
label variable grad_25 "Obtención de grado en la ola 25"
label variable main_act_25 "Actividad principal en la ola 25"
label variable wrkhrs_25 "Horas trabajadas en la ola 25"
label variable wrkstatus_25 "Estatus laboral en la ola 25"
label variable ksco_25 "Ocupación KSCO en la ola 25"
label variable weight_l_25 "Peso longitudinal en la ola 25"
label variable weight_c_25 "Peso transversal en la ola 25"

count
tab primer_matrimonio_25 unido_25 if hwaveent == 25, mi
replace fathers_edu_25 = .i if fathers_edu_25 == -1
tab fathers_edu_25 if hwaveent == 25, mi
tab siblings_25 if hwaveent == 25, mi
tab nse14_25 if hwaveent == 25, mi
count if inrange(b_cohort_25, 1960, 1989)

save "path\general\wave25_clean.dta", replace

***************************************************
**#* OLA 26 **************************************
***************************************************

use "path\data\klips26p.dta", clear

***************************************************
*** COHORTES **************************************
***************************************************
gen cohorte_26  = p260104
replace cohorte_26 = .i if cohorte_26 == -1

gen cohorte5_26 = p260104
replace cohorte5_26 = .i if cohorte5_26 == -1

recode cohorte_26 ///
 (1800/1959=1) ///
 (1960/1969=2) ///
 (1970/1979=3) ///
 (1980/1989=4) ///
 (1990/1999=5) ///
 (2000/2009=6) ///
 (else=.)

recode cohorte5_26 ///
 (1800/1959=1) ///
 (1960/1964=2) ///
 (1965/1969=3) ///
 (1970/1974=4) ///
 (1975/1979=5) ///
 (1980/1984=6) ///
 (1985/1989=7) ///
 (1990/1994=8) ///
 (1995/1999=9) ///
 (2000/2004=10) ///
 (2005/2009=11) ///
 (else=.)

gen birth_month_26 = p260105
replace birth_month_26 = .i if birth_month_26 == -1

***************************************************
*** HERMANOS **************************************
***************************************************
gen male_sibs_26   = p269021
replace male_sibs_26 = .i if male_sibs_26 == -1

gen female_sibs_26 = p269022
replace female_sibs_26 = .i if female_sibs_26 == -1

egen siblings_26 = rowtotal(male_sibs_26 female_sibs_26) if !missing(male_sibs_26) | !missing(female_sibs_26)

gen seniority_26 = p269023
replace seniority_26 = .i if seniority_26 == -1

replace siblings_26 = .i if siblings_26 == . & hwaveent == 26
replace siblings_26 = .v if siblings_26 == . & hwaveent != 26

***************************************************
*** ESTADO CONYUGAL *******************************
***************************************************
gen edo_conyug_26 = p265501
replace edo_conyug_26 = .i if edo_conyug_26 == -1

gen change_edo_26 = p265502
replace change_edo_26 = .i if change_edo_26 == -1

gen type_changeedo_26 = p265504
replace type_changeedo_26 = .i if type_changeedo_26 == -1

gen y_change_26 = p265505
replace y_change_26 = .i if y_change_26 == -1
replace y_change_26 = .v if type_changeedo_26 != 1

gen m_change_26 = p265506
replace m_change_26 = .i if m_change_26 == -1
replace m_change_26 = .v if type_changeedo_26 != 1

gen unido_26 = 0
replace unido_26 = 1 if inrange(edo_conyug_26,2,5)

gen primer_matrimonio_26 = 0
replace primer_matrimonio_26 = 1 if unido_26 == 1 & type_changeedo_26 == 1

replace primer_matrimonio_26 = .i if unido_26 == 1 & primer_matrimonio_26 == 0 & hwaveent == 26
replace primer_matrimonio_26 = .v if unido_26 == 1 & primer_matrimonio_26 == 0 & inrange(hwaveent, 1, 25)

tab primer_matrimonio_26 unido_26, mi

***************************************************
*** VARIABLES GENERALES ***************************
***************************************************
gen year_26 = 2023

gen b_cohort_26 = p260104
replace b_cohort_26 = .i if b_cohort_26 == -1

gen sex_26 = p260101
replace sex_26 = .i if sex_26 == -1

gen edu_26 = p260110
replace edu_26 = .i if edu_26 == -1

gen grad_26 = p260111
replace grad_26 = .i if grad_26 == -1

gen main_act_26 = p260202
replace main_act_26 = .i if main_act_26 == -1

gen edad_26 = p260107
replace edad_26 = .i if edad_26 == -1

gen wrkstatus_26 = p260314
replace wrkstatus_26 = .i if wrkstatus_26 == -1

gen wrkhrs_26 = p260315
replace wrkhrs_26 = .i if wrkhrs_26 == -1

gen ksco_26 = p260350
replace ksco_26 = .i if ksco_26 == -1

***************************************************
*** PESOS *****************************************
***************************************************
gen weight_l_26 = w26p_l
replace weight_l_26 = .i if weight_l_26 == -1

gen weight_c_26 = w26p_c
replace weight_c_26 = .i if weight_c_26 == -1
***************************************************
*** ORIGEN SOCIAL**********************************
***************************************************
//EDUCACIÓN DEL PADRE 
clonevar fathers_edu_26 = p269051 
label variable fathers_edu_26 "Educación máxima del padre reportada en la ola 26"
recode fathers_edu_26 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define fathers_edu_26 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values fathers_edu_26 fathers_edu_26

/// EDUCACION DE LA MADRE 
clonevar mothers_edu_26 = p269053 
label variable mothers_edu_26 "Educación máxima de la madre reportada en la ola 26"
recode mothers_edu_26 ///
(1 = 1) /// sin edu
(2 = 2) /// primaria 
(3 = 3) /// secundaria
(4 = 4) /// prepa 
(5/7 = 5) 

label define mothers_edu_26 ///
1 "Sin Educación" ///
2 "Primaria" ///
3 "Secundaria" ///
4 "Preparatoria" ///
5 "Universidad"
label values mothers_edu_26 mothers_edu_26


//OCUPACIÓN DEL PADRE CUANDO LA PERSONA TENÍA 14
tab p269055, mi
clonevar sosten_26 = p269055
label define sosten_26 ///
1 "Padre" ///
2 "Madre" 
label values sosten_26 sosten_26

replace sosten_26 = .i if sosten_26 == -1 

gen parents_activity_26 = p269059

// 143 missing values 
label define parents_activity_26 ///
 1 "Regular/trabajador asalariado estándar" ///
 2 "Irregular/trabajador asalariado inestable" ///
 3 "Empleador (con empleados)" /// 
 4 "Cuenta propia (sin empleados)"  ///
 5 "Trabajador familiar" ///
 6 "Sin trabajo / ama de casa"   
label values parents_activity_26 parents_activity_26


gen parents_ocupation_26 = p269064

************************************************
*** NSE A LA EDAD 14 ***************************
************************************************
clonevar nse14_26 = p269006 
label variable nse14_26 "Nivel Socioeconómico a los 14 (proxy. IOS)"
tab nse14_26, mi
***************************************************
***************SALIDA DE LA ESCUELA**************** 
***************************************************
gen y_dropout_26 =p260114 
gen m_dropout_26 =p260115 
***************************************************
*** KEEP ******************************************
***************************************************
keep pid b_cohort_26 sex_26 cohorte_26 cohorte5_26 edad_26 year_26 ///
birth_month_26 male_sibs_26 female_sibs_26 siblings_26 ///
edo_conyug_26 change_edo_26 type_changeedo_26 y_change_26 m_change_26 ///
primer_matrimonio_26 seniority_26 ///
edu_26 grad_26 main_act_26 wrkhrs_26 wrkstatus_26 ksco_26 ///
weight_l_26 weight_c_26 unido_26 fathers_edu_26 mothers_edu_26 hwaveent ///
sosten_26 parents_activity_26 parents_ocupation_26 ///
nse14_26 y_dropout_26 m_dropout_26

***************************************************
*** LABELS ****************************************
***************************************************
label variable pid "Identificador de la persona en la ola 26"
label variable b_cohort_26 "Cohorte de nacimiento en la ola 26"
label variable sex_26 "Sexo en la ola 26"
label variable cohorte_26 "Cohorte decenal en la ola 26"
label variable cohorte5_26 "Cohorte quinquenal en la ola 26"
label variable edad_26 "Edad en la ola 26"
label variable year_26 "Año de la encuesta en la ola 26"
label variable birth_month_26 "Mes de nacimiento en la ola 26"
label variable male_sibs_26 "Número de hermanos varones en la ola 26"
label variable female_sibs_26 "Número de hermanas mujeres en la ola 26"
label variable siblings_26 "Número total de hermanos en la ola 26"
label variable edo_conyug_26 "Estado conyugal en la ola 26"
label variable change_edo_26 "Cambio de estado conyugal en la ola 26"
label variable type_changeedo_26 "Tipo de cambio conyugal en la ola 26"
label variable y_change_26 "Año del cambio conyugal en la ola 26"
label variable m_change_26 "Mes del cambio conyugal en la ola 26"
label variable primer_matrimonio_26 "Ocurrencia de primer matrimonio en la ola 26"
label variable seniority_26 "Orden de nacimiento entre hermanos en la ola 26"
label variable edu_26 "Educación en la ola 26"
label variable grad_26 "Obtención de grado en la ola 26"
label variable main_act_26 "Actividad principal en la ola 26"
label variable wrkhrs_26 "Horas trabajadas en la ola 26"
label variable wrkstatus_26 "Estatus laboral en la ola 26"
label variable ksco_26 "Ocupación KSCO en la ola 26"
label variable weight_l_26 "Peso longitudinal en la ola 26"
label variable weight_c_26 "Peso transversal en la ola 26"

count
tab primer_matrimonio_26 unido_26 if hwaveent == 26, mi
replace fathers_edu_26 = .i if fathers_edu_26 == -1
tab fathers_edu_26 if hwaveent == 26, mi
tab siblings_26 if hwaveent == 26, mi
tab nse14_26 if hwaveent == 26, mi
count if inrange(b_cohort_26, 1960, 1989)

save "path\general\wave26_clean.dta", replace
//log close 

