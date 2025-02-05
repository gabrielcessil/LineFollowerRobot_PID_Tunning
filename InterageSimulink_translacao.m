function [reference_values, output_values] = InterageSimulink_translacao(Simulation)
    
    % Coleta as informacoes da execucao finalizada
    carro_x_axis    = Simulation.carro_x_axis(:,1).';    
    carro_y_axis    = Simulation.carro_y_axis(:,1).'; 
    pista_x_axis    = Simulation.pista_x_axis(:,1).'; 
    pista_y_axis    = Simulation.pista_y_axis(:,1).';
    
    % Agrupa entre referencia e saida real
    reference_values = [pista_x_axis;pista_y_axis];
    output_values    = [carro_x_axis;carro_y_axis];
end