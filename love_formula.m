
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

% ハートの方程式をプロット
fig_heart = figure('Name', 'ハートの方程式');
plot(x, yu, x, yl);
pbaspect([1, 1, 1]);    % それぞれの軸の比を1:1:1に固定
xlim([-1.2, 1.2]);      % x方向の表示範囲
ylim([-1.2, 2.0]);      % y方向の表示範囲

%% 1. グリッドデータを用いる方法
tic
% 分類学習器のようなモデルを作成
model = struct(...
    'yu', @(x) (1 - x).^(1/2).*(x + 1).^(1/2) + (x.^2).^(1/3),...
    'yl', @(x) (x.^2).^(1/3) - (1 - x).^(1/2).*(x + 1).^(1/2));

% グリッドデータを作成
[X, Y] = meshgrid(-1.2:dx:1.2, -1.2:dx:2);

% 全ての組み合わせについて判別させる
Z = isBetween2Curves(model, [X(:), Y(:)]);

% 判別結果をXやYと同じサイズの行列に整形する
Z = reshape(Z, size(X));

% 結果を等高線を表示させる
fig_grid = figure('Name', 'グリッドデータを用いる方法');
contourf(X, Y, Z);          % 塗りつぶし等高線をプロット
pbaspect([1, 1, 1]);        % それぞれの軸の比を1:1:1に固定
colormap([1,1,1; 1,0,0]);   % false(0)を白([1,1,1])，true(1)を赤([1,0,0])へ
toc

%% 2. 多角形を表示する方法
tic
vX = [x, fliplr(x)];    % 頂点のx座標
vY = [yu, fliplr(yl)];  % 頂点のy座標

fig_fill = figure('Name', '多角形を表示する方法');
fill(vX, vY, 'r');      % 多角形の表示
pbaspect([1, 1, 1]);    % それぞれの軸の比を1:1:1に固定
xlim([-1.2, 1.2]);      % x方向の表示範囲
ylim([-1.2, 2.0]);      % y方向の表示範囲
toc

%% 結果のグラフの保存
figs = [fig_grid, fig_fill];
names = {'heart_grid', 'heart_fill'};
for i = 1:2
    print(figs(i), names{i}, '-dpng');
end

%% ローカル関数
function label = isBetween2Curves(model, data)
    validateattributes(model, {'struct'}, {'scalar'});
    validateattributes(model.yu, {'function_handle'}, {'scalar'});
    validateattributes(model.yl, {'function_handle'}, {'scalar'});
    validateattributes(data, {'numeric'}, {'2d'});
    
    % 変数の置きなおし
    xi = data(:, 1);
    yi = data(:, 2);
    
    % falseですべて埋めたベクトルを用意
    label = false(size(xi));
    
    % データのxに対する上界と下界を計算
    yu = model.yu(xi);
    yl = model.yl(xi);
    
    % 内部領域にある場合のみ，trueを代入
    label(yl < yi & yi < yu) = true;
end
