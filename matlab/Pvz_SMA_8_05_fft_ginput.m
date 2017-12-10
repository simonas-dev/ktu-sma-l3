%
%   Viename periode aprasytai funkcijai atliekama diskrecioji Furje
%   transformacija
%   Funkcija ivedama taskais i brezini, ginput
%
%   Sulyginimas su fft rezultatais 

function main
clc,close all,clear all


T=10
n=100;n=round(n/2)*2+1; % n visuomet nelyginis
dt=T/n

xmin=0;ymin=-10;xmax=T;ymax=10; % koordinaciu sistemos ribos
figure(1),hold on, axis([xmin,xmax,ymin,ymax]);grid on
title('vienas duotosios funkcijos periodas')

% Pele ivedami taskai. Baigiama, kai taskas parenkamas uz koord. sistemos ribu
ibreak=0;icount=1;
x1=0;y1=0;plot(x1,y1,'*');tinp(1)=x1;fffinp(1)=y1;
while 1     % pele ivedami taskai
    [x1,y1]=ginput(1); icount=icount+1;  
    if x1 < xmin || x1 > xmax || y1 < ymin || y1 > ymax,  x1=T; y1=0; ibreak=1; end
    tinp(icount)=x1; fffinp(icount)=y1;
    plot(x1,y1,'*');
    if ibreak, break; end
end
t=[0:dt:T-dt]; fff=interp1(tinp,fffinp,t); cla, plot(t,fff,'k.');

m=(n+1)/2  % m - harmoniku skaicius interpoliuojanciai Furje aproksimacijai, 

N=10000 % vaizdavimo tasku skaicius
dttt=T/N
ttt=[-T:dttt:2*T];

% Spektras apskaiciuojamas naudojant fft:  *******************
yyy=fft(fff)/n;
spektras=abs(2*yyy(1:m));
spektras(1)=spektras(1)/2;

spektras_c0=real(yyy(1));   % pastovi dedamoji
spektras_c=real(2*yyy(2:m)); % cos amplitudes
spektras_s=-imag(2*yyy(2:m)); % sin amplitudes

figure(2),hold on,grid on,bar([0:m-1],spektras,0.01)
title('Furje amplitudziu spektras pagal kompleksinio skaiciaus moduli ')

%*************************************************************

% apskaiciuojame cos ir sin koeficientus pagal DFT algoritma:  ..........
ac0=dot(fff,fC(0,T,t))/n;
for i=1:m-1
    ac(i)=dot(fff,fC(i,T,t))*2/n;
    as(i)=dot(fff,fS(i,T,t))*2/n;
end
ac,as

% .......................................................................
figure(3),hold on
bar(0:m-1,[ac0,sqrt(ac.^2+as.^2)],0.01)
legend(sprintf('n=%d tasku, m=%d harmoniku ',n,m))
title('Furje amplitudziu spektras pagal DFT sin ir cos amplitudes')


fffz=ac0*fC(0,T,ttt);
frequencies=[1:m-1];
% frequencies=[1:3,5,6,10,30,50];
for i=frequencies   % funkcijos braizymas pagal harmonines komponentes
        fffz=fffz+ac(i)*fC(i,T,ttt)+as(i)*fS(i,T,ttt);    
end

figure(4),hold on,grid on, plot(ttt,fffz,'r');plot(t,fff,'b.','LineWidth',2);
legend(sprintf('n=%d tasku, m=%d harmoniku',n,m))
title('Pagal harmonikas atstatytas funkcijos grafikas')

% Sulyginimui pavaizduojame cos ir sin amplitudes gautas fft ir musu
% skaiciavimu:
figure(5),hold on,grid on
bar(0:m-1,[ac0,ac],0.01);plot(0:m-1,[spektras_c0,spektras_c])
title('FFT ir DFT gautu cos amplitudziu sulyginimas');
legend({'FFT','DFT'})
figure(6),hold on,grid on
bar(1:m-1,as,0.01);plot(1:m-1,spektras_s)
title('FFT ir DFT gautu sin amplitudziu sulyginimas');
legend({'FFT','DFT'})
figure(6),hold on,grid 
return
end

function c=fC(i,T,t), if i==0,c=1*cos(0*t); else, c=cos(2*pi*i/T*t); end, return, end
function s=fS(i,T,t), s=sin(2*pi*i/T*t); return, end

