clc;close all;clear
%% ˵����ÿһ������ͬ��һ��������Ϣ��ÿһ�д���һ���������һ������
data = xlsread('Molecular_Descriptor.xlsx');
cd C:\Users\Сţ��\Desktop\��ѧ��ģ\2021��D��
activity = xlsread('ER��_activity.xlsx');
admet_training = xlsread('ADMET.xlsx');
cd C:\Users\Сţ��\Desktop\��ѧ��ģ\2021��D��\code\solution2
activity = activity(:,2);
[activity_norm,ps] = mapminmax(activity',0,1);
activity_norm = activity_norm';

% corrmatrix = corrcoef(data);

dim = 10;
admet_var = 1;
[coeff,demension_dec,latent] = pca(data);
data_dec = demension_dec(:,1:dim);  %����10ά

train_data = data_dec;
train_y = activity_norm;

save C:\Users\Сţ��\Desktop\��ѧ��ģ\2021��D��\code\solution1\train_data;
save C:\Users\Сţ��\Desktop\��ѧ��ģ\2021��D��\code\solution1\train_y;
% b = regress(activity_norm(1:1900,2),data_dec(1:1900,:));
% 
% test = data_dec(1901:end,:)*b;
% res = activity_norm(1901:end,2)-test;
% mse = sqrt(mean(res.^2));

train =zeros(1500,dim+1);
test =zeros(474,dim+1);

% data_dec = data(:,1:dim);
train(:,1:end-1)= data_dec(1:1500,:);
train(:,end) = admet_training(1:1500,admet_var);

test(:,1:end-1) = data_dec(1501:end,:);
save test;
save train;
test(:,end) = admet_training(1501:end,admet_var);

svm_data = data_dec;
svm_label = admet_training(:,admet_var);
save('./svm/svm_data.mat','svm_data','-mat');
save('./svm/svm_label.mat','svm_label','-mat');
KNNmain(3);