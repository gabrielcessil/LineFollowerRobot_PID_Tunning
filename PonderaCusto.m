function custoPonderado = PonderaCusto(custo_rot, custo_trans)
    % Definicao de funcionamento
    peso_Translacao = evalin('base', 'peso_Translacao');
    peso_Rotacao = evalin('base', 'peso_Rotacao');
    
    custoPonderado = ...
    + custo_rot * peso_Rotacao ...
    + custo_trans * peso_Translacao;
end