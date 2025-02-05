function [options, lowBound, highBound] = setupGA()
    
    PopulationSize = 30;
    MaximoGeracoes = 20;
    MaxTime = (60)*(60)*6;
    lowBound =  [0, 0, 0];
    highBound = [10000, 10000, 10000];   
    CriacaoIndividuos = 'gacreationuniform';
    ModoSelecao = 'selectionroulette';
    ModoRankeamento = 'fitscalingrank';
    ModoMutacao = 'mutationadaptfeasible';
    ModoCrossover = 'crossoverheuristic';
    CustoObjetivo = 1e-9;
    
    fprintf('Tamanho da populacao: %f\n', PopulationSize);
    fprintf('Maximo de geracoes: %f\n', MaximoGeracoes);
    fprintf('Tempo maximo de execucao: %f\n', MaxTime);
    fprintf('Limites inferiores: %f\n', lowBound);
    fprintf('Limites superiores: %f\n', highBound);
    fprintf('Modo de gerar individuos: %s\n', CriacaoIndividuos);
    fprintf('Modo de selcionar individuos: %s\n', ModoSelecao);
    fprintf('Modo de rankeamento: %s\n', ModoRankeamento);
    fprintf('Modo de mutacao: %s\n', ModoMutacao);
    fprintf('Modo de crossover: %s\n', ModoCrossover);
    fprintf('Custo objetivo: %f\n', CustoObjetivo);
    
    options = optimoptions( 'ga',...
                            'PopulationType','doubleVector',...
                            'PopulationSize',PopulationSize, ...
                            'CreationFcn', CriacaoIndividuos, ...
                            'FitnessScalingFcn',ModoRankeamento, ...
                            'SelectionFcn',ModoSelecao, ...
                            'MutationFcn',ModoMutacao, ...
                            'CrossoverFcn',ModoCrossover, ...
                            'MaxGenerations',MaximoGeracoes,...
                            'MaxTime',MaxTime,...
                            'FitnessLimit',CustoObjetivo,...
                            'PlotFcn', {@gaplotdistance, @gaplotbestf, @gaplotrange, @gaplotscorediversity});
                
end