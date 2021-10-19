%% ��������
load ps;  %���ع�һ��״̬���ڷ���һ��
load('y_res.mat');  %ģ������ʱ��ʵ����
load('regr_res.mat');  %ģ������ʱ��Ԥ������
load('y_2.mat')  %ģ�͵õ��Ĳ��Լ�Ԥ������

%% ���չ�һ�����Եķ�����ps��¼������һ����������
a=mapminmax('reverse',y_res,ps);  %��ʵֵ����ps������Ĺ�һ��״̬������һ������ʵ����
b=mapminmax('reverse',regr_res,ps);  %ģ������Ԥ��ֵ����ps������Ĺ�һ��״̬������һ������ʵ����
d=mapminmax('reverse',y_2,ps);  %ģ�ͶԲ������ݵ�Ԥ��ֵ����ps������Ĺ�һ��״̬������һ��������Ԥ������

%% Ԥ����
plot(d,'*--','color','red');
title('����������Ԥ����')
xlabel('������')
ylabel('pIC50')

%% �����ع����ͼ��ģ�����Ч��
l=length(a);
figure
plot(1:l,a(1:l),'*--')
hold on
plot(1:l,b(1:l),'x--','linewidth',1.5)
legend('true','pridict')
title('adaBoost')
xlabel('����')
ylabel('pIC50')

% %% ����ع�ģ�͵�ƽ������������
disp(['adaboost�ع�����ƽ���������Ϊ��',num2str(mean(abs(a'-b)))])

