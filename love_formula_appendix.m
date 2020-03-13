
close all;
clearvars;

%% ハートの方程式
% 刻み幅を指定
dx = 0.001;

% x方向の値域を指定
x = -1:dx:1;

% 上界となる境界線 yu
yu = (1 - x).^(1/2).*(x + 1).^(1/2) + (x.^2).^(1/3);

% 下界となる境界線 yl
yl = (x.^2).^(1/3) - (1 - x).^(1/2).*(x + 1).^(1/2);

%% 補足1：fliplrを忘れたらどうなる？
vX = [x, (x)];    % 頂点のx座標
vY = [yu, (yl)];  % 頂点のy座標

fig_fill2 = figure('Name', '多角形を表示する方法');
fill(vX, vY, 'r');      % 多角形の表示
pbaspect([1, 1, 1]);    % それぞれの軸の比を1:1:1に固定
xlim([-1.2, 1.2]);      % x方向の表示範囲
ylim([-1.2, 2.0]);      % y方向の表示範囲

%% 補足：area関数
fig_area = figure('Name', 'Area');
area(x, yu, min(yu), 'FaceColor', 'r', 'ShowBaseLine', 'off', 'LineStyle', 'none');
hold on;
area(x, yl, max(yl), 'FaceColor', 'r', 'ShowBaseLine', 'off', 'LineStyle', 'none');
hold on;
plot(x, yu, 'k', x, yl, 'k');
pbaspect([1, 1, 1]);    % それぞれの軸の比を1:1:1に固定
xlim([-1.2, 1.2]);      % x方向の表示範囲
ylim([-1.2, 2.0]);      % y方向の表示範囲

%% 結果のグラフの保存
figs = [fig_fill2, fig_area];
names = {'heart_fill2', 'heart_area'};
for i = 1:2
    print(figs(i), names{i}, '-dpng');
end

