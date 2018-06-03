% Karam Mawas	    2946939 	
% Ehtesham Hasnain  2995236
clear all
close all
clc

% X=linspace(-6371000,384400000*cosd(390)+1738000,150);
% Y=linspace(-6371000,384400000*sind(390)+1738000,150);
% [X Y]=meshgrid(X,Y);
X=linspace(-1e8,+4e8,25);
Y=linspace(-1e8,+3e8,25);
[X Y]=meshgrid(X,Y);


%%Task 2

%For Earth
X_E = 0;
Y_E = 0;
R_E = 6371000;
m_E = 5.9736*10^24; %mass
v_E = (4/3)*pi*R_E^3; %volume
p_E = m_E/v_E; %density



%For Moon
r_M = 384400000; %distance Earth-Moon
X_M = r_M*cosd(390);
Y_M = r_M*sind(390);
Z_M = 0;
R_M = 1738000;
m_M = 7.349*10^22; %mass
v_M = (4/3)*pi*R_M^3; %volume
p_M = m_M/v_M; %density

%contour
X_c=linspace(-R_E,X_M+R_M,500);
Y_c=linspace(-R_E,Y_M+R_M,500);
[X_c Y_c]=meshgrid(X_c,Y_c);

V_earth=V_sphere(X_c,Y_c,R_E,X_E,Y_E,p_E); %Potential Earth
[ax_E ay_E]=a_sphere( X,Y,R_E,X_E,Y_E,p_E ); %attraction Earth

V_Moon=V_sphere(X_c,Y_c,R_M,X_M,Y_M,p_M); %Potential Moon
[ax_M ay_M]=a_sphere( X,Y,R_M,X_M,Y_M,p_M ); %attraction Moon

%% Task 3 -Visualizing the vector field
% figure 
% quiver(X,Y,ax_E,ay_E)
% figure 
% quiver(X,Y,ax_M,ay_M)

%  The attraction vector driven by Earth and Moon
ax_EM=ax_E+ax_M;
ay_EM=ay_E+ay_M;
a=sqrt(ax_EM.^2+ay_EM.^2);
%Normalization the vector field
ax_EM=ax_EM./a;
ay_EM=ay_EM./a;

%ploting
figure
quiver(X,Y,ax_EM,ay_EM,'b');
hold on
t=linspace(0,2*pi);
x=R_E*cos(t); %Drawing the Earth
y=R_E*sin(t);
plot(x,y,'color','w');
x=X_M+R_M*cos(t); %Drawing the Moon
y=Y_M+R_M*sin(t);
plot(x,y,'color','m');
xlabel('X (m)','color','k');
ylabel('Y (m)','color','k');
axis equal
whitebg('k')
title({'Attraction Fields (m/s^2) of the earth and the moon'},'fontweight','bold','color','k')

%Computing the Vanished area between the Earth-Moon
for i=1:size(a,1)
    for j=1:size(a,2)
        if abs(a(i,j))<=0.003 %threshold
            plot(X(i,j),Y(i,j),'*','color','r');
        end
    end
end
legend('attraction','Earth','Moon','Zero attraction')

%% Task 4 -Visualizing the potential field

%  Superimposed gravitational potential of the earth and moon
V_EM=V_earth+V_Moon;

%ploting
X_c=linspace(-R_E,(X_M+R_M),500);
Y_c=linspace(-R_E,(Y_M+R_M),500);
[X_c Y_c]=meshgrid(X_c,Y_c);
figure
[c h]= contour(X_c,Y_c,V_EM,[1:2.5:15,0.09:0.15:3.3,0.1:0.1:1]*1e6,'LineWidth',1.5);
clabel(c,h,'LabelSpacing',500,'FontSize',7,'Color','r','fontweight','bold');
colorbar
hold on
t=linspace(0,2*pi);
x=R_E*cos(t); %Drawing the Earth
y=R_E*sin(t);
plot(x,y,'color','w');
x=X_M+R_M*cos(t); %Drawing the Moon
y=Y_M+R_M*sin(t);
plot(x,y,'color','m');
xlabel('X (m)','color','k');
ylabel('Y (m)','color','k');
axis equal
whitebg('k')
title({'The Superimposed Potential (m^2/s^2) of the earth and the moon'},'fontweight','bold','color','k')
legend('Potential','Earth','Moon')

%% Task-5

Rc=3500000;
pc=11200;
Rm=6400000;
pm=4300;
r_Task5=linspace(0,2*Rm,500);

V_cm = V_shell_( 0,Rm,pc,r_Task5 )+V_shell_( Rc,Rm,pm,r_Task5 );
a_cm = a_shell_( 0,Rm,pc,r_Task5 )+a_shell_( Rc,Rm,pm,r_Task5 );

%% Task-7
r=linspace(0,4*Rm,1000);

%The potential of two shells
V = V_shell_( 0,Rc,pc,r )+V_shell_( Rc,Rm,pm,r );
%plot the potential
figure
plot(r,V)
whitebg('w')
hold on
grid on
% ploting the Earth's crust at the radius of the Earth
R_E=6371000;
V_Re=V_shell_( 0,Rc,pc,R_E )+V_shell_( Rc,Rm,pm,R_E );
plot(R_E,V_Re,'*','color','g')

legend('Potential','r = R_E')
xlabel('r (m)');
ylabel('Vcm(m^2/s^2)');
title({'The Potential of two shells '},'fontweight','bold','color','k')

%The attraction of two shells
a = a_shell_( 0,Rc,pc,r )+a_shell_( Rc,Rm,pm,r );
%plot
figure
plot(r,abs(a),'color','r')
hold on
% ploting the Earth's crust at the radius of the Earth
a_Re=a_shell_( 0,Rc,pc,R_E )+a_shell_( Rc,Rm,pm,R_E );
plot(R_E,abs(a_Re),'*','color','g')
grid on
title({'The attraction of two shells'},'fontweight','bold')
xlabel('r (m)');
ylabel('acm(m/s^2)')
legend('attraction','r = R_E')
%% PREM
load PREM.mat
% A=[(PREM(6379,1)+1:1:2*PREM(6379,1))' zeror(6371,1) ] ;
PREM=[PREM;(PREM(6379,1)+1:1:2*PREM(6379,1))' zeros(6371,1)];

R=PREM(:,1)*1000;
p=PREM(:,2);
V=zeros(size(R));
a=V;
for i=1:length(PREM)-1
    V = V+V_shell_( R(i),R(i+1),p(i),R );
   a=a+a_shell_(R(i),R(i+1),p(i),R);
       if R(i)==6371000
           V_R=V+V_shell_( R(i),R(i+1),p(i),R );
           a_R=a+a_shell_(R(i),R(i+1),p(i),R);    
       end
                 
end
T=[PREM V a];
V_max=max(V);
a_max=min(a);
figure
plot(R,V)
hold on
plot(6371000,6.256283165450073e+07,'*','color','g')
hold on
plot(0,V_max,'*','color','r')
legend('attraction','r = R_E','V(max)')
grid on
title({'The Potential PREM'},'fontweight','bold')
xlabel('r (m)');
ylabel('V(m/s^2)')
figure
plot(R,abs(a))
hold on
grid on
plot(6371000,9.819083780883838,'*','color','g')
hold on
plot(3480*1000,abs(a_max),'*','color','r')
legend('attraction','r = R_E','a(max)')
title({'The attraction PREM'},'fontweight','bold')
xlabel('r (m)');
ylabel('a(m/s^2)')