x = -4:5;
%y = [-1 -1 -1 0 1 1 1];
%x=[-1  -1 -1 1  0 -1.2  1 2   3 4];
%y=[ 1  -2  0 0  1  0.5 -2 1  -2 1];
y=[ 1  -2  0 0  1  0.5 -2 1  -2 1];

t = -4:.01:5;
p = pchip(x,y);
%s = spline(x,y);
plot(x,y,'o',p,'-','-.')
legend('data','pchip','spline','Location','SouthEast')