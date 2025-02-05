function [teta_ref, teta_out, pos_ref, pos_out, erro_rot, erro_trans, tempo]...
    = SimulaModeloCompleto(solucao, Pista)
    % Cria todas as variaveis usadas no modelo
    setupSimulinkSolucao(solucao, Pista);
    
    % Executa uma simulacao
    simuTime                    = evalin('base', 'simuTime');
    simu                        = sim('ModeloCompleto.slx','StopTime', sprintf('%.6f',simuTime));
    
    % Extrai referencias e saidas
    [teta_ref,teta_out]         = InterageSimulink_rotacao(simu);
    [pos_ref,pos_out]           = InterageSimulink_translacao(simu);
    [erro_rot, erro_trans]      = InterageSimulink_erro(simu);
    tempo                       = InterageSimulink_tempo(simu);
    
    % Normaliza os valores em relacao ao seus maximos esperados
    erroMax_rotacao             =  evalin('base', 'erroMax_rotacao');
    erroMax_translacao          =  evalin('base', 'erroMax_translacao');
    
    erro_rot                    = erro_rot/erroMax_rotacao;
    erro_trans                  = erro_trans/erroMax_translacao;
end