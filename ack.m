function fx = ack(x1,x2,x3)
n = 3;
fx = -20*exp(-0.2*sqrt(1/n)*(x1^2+x2^2+x3^2)) - exp(1/n*(cos(2*pi*x1)+cos(2*pi*x2)+cos(2*pi*x3))) + 20 + exp(1);
end

