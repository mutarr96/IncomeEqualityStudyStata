*VARIABLE DESCRIPTION 
*time	Year
*gini 	Gini Index
*op		Trade Openness
*gdp	GDP Per Capita
*ge		Government Expenditure
*iv		Investment
*hc		Human Capital
*psav	Political Stability and Absence of Violence or Terrorism 


*LINEAR CASE WITH ALL TESTS
*(LOGS FOR GDP, GE, OP, IV)
clear
import excel "C:\Users\Mutarr\Desktop\PANEL DATA (2000-2010).xls", sheet("PANEL_DATA") firstrow
egen countrynum=group(countryname)
destring, replace
xtset countrynum time, yearly
gen lngdp=log(gdp)
gen lnge=log(ge)
gen lnop=log(op)
gen lniv=log(iv)
*RANDOM EFFECTS MODEL
xtreg lngdp gini lnge lnop lniv hc, re
estimates store re
*FIXED EFFECTS MODEL
xtreg lngdp gini lnge lnop lniv hc, fe
estimates store fe
*HAUSMAN TEST
hausman fe re, sigmamore
*FIRST DIFFERENCE
gen gdpdiff=lngdp[_n]-lngdp[_n-1]
gen ginidiff=gini[_n]-gini[_n-1]
gen opdiff=lnop[_n]-lnop[_n-1]
gen gediff=lnge[_n]-lnge[_n-1]
gen ivdiff=lniv[_n]-lniv[_n-1]
gen hcdiff=hc[_n]-hc[_n-1]
reg gdpdiff ginidiff opdiff gediff ivdiff hcdiff, nocons
xtreg gdpdiff ginidiff opdiff gediff ivdiff hcdiff
*WOOLDRIDGE TEST FOR SERIAL CORRELATION
xtserial lngdp gini lnge lnop lniv hc, output
*LEVIN-LIN-CHU UNIT ROOT TEST
xtunitroot llc lngdp
xtunitroot llc d.lngdp
xtunitroot llc gini
xtunitroot llc d.gini
xtunitroot llc lnge
xtunitroot llc d.lnge
xtunitroot llc lnop
xtunitroot llc d.lnop
xtunitroot llc lniv
xtunitroot llc d.lniv
xtunitroot llc hc
xtunitroot llc d.hc
*PEDRONI PANEL COINTEGRATION TEST
xtcointtest pedroni lngdp gini lnge lnop lniv hc


*NONLINEAR CASE WITH ALL TESTS
*(LOGS FOR GDP, GE, OP, IV)
clear
import excel "C:\Users\Mutarr\Desktop\PANEL DATA (2000-2010).xls", sheet("PANEL_DATA") firstrow
egen countrynum=group(countryname)
destring, replace
xtset countrynum time, yearly
gen lngdp=log(gdp)
gen lnge=log(ge)
gen lnop=log(op)
gen lniv=log(iv)
gen gini2=gini*gini 
*RANDOM EFFECTS MODEL
xtreg lngdp gini2 lnge lnop lniv hc, re
estimates store re
*FIXED EFFECTS MODEL
xtreg lngdp gini2 lnge lnop lniv hc, fe
estimates store fe
*HAUSMAN TEST
hausman fe re, sigmamore
*FIRST DIFFERENCE
gen gdpdiff=lngdp[_n]-lngdp[_n-1]
gen gini2diff=gini2[_n]-gini2[_n-1]
gen opdiff=lnop[_n]-lnop[_n-1]
gen gediff=lnge[_n]-lnge[_n-1]
gen ivdiff=lniv[_n]-lniv[_n-1]
gen hcdiff=hc[_n]-hc[_n-1]
reg gdpdiff gini2diff opdiff gediff ivdiff hcdiff, nocons
xtreg gdpdiff gini2diff opdiff gediff ivdiff hcdiff
*WOOLDRIDGE TEST FOR SERIAL CORRELATION
xtserial lngdp gini2 lnge lnop lniv hc, output
*LEVIN-LIN-CHU UNIT ROOT TEST
xtunitroot llc lngdp
xtunitroot llc d.lngdp
xtunitroot llc gini2
xtunitroot llc d.gini2
xtunitroot llc lnge
xtunitroot llc d.lnge
xtunitroot llc lnop
xtunitroot llc d.lnop
xtunitroot llc lniv
xtunitroot llc d.lniv
xtunitroot llc hc
xtunitroot llc d.hc
*PEDRONI PANEL COINTEGRATION TEST
xtcointtest pedroni lngdp gini2 lnge lnop lniv hc

