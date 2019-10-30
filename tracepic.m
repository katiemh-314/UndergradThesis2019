%% Open Trace Pro file
%[a,f]=tracepic(X,Y,Z,x,y,z,n)
close all
clear
clc
filename='Phantom_2_10^6.xls'
%xcelrange=input('Input the matrix range? (Format A10:C20)\n','s')    %user define matrix range in excel
%xcelrange='H3:M2860'
A=xlsread(filename);
%% 
X=A(:,2)*100+15; %x Position
Y=A(:,3)*100;   %y Position
Z=A(:,4);       %z Position
x=A(:,5);       %x Vector
y=A(:,6);       %y Vector
z=A(:,7);       %z Vector
n=[0,0,max(A)]; %

%% Create Plot 2 D map
plot(X,Y,'hr'); %Plot the X and Y position of each photon trace
c=size(X);  %The number of photons that encountered 
i=1;    
hold on
for i=1:c(1);       %Find angle of entry for each photon path
a(i)=asin(abs(x(i)*0+y(i)*0+z(i)*n(:,3))/(sqrt(x(i)^2+y(i)^2+z(i)^2)*sqrt(n(:,3).^2)));
i=i+1;
end

d=input('How many degrees are allowed?\n'); %Input minimum angle of entry
a=rad2deg(a);
f=find(a>d) ;   %number of degrees allowable

plot(X(f),Y(f),'hg');       %Show change in number of allowed photons
legend('bad','good');

figure
plot(X(f),Y(f),'hc')


%% Plot 3D histogram

%Plot histogram
figure
B=A(:,2:3);
C=hist3(B,'Nbins',[100 100]);
colorbar

%Plot colored heat plot
B=A(:,2:3);
D=hist3(B,'Nbins',[10 10]);
title('Hist')
%hist3(B,'CdataMode','auto')
pcolor(D)
title('Hist')
colormap('jet')
colorbar
view(2)
%% 
figure
%dist=sqrt((X+.1634).^2+(Y+0).^2);
N_pcolor=C';
N_pcolor(size(N_pcolor,1)+1,size(N_pcolor,2)+1)=0
x1=linspace(min(X),max(X),size(N_pcolor,2));
y1=linspace(min(Y),max(Y),size(N_pcolor,1));
h=pcolor(x1,y1,N_pcolor)
colormap('jet')
colorbar

Xedges = get(h, 'XData')
Yedges = get(h, 'YData')

%% Find Bin value

Axis=C(5,:)
Bdist=[1:10]

%matlab fitting tool power law