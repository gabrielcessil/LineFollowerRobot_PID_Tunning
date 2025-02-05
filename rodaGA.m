function xFinal = rodaGA(fitfcn)

    disp('O Algoritmo Genetico sera executado...');
    % Define constantes usadas na simulacao
    setupSimulinkConstantes();
    % Estabelece os parametros de execucao do GA
    [options, lowBound, highBound] = setupGA();
    % Efetua a otimizacao
    xFinal = ga(fitfcn,length(lowBound),[],[],[],[],lowBound,highBound,[],options);
    disp('O Algoritmo Genetico terminou sua execucao');
end