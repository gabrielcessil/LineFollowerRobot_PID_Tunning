function T0 = CalculaT0(DELTA_E) 
    E0 = 0.8; % Valor empirico encontrado nas referencias
    T0 = - DELTA_E / log(E0); % Formula encontrada nas referencias
end