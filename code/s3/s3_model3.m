clc;clear;close all
load('data_set_select');%ѡȡ������20�������Ĺ�һ������
data=data_select_result;
load('for-question2_and_question3.mat');  %ɸѡ���Ĳ������ݱ���
test_data=data_2_test_use_1;
test_data=mapminmax(test_data',0,1);  %��һ����������
test_data=test_data';
admet_training = xlsread('ADMET.xlsx');  %��ǩ����ADMET����

dim = 9;  %PCA��ά��ȡ�����ɷ�ά��
N_train=1000;
admet_var = 3;  %������ADMET1����
[coeff,demension_dec,latent] = pca(data);  %PCA��ά
data_dec = demension_dec(:,1:dim);  %����dimά
[coff,test_demension_dec,latent_test] = pca(test_data);  %����������ͬ�Ĳ���
test_data_dec = test_demension_dec(:,1:dim);
test_data=test_data_dec;

svm_data = data_dec;
length(svm_data)
svm_label = admet_training(:,admet_var);
train_data=svm_data;
train_label=svm_label;
save('./svm/svm_data.mat','svm_data','-mat'); %����ģ�����ݣ���ȫ���������ݣ�python���밴��0.2���ֲ��Լ�
save('./svm/svm_label.mat','svm_label','-mat'); %����ģ�ͱ�ǩ
save('./svm/train_data.mat','train_data','-mat');%��������Ԥ���������ѵ����ȫ��ѵ������
save('./svm/train_label.mat','train_label','-mat');%��������Ԥ���������ѵ����ȫ��ѵ����ǩ
save('./svm/test_data.mat','test_data','-mat');%��������
