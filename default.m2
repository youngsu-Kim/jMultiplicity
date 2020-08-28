-- Aug 21, 2020
R = QQ[x_1..x_8]
M = genericMatrix(R,4,2)

R = ZZ/31[x_1..x_10], M = genericMatrix(R,5,2)
R = QQ[x_1..x_9], M = genericMatrix(R,3,3)

maxR = ideal vars R
I = minors(2,M)
dMinusI = dim R - dim (R/I), l = analyticSpread I

-- general elements
genEleMat = (gens I) * random(ZZ^(numgens I), ZZ^l); -- here l is the analytic spread of I, change QQ to the ring R

dMinusI >= 2 -- add ``if''
    colonIdeals = for i from dMinusI to l list time {i,(saturate(ideal submatrix(genEleMat,{0..(i-2)}),I) + ideal submatrix(genEleMat,{i-1}) )}; -- x_1..x_(i-1):I^infty + (x_i)
    time apply(colonIdeals, i -> codim i_1) == for i from dMinusI to l list i -- this checks if x_1..x_(i-1):I^infty + (x_i) is of codim i.
needsPackage "MinimalPrimes" -- Justin's suggestion 
installMinprimes()
    minPrimesOfColonIdeals = for i from 0 to (#colonIdeals-1) list time {(colonIdeals_(i))_0, minimalPrimes (I+(colonIdeals_(i))_1 ) };

-- e(m, R/I)
multiplicityG := (I)-> {
    RRR := (ring I)/I;
    maxR := ideal vars RRR;
    if (dim RRR == 0) then return (degree comodule primaryComponent (I, maxR)); -- finite colength case; 
    genLinComMat := (gens maxR) * random (ZZ^(numgens maxR), ZZ^(dim RRR));
    colInGenLinComMat := numcols genLinComMat;
    genRedIdeal = ideal (0_RRR);
    if (dim RRR == 1) then genRedIdeal = saturate (ideal (0_RRR), maxR) + ideal genLinComMat  -- the case of dim R/I = 1
    -- the case of dim R/I >= 2
        else genRedIdeal = saturate (ideal submatrix (genLinComMat, {0..(colInGenLinComMat - 2)}), maxR) + ideal genLinComMat;     
    -- if (codim genRedIdeal != dim RRR) then return "Elements chosen are not general. Try again."; 
    -- blank line
    use ring I;
    -- return length comodule primaryComponent (genRedIdeal,maxR) 
    -- the length method doesn't handle the non-graded case, but the degree function does.
    return degree comodule primaryComponent (genRedIdeal,maxR) 
    }

-- for loop
j = 3
    idealIn21 = ((select (colonIdeals, i-> i_0 == j))_0)_1; 
    primesIn21 = ((select (minPrimesOfColonIdeals, i-> i_0 == j))_0)_1;
    time for i from 0 to (#primesIn21 -1) list multiplicityG primaryComponent(idealIn21, primesIn21_i)
    {j,sum oo}
    
j = 4
    idealIn21 = ((select (colonIdeals, i-> i_0 == j))_0)_1; 
    primesIn21 = ((select (minPrimesOfColonIdeals, i-> i_0 == j))_0)_1;
    for i from 0 to (#primesIn21 -1) list time multiplicityG localize(idealIn21, primesIn21_i) 
    for i from 0 to (#primesIn21 -1) list time multiplicityG primaryComponent(idealIn21, primesIn21_i) -- localize is faster than primaryComponent
    {j,sum oo}
---- The case of homogeneous ideals
---- Method 1
    idealIn21 = ((select (colonIdeals, i-> i_0 == j))_0)_1; 
    time primesIn21 = minimalPrimes idealIn21;
    time primesIn21NotConI = select (primesIn21, i-> not isSubset(I,i));
    time intPrimesIn21NotConI = primesIn21NotConI // intersect;
    time saturate(idealIn21, intPrimesIn21NotConI);
    time if isHomogeneous oo then degree oo     
---- Method 2 
    idealIn21 = ((select (colonIdeals, i-> i_0 == j))_0)_1;
    time primesIn21 = minimalPrimes (idealIn21+I);
    time primesIn21 // intersect;
    time saturate(idealIn21, saturate(idealIn21,oo)); -- possible to have embedded components, need to check if inner saturated ideal is unit ideal (e.g. j = 7 with I_2(5x2 generic))
    time if isHomogeneous oo then degree oo     
 
 L = {3,3,3,3}
 randomMonomialIdeal (L, R)
 ideal(x^2*y,x^2*z,z^3,x^2*w) -- codim I = 2, l(I) = 4 check c_3.
-- non m-primary component































</pre></body></html>Ztext/plainUUTF-8_Mhttps://raw.githubusercontent.com/youngsu-Kim/jMultiplicity/master/default.m2    ( ? Q g � � ����                           <