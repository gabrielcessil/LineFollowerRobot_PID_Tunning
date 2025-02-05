function custo = fcusto_completa(x) 
    % Definicao de funcionamento
    custoFormula = evalin('base', 'custoFormula');
    simuTime = evalin('base', 'simuTime');
    custo = 0;
    % Calcula custos de translacao e rotacao para todas as pistas
    for i = 1:6
        % Seleciona pista da iteracao
        Pista = i;
        
        % Executa a simulacao e retorna dados em escala 
        [teta_ref, teta_out, pos_ref, pos_out, erro_rot, erro_trans, tempo] = SimulaModeloCompleto(x, Pista);
        
        % Verifica se eh simulacao valida
        if tempo(end) ~= simuTime
            custo = Inf;
            break;
        else
            try
                % Calcula custos
                custo_rot       = CalculaCusto(erro_rot, tempo, custoFormula);
                custo_trans     = CalculaCusto(erro_trans, tempo, custoFormula);
                
                % Adiciona custo ponderado
                custoPonderado  = PonderaCusto(custo_rot, custo_trans);
                custo           = custo + custoPonderado;
                
            % Em caso de erro, atribui como infinito
            catch ME
                 custo = Inf;
                 break;
            end 
        end
    end
end

