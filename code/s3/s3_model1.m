clc;clear;close all
%%˵����ע�͵��Ĳ��ִ���Ϊģ�������Ĺ��̴��룬��Ҫ�ı�ѵ���Ͳ��Լ��Ķ���
%ѵ�����Ͳ��Լ�����ѵ�������֣���������ѵ�����������ڲ���
%% ��������
load('data_set_select');  %ѡȡ������20�������Ĺ�һ������
data=data_select_result;
load('for-question2_and_question3.mat');  %50������������Ӧ��20��������δ��һ������
test_data=data_2_test_use_1;
test_data=mapminmax(test_data',0,1);  %��һ����������
test_data=test_data';
admet_training = xlsread('ADMET.xlsx');  %��ȡADMET������Ϊ��ǩ

%% PCA����
dim = 5;  %PCA��ά��ȡ�����ɷ�ά��
N_train=400;  %��ѵ��������ѡȡ400����ΪKNNѵ������
admet_var = 1;  %����ADMET��һ������Ԥ��
[coeff,demension_dec,latent] = pca(data);  %ѵ������PCA����
[coff,test_demension_dec,latent_test] = pca(test_data);%��������PCA����
data_dec = demension_dec(:,1:dim);  %����dimά
test_data_dec = test_demension_dec(:,1:dim);

%% ���ݼ�
test=zeros(50,dim+1);
test(:,1:end-1) = test_data_dec;  %��������
%��50�����ݱ�ǩȫ����Ϊ1�����������ã�ֻΪ��KNNmain�뺯����Ӧ�����յ�Ԥ���ǩΪpridicted��Ӧ��ֵ
test(:,end) =ones(50,1);  

%ȡ400��ѵ������ѵ��KNN
train =zeros(N_train,dim+1);
% test =zeros(1974-N_train,dim+1);  %��ʼ��

train(:,1:end-1)= data_dec(1:N_train,:);
train(:,end) = admet_training(1:N_train,admet_var);

% test(:,1:end-1) = data_dec(N_train+1:end,:);  %��������
save test;  %�������KNNmain������ȡ
save train;  %�������KNNmain������ȡ
% test(:,end) = admet_training(N_train+1:end,admet_var);  %���Ա�ǩ

acc=KNNmain(80);  %����Ԥ��
% plot(N_train,acc,'*--','linewidth',1.5);
% title('CaCo-2:KNN����ģ��׼ȷ����ѵ���������仯������');
% xlabel('ѵ��������')
% ylabel('Ԥ��׼ȷ��')
% legend('CaCo-2-KNNԤ��ģ��')