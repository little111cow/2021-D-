clc;clear;close all;
cd C:\Users\Сţ��\Desktop\��ѧ��ģ\2021��D��
N=729;
activity = xlsread('ER��_activity.xlsx');
descriptor_training = xlsread('Molecular_Descriptor.xlsx',1);  %����������ѵ������
descriptor_test = xlsread('Molecular_Descriptor.xlsx',2);  %������������������
admet_training = xlsread('ADMET.xlsx'); %����

cd C:\Users\Сţ��\Desktop\��ѧ��ģ\2021��D��\code\s1
%%  ��һ������
activity_norm = mapminmax(activity',0,1);
descriptor_training_norm = mapminmax(descriptor_training',0,1);
descriptor_test_norm = mapminmax(descriptor_test',0,1);



%% ɸ�����Ϊ��ı���
j=1;
for i=1:N
    if var(descriptor_training_norm(i,:))~=0
        descriptor_training_byvar(j,:)=descriptor_training_norm(i,:);
        descriptor_index(j)=i;  %��Ӧ������xlxs���е�����λ��
        j=j+1;
    end
end
save activity_norm;
save descriptor_training_byvar;
%��������ѡ�����ϱ���ͬ�ı���
for i=1:length(descriptor_index)
    descriptor_test_byvar(i,:) = descriptor_test_norm(descriptor_index(i),:);
end

N_class = 50;
[idx,C,sumd,D] = kmeans(descriptor_training_byvar,N_class);

for i=1:N_class
    p{i}=find(idx==i);
end


%% �ھ�����������ҳ����ϵ�������Ǹ�������������
load('coff1.mat');
topn = zeros(1,N_class);
for i=1:N_class
    temp = coff1(p{i}(1:length(p{i})));
    for j=1:length(temp)
        if coff1(p{i}(j))==max(temp)
            topn(i)=p{i}(j);
        end
    end
end
topn =sort(topn);
%% ����ɸ��ǰ20��
res = zeros(1,20);

temp = coff1(topn(1:N_class));
temp1 = sort(temp,'descend');   
th = temp1(20);

j=1;
for i=1:N_class
    if coff1(topn(i))>=th
        res(j)=topn(i);
        j=j+1;
    end
end
res= sort(res);

