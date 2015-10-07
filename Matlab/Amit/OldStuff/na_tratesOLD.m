PROCEDURE trates(v) {  
                      
        
        TABLE minf,  hinf, mtau, htau
	DEPEND  celsius, temp, Ra, Rb, Rd, Rg, tha, thi1, thi2, qa, qi, qinf
	
	FROM vmin TO vmax WITH 199

	rates(v): not consistently executed from here if usetable == 1

:        tinc = -dt * tadj

:        mexp = 1 - exp(tinc/mtau)
:        hexp = 1 - exp(tinc/htau)
}

