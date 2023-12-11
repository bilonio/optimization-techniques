clc;
clear;
close all;

syms x1 x2;


% create directories
formats = ["eps", "png", "jpg"];

for i = 1:length(formats)
    mkdir(fullfile('../../figures', 'ex3', sprintf('%s', formats(i))));
end


% init params
f=(1/3)*(x1^2)+3*(x2^2);

f1 = inline(f);
fx = @(x) f1(x(:,1), x(:,2));


a=[-10 -8];
b=[5 12];
x0 = [-5 10];
gamma=0.1;
sk=15;



    X0 = sprintf('For initial point (%d, %d)\n', x0(1,1), x0(1,2));
    disp(X0);
    fig = figure();
    fig.WindowState = 'maximized';
    

        [res] = DescentProjection(1e-2, x0, f,gamma,sk,a,b);

        results.xmin = res.xmin;
        results.dist = res.dist;
        results.gammas = res.gammas;
        results.time = res.time;
        results.xs = res.xs;
        results.k = res.k;
        
        results.x0 = x0;

        subplot(1,2,1);
        plot(1:res.k, fx(res.xs), '-ob');
        hold on;
        yline(fx(res.xmin), '-.r');
       

        xlabel('k Αριθμός επαναλήψεων', 'Interpreter','tex')
        ylabel('Τιμή της f(x_k)', 'Interpreter','tex');
        legend('Τιμή της f', 'Ελάχιστη τιμή της f');
        title(sprintf('Τιμή της f με γ_{κ}= %d, s_{k}=%d για αρχικό σημείο (x, y) = (%d, %d) ~ k αριθμός επαναλήψεων', gamma, sk,x0(1,1), x0(1,2)), 'Interpreter', 'tex');

        subplot(1,2,2);
% Plot contour of the objective function 
[X, Y] = meshgrid(linspace(a(1), b(1), 100), linspace(a(2), b(2), 100));
Z = (1/3) * X.^2 + 3 * Y.^2;
contour(X, Y, Z, 50, 'LineWidth', 1.5,'DisplayName','Contour Lines');
hold on;
% Filter xs based on the specified range
valid_indices = find(res.xs(:, 1) >= -10 & res.xs(:, 1) <= 5 & res.xs(:, 2) >= -8 & res.xs(:, 2) <= 12);

% Plot xs within the specified range
plot(res.xs(valid_indices, 1), res.xs(valid_indices, 2), '-ob', 'DisplayName', 'kth xs');
% Plot res.xmin point
scatter(res.xmin(1), res.xmin(2), 100, 'xr', 'DisplayName', 'Minimum Point');


xlabel('x_1');
ylabel('x_2');
title('Σύγκλιση των υποψηφίων σημείων ελαχίστου');
legend;  

    

    for k  = 1:length(formats)
         % delete and save new plots
         delete(fullfile('../../figures', 'ex3', sprintf("%s", formats(k)), sprintf("ex3a(%.0f, %.0f).%s", x0(1,1), x0(1,2), formats(k))));
         saveas(fig, fullfile('../../figures', 'ex3', sprintf("%s", formats(k)), sprintf("ex3a(%.0f, %.0f).%s", x0(1,1), x0(1,2), formats(k))));
    end


