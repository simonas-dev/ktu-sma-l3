function main
    clear all;
    clc;
    close all;

    T = 4; % periodas 

    fp=@(t)sin(2*pi*t/T)./(cos(2*pi*3*t/T)+1.5);
    r=@(t)0.17*sin(2*pi*103*t/T)+0.2*cos(2*pi*56*t/T);
    
    f=@(t)fp(t) + r(t);

    n = 1000; % reikia nelyginio skaicius
    n = floor(n/2) * 2 + 1;
    m = 200; % auskciausias imanomas daznis bazines func

    dt = T/n;
    t = 0:dt:T-dt;
    ttt = -T:dt:T*2;

    % Atvaizduojama pradine func ir triuksmas.
    pradDuom(fp, t, 1, 'Pradine funkcija');
    pradDuom(f, t, 2, 'Funkcija su triukšmu');

    ff = f(t);

    % 1)
    %amplitudziuSlenkstis = 0.2001; 
    %dazniuSlenkstis = m;
    
    % 2)
    amplitudziuSlenkstis = 0;
    dazniuSlenkstis = 20;
    
    ac = zeros(1, m);
    as = zeros(1, m);

    ac(1) = sum(ff) / n;
    for i=2:m
        ac(i) = ff * cos((i-1)*2*pi*t/T)'*2/n;
        as(i) = ff * sin((i-1)*2*pi*t/T)'*2/n;
    end
    amplitudes = sqrt(ac.^2 + as.^2);
    
    % Atvaizduojamos amplitudes.
    ampl(3, m, amplitudes, amplitudziuSlenkstis, dazniuSlenkstis)

    dazniai = 1:m;
    dazniai = dazniai(dazniai < dazniuSlenkstis &...
        amplitudes > amplitudziuSlenkstis);

    fffz = zeros(1, numel(ttt));
    for i=dazniai
        fffz = fffz + ac(i) *cos((i-1)*2*pi*ttt/T)+...
            as(i) *sin((i-1)*2*pi*ttt/T);
    end

    % Rezultatas.
    rez(4, ttt, fffz, ff, t);
end

% Atvaizduojami pradiniai duomenys.
function pradDuom(f, t, nr, name)
    figure(nr); hold on; grid on;
    plot(t, f(t), 'b-', 'LineWidth', 1);
    title(name)
end

% Atvaizduojamos amplitudes.
function ampl(nr, m, amplitudes, amplitudziuSlenkstis, dazniuSlenkstis)
    figure(nr); hold on; grid on;
    bar(0:m-1, amplitudes, 0.1);
    xlabel('dazniai'); ylabel('amplitudes');
    h1 = plot([0 m-1], [amplitudziuSlenkstis amplitudziuSlenkstis], 'm-', 'LineWidth', 1);
    h2 = plot([dazniuSlenkstis dazniuSlenkstis], [0 max(amplitudes)], 'r-', 'LineWidth', 1);
    title('Harmoniku amplitudes ir amplitudinis slenkstis');
    legend([h1 h2],{sprintf('Amplitudziu slenkstis, y=%.4f', amplitudziuSlenkstis),'Dazniu slenksttis'});
end

function rez(nr, ttt, f, ff, t)
    figure(nr); hold on; grid on;
    plot(t, ff, 'b-');   
    plot(ttt, f, 'r-', 'LineWidth', 2); 
    title('Transformuota funkcija');
    legend('Funkcija intervale', 'Transformuota funkcija');
end



