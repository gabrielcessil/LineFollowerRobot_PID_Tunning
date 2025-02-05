clc, clear, close all;

%SolInicial      = rodaGA(@fcusto_simplificada);
%disp("Solucao inicial encontrada pelo GA:");
%disp(SolInicial);
%ValidaResultado(SolInicial);

SolInicial = [1000,0,0];
SolFinal        = rodaSA(SolInicial, @fcusto_completa);
ValidaResultado(SolFinal);
disp("Solucao final encontrada pelo SA");
disp(SolFinal);
