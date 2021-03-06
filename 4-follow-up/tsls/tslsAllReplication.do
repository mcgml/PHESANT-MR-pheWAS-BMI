* apps/stata14

local resDir : env RES_DIR
local dataDir : env PROJECT_DATA




* 1: 150K sample in IJE PHESANT paper
* 2: 500K sample minus participants found to be related to 150K sample

foreach i in 1 2 {

* results file setup
tempname memhold
postfile `memhold' str60 field str60 test estimate lower upper  using "`resDir'/nervous-followup/nervous-results-replication-sample`i'.dta" , replace


**
** load and prepare data

insheet using "`dataDir'/phenotypes/derived/nervous-dataset-replication.csv", clear

keep if sample == `i'

summ x21001_0_0

rename x31_0_0 sex
rename x21022_0_0 age

summ sex
summ age

* standardise scores

summ snpscore96
summ snpscore95

egen snpscore96std = std(snpscore96)
egen snpscore95std = std(snpscore95)

replace snpscore96 = snpscore96std
replace snpscore95 = snpscore95std

summ snpscore96
summ snpscore95

* standardised BMI
egen x21001_0_0std = std(x21001_0_0)


log using "`resDir'/nervous-followup/nervous-results-fstats-replication-sample`i'.log", text replace

summ 


****
**** f statistics

*  f statistic of each genetic IV

regress x21001_0_0 snpscore96

regress x21001_0_0 rs1558902

regress x21001_0_0 snpscore95

log close


****
**** tsls analysis of each nervousness trait

do tslsReplication "x1970_0_0" `memhold' `i'

do tslsReplication "x1980_0_0" `memhold' `i'

do tslsReplication "x1990_0_0" `memhold' `i'

do tslsReplication "x2010_0_0" `memhold' `i'


postclose `memhold' 

clear

}

exit


