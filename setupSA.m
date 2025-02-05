function [options, lowBound, highBound]  = setupSA(xInit)
    disp('Efetuando o setup do S.A...');
    perturbaX = @GeraPerturbacao;
    
    DELTA_E = Calcula_Delta_E(xInit, @fcusto_simplificada, 10); % Calcula conforme achado nas referencias
    T0 = CalculaT0(DELTA_E); % Calculo conforme achado nas referencias
    TF = -DELTA_E/log(0.05); % Metrica de aceitacao = e^(DeltaE/Tk) -> Tf = DeltaE / ln(Metrica Final)
    MaxIterations = fix(log(TF/T0)/log(0.95));  % Tk = InitialTemperature * 0.95^k -> kFinal = log(Tfinal/T0)/log(0.95);
    lowBound = [-Inf, -Inf, -Inf];
    highBound = [Inf, Inf, Inf];
    decay_mode = 'temperatureexp'; 
    reannel_times = 5;
    
    fprintf('Temperatura inicial: %f\n', T0);
    fprintf('Variacao media de energia: %f\n', DELTA_E);
    fprintf('Temperatura final estimada: %f\n', TF);
    fprintf('Maximo de iteracoes: %f\n', MaxIterations);
    fprintf('Limites inferiores: %f %f %f\n', lowBound.');
    fprintf('Limites superiores: %f %f %f\n', highBound.');
    fprintf('Modo de decaimento: %s\n', decay_mode);
    fprintf('Numero de recozimentos: %f\n', reannel_times);
    

    options = optimoptions('simulannealbnd',...
    'TemperatureFcn', decay_mode,...
    'InitialTemperature', T0,...
    'AnnealingFcn', perturbaX,...
    'MaxIterations', MaxIterations,...
    'ReannealInterval',round(MaxIterations/reannel_times + 1),...
    'PlotFcn', {@saplotx, @saplottemperature, @saplotf, @saplotbestx} );    
    
    disp('Setup do S.A efetuado.');
end










%options = optimoptions(@simulannealbnd,'MaxIterations',150)

%AnnealingFcn -> qual a funcao de gerador de novos pontos
%AcceptanceFcn -> qual funcao para aceitar ou nao novos pontos
%InitialTemperature -> temperatura inicial
%MaxIterations
%MaxStallIterations
%ObjectiveLimit
%MaxFunctionEvaluations
%TemperatureFcn -> Function handler ou 'temperatureboltz' | 'temperaturefast' | {'temperatureexp'}


%FLAGS
%1	 Average change in the value of the objective function over options.MaxStallIterations iterations is less than options.FunctionTolerance.
%5	 Objective function value is less than options.ObjectiveLimit.
%0	 Maximum number of function evaluations or iterations reached.
%-1	 Optimization terminated by an output function or plot function.
%-2	 No feasible point found.
%-5	 Time limit exceeded.