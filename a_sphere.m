function [ ax ay ] =  a_sphere( X,Y,R,Xm,Ym,p )
% Karam Mawas	    2946939 	
% Ehtesham Hasnain  2995236
%Function for calculating the acceleration for assuming a spherical shape

G = 6.672*1e-11;

%without loops!
r =sqrt((X-Xm).^2+(Y-Ym).^2);
ax=zeros(size(r));
ay=zeros(size(r));

delta_X = X-Xm;
delta_Y = Y-Ym;
Theta = atan2(delta_Y,delta_X);

r_out= r>=R ;
ax(r_out) = -(4/3)*pi*G*p*R^3*(1./r(r_out).^2).*cos(Theta(r_out));
ay(r_out) = -(4/3)*pi*G*p*R^3*(1./r(r_out).^2).*sin(Theta(r_out));
r_in= r<R;
ax(r_in) = -(4/3)*pi*G*p*r(r_in).*cos(Theta(r_in));
ay(r_in) = -(4/3)*pi*G*p*r(r_in).*sin(Theta(r_in));
end

% % Sloved by a loop!
%     for i=1:size(X,1);
%         for j=1:size(X,2);
%             r = sqrt((X(i,j)-Xm)^2+(Y(i,j)-Ym)^2);
%             delta_X = X(i,j)-Xm;
%             delta_Y = Y(i,j)-Ym;
%             Theta = atan2(delta_Y,delta_X);
%               if r>=R ;
%                  a(i,j) = -(4/3)*pi*G*p*R^3*(1/r^2);
%               else
%                  a(i,j) = -(4/3)*pi*G*p*r;
%               end
%         
%         ax(i,j) = a(i,j)*cos(Theta);
%         ay(i,j) = a(i,j)*sin(Theta);
%       
%         end
%     end
% end
