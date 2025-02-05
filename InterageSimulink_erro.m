function [erro_rotacao, erro_translacao] = InterageSimulink_erro(Simulation)
    % Coleta as informacoes da execucao finalizada
    erro_rotacao          = abs(Simulation.erro_rotacao(:,1).');
    erro_translacao       = abs(Simulation.erro_translacao(:,1).');
    
end