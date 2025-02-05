function TestaResultado(solucao)
    close all;
    % Inicia modelo simulink
    setupSimulinkConstantes();
    
    % Definicao de funcionamento
    custoFormula = evalin('base', 'custoFormula');
    simuTime = evalin('base', 'simuTime');
    Pista = 0;

    % Executa a simulacao e retorna dados em escala
    [teta_ref, teta_out, pos_ref, pos_out, erro_rot, erro_trans tempo] = SimulaModeloCompleto(solucao, Pista);
    
    % Verifica se eh simulacao valida
    if tempo(end) ~= simuTime
        fprintf('Condicao de parada atingida em t=%f. Custo atribuido como INF e grafico nao gerado.\n', tempo(end));
    else
        try
            % Calcula custos
            custo_rot       = CalculaCusto(erro_rot, tempo, custoFormula);
            custo_trans     = CalculaCusto(erro_trans, tempo, custoFormula);

            % Adiciona custo ponderado
            custoPonderado  = PonderaCusto(custo_rot, custo_trans);
            custo           = custoPonderado;
            
            % Exibe Resultados
            fprintf('Custo de rotacao: %f\n', custo_rot);
            disp(custo_rot);
            fprintf('Custo de translacao: %f\n', custo_trans);
            disp(custo_trans);
            fprintf('Custo final: %f\n', custo);
            disp(custo);
            figure;
            plot(tempo, teta_ref,tempo, teta_out);
            figure;
            plot(pos_ref(1,:), pos_ref(2,:), pos_out(1,:), pos_out(2,:));

        % Em caso de erro, atribui como infinito
        catch ME
            warning('Erro no calculo de custo. Custo atribuido como INF e grafico nao gerado.\n');

        end 
    end
end




