function [Wre,Wim] = DFT(N) %N es el numero de puntos
Wre=[];
Wim=[];
for k=0:N-1
    for n=0:N-1
        Wre(k+1,n+1)=real(exp(-1i*2*pi*k*n/N));
        Wim(k+1,n+1)=imag(exp(-1i*2*pi*k*n/N));
    end
end
Wre %esto se pone para imprimir Wre y Wim
Wim
end
