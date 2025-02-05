%DEFASADA: Simulink ja entrega esses valores

function erro = CalculaErro(reference, real)
   
    % Parametros de escala de erro
    erroMax_translacao =  evalin('base', 'erroMax_translacao');
    erroMax_rotacao =  evalin('base', 'erroMax_rotacao');
    
    sz = length(reference);
    erro = zeros(1,sz);
    % Erro temporal simples (angular)
    if isequal( size(reference(:,1)), [1,1])
        
        for i = 1:sz
            erro(i) =  abs(reference(i) - real(i));
            erro(i) = erro(i)/erroMax_rotacao;
        end
        
    % Erro temporal geometrico (posicao cartesiana)
    else
        for i = 1:sz
            ex = reference(1,i) - real(1,i);
            ey = reference(2,i) - real(2,i);      
            erro(i) =  sqrt( ex.^2 + ey.^2 );
            erro(i) = erro(i)/erroMax_translacao;
        end
    end
    
end