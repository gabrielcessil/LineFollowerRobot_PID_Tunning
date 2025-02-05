function setupSimulinkConstantes()
    
    %CONSTANTES MECANICAS
    R = 0.05; % raio da roda [m]
    L = 0.1; % distancia entre as todas / 2 [m]
    d = 0.01; % distancia entre o eixo das rodas e o c.m [m]
    J = 0.0015; % momento de inercia em relacao ao c.m [m]
    M = 0.25; % massa total [kg]
    N = 30; % relacao de reducao de velocidade: Wmotor/Wroda
        
    %CONSTANTES ELETRICAS
    Ra = 5e-3; % resistencia de armadura do motor [Ohm]
    La = 1e-6; % indutancia do motor [H]
    Kb = 0.4; % constante de magnetizacao
    Kt = 0.4; % constante de magnetizacao
    Kc = 4; % ganho do conversor
    
    %CONSTANTE DE CONTROLE
    Va_med = 2.5; % tensao media entregue pelo controlador [m/s]    
    
    %CONSTANTES DE SETUP DA EXECUCAO
    simuTime = 27; % tempo de simulacao [s]
        
    %CONSTANTES DE METRICA DE CUSTO
    custoFormula='itse'; % formula de custo
    peso_Translacao=0.3; % punicao ao deslocamento do c.m em relacao a linha
    peso_Rotacao= 0.4; % punicao ao deslocamento angular em relacao a linha
    
    %CONSTATES DE DESEMPENHO ESPERADO
    erroMax_translacao = 0.2; % distancia cartesiana maxima da linha (extrapolado)[m] 
    erroMax_rotacao = pi/2; % desalinhamento maximo da linha (extrapolado)[rad]
    
    %CONSTANTES DE METRICA DE INVIABILIDADE DA SOLUCAO
    erroInviavel_translacao = 10; % distancia cartesiana maxima da linha (extrapolado)[m] 
    erroInviavel_rotacao = pi; % desalinhamento maximo da linha (extrapolado)[rad]
    
    %CONSTANTES DE CONTROLE 
    intervalo_quantizacao_sensor = (pi/2)/8; % distancia angular entre valores de leitura [rad]
    tempo_de_amostragem = 0.01; % tempo entre cada conjunto de leituras [s]
    
    %EXPORTANDO AO WORKSPACE
    assignin('base', 'R', R); 
    assignin('base', 'M', M);
    assignin('base', 'L', L);
    assignin('base', 'd', d);
    assignin('base', 'J', J);
    assignin('base', 'N', N);
    assignin('base', 'Ra', Ra);  
    assignin('base', 'La', La);
    assignin('base', 'Kb', Kb);
    assignin('base', 'Kt', Kt);
    assignin('base', 'Kc', Kc);
    assignin('base', 'Va_med', Va_med);
    assignin('base', 'simuTime', simuTime); 
    assignin('base', 'custoFormula', custoFormula);
    assignin('base', 'peso_Translacao', peso_Translacao);
    assignin('base', 'peso_Rotacao', peso_Rotacao);
    assignin('base', 'erroMax_translacao', erroMax_translacao); 
    assignin('base', 'erroMax_rotacao', erroMax_rotacao); 
    assignin('base', 'erroInviavel_translacao',erroInviavel_translacao);
    assignin('base', 'erroInviavel_rotacao',erroInviavel_rotacao);
    assignin('base', 'intervalo_quantizacao_sensor', intervalo_quantizacao_sensor);
    assignin('base', 'tempo_de_amostragem', tempo_de_amostragem);
end