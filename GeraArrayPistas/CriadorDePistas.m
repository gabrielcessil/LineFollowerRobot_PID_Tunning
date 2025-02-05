

%CONSTANTE DE ESTIMACAO DAS PISTAS
velocidade_media_estimada = 1.25; % velocidade de translacao estimada [m/s]


GeraPistas(velocidade_media)
function GeraPistas(velocidade_media)
    
    setupPista1(velocidade_media, 'pista1');
    CarregaPistaSimulink('pista1');
    
    setupPista2(velocidade_media, 'pista2');
    CarregaPistaSimulink('pista2');
    
    setupPista3(velocidade_media, 'pista3');
    CarregaPistaSimulink('pista3');
    
    setupPista4(velocidade_media, 'pista4');
    CarregaPistaSimulink('pista4');
    
    setupPista5(velocidade_media, 'pista5');
    CarregaPistaSimulink('pista5');
    
    setupPista6(velocidade_media, 'pista6');
    CarregaPistaSimulink('pista6');
end    
function CarregaPistaSimulink(file_name_csv)
    data = importdata(file_name_csv + ".txt"); 
    pista_tempo = data(:,1).';
    pista_teta = data(:,2).';
    assignin('base', file_name_csv + "_tempo", pista_tempo);
    assignin('base', file_name_csv + "_teta", pista_teta);
end

function setupPista1(vel, nome)
    a = ClassePista(vel, nome);
    a = a.add_reta(174);
    a = a.add_curva(20, -90);
    a = a.add_reta(300);
    a = a.add_curva(20, -90);
    a = a.add_reta(20);
    a = a.add_curva(20, -90);
    a = a.add_reta(180);    
    a = a.add_curva(20, 90);
    a = a.add_reta(200);
    a = a.add_curva(20, -180);
    a = a.add_reta(180);
    a = a.add_curva(30, 180);
    a = a.add_reta(180);
    a = a.add_curva(15, -180);
    a = a.add_reta(40);
    a = a.add_curva(10, -90);
    a = a.add_reta(360);
    a = a.add_curva(20, 90);
    a = a.add_reta(20);
    a = a.add_curva(30, 90);
    a = a.add_reta(150);
    a = a.add_curva(30, 90);
    a = a.add_reta(200);
    a = a.add_curva(20, 90);
    a = a.add_reta(10);
    a = a.add_curva(10, 90);
    a = a.add_reta(10);
    a = a.add_curva(70, -270);
    a = a.add_reta(185);
    a = a.add_curva(15, -60);
    a = a.add_curva(30, 120);
    a = a.add_curva(30, -120);
    a = a.add_curva(15, 60);
    a = a.add_reta(20);
    a = a.add_curva(25, -90);
    a = a.add_reta(220);
    a.delete();
end

function setupPista2(vel, nome)
    a = ClassePista(vel, nome);
    a = a.add_curva(50, 270);
    a = a.add_curva(50, -270);
    a = a.add_curva(30, -270);
    a = a.add_curva(15, -270);
    a.delete();

end

function setupPista3(vel, nome)
    a = ClassePista(vel, nome);
    a = a.add_curva(50, 180);
    a = a.add_reta(50);
    a = a.add_curva(50, 180);
    a = a.add_reta(50);
    a.delete();
end

function setupPista4(vel, nome)
    a = ClassePista(vel, nome);
    a = a.add_reta(30);
    a = a.add_curva(15, -30);
    a = a.add_curva(15, -120);
    a = a.add_curva(15, 120);
    a = a.add_curva(15, -120);
    a = a.add_curva(15, 120);
    a = a.add_curva(15, -120);
    a = a.add_curva(15, 120);
    a = a.add_curva(15, -120);
    a = a.add_curva(15, 120);
    a = a.add_curva(15, -120);
    a = a.add_curva(15, 120);
    a = a.add_curva(15, -120);
    a = a.add_curva(15, 120);
    a = a.add_curva(15, -120);
    a = a.add_curva(15, 120);
    a = a.add_curva(15, -120);
    a = a.add_curva(15, 120);
    a = a.add_curva(15, -120);
    a = a.add_curva(15, 120);
    a = a.add_curva(15, -120);
    a = a.add_curva(15, 120);
    a = a.add_curva(15, -120);
    a = a.add_curva(15, 120);
    a = a.add_curva(15, -120);
    a = a.add_curva(15, 120);
    a = a.add_curva(15, -120);
    a = a.add_curva(15, 120);
    a = a.add_curva(15, -120);
    a = a.add_curva(15, 120);
    a = a.add_curva(15, -120);
    a = a.add_curva(15, -30);
    a = a.add_reta(30);
    a = a.add_curva(15, -90);
    a = a.add_reta(300);
    a.delete();
end

function setupPista5(vel, nome)
    a = ClassePista(vel, nome);
    a = a.add_reta(30);

    a = a.add_curva(15, -180);
    a = a.add_reta(15);
    a = a.add_curva(15, 180);
    a = a.add_reta(15);

    a = a.add_curva(15, -180);
    a = a.add_reta(15);
    a = a.add_curva(15, 180);
    a = a.add_reta(15);

    a = a.add_curva(15, -180);
    a = a.add_reta(15);
    a = a.add_curva(15, 180);
    a = a.add_reta(15);

    a = a.add_curva(15, -180);
    a = a.add_reta(15);
    a = a.add_curva(15, 180);
    a = a.add_reta(15);

    a = a.add_curva(15, -180);
    a = a.add_reta(15);
    a = a.add_curva(15, 180);
    a = a.add_reta(15);

    a = a.add_curva(15, -180);
    a = a.add_reta(15);
    a = a.add_curva(15, 180);
    a = a.add_reta(15);

    a = a.add_curva(15, -180);
    a = a.add_reta(15);
    a = a.add_curva(15, 180);
    a = a.add_reta(15);

    a = a.add_curva(15, -180);
    a = a.add_reta(15);
    a = a.add_curva(15, 180);
    a = a.add_reta(15);

    a = a.add_curva(15, -180);
    a = a.add_reta(15);
    a = a.add_curva(15, 180);
    a = a.add_reta(15);

    a = a.add_curva(15, -180);
    a = a.add_reta(45);
    a = a.add_curva(15, -90);
    a = a.add_reta(150);

    a.delete();
end

function setupPista6(vel, nome)
    a = ClassePista(vel, nome);
    a = a.add_reta(60);
    a = a.add_curva(3, 45);
    a = a.add_reta(60);
    a = a.add_curva(3, 45);
    a = a.add_reta(60);
    a = a.add_curva(3, 45);
    a = a.add_reta(60);
    a = a.add_curva(3, 45);
    a = a.add_reta(60);
    a = a.add_curva(3, 45);
    a = a.add_reta(60);
    a = a.add_curva(3, 45);
    a = a.add_reta(60);
    a = a.add_curva(3, 45);
    a = a.add_reta(60);
    a = a.add_curva(3, 45);
    a.delete();
end


