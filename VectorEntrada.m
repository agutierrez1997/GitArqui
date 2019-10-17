%Script que genera un Vector de entrada aleatorio para probar
%el algoritmo de FFT en ensamblador

%Entrada: Tamaño del vector de entrada
%Salida: Vector de entrada aleatorio
%Ademas se imprime el vector con sintaxis de Nasm para pegar en el codigo

function[X]=VectorEntrada(N)

X=[]; %Vector de entrada para la fft
cant=1; %para elegir la cantidad que se desea por fila, solo para que se vea mejor en el codigo
fprintf("X:\n\t dd ");
for n=0:N-1
    X(n+1,1)=(15*rand);
    fprintf("%f",X(n+1,1));
    
    if n~=(N-1)
      if (cant==9)
        cant=0;
        fprintf("\n\t dd ")
      else
        fprintf(", ")
      end
    else
      fprintf("\n")
    end
    
    cant=cant+1;
end
end