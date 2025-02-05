% CALCULA APENAS CUSTO DE SIMULACAO NA PISTA DEFAULT
function custo = fcusto_simplificada(x)
    % Definicao de funcionamento
    custoFormula = evalin('base', 'custoFormula');
    simuTime = evalin('base', 'simuTime');
    Pista = 0;

    % Executa a simulacao e retorna dados em escala
    [teta_ref, teta_out, pos_ref, pos_out, erro_rot, erro_trans, tempo] = SimulaModeloCompleto(x, Pista);

    % Verifica se eh simulacao valida
    if tempo(end) ~= simuTime
        custo = Inf;
    else
        try
            % Calcula custos
            custo_rot       = CalculaCusto(erro_rot, tempo, custoFormula);
            custo_trans     = CalculaCusto(erro_trans, tempo, custoFormula);

            % Adiciona custo ponderado
            custoPonderado  = PonderaCusto(custo_rot, custo_trans);
            custo           = custoPonderado;

        % Em caso de erro, atribui como infinito
        catch ME
             custo = Inf;
        end 
    end
end

