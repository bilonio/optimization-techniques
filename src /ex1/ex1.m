% clear all and close all the streams
clc;
clear;
close all;

% create directories
formats = ["svg", "eps", "jpg"];

for i = 1:length(formats)
    mkdir(fullfile('../../figures', 'ex1', sprintf('%s', formats(i))));
end
% mkdir(fullfile('../../figures', 'ex1', 'svg'));
% mkdir(fullfile('../../figures', 'ex1', 'eps'));

syms x1 x2;
f = (x1^3) * (exp(-x1^2 - x2^4));

fig = figure;
fig.WindowState = 'maximized';

% plot the function 
fsurf(f, 'ShowContours', 'on')
hold on;
title('Γραφική παράσταση της f(x) = x^{3} \cdot e^{-x^2 - y^4}', 'FontSize', 20, 'Interpreter','tex');

% make title larger 
ax = gca;
% ax.TitleFontSizeMultiplier = 3;

% labels
ylabel('y', 'FontSize', 20, 'Interpreter', 'tex');
xlabel('x', 'FontSize', 20, 'Interpreter', 'tex');
zlabel('z', 'FontSize', 20, 'Interpreter', 'tex');


% save plots

for i = 1:length(formats)
 delete(fullfile('../../figures', 'ex1', sprintf("%s", formats(i)), sprintf("fx.%s", formats(i))));
 saveas(fig, fullfile('../../figures', 'ex1', sprintf("%s", formats(i)), sprintf("fx.%s", formats(i))));
end


