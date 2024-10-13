EbN0_db = 0:2:24;
EbN0 = 10.^(EbN0_db/10);

%PSK
M_PSK = [2,4,6,8,16,32];
P_SER_PSK =  zeros(length(M_PSK),length(EbN0));

for i=1:length(M_PSK)
    M = M_PSK(i);
    P_SER_PSK(i,:) = 2*qfunc(sqrt(2*EbN0*sin(pi/M)));
end

%PAM
M_PAM = [2,4,6,8,16,32];
P_SER_PAM =  zeros(length(M_PAM),length(EbN0));

for i=1:length(M_PAM)
    M = M_PAM(i);
    P_SER_PAM(i,:) = 2*((M-1)./M)*qfunc(sqrt((6*log2(M)/(M.^2 - 1))*EbN0));
end

%QAM
M_QAM = [4,16,64,256];
P_SER_QAM =  zeros(length(M_QAM),length(EbN0));

for i=1:length(M_QAM)
    M = M_QAM(i);
    P_SER_QAM(i,:) = 4*(1-1./(sqrt(M)))*qfunc(sqrt((3*log2(M)/(M - 1))*EbN0));
end

%MFSK Coherent
M_FSK_C = [2,4,6,8,16,32];
P_SER_FSK_C =  zeros(length(M_FSK_C),length(EbN0));

for i=1:length(M_FSK_C)
    M = M_FSK_C(i);
    P_SER_FSK_C(i,:) = qfunc(sqrt(2*EbN0*log2(M)/(M-1)));
end

%MFSK Coherent
M_FSK_NC = [2,4,6,8,16,32];
P_SER_FSK_NC =  zeros(length(M_FSK_NC),length(EbN0));

for i=1:length(M_FSK_NC)
    M = M_FSK_NC(i);
    P_SER_FSK_NC(i,:) = exp(-EbN0/2).*(((1+EbN0).^(M-1)-1)./M-1);
end
%plotting
subplot(2,3,1)
for i = 1:length(M_PSK)
    semilogy(EbN0_db,P_SER_PSK(i,:),'-o');
    hold on;
end
subplot(2,3,2)
for i = 1:length(M_PAM)
    semilogy(EbN0_db,P_SER_PAM(i,:),'-o');
    hold on;
end
subplot(2,3,3)
for i = 1:length(M_QAM)
    semilogy(EbN0_db,P_SER_QAM(i,:),'-o');
    hold on;
end
subplot(2,3,4)
for i = 1:length(M_FSK_C)
    semilogy(EbN0_db,P_SER_FSK_C(i,:),'-o');
    hold on;
end
subplot(2,3,5)
for i = 1:length(M_FSK_NC)
    semilogy(EbN0_db,P_SER_FSK_NC(i,:),'-o');
    hold on;
end