function Furje
    clc, close all, clear all;

    n=1000;     % taðkø skaièius
    m=200;      % harmonikø skaièius
    M=2*m-1;    % m - harmonikø skaièius, M -koeficientø skaièius
    
    if M > n, '*********per didelis harmoniku skaicius';end
   
    T=4;		%periodas
    slenkstis=0.2005 ; % harmonikø amplitudþiø slenkstis triukðmø filtravimui
    dt=T/n;
    N=1000;     % vaizdavimo taðkø skaièius
    dttt=T/N;

    t=[0:dt:T-dt];
    ttt=[-T:dttt:2*T];

    fff=fnk(T,t); % apskaiciuojame ir pavaizduojame duotà taðkø sekà 
    fffg=fnk2(T,t);
    fff2=fnk2(T,ttt);

    % braiþomas duotosios funkcijos grafikas
        figure(1),hold on,grid on, plot(t,fffg,'r.-'); 
        title('Duotosios funkcijos grafikas (be triukðmo)')
        legend(sprintf('n=%d taðkø\n m=%d harmonikø',n,m))
        
    % braiþomas duotosios funkcijos grafikas su triukðmais
        figure(2),hold on,grid on,plot(t,fff,'r.-','MarkerSize',8);
        title('Funkcijos grafikas (su triukðmais)')
        legend(sprintf('n=%d taðkø\n m=%d harmonikø',n,m))
    %-----------------------------------------------------------------
        % ac - cos koeficientai
        % as - sin koeficientai
    ac0=dot(fff,fC(0,T,t))/n;
    for i=1:m-1
        ac(i)=dot(fff,fC(i,T,t))*2/n;
        as(i)=dot(fff,fS(i,T,t))*2/n;
    end

    % braiþomas harmonikø amplitudës ir amplitudinis slenkstis
    figure(3),hold on
    bar(0:m-1,[ac0,sqrt(ac.^2+as.^2)],0.01)
    xx=axis; 
    plot([xx(1),xx(2)],slenkstis*[1 1],'g-','LineWidth',3); % braizo slenkscio linija
    title('Harmonikø amplitudës ir amplitudinis slenkstis')
    legend(sprintf('n=%d taðkø\n m=%d harmonikø\n slenkstis=%g ',n,m,slenkstis))
    xlabel('Daþniai');
    ylabel('Amplitudës');
    %-----------------------------------------------------------------

    fffz=ac0*fC(0,T,ttt)
    dazniai=1:m-1;
    for i=dazniai
        if sqrt(ac(i)^2+as(i)^2) > slenkstis
            fffz=fffz+ac(i)*fC(i,T,ttt)+as(i)*fS(i,T,ttt);    
        end
    end

    % braiþomas aproksimuotos funkcijos grafikas naudojant amplitudës
    % slenkstá
    figure(4),hold on,grid on, plot(ttt,fffz,'b-','LineWidth',2);
    plot(t,fff,'r-');
    title('Aproksimuota funkcija atmetant harmonikas, kuriø amplitudë maþesnë uþ nustatytà slenksèio reikðmæ')
    legend(sprintf('n=%d taðkø\n m=%d harmonikø\n slenkstis=%g ',n,m,slenkstis))
    %--------------------------------------------------------------------------
    Y = fft(fnk(T,t))
    Pyy = sqrt(Y.* conj(Y));
    filt=55; % daþnis filtravimui, nustaèiau að pagal savo funkcijà
    ind=Pyy<filt;
    Y(ind)=0;
    yt=ifft(Y);
    %--------------------------------------------------------------------------
    for i=1:filt
        ac_daz(i)=dot(fff,fC(i,T,t))*2/n;
        as_daz(i)=dot(fff,fS(i,T,t))*2/n;
    end
    for i=1:m-1-filt-1
        ac_daz1(i)=dot(fff,fC(i+1+filt,T,t))*2/n;
        as_daz1(i)=dot(fff,fS(i+1+filt,T,t))*2/n;
    end

    % braiþomos harmonikø amplitudës ir daþnio slenkstis
    figure(5),title('Harmonikø amplitudës ir daþnio slenkstis'),hold on
           bar(0:filt,[ac0,sqrt(ac_daz.^2+as_daz.^2)],'FaceColor', 'r','EdgeColor','r', 'BarWidth', 0.001)
        bar(filt+1:m-1,[ac0,sqrt(ac_daz1.^2+as_daz1.^2)],'FaceColor', 'g','EdgeColor','g', 'BarWidth', 0.001)
    legend('nefiltruojami daþniai', 'filtruojami daþniai');
    xlabel('Daþniai');
    ylabel('Amplitudës');
    %-----------------------------------------------------------------
    fffz1=ac0*fC(0,T,ttt)
    dazniai=[1:filt];
    for i=dazniai
            fffz1=fffz1+ac(i)*fC(i,T,ttt)+as(i)*fS(i,T,ttt);    
    end

    % braiþomas aproksimuotos funkcijos grafikas naudojant daþniø slenkstá
    figure(6),title('Aproksimuota funkcija atmetus harmonikas, kuriø darþnis didesnis nei 55')
    hold on,grid on
    plot(ttt,fffz1,'b','LineWidth',2);
    plot(t,fff,'r-','LineWidth',1);
    legend(sprintf('n=%d taðkø\n m=%d harmonikø\n filtras=%g ',n,m,filt))
    %-----------------------------------------------------------------
    return
end

    function c=fC(i,T,t)
        if i==0,
            c=1*cos(0*t); 
        else 
            c=cos(2*pi*i/T*t); 
        end 
        return,
    end

    function s=fS(i,T,t)
        s=sin(2*pi*i/T*t); 
        return
    end
    
    function rez=fnk(T,t) % su triuksmais 
        rez=sin(2*pi/T)./(cos(2*pi*3*t/T)+1.5)+0.17*sin(2*pi*103*t/T)+0.2*cos(2*pi*56*t/T);
    return
    end
    
    function rez=fnk2(T,t) % be triuksmu
        rez=sin(2*pi/T)./(cos(2*pi*3*t/T)+1.5);
    return 
    end 
