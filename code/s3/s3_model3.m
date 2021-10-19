clc;clear;close all
load('data_set_select');%选取出来的20个变量的归一化数据
data=data_select_result;
load('for-question2_and_question3.mat');  %筛选出的测试数据变量
test_data=data_2_test_use_1;
test_data=mapminmax(test_data',0,1);  %归一化测试数据
test_data=test_data';
admet_training = xlsread('ADMET.xlsx');  %标签，即ADMET性质

dim = 9;  %PCA降维后取的主成分维数
N_train=1000;
admet_var = 3;  %第三列ADMET1性质
[coeff,demension_dec,latent] = pca(data);  %PCA降维
data_dec = demension_dec(:,1:dim);  %降到dim维
[coff,test_demension_dec,latent_test] = pca(test_data);  %测试数据相同的操作
test_data_dec = test_demension_dec(:,1:dim);
test_data=test_data_dec;

svm_data = data_dec;
length(svm_data)
svm_label = admet_training(:,admet_var);
train_data=svm_data;
train_label=svm_label;
save('./svm/svm_data.mat','svm_data','-mat'); %评估模型数据，即全部测试数据，python代码按照0.2划分测试集
save('./svm/svm_label.mat','svm_label','-mat'); %评估模型标签
save('./svm/train_data.mat','train_data','-mat');%用于最终预测测试数据训练的全部训练数据
save('./svm/train_label.mat','train_label','-mat');%用于最终预测测试数据训练的全部训练标签
save('./svm/test_data.mat','test_data','-mat');%测试数据
