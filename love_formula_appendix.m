
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

%% �⑫1�Ffliplr��Y�ꂽ��ǂ��Ȃ�H
vX = [x, (x)];    % ���_��x���W
vY = [yu, (yl)];  % ���_��y���W

fig_fill2 = figure('Name', '���p�`��\��������@');
fill(vX, vY, 'r');      % ���p�`�̕\��
pbaspect([1, 1, 1]);    % ���ꂼ��̎��̔��1:1:1�ɌŒ�
xlim([-1.2, 1.2]);      % x�����̕\���͈�
ylim([-1.2, 2.0]);      % y�����̕\���͈�

%% �⑫�Farea�֐�
fig_area = figure('Name', 'Area');
area(x, yu, min(yu), 'FaceColor', 'r', 'ShowBaseLine', 'off', 'LineStyle', 'none');
hold on;
area(x, yl, max(yl), 'FaceColor', 'r', 'ShowBaseLine', 'off', 'LineStyle', 'none');
hold on;
plot(x, yu, 'k', x, yl, 'k');
pbaspect([1, 1, 1]);    % ���ꂼ��̎��̔��1:1:1�ɌŒ�
xlim([-1.2, 1.2]);      % x�����̕\���͈�
ylim([-1.2, 2.0]);      % y�����̕\���͈�

%% ���ʂ̃O���t�̕ۑ�
figs = [fig_fill2, fig_area];
names = {'heart_fill2', 'heart_area'};
for i = 1:2
    print(figs(i), names{i}, '-dpng');
end

