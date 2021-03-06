* apps/stata14

local resDir : env RES_DIR
local dataDir : env PROJECT_DATA

* results file setup
tempname memhold
postfile `memhold' str60 field str60 test estimate lower upper  using "`resDir'/nervous-followup/nervous-results.dta" , replace


**
** load and prepare data

insheet using "`dataDir'/phenotypes/derived/nervous-dataset.csv", clear

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

log using "`resDir'/nervous-followup/nervous-results-fstats.log", text replace

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

do tsls "x1970_0_0" `memhold'

do tsls "x1980_0_0" `memhold'

do tsls "x1990_0_0" `memhold'

do tsls "x2010_0_0" `memhold'


* other anxiety / nervous fields
do tsls "x2100_0_0" `memhold'
do tsls "x2090_0_0" `memhold'
do tslsContinuous "x2070_0_0" `memhold'




postclose `memhold' 

exit, clear
