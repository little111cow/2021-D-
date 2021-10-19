% x-x-x-x-x-x
load('for2_20.mat')
PP1=p_2_20;
load('for2-20-7-4.mat')
PP2=p_2_20;
load('for2-20-7-4-3-4.mat')
PP3=p_2_20;
load('for2-20-7-4-3-4-1-3.mat')
data_16_4_4_3_3_2_x_x=cell(29,1);
data_16_4_4_3_3_2_x_x_n=zeros(29,1);
data_16_4_4_3_3_2_x_x_k=zeros(29,1);
data_max_16_4_4_3_3_2_x_x=zeros(KK,1);
text_data_7_6_5_2_1_2_1_2=cell(6,1);
L_0=p{1,2}; 
L_1=PP1{1,7};
L_1_1=PP2{1,3};
L_1_1_1=PP3{1,1};
for k=1:3
    L_2=p_2_20{1,k};
    L_3=L_1_1_1(L_2);
    L_4=L_1_1(L_3);
    L_5=L_1(L_4);
    L=L_0(L_5);
    data_max_16_4_4_3_3_2_x_x(k)=max(data_select_use_max(L));
    data_use_2=data_2(:,L);
    Cor_data_use_2=corr(data_use_2,'type','Spearman');
    Cor_data_use_1=corr(data_use_2);
    text_data_7_6_5_2_1_2_1_2{k,1}=text_use(L,1);
    if min(min(Cor_data_use_2))<0.85 && min(min(Cor_data_use_1))<0.85
        display(k)
        data_16_4_4_3_3_2_x_x_k(k,1)=k;
        data_16_4_4_3_3_2_x_x{k,1}=data_use_2;
        [coeff,score,latent] = pca(data_use_2); % �������ɷַ���
        w_sum=0;
        n=0;
        while w_sum<0.85
            n=n+1;
            w_sum=(w_sum*sum(latent)+latent(n))/sum(latent);
        end
        display(n) %����n=29
        data_16_4_4_3_3_2_x_x_n(k,1)=n;
        save(strcat('2-20-7-4-3-4-1-3-',num2str(k),'-',num2str(n),'.mat'),'data_use_2')
    end
end