%% ������Ӽ�����ԡ�����
corr_data_2=corr(data_2);
[M1,N1]=find(corr_data_2>=0.85 & corr_data_2<1 );
MN=[M1,N1];

%% �������ɷַ���
[coeff,score,latent] = pca(data_2); % �������ɷַ���
% �Թ�����Ϊ85%��Ϊɸѡ������
w_sum=0;
n=0;
while w_sum<0.85
    n=n+1;
    w_sum=(w_sum*sum(latent)+latent(n))/sum(latent);
end
display(n) %����n=29
