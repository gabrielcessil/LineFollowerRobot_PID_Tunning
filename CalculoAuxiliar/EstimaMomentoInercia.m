function J = EstimaMomentoInercia()
    L = 0.1; % distancia entre as todas / 2 [m]
    h = 0.13; % distancia entre eixo entre rodas e roda boba [m]
    mRodaMotor = 50*10^-3; % massa do conjunto roda e motor
    mRodaBoba = 40*10^-3; % massa da roda boba
    mPonteH = 30*10^-3; % massa da ponte H
    % Calculos aproximados de centro de massa e momento de inercia
    ycm = (mRodaBoba)*h/(2*mRodaMotor+mPonteH+mRodaBoba);
    D = sqrt(ycm^2+L^2);
    J = (2*mRodaMotor*D^2) +( mPonteH*ycm^2) +(mRodaBoba*(h-ycm)^2);
    disp(J)
end