clc;
clear;
close all;

syms x1 x2;


% create directories
formats = ["eps", "png", "jpg"];

for i = 1:length(formats)
    mkdir(fullfile('../../figures', 'ex1', sprintf('%s', formats(i))));
end


% init params
f=(1/3)*(x1^2)+3*(x2^2);

f1 = inline(f);
fx = @(x) f1(x(:,1), x(:,2));


 
x0 = [8 -10];
gammaOptions = [0.1,0.3,3,5];
subPlotPositions = {1, 2, 3, 4};

count = 1;

    X0 = sprintf('For initial point (%d, %d)\n', x0(1,1), x0(1,2));
    disp(X0);
    fig = figure();
    fig.WindowState = 'maximized';
    for i = 1:length(gammaOptions)

        [res] = steepestDescent(1e-3, x0, f, gammaOptions(i));

        results(count).xmin = res.xmin;
        results(count).dist = res.dist;
        results(count).gammas = res.gammas;
        results(count).time = res.time;
        results(count).xs = res.xs;
        results(count).k = res.k;
        results(count).method = res.method;
        results(count).x0 = x0;

        subplot(2,2, subPlotPositions{i});
        plot(1:res.k, fx(res.xs), '-ob');
        
        hold on;
        yline(fx(res.xmin), '-.r');
        

        xlabel('k Αριθμός επαναλήψεων', 'Interpreter','tex')
        ylabel('Τιμή της f(x_k)', 'Interpreter','tex');
        legend('Τιμή της f', 'Ελάχιστη τιμή της f');
        title(sprintf('Τιμή της f με γ_{k} =  %d για αρχικό σημείο (x, y) = (%d, %d) ~ k αριθμός επαναλήψεων', gammaOptions(i), x0(1,1), x0(1,2)), 'Interpreter', 'tex');

        count = count+1;

    end

    for k  = 1:length(formats)
         % delete and save new plots
         delete(fullfile('../../figures', 'ex1', sprintf("%s", formats(k)), sprintf("ex1b.%s", formats(k))));
         saveas(fig, fullfile('../../figures', 'ex1', sprintf("%s", formats(k)), sprintf("ex1b.%s", formats(k))));
    end