*RESULTS
*(LOGS FOR GDP, GE, OP, IV)
*LINEAR CASE
clear
import excel "C:\Users\Mutarr\Desktop\PANEL DATA (2000-2010).xls", sheet("PANEL_DATA") firstrow
egen countrynum=group(countryname)
destring, replace
xtset countrynum time, yearly
gen lngdp=log(gdp)
gen lnge=log(ge)
gen lnop=log(op)
gen lniv=log(iv) 
gen gl1=l.gini
*RANDOM EFFECTS MODEL
xtreg lngdp gl1 lnge lnop lniv hc psav, re
estimates store re
*FIXED EFFECTS MODEL
xtreg lngdp gl1 lnge lnop lniv hc psav, fe
estimates store fe
*HAUSMAN TEST
hausman fe re, sigmamore

*WOOLDRIDGE TEST FOR SERIAL CORRELATION
xtserial lngdp gl1 lnge lnop lniv hc psav, output

*FIRST DIFFERENCE (METHOD 2)
gen gdpdiff=d.lngdp
gen ginidiff=d.gl1
gen opdiff=d.lnop
gen gediff=d.lnge
gen ivdiff=d.lniv
gen hcdiff=d.hc
gen psavdiff=d.psav 
reg gdpdiff ginidiff opdiff gediff ivdiff hcdiff psavdiff, nocons


*NONLINEAR CASE 
clear
import excel "C:\Users\Mutarr\Desktop\PANEL DATA (2000-2010).xls", sheet("PANEL_DATA") firstrow
egen countrynum=group(countryname)
destring, replace
xtset countrynum time, yearly
gen lngdp=log(gdp)
gen lnge=log(ge)
gen lnop=log(op)
gen lniv=log(iv)
gen gl1=l.gini
gen gl1sq=gl1*gl1
*RANDOM EFFECTS MODEL
xtreg lngdp gl1sq lnge lnop lniv hc psav, re
estimates store re
*FIXED EFFECTS MODEL
xtreg lngdp gl1sq lnge lnop lniv hc psav, fe
estimates store fe
*HAUSMAN TEST
hausman fe re, sigmamore 

*WOOLDRIDGE TEST FOR SERIAL CORRELATION
xtserial lngdp gl1sq lnge lnop lniv hc psav, output

*FIRST DIFFERENCE (METHOD 2)
gen gdpdiff=d.lngdp
gen gini2diff=d.gl1sq
gen opdiff=d.lnop
gen gediff=d.lnge
gen ivdiff=d.lniv
gen hcdiff=d.hc
gen psavdiff=d.psav
reg gdpdiff gini2diff opdiff gediff ivdiff hcdiff psavdiff, nocons


*PEDRONI PANEL COINTEGRATION TEST FOR LINEAR CASE
xtcointtest pedroni lngdp gl1 lnge lnop lniv hc psav

*PEDRONI PANEL COINTEGRATION TEST FOR NONLINEAR CASE
xtcointtest pedroni lngdp gl1sq lnge lnop lniv hc psav

*Perform a LLC unit root test at levels (ie without logs) and at first difference
*LEVIN-LIN-CHU UNIT ROOT TEST FOR LINEAR CASE
xtunitroot llc gdp
xtunitroot llc d.gdp
xtunitroot llc gini
xtunitroot llc d.gini
xtunitroot llc ge
xtunitroot llc d.ge
xtunitroot llc op
xtunitroot llc d.op
xtunitroot llc iv
xtunitroot llc d.iv
xtunitroot llc hc
xtunitroot llc d.hc
xtunitroot llc psav
xtunitroot llc d.psav
*It is not necessary to perform a unit root test for linear and non linear case separately because the unit root test is performed in levels and at first difference 

