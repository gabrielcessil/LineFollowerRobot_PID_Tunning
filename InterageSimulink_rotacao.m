function [reference_values, output_values] = InterageSimulink_rotacao(Simulation)

    % Coleta as informacoes da execucao finalizada
    reference_values    = Simulation.pista_angle(:,1).';
    output_values       = Simulation.carro_angle(:,1).';
   
end