
close all;
clearvars;

%% �n�[�g�̕�����
% ���ݕ����w��
dx = 0.001;

% x�����̒l����w��
x = -1:dx:1;

% ��E�ƂȂ鋫�E�� yu
yu = (1 - x).^(1/2).*(x + 1).^(1/2) + (x.^2).^(1/3);

% ���E�ƂȂ鋫�E�� yl
yl = (x.^2).^(1/3) - (1 - x).^(1/2).*(x + 1).^(1/2);

% �n�[�g�̕��������v���b�g
fig_heart = figure('Name', '�n�[�g�̕�����');
plot(x, yu, x, yl);
pbaspect([1, 1, 1]);    % ���ꂼ��̎��̔��1:1:1�ɌŒ�
xlim([-1.2, 1.2]);      % x�����̕\���͈�
ylim([-1.2, 2.0]);      % y�����̕\���͈�

%% 1. �O���b�h�f�[�^��p������@
tic
% ���ފw�K��̂悤�ȃ��f�����쐬
model = struct(...
    'yu', @(x) (1 - x).^(1/2).*(x + 1).^(1/2) + (x.^2).^(1/3),...
    'yl', @(x) (x.^2).^(1/3) - (1 - x).^(1/2).*(x + 1).^(1/2));

% �O���b�h�f�[�^���쐬
[X, Y] = meshgrid(-1.2:dx:1.2, -1.2:dx:2);

% �S�Ă̑g�ݍ��킹�ɂ��Ĕ��ʂ�����
Z = isBetween2Curves(model, [X(:), Y(:)]);

% ���ʌ��ʂ�X��Y�Ɠ����T�C�Y�̍s��ɐ��`����
Z = reshape(Z, size(X));

% ���ʂ𓙍�����\��������
fig_grid = figure('Name', '�O���b�h�f�[�^��p������@');
contourf(X, Y, Z);          % �h��Ԃ����������v���b�g
pbaspect([1, 1, 1]);        % ���ꂼ��̎��̔��1:1:1�ɌŒ�
colormap([1,1,1; 1,0,0]);   % false(0)��([1,1,1])�Ctrue(1)���([1,0,0])��
toc

%% 2. ���p�`��\��������@
tic
vX = [x, fliplr(x)];    % ���_��x���W
vY = [yu, fliplr(yl)];  % ���_��y���W

fig_fill = figure('Name', '���p�`��\��������@');
fill(vX, vY, 'r');      % ���p�`�̕\��
pbaspect([1, 1, 1]);    % ���ꂼ��̎��̔��1:1:1�ɌŒ�
xlim([-1.2, 1.2]);      % x�����̕\���͈�
ylim([-1.2, 2.0]);      % y�����̕\���͈�
toc

%% ���ʂ̃O���t�̕ۑ�
figs = [fig_grid, fig_fill];
names = {'heart_grid', 'heart_fill'};
for i = 1:2
    print(figs(i), names{i}, '-dpng');
end

%% ���[�J���֐�
function label = isBetween2Curves(model, data)
    validateattributes(model, {'struct'}, {'scalar'});
    validateattributes(model.yu, {'function_handle'}, {'scalar'});
    validateattributes(model.yl, {'function_handle'}, {'scalar'});
    validateattributes(data, {'numeric'}, {'2d'});
    
    % �ϐ��̒u���Ȃ���
    xi = data(:, 1);
    yi = data(:, 2);
    
    % false�ł��ׂĖ��߂��x�N�g����p��
    label = false(size(xi));
    
    % �f�[�^��x�ɑ΂����E�Ɖ��E���v�Z
    yu = model.yu(xi);
    yl = model.yl(xi);
    
    % �����̈�ɂ���ꍇ�̂݁Ctrue����
    label(yl < yi & yi < yu) = true;
end
