function K = equilibrium_constant_prec(obj,temp)

  K = zeros(6,1);
  if 300.000000 <= temp && temp <= 1000.000000
    K(1) = ...
       exp( 1*(2.5000000000e+00*log(temp)-4.4668285300e-01+temp*(7.0533281900e-13+temp*(-9.9795982000e-16+temp*(7.6693877333e-19+temp*-2.3193308300e-22))))) ...
      *exp(+1*(3.9920154300e+00*log(temp)-1.0392545800e-01+temp*(-2.4013175200e-03+temp*(2.3089692050e-06+temp*(-1.2937111100e-09+temp*3.4102867500e-13))))) ...
      *exp(-1*(3.1682671000e+00*log(temp)+2.0519334600e+00+temp*(-3.2793188400e-03+temp*(3.3215319800e-06+temp*(-2.0426887467e-09+temp*5.2816492750e-13))))) ...
      *exp(-1*(2.3443311200e+00*log(temp)+6.8301023800e-01+temp*(7.9805207500e-03+temp*(-9.7390755000e-06+temp*(6.7190698000e-09+temp*-1.8440294025e-12))))) ...
      /exp( 1*(2.5473659900e+04+temp*(2.5000000000e+00+temp*(3.5266640950e-13+temp*(-6.6530654667e-16+temp*(5.7520408000e-19+temp*-1.8554646640e-22)))))/temp) ...
      /exp(+1*(3.6150805600e+03+temp*(3.9920154300e+00+temp*(-1.2006587600e-03+temp*(1.5393128033e-06+temp*(-9.7028333250e-10+temp*2.7282294000e-13)))))/temp) ...
      /exp(-1*(2.9122259200e+04+temp*(3.1682671000e+00+temp*(-1.6396594200e-03+temp*(2.2143546533e-06+temp*(-1.5320165600e-09+temp*4.2253194200e-13)))))/temp) ...
      /exp(-1*(-9.1793517300e+02+temp*(2.3443311200e+00+temp*(3.9902603750e-03+temp*(-6.4927170000e-06+temp*(5.0393023500e-09+temp*-1.4752235220e-12)))))/temp);
    K(2) = ...
       exp( 1*(4.1986405600e+00*log(temp)-8.4903220800e-01+temp*(-2.0364341000e-03+temp*(3.2602010550e-06+temp*(-1.8293235400e-09+temp*4.4299454250e-13))))) ...
      *exp(+1*(2.5000000000e+00*log(temp)-4.4668285300e-01+temp*(7.0533281900e-13+temp*(-9.9795982000e-16+temp*(7.6693877333e-19+temp*-2.3193308300e-22))))) ...
      *exp(-1*(2.3443311200e+00*log(temp)+6.8301023800e-01+temp*(7.9805207500e-03+temp*(-9.7390755000e-06+temp*(6.7190698000e-09+temp*-1.8440294025e-12))))) ...
      *exp(-1*(3.9920154300e+00*log(temp)-1.0392545800e-01+temp*(-2.4013175200e-03+temp*(2.3089692050e-06+temp*(-1.2937111100e-09+temp*3.4102867500e-13))))) ...
      /exp( 1*(-3.0293726700e+04+temp*(4.1986405600e+00+temp*(-1.0182170500e-03+temp*(2.1734673700e-06+temp*(-1.3719926550e-09+temp*3.5439563400e-13)))))/temp) ...
      /exp(+1*(2.5473659900e+04+temp*(2.5000000000e+00+temp*(3.5266640950e-13+temp*(-6.6530654667e-16+temp*(5.7520408000e-19+temp*-1.8554646640e-22)))))/temp) ...
      /exp(-1*(-9.1793517300e+02+temp*(2.3443311200e+00+temp*(3.9902603750e-03+temp*(-6.4927170000e-06+temp*(5.0393023500e-09+temp*-1.4752235220e-12)))))/temp) ...
      /exp(-1*(3.6150805600e+03+temp*(3.9920154300e+00+temp*(-1.2006587600e-03+temp*(1.5393128033e-06+temp*(-9.7028333250e-10+temp*2.7282294000e-13)))))/temp);
    K(3) = ...
       exp( 2*(3.9920154300e+00*log(temp)-1.0392545800e-01+temp*(-2.4013175200e-03+temp*(2.3089692050e-06+temp*(-1.2937111100e-09+temp*3.4102867500e-13))))) ...
      *exp(-1*(3.1682671000e+00*log(temp)+2.0519334600e+00+temp*(-3.2793188400e-03+temp*(3.3215319800e-06+temp*(-2.0426887467e-09+temp*5.2816492750e-13))))) ...
      *exp(-1*(4.1986405600e+00*log(temp)-8.4903220800e-01+temp*(-2.0364341000e-03+temp*(3.2602010550e-06+temp*(-1.8293235400e-09+temp*4.4299454250e-13))))) ...
      /exp( 2*(3.6150805600e+03+temp*(3.9920154300e+00+temp*(-1.2006587600e-03+temp*(1.5393128033e-06+temp*(-9.7028333250e-10+temp*2.7282294000e-13)))))/temp) ...
      /exp(-1*(2.9122259200e+04+temp*(3.1682671000e+00+temp*(-1.6396594200e-03+temp*(2.2143546533e-06+temp*(-1.5320165600e-09+temp*4.2253194200e-13)))))/temp) ...
      /exp(-1*(-3.0293726700e+04+temp*(4.1986405600e+00+temp*(-1.0182170500e-03+temp*(2.1734673700e-06+temp*(-1.3719926550e-09+temp*3.5439563400e-13)))))/temp);
    K(4) = ...
       exp( 2*(2.5000000000e+00*log(temp)-4.4668285300e-01+temp*(7.0533281900e-13+temp*(-9.9795982000e-16+temp*(7.6693877333e-19+temp*-2.3193308300e-22))))) ...
      *exp(-1*(2.3443311200e+00*log(temp)+6.8301023800e-01+temp*(7.9805207500e-03+temp*(-9.7390755000e-06+temp*(6.7190698000e-09+temp*-1.8440294025e-12))))) ...
      /exp( 2*(2.5473659900e+04+temp*(2.5000000000e+00+temp*(3.5266640950e-13+temp*(-6.6530654667e-16+temp*(5.7520408000e-19+temp*-1.8554646640e-22)))))/temp) ...
      /exp(-1*(-9.1793517300e+02+temp*(2.3443311200e+00+temp*(3.9902603750e-03+temp*(-6.4927170000e-06+temp*(5.0393023500e-09+temp*-1.4752235220e-12)))))/temp) ...
      *(1.2186600505e+04/temp)^1;
    K(5) = ...
       exp( 1*(3.9920154300e+00*log(temp)-1.0392545800e-01+temp*(-2.4013175200e-03+temp*(2.3089692050e-06+temp*(-1.2937111100e-09+temp*3.4102867500e-13))))) ...
      *exp(-1*(3.1682671000e+00*log(temp)+2.0519334600e+00+temp*(-3.2793188400e-03+temp*(3.3215319800e-06+temp*(-2.0426887467e-09+temp*5.2816492750e-13))))) ...
      *exp(-1*(2.5000000000e+00*log(temp)-4.4668285300e-01+temp*(7.0533281900e-13+temp*(-9.9795982000e-16+temp*(7.6693877333e-19+temp*-2.3193308300e-22))))) ...
      /exp( 1*(3.6150805600e+03+temp*(3.9920154300e+00+temp*(-1.2006587600e-03+temp*(1.5393128033e-06+temp*(-9.7028333250e-10+temp*2.7282294000e-13)))))/temp) ...
      /exp(-1*(2.9122259200e+04+temp*(3.1682671000e+00+temp*(-1.6396594200e-03+temp*(2.2143546533e-06+temp*(-1.5320165600e-09+temp*4.2253194200e-13)))))/temp) ...
      /exp(-1*(2.5473659900e+04+temp*(2.5000000000e+00+temp*(3.5266640950e-13+temp*(-6.6530654667e-16+temp*(5.7520408000e-19+temp*-1.8554646640e-22)))))/temp) ...
     *(1.2186600505e+04/temp)^-1;
    K(6) = ...
       exp( 1*(4.1986405600e+00*log(temp)-8.4903220800e-01+temp*(-2.0364341000e-03+temp*(3.2602010550e-06+temp*(-1.8293235400e-09+temp*4.4299454250e-13))))) ...
      *exp(-1*(2.5000000000e+00*log(temp)-4.4668285300e-01+temp*(7.0533281900e-13+temp*(-9.9795982000e-16+temp*(7.6693877333e-19+temp*-2.3193308300e-22))))) ...
      *exp(-1*(3.9920154300e+00*log(temp)-1.0392545800e-01+temp*(-2.4013175200e-03+temp*(2.3089692050e-06+temp*(-1.2937111100e-09+temp*3.4102867500e-13))))) ...
      /exp( 1*(-3.0293726700e+04+temp*(4.1986405600e+00+temp*(-1.0182170500e-03+temp*(2.1734673700e-06+temp*(-1.3719926550e-09+temp*3.5439563400e-13)))))/temp) ...
      /exp(-1*(2.5473659900e+04+temp*(2.5000000000e+00+temp*(3.5266640950e-13+temp*(-6.6530654667e-16+temp*(5.7520408000e-19+temp*-1.8554646640e-22)))))/temp) ...
      /exp(-1*(3.6150805600e+03+temp*(3.9920154300e+00+temp*(-1.2006587600e-03+temp*(1.5393128033e-06+temp*(-9.7028333250e-10+temp*2.7282294000e-13)))))/temp) ...
     *(1.2186600505e+04/temp)^-1;

  elseif 1000.000000 <= temp && temp <= 3500.000000
    K(1) = ...
       exp( 1*(2.5000000100e+00*log(temp)-4.4668291400e-01+temp*(-2.3084297300e-11+temp*(8.0780974000e-15+temp*(-1.5783841167e-18+temp*1.2454933925e-22))))) ...
      *exp(+1*(3.0928876700e+00*log(temp)+4.4766961000e+00+temp*(5.4842971600e-04+temp*(6.3252614000e-08+temp*(-2.9315385200e-11+temp*2.9353094000e-15))))) ...
      *exp(-1*(2.5694207800e+00*log(temp)+4.7843386400e+00+temp*(-8.5974113700e-05+temp*(2.0974229450e-08+temp*(-3.3392599667e-12+temp*3.0708422750e-16))))) ...
      *exp(-1*(3.3372792000e+00*log(temp)-3.2050233100e+00+temp*(-4.9402473100e-05+temp*(2.4972838900e-07+temp*(-5.9855464667e-11+temp*5.0063844000e-15))))) ...
      /exp( 1*(2.5473659900e+04+temp*(2.5000000100e+00+temp*(-1.1542148650e-11+temp*(5.3853982667e-15+temp*(-1.1837880875e-18+temp*9.9639471400e-23)))))/temp) ...
      /exp(+1*(3.8586570000e+03+temp*(3.0928876700e+00+temp*(2.7421485800e-04+temp*(4.2168409333e-08+temp*(-2.1986538900e-11+temp*2.3482475200e-15)))))/temp) ...
      /exp(-1*(2.9217579100e+04+temp*(2.5694207800e+00+temp*(-4.2987056850e-05+temp*(1.3982819633e-08+temp*(-2.5044449750e-12+temp*2.4566738200e-16)))))/temp) ...
      /exp(-1*(-9.5015892200e+02+temp*(3.3372792000e+00+temp*(-2.4701236550e-05+temp*(1.6648559267e-07+temp*(-4.4891598500e-11+temp*4.0051075200e-15)))))/temp);
    K(2) = ...
       exp( 1*(3.0339924900e+00*log(temp)+4.9667701000e+00+temp*(2.1769180400e-03+temp*(-8.2036259000e-08+temp*(-3.2347329000e-11+temp*4.2050248000e-15))))) ...
      *exp(+1*(2.5000000100e+00*log(temp)-4.4668291400e-01+temp*(-2.3084297300e-11+temp*(8.0780974000e-15+temp*(-1.5783841167e-18+temp*1.2454933925e-22))))) ...
      *exp(-1*(3.3372792000e+00*log(temp)-3.2050233100e+00+temp*(-4.9402473100e-05+temp*(2.4972838900e-07+temp*(-5.9855464667e-11+temp*5.0063844000e-15))))) ...
      *exp(-1*(3.0928876700e+00*log(temp)+4.4766961000e+00+temp*(5.4842971600e-04+temp*(6.3252614000e-08+temp*(-2.9315385200e-11+temp*2.9353094000e-15))))) ...
      /exp( 1*(-3.0004297100e+04+temp*(3.0339924900e+00+temp*(1.0884590200e-03+temp*(-5.4690839333e-08+temp*(-2.4260496750e-11+temp*3.3640198400e-15)))))/temp) ...
      /exp(+1*(2.5473659900e+04+temp*(2.5000000100e+00+temp*(-1.1542148650e-11+temp*(5.3853982667e-15+temp*(-1.1837880875e-18+temp*9.9639471400e-23)))))/temp) ...
      /exp(-1*(-9.5015892200e+02+temp*(3.3372792000e+00+temp*(-2.4701236550e-05+temp*(1.6648559267e-07+temp*(-4.4891598500e-11+temp*4.0051075200e-15)))))/temp) ...
      /exp(-1*(3.8586570000e+03+temp*(3.0928876700e+00+temp*(2.7421485800e-04+temp*(4.2168409333e-08+temp*(-2.1986538900e-11+temp*2.3482475200e-15)))))/temp);
    K(3) = ...
       exp( 2*(3.0928876700e+00*log(temp)+4.4766961000e+00+temp*(5.4842971600e-04+temp*(6.3252614000e-08+temp*(-2.9315385200e-11+temp*2.9353094000e-15))))) ...
      *exp(-1*(2.5694207800e+00*log(temp)+4.7843386400e+00+temp*(-8.5974113700e-05+temp*(2.0974229450e-08+temp*(-3.3392599667e-12+temp*3.0708422750e-16))))) ...
      *exp(-1*(3.0339924900e+00*log(temp)+4.9667701000e+00+temp*(2.1769180400e-03+temp*(-8.2036259000e-08+temp*(-3.2347329000e-11+temp*4.2050248000e-15))))) ...
      /exp( 2*(3.8586570000e+03+temp*(3.0928876700e+00+temp*(2.7421485800e-04+temp*(4.2168409333e-08+temp*(-2.1986538900e-11+temp*2.3482475200e-15)))))/temp) ...
      /exp(-1*(2.9217579100e+04+temp*(2.5694207800e+00+temp*(-4.2987056850e-05+temp*(1.3982819633e-08+temp*(-2.5044449750e-12+temp*2.4566738200e-16)))))/temp) ...
      /exp(-1*(-3.0004297100e+04+temp*(3.0339924900e+00+temp*(1.0884590200e-03+temp*(-5.4690839333e-08+temp*(-2.4260496750e-11+temp*3.3640198400e-15)))))/temp);
    K(4) = ...
       exp( 2*(2.5000000100e+00*log(temp)-4.4668291400e-01+temp*(-2.3084297300e-11+temp*(8.0780974000e-15+temp*(-1.5783841167e-18+temp*1.2454933925e-22))))) ...
      *exp(-1*(3.3372792000e+00*log(temp)-3.2050233100e+00+temp*(-4.9402473100e-05+temp*(2.4972838900e-07+temp*(-5.9855464667e-11+temp*5.0063844000e-15))))) ...
      /exp( 2*(2.5473659900e+04+temp*(2.5000000100e+00+temp*(-1.1542148650e-11+temp*(5.3853982667e-15+temp*(-1.1837880875e-18+temp*9.9639471400e-23)))))/temp) ...
      /exp(-1*(-9.5015892200e+02+temp*(3.3372792000e+00+temp*(-2.4701236550e-05+temp*(1.6648559267e-07+temp*(-4.4891598500e-11+temp*4.0051075200e-15)))))/temp) ...
     *(1.2186600505e+04/temp)^1;
    K(5) = ...
       exp( 1*(3.0928876700e+00*log(temp)+4.4766961000e+00+temp*(5.4842971600e-04+temp*(6.3252614000e-08+temp*(-2.9315385200e-11+temp*2.9353094000e-15))))) ...
      *exp(-1*(2.5694207800e+00*log(temp)+4.7843386400e+00+temp*(-8.5974113700e-05+temp*(2.0974229450e-08+temp*(-3.3392599667e-12+temp*3.0708422750e-16))))) ...
      *exp(-1*(2.5000000100e+00*log(temp)-4.4668291400e-01+temp*(-2.3084297300e-11+temp*(8.0780974000e-15+temp*(-1.5783841167e-18+temp*1.2454933925e-22))))) ...
      /exp( 1*(3.8586570000e+03+temp*(3.0928876700e+00+temp*(2.7421485800e-04+temp*(4.2168409333e-08+temp*(-2.1986538900e-11+temp*2.3482475200e-15)))))/temp) ...
      /exp(-1*(2.9217579100e+04+temp*(2.5694207800e+00+temp*(-4.2987056850e-05+temp*(1.3982819633e-08+temp*(-2.5044449750e-12+temp*2.4566738200e-16)))))/temp) ...
      /exp(-1*(2.5473659900e+04+temp*(2.5000000100e+00+temp*(-1.1542148650e-11+temp*(5.3853982667e-15+temp*(-1.1837880875e-18+temp*9.9639471400e-23)))))/temp) ...
     *(1.2186600505e+04/temp)^-1;
    K(6) = ...
       exp( 1*(3.0339924900e+00*log(temp)+4.9667701000e+00+temp*(2.1769180400e-03+temp*(-8.2036259000e-08+temp*(-3.2347329000e-11+temp*4.2050248000e-15))))) ...
      *exp(-1*(2.5000000100e+00*log(temp)-4.4668291400e-01+temp*(-2.3084297300e-11+temp*(8.0780974000e-15+temp*(-1.5783841167e-18+temp*1.2454933925e-22))))) ...
      *exp(-1*(3.0928876700e+00*log(temp)+4.4766961000e+00+temp*(5.4842971600e-04+temp*(6.3252614000e-08+temp*(-2.9315385200e-11+temp*2.9353094000e-15))))) ...
      /exp( 1*(-3.0004297100e+04+temp*(3.0339924900e+00+temp*(1.0884590200e-03+temp*(-5.4690839333e-08+temp*(-2.4260496750e-11+temp*3.3640198400e-15)))))/temp) ...
      /exp(-1*(2.5473659900e+04+temp*(2.5000000100e+00+temp*(-1.1542148650e-11+temp*(5.3853982667e-15+temp*(-1.1837880875e-18+temp*9.9639471400e-23)))))/temp) ...
      /exp(-1*(3.8586570000e+03+temp*(3.0928876700e+00+temp*(2.7421485800e-04+temp*(4.2168409333e-08+temp*(-2.1986538900e-11+temp*2.3482475200e-15)))))/temp) ...
     *(1.2186600505e+04/temp)^-1;
  end
end
