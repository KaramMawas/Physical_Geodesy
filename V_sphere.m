function [ V ] = V_sphere( X,Y,R,Xm,Ym,p )
% Karam Mawas	    2946939 	
% Ehtesham Hasnain  2995236
%Function for calculating the gravitational Potential for assuming a
%spherical shape

G = 6.672*1e-11;

%without loops !!
r =sqrt((X-Xm).^2+(Y-Ym).^2);
V=zeros(size(r));
r_out=r>=R;
r_in =r<R;
V(r_out) = (4/3)*pi*G*p*R^3*(1./r(r_out));
V(r_in) = 2*pi*G*p*(R^2-(1/3)*r(r_in).^2);
%side note: r(r_out) means that we take the binary vector(boolean vector)and
%insert it to the origin vector r
%r_out size is equal to r, but the size of r(r_out) is just the elements
%are not zeros
end

% %Solved by loop!
%     for i=1:size(X,1);
%         for j=1:size(X,2);
%             r = sqrt((X(i,j)-Xm)^2+(Y(i,j)-Ym)^2);
%             if r>=R 
%                V(i,j) = (4/3)*pi*G*p*R^3*(1/r);
%             else
%                V(i,j) = 2*pi*G*p*(R^2-(1/3)*r^2);
%             end
%         end
%     end
% end
% 
