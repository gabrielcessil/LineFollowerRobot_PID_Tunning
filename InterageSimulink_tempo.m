function tempo = InterageSimulink_tempo(Simulation)
    % Coleta as informacoes da execucao finalizada
    tempo            = Simulation.tout.';
end