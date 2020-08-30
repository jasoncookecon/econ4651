
cd "C:\Users\Jason Cook\Box Sync\Teaching\Jason Cook\QAMO_UG_Intro_Metrics\Lectures\03-Statistics_Review\stata"
use "county_cases_through_5_24_2020",clear

set seed 1234
keep if date == "2020-05-23"
sum cases

* Look at Central Limit Theorem by using Bootstraps of average age
bootstrap mean=r(mu_1), rep(5000) saving(bscovid, replace): ttest cases=560


use bscovid,clear
sum mean,d
gen mean_m = mean - `r(mean)'
gen mean_std = mean_m / `r(sd)'
di "`r(p95)' `r(p5)'"
di "SD = `r(sd)'"


histogram mean, normal xtitle(Average Cases) xline(`r(p95)' `r(p5)')
graph export mean_covid.png,replace as(png)

histogram mean, normal xtitle(Average Cases) 
graph export sampdist_covid.png,replace as(png)

sum mean_m,d
histogram mean_m, normal xtitle(Average Cases - E[Y]) xline(`r(p95)' `r(p5)')
graph export mean_m_covid.png,replace as(png)

sum mean_std,d
histogram mean_std, normal xtitle(Average Cases - E[Y] / SE) xline(-1.96 1.96)
graph export mean_std_cps.png,replace as(png)
* close log file
log close
* see ya
