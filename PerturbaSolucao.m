function X = PerturbaSolucao(X, nX)
    desvioPadrao = mean(X)/10; 
    if(desvioPadrao == 0)
        desvioPadrao = 1;
    end
    
    for aux = 0:nX
        i = randi([1,nX], 1);  % Escolha aleatoria de qual variavel ira perturbar
        dist = normrnd(0, desvioPadrao); % Perturbacao aleatoria
        X(i) = X(i) + dist; % Aplica perturbacao
    end
end