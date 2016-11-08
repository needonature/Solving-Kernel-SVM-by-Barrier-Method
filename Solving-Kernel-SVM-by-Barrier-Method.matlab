load('moviesTest.mat');
load('moviesTrain.mat');
Y=trainLabels;
X=trainRatings;
[n,~]=size(X);
Y(find(Y==0))=-1;
KK=K(Y,X);

%barrier
t=1000;
mu=1.5;
m=2*n;
epsilon=1e-8;
w=500*ones(n,1);

%following R
while(m/t>=epsilon)
    w=Newton(w,KK,Y,t);
    t=mu*t;
end

%optimal value
f(w,KK)

%#support vector
length(find(w>=1e-6&w<1000-1e-6))

%accuracy
Y1=trainLabels;
X1=trainRatings;
Y2=testLabels;
X2=testRatings;
Y1(find(Y1==0))=-1;
Y2(find(Y2==0))=-1;
ii=find(w>=1e-6&w<1000-10e-6);

%train
n=length(Y1);
beta0=sum(Y(ii)'-sum(diag(w)*diag(Y)*KK(:,ii)))/length(ii);

sigma=1000;
YY=zeros(n,1);
for j=1:n
    qq=0;
    for i=1:n
        qq=qq+w(i)*Y(i)*exp(-norm(X(j,:)-X(i,:))^2/(2*sigma^2));
    end
    YY(j)=qq+beta0;
end

YY(YY>0)=1;
YY(YY<0)=-1;
e=abs(YY-Y);
err1=length(e(e>0))/n;
acc1=1-err1

%test
KK2=K(Y2,X2);
n=length(Y2);

sigma=1000;
YY=zeros(n,1);
for j=1:n
    qq=0;
    for i=1:n
        qq=qq+w(i)*Y2(i)*exp(-norm(X(j,:)-X(i,:))^2/(2*sigma^2));
    end
    YY(j)=qq+beta0;
end

YY(YY>0)=1;
YY(YY<0)=-1;
e=abs(YY-Y2);
err2=length(e(e>0))/n;
acc2=1-err2
