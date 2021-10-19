%% ����1
[data_1_0,text_1]=xlsread('ER��_activity.xlsx');
[data_2_0,text_2]=xlsread('Molecular_Descriptor.xlsx');
%% ���ݹ�һ��
data_1=mapminmax(data_1_0',0,1)'; %mapminmax���й�һ���谴�й�һ
data_2_1=mapminmax(data_2_0',0,1)';
%data_2_1=data_2_0;

%% ��������ֵ�޳�������ֵ�̶��޲�����
Var_data_2=var(data_2_1); %���㷽��
L_use=find(Var_data_2~=0); %��λ
N=length(L_use); 
data_2=data_2_1(:,Var_data_2~=0);
text_use=cell(N,1); %���������޳��󣬶�Ӧ�������Ƹ���
for k=1:N
    text_use{k,1}=text_2{1,L_use(k)+1};
end
L_unuse=find(Var_data_2==0);
N_unuse=length(L_unuse);
text_unuse=cell(N_unuse,1); %���������޳��󣬶�Ӧ�������Ƹ���
for k=1:N_unuse
    text_unuse{k,1}=text_2{1,L_unuse(k)+1};
end

%% ����1��������Ƥ��ѷ�������ϵ����˹Ƥ�����ȣ���Kendall�����ϵ��
N=length(data_2(1,:));
R_result_P=zeros(2,N); %��¼�������ϵ��
P_result_P=zeros(2,N); %��¼�������������ָ��pֵ
R_result_S=zeros(2,N); %��¼���������ϵ��
P_result_S=zeros(2,N); %��¼���������������ָ��pֵ
y1=data_1(:,1); %IC50_nM(ֵԽС�������������Խ�󣬶�����ER������Խ��Ч)
y2=data_1(:,2); %pIC50(ֵԽ�󣺱����������Խ��,��������ER������Խ��Ч)
for k=1:N
    x=data_2(:,k);
%     fig1=scatter(x,y1);
%     % saveas(fig1,strcat('1-',num2str(k),'.jpg'));
%     fig2=scatter(x,y2);
%     saveas(fig2,strcat('2-',num2str(k),'.jpg'));
    [R_result_P(1,k),P_result_P(1,k)]=corr(x,y1); % ����IC50_nM���������ϵ��
    [R_result_P(2,k),P_result_P(2,k)]=corr(x,y2); % ����IC50_nM���������ϵ��
    [R_result_S(1,k),P_result_S(1,k)]=corr(x,y1,'type','Spearman'); % ����IC50_nM�ķ��������ϵ��
    [R_result_S(2,k),P_result_S(2,k)]=corr(x,y2,'type','Spearman'); % ����IC50_nM�ķ��������ϵ��
    
end

%% ���ݶ�ȡ
[data_select_1,text_select]=xlsread('���ϵ��.xlsx','Sheet1');
[data_select_2,~]=xlsread('���ϵ��.xlsx','Sheet2');
[data_select_3,~]=xlsread('���ϵ��.xlsx','Sheet3');

%% ��������
data_select_use=[abs(data_select_1(:,1))';abs(data_select_2(:,1))';abs(data_select_3(:,1))']; % �����3��
data_select_use_max=max(data_select_use); %ȡ���ֵ  %%%%%%%%%%%��������
data_select_use_max_sort=sort(data_select_use_max,2,'descend');
% ����������ֵ����
text_sort_2_M=cell(504,1);
data_sort_2_M=zeros(504,5);
k=1;
while k<=504 
    L_x=data_select_use_max_sort(k);
    L_2=find(abs(data_select_use_max)==L_x);
    n=length(L_2);
    for g=1:n
        L_r=data_select_use_max(L_2(g));
        data_sort_2_M(k+g-1,1:2)=[L_r,L_2(g)];
        data_sort_2_M(k+g-1,3:5)=data_select_use(:,L_2(g))';
        text_sort_2_M{k+g-1,1}=text_select{L_2(g)+1,1};
    end
    k=k+n;
%     display(strcat(text{L_x,1},num2str(L_x),',',num2str(L_2),',',num2str(L_p)))
end

