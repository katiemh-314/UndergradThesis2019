% TracePic but with a txt file

%% Open text file
%
close all
clear
clc

Table = readtable('Phantom_2_10^6.txt');

%% 
A=table2array(Table);
X=A(:,4);       %x Position
Y=A(:,5);       %y Position
Z=A(:,6);       %z Position
x=A(:,7);       %x Vector
y=A(:,8);       %y Vector
z=A(:,9);       %z Vector
n=[0,0,max(A)]; %

%% Create Plot 2 D map
plot(X,Y,'hb'); %Plot the X and Y position of each photon trace
c=size(X);  %The number of photons that encountered 
i=1;    
hold on
for i=1:c(1)       %Find angle of entry for each photon path
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
B=A(:,4:5);
C=hist3(B,'Nbins',[100 100]);
title('Figure 1')
colorbar

%Plot colored heat plot
figure
B=A(:,4:5);
D=hist3(B,'Nbins',[100 100]);
title('Hist')
pcolor(D)
title('Segmented Photon Heatmap')
colormap('jet')
colorbar
view(2)

%%  
%figure
%dist=sqrt((X+.1634).^2+(Y+0).^2);
%N_pcolor=C';
%N_pcolor(size(N_pcolor,1)+1,size(N_pcolor,2)+1)=0;
%x1=linspace(min(X),max(X),size(N_pcolor,2));
%y1=linspace(min(Y),max(Y),size(N_pcolor,1));
%h=pcolor(x1,y1,N_pcolor);
%colormap('jet')
%colorbar
%title('Wow')
%Xedges = get(h, 'XData');
%Yedges = get(h, 'YData');

%% Find Bin value
%E=imrotate(D,50);
%figure
%imagesc(E)
%title('Rotated Image')
Axis=D(50,:);
Axis=flip(Axis);
Normalized_Reflectance=Axis./max(Axis)
%Axis=Axis(1:100)
Distance_from_Source=[364:10:1363];
Bdist=linspace(1,1000);

%plot([1:141],Axis);
%matlab fitting tool power law