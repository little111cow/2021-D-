load('data_set_select');  %����ɸѡ����20������
data=data_select_result;
activity = xlsread('ER��_activity.xlsx');  % ���ػ�������
load('for-question2_and_question3.mat');  %���ز�������
test=data_2_test_use_1;
test=mapminmax(test',0,1);  %�������ݹ�һ��
test=test';
activity = activity(:,2);  %ʹ��PIC50����ֵ����Ϊ�ع�ģ�����

[activity_norm,ps] = mapminmax(activity',0,1);  %���ݹ�һ��
activity_norm = activity_norm';

dim = 15;  %pca������άά��
[coeff,demension_dec,latent] = pca(data);  %ѵ������PCA��ά
data_dec = demension_dec(:,1:dim);  %����dimά
[coff,test_demension_dec,latent_test] = pca(test);  %��������PCA��ά
data_dec = demension_dec(:,1:dim);  %����dimά

test_data_dec = test_demension_dec(:,1:dim);

train_data = data_dec;
train_y = activity_norm;

test_data = test_data_dec;
save train_data;
save train_y;
save test_data;
save ps;  %�����һ����¼�����ڷ���һ��