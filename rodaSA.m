function xFinal = rodaSA(xInit, fitfcn)

    disp('O Simulated Anneling será executado...');
    % Define constantes usadas na simulacao
    setupSimulinkConstantes();
    % Estabelece os parametros de execucao do SA
    [options, lowBound, highBound] = setupSA(xInit);
    % Efetua a otimizacao
    [xFinal,fval,exitFlag,output] = simulannealbnd(fitfcn, xInit, lowBound, highBound, options);
    disp('O Simulated Anneling terminou sua execucao');
end