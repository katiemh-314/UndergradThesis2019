%% Open text file
%
%clear
%clc

%A = textread('Test1Large1.txt','%s');
%b=1;
%c=1;
%d=25;
%while b < 2859;
%B(b,:)=A(c:d);
%b=b+1;
%c=c+25;
%d=d+25;
%end

%RayNumber=B(:,1)
%StartNumber=B(:,2)
%SplitNumber=B(:,3)
%Type=B(:,4)
%Hist=B(:,5)
%IncFlux=B(:,6)
%AbsFlux=B(:,7)
%Xpos=B(:,8)
%Xpos=double(Xpos)
%Ypos=B(:,9)
%Ypos=str2num(Ypos)
%Zpos=B(:,10)
%Xvec=B(:,11)
%Yvec=B(:,12)
%Zvex=B(:,13)
%XNorm=B(:,14)
%YNorm=B(:,15)
%ZNorm=B(:,16)
%S0=B(:,17)
%S1=B(:,18)
%S2=B(:,19)
%S3=B(:,20)
%DegofPol=B(:,21)
%ElliRatio=B(:,22)
%XMajAxis=B(:,23)
%YMajAxis=B(:,24)
%ZMajAxis=B(:,25)
%% Open Trace Pro file
%[a,f]=tracepic(X,Y,Z,x,y,z,n)
close all
clear
clc
filename='Ray Table 10Mill P1-1.xls'
%xcelrange=input('Input the matrix range? (Format A10:C20)\n','s')    %user define matrix range in excel
%xcelrange='H3:M2860'
A=xlsread(filename);
%% 

X=A(:,2)*100;
Y=A(:,3)*100;
Min=-min(X)
X=X+Min
Z=A(:,4);
x=A(:,5);
y=A(:,6);
z=A(:,7);
n=[0,0,max(A)];

%% Plot 2 D map
plot(X,Y,'hr');
c=size(X);
i=1;
hold on
for i=1:c(1);
a(i)=asin(abs(x(i)*0+y(i)*0+z(i)*n(:,3))/(sqrt(x(i)^2+y(i)^2+z(i)^2)*sqrt(n(:,3).^2)));
i=i+1;
end

d=input('How many degrees are allowed?\n');
a=rad2deg(a);
f=find(a>d) ;   %number of degrees allowable

plot(X(f),Y(f),'hg');
legend('bad','good');

figure
plot(X(f),Y(f),'hc')

%% Plot 3D histogram

%Plot histogram
e=21
figure
B=[X,Y];
C=hist3(B,'Nbins',[e e]);
title('e Hist')
colorbar

%Plot colored heat plot
D=hist3(B,'Nbins',[10 10]);
title('Hist')
%hist3(B,'CdataMode','auto')
%figure
pcolor(D)
title('Hist')
colormap('jet')
colorbar
view(2)
%% Create heat map
figure
N_pcolor=C';
N_pcolor(size(N_pcolor,1)+1,size(N_pcolor,2)+1)=0
x1=linspace(min(X),max(X),size(N_pcolor,2));
y1=linspace(min(Y),max(Y),size(N_pcolor,1));
h=pcolor(x1,y1,N_pcolor)
colormap('jet')
colorbar

Xedges = get(h, 'XData')
Yedges = get(h, 'YData')

%% Find Number of Rays in each bin

[Nx,edges]=histcounts(B(:,1),Xedges)
Nx(e+1)=0
R=ones(e);
Pre=1
Post=Nx(1)
for j=1:e
[Ny,edges]=histcounts(B(Pre:Post,2),Yedges)
R(j,:)=Ny
Pre=Pre+Nx(j)
Post=Post+Nx(j+1)
end
R=R'

%% Find distance for source
binDist=ones(e)
Rangex=max(X)
Binx=Rangex/e
Rangey=max(Y)*2
Biny=Rangey/e

for j=1:e
    for i=1:e
    binDist(i,j)=sqrt((j*Binx-.5*Binx).^2+(i*Biny-.5*Biny-15).^2)
    end
end

%% Find distance just of radial points

centerline=R(11,:)        
for k=1:21
    bin2Dist(k)=k*Binx
end


%% f

[Nx,edges]=histcounts(B(:,1),Xedges)
Nx(11)=0
R=ones(10);
Pre=1
Post=Nx(1)
for j=1:10
[Ny,edges]=histcounts(B(Pre:Post,2),Yedges)
R(j,:)=Ny
Pre=Pre+Nx(j)
Post=Post+Nx(j+1)
end
R=R'

%% Find the distance of each bin from source
binDist=ones(10)
Rangex=max(X)
Binx=Rangex/10
Rangey=max(Y)*2
Biny=Rangey/10

for j=1:10
    for i=1:10
    binDist(i,j)=sqrt((j*Binx-.5*Binx).^2+(i*Biny-.5*Biny-15).^2)
    end
end
