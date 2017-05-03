clear;
clc;
% S = xlsread ('/Users/David/Downloads/Untitled spreadsheet.xlsx','B:G');
S = xlsread ('SC_HPA','B:D');

%GP
S_b = S(:,1);
%mean
S_c = S(:,2);
%LR
S_d = S(:,3);
x = (3:12)';
M_PAI = [x S_b S_c S_d];
%save('SC_GP');
figure;
plot(x, S_b, 'r-');
hold on;
plot(x, S_c, 'g-');
plot(x, S_d, 'b-');
legend('GP','Mean','LR');
title('STREET CRIME');
xlabel('Month');
ylabel('Hotspot Prediction Accuracy');
% 
% plot(x, S_c, 'r-');
% hold on;
% plot(x, S_e, 'g-');
% plot(x, S_g, 'b-');
% legend('GP','Mean','LR');
% title('BURGLARY');
% xlabel('Month');
% ylabel('PEI');