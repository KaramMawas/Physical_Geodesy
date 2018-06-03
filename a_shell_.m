function [ a ] = a_shell_( Rin,Rout,p,r )
% Karam Mawas	    2946939 	
% Ehtesham Hasnain  2995236
%Function to compute the attraction of spherical shells
G=6.672e-11;
a=zeros(size(r));

%without loop!
r_in = r<=Rin;  % inner the shell
a(r_in)=0;
r_between = and(r>Rin,Rout>=r); % within the shell
a(r_between)=-4/3*pi*G*p*(r(r_between).^3-Rin^3)*1./r(r_between).^2;
r_out = r>Rout; % outside the shell
a(r_out)=-4/3*pi*G*p*(Rout^3-Rin^3)*1./(r(r_out).^2);
end

% %Solved with loop!
%     for i=1:size(r,1)
%          if r(i)<=Rin
%          a(i)=0;
%          elseif r(i)<Rout
%                a(i)=-4/3*pi*G*p*(r(i)^3-Rin^3)*1/r(i)^2;
%           else
%                 a(i)=-4/3*pi*G*p*(Rout^3-Rin^3)*1/r(i)^2;
%          end
%     end
% end


