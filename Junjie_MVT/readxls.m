clear;
clc;
% S = xlsread ('/Users/David/Downloads/Untitled spreadsheet.xlsx','B:G');
S = xlsread ('BUR','B:G');

%GP
S_b = S(:,1);
S_c = S(:,2);
%mean
S_d = S(:,3);
S_e = S(:,4);
%LR
S_f = S(:,5);
S_g = S(:,6);
x = (3:12)';
M_PAI = [x S_b S_d S_f];
%save('SC_GP');
figure;
plot(x, S_b, 'r-');
hold on;
plot(x, S_d, 'g-');
plot(x, S_f, 'b-');
legend('GP','Mean','LR');
title('BURGLARY');
xlabel('Month');
ylabel('PAI');
% 
% plot(x, S_c, 'r-');
% hold on;
% plot(x, S_e, 'g-');
% plot(x, S_g, 'b-');
% legend('GP','Mean','LR');
% title('BURGLARY');
% xlabel('Month');
% ylabel('PEI');