function IntegralError = CalculaCusto(erro,time,mode)
    
    switch mode
        case {'IAE','iae'}
            IntegralError=iae(erro, time);
        case {'ITAE','itae'}
            IntegralError=itae(erro, time);
        case {'ISE','ise'}
            IntegralError=ise(erro, time);
        otherwise
            IntegralError=itse(erro, time);
    end
end

function value = iae(erro, time)
    if isscalar(erro)
        value = erro*time(end);
    else
        sz = length(erro);
        value = 0;
        for i = 2:sz
            deltaT = time(i) - time(i-1);
            value = value + erro(i)*deltaT;
        end
    end
end
function value = itae(erro, time)
    if isscalar(erro)
        value = erro*time(end)^2/2;
    else
        sz = length(erro);
        value = 0;
        for i = 2:sz
            deltaT = time(i) - time(i-1);
            value = value + time(i)*erro(i)*deltaT;
        end
    end
    
end
function value = ise(erro, time)
    if isscalar(erro)
        value = erro^2*time(end)/2;
    else
        sz = length(erro);
        value = 0;
        for i = 2:sz
            deltaT = time(i) - time(i-1);
            value = value + power(erro(i), 2)*deltaT;
        end
    end
end
function value = itse(erro, time)
    if isscalar(erro)
        value = (erro*time(end))^2/2;
    else
        sz = length(erro);
        value = 0;
        for i = 2:sz
            deltaT = time(i) - time(i-1);
            value = value + time(i)*power(erro(i), 2)*deltaT;
        end
    end
    
end