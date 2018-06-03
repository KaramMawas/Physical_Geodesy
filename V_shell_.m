function [ V ] = V_shell_( Rin,Rout,p,r )
% Karam Mawas	    2946939 	
% Ehtesham Hasnain  2995236
%Function to compute the Gravitational potential of spherical shells
G=6.672e-11;
V=zeros(size(r));

%without loop!
r_in = r<=Rin;  % inner the shell
V(r_in)=2*pi*G*p*(Rout^2-Rin^2);
r_between = and(Rin<r,r<=Rout); % within the shell
V(r_between)=2*pi*G*p*(Rout^2-(1/3)*(r(r_between).^2))-4/3*pi*G*p*Rin^3*(1./(r(r_between)));
r_out = r>Rout; % outside the shell
V(r_out)=4/3*pi*G*p*(Rout^3-Rin^3)*(1./r(r_out));
end

% %Solved with loop!
% for i=1:size(r,1)
%          if r(i)<=Rin                % inner the shell
%             V(i)=2*pi*G*p*(Rout^2-Rin^2);
%          elseif r(i)<=Rout    % within the shell
%             V(i)=2*pi*G*p*(Rout^2-(1/3)*(r(i)^2))-4/3*pi*G*p*Rin^3*(1/r(i));
%           else %r(i)=>Rout;               % outside the shell
%               V(i)=4/3*pi*G*p*(Rout^3-Rin^3)*(1/r(i));
%         end
%     end
% end


