clc;
clear;
close all;

syms x1 x2;


% create directories
formats = ["png","eps","jpg"];
for i = 1:length(formats)
    mkdir(fullfile('../../figures', 'ex4', sprintf('%s', formats(i))));
end


% init params
f=(x1^3)*(exp(-x1^2 - x2^4));

f1 = inline(f);
fx = @(x) f1(x(:,1), x(:,2));


 
x0 = [[-1 -1]; [0 0]; [1 1]];
celoptionarray = ["optimal", "constant", "armijo"];
titleoptionarray = ["τέτοιο ώστε να ελαχιστοποιεί την f(x_k + \gamma_k \cdot d_k)", 'σταθερό', 'βάσει του κανόνα Armijo']; 
subPlotPositions = {1, 2, [3, 4]};

count = 1;
for i = length(x0):-1:1
    X0 = sprintf('For initial point (%d, %d)\n', x0(i,1), x0(i,2));
    disp(X0);
    fig = figure(i);
    fig.WindowState = 'maximized';
    for j = 1:length(celoptionarray)

        [res] =levenberg_marquardt(1e-4, x0(i,:), f, celoptionarray(j));

        results(count).xmin = res.xmin;
        results(count).dist = res.dist;
        results(count).gammas = res.gammas;
        results(count).time = res.time;
        results(count).xs = res.xs;
        results(count).k = res.k;
        results(count).method = res.method;
        results(count).x0 = x0(i,:);

        
        subplot(2,2, subPlotPositions{j});
        plot(1:res.k, fx(res.xs), '-ob');
        
        hold on;
        yline(fx(res.xmin), '-.r');
        xlabel('k Αριθμός επαναλήψεων', 'Interpreter','tex')
        ylabel('Τιμή της f(x_k)', 'Interpreter','tex');
        legend('Τιμή της f', 'Ελάχιστη τιμή της f');
        title(sprintf('Τιμή της f με γκ  %s για αρχικό σημείο (x, y) = (%d, %d) ~ k αριθμός επαναλήψεων', titleoptionarray(j), x0(i,1), x0(i,2)), 'Interpreter', 'tex');
       
        
        

        count = count+1;

    end



    for k  = 1:length(formats)
         % delete and save new plots
         delete(fullfile('../../figures', 'ex4', sprintf("%s", formats(k)), sprintf("ex4a(%.0f, %.0f).%s", x0(i,1), x0(i,2), formats(k))));
         saveas(fig, fullfile('../../figures', 'ex4', sprintf("%s", formats(k)), sprintf("ex4a(%.0f, %.0f).%s", x0(i,1), x0(i,2), formats(k))));
    end
end

% find minimums and keep index
[minDist, indexDist] = min([results.dist]);
[minIterations, indexIterations] = min([results.k]);
[minTime, indexTime] = min([results.time]);
[minXmin, indexXmin] = min([results.xmin]);

% display minimums
dist = ['x0 =' , num2str(results(indexDist).x0), ', method ', results(indexDist).method, 'for minimum distance of', num2str(minDist)];
disp(dist);
iterations = ['x0 = ', num2str(results(indexIterations).x0), ', method ', results(indexIterations).method, 'for minimum iterations of', num2str(minIterations)];
disp(iterations);
time = ['x0 = ', num2str(results(indexTime).x0), ', method ', results(indexTime).method, 'for minimum running time of', num2str(minTime)];
disp(time);
xmin = ['x0 = ', num2str(results(indexXmin).x0), ', method ', results(indexXmin).method, 'for minimum final X of', num2str(minXmin)];
disp(xmin);


