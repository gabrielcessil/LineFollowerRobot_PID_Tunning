function setupSimulinkSolucao(solucao, Pista)
    % Tratamento dos parametros
    Kp = solucao(1);
    Ki = solucao(2);
    Kd = solucao(3);
    assignin('base', 'Kp', Kp); % Controlador 
    assignin('base', 'Ki', Ki); % Controlador
    assignin('base', 'Kd', Kd); % Controlador    
    assignin('base', 'Pista', Pista); % Selecao da pista que sera simulada
end

