PROCEDURE rates(vm) {  
        LOCAL  a, b

	a = trap0(vm,tha,Ra,qa)
	b = trap0(-vm,-tha,Rb,qa)

        tadj = q10^((celsius - temp)/10)

	mtau = 1/tadj/(a+b)
	minf = a/(a+b)

		:"h" inactivation 

	a = trap0(vm,thi1,Rd,qi)
	b = trap0(-vm,-thi2,Rg,qi)
	htau = 1/tadj/(a+b)
	hinf = 1/(1+exp((vm-thinf)/qinf))
}

