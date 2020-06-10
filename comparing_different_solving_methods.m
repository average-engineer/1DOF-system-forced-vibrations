clear all
close all
clc

%system parameters
%mass
m = 750;
%damping
c = 200;
%spring stiffness
k = 50000;
%simulation time
time_span = [0:0.01:10];
%natural eigenfrequency
omega_n = sqrt(k/m);
%frequency of the system/frequency of the harmonic force
omega = 2;
%magnitude of the harmonic force
force_excitation = 2000;
%critical damping 
c_c = 2*m*omega_n;
%damping ratio
damp_ratio = c/c_c;
%damping coefficient
del = c/(2*m);
%frequency ratio
r = omega/omega_n;
%initial conditions
x_0 = 0.0;%initial displacement
x_dot_0 = 0;%initial velocity

%number of test calculations
n = 10;


%SYMBOLIC SOLVING
%defining the symbolic variable for time
for kk = 1:n
tic;
syms t
x = symfun(str2sym('x(t)'),t);%x is a symfun here

%first differential of x wrt t
d1x = diff(x,1);%d1x is a symfun
%second differential of x wrt t
d2x = diff(x,2)%d2x is a symfun

%defining the governing EOM
symEq = (m*d2x + c*d1x + k*x - force_excitation*cos(omega*t) == 0)

%solving for x wrt t
x = dsolve(symEq,x(0) == x_0, d1x(0) == x_dot_0,t);%since dsolve gives sym outputs only, x changes from a symfun to sym
%computational time for each iteration
computational_time_sym(kk) = toc;

%now that x is a sym, diff(x) will also become a sym but d1x is still a
%symfun. This is very important to remember
%displacement
x_t_sym = double(subs(x,t,time_span));
%velocity
v_t_sym = double(subs(diff(x,1),t,time_span));
%another way of getting x_t_sym and v_t_sym are
%generating a function handle
%x_sym = matlabFunction(x)%function handle for displacment
%v_sym = matlabFunction(diff(x))%function handle for velocity
%x_t_sym = feval(x_sym,t,time_span)
%v_t_sym = feval(v_sym,t,time_span)
end


%NUMERICAL SOLVING
%initial state vector
for jj = 1:n
tic;
w_0 = [x_0;x_dot_0];

%solving the EOM numerically
[time,results] = ode45(@(time,w) state_space_func(w,time,force_excitation,m,k,c,omega),time_span,w_0);

%computational time for each iteration
computational_time_num(jj) = toc;

x_t_num = results(:,1)%displacment
v_t_num = results(:,2);%velocity
end 


%ANALYTICAL SOLVING
%solving analyticaly for n number of test calculations
for ii = 1:n
tic%tic is used to start an internal timer once the loops starts for each iteration
%eigenvalues of the system/roots of the characteristic equation of the
%system
lambda = roots([1,2*del,omega_n^2]);

%amplitude/particular solution magnitude
x_max = (force_excitation/k)/sqrt((2*damp_ratio*r)^2 + (1-(r)^2)^2);

%phase lag in the displacment wrt the harmonic force
phi = atan(2*damp_ratio*r/(1-(r)^2));

%coefficients in the complimentary solution
c1 = x_0 - x_max*cos(phi) - ((lambda(1)*x_0 - x_dot_0 + x_max*(omega*sin(phi) - lambda(1)*cos(phi)))/(lambda(1) - lambda(2)));
c2 = (lambda(1)*x_0 - x_dot_0 + x_max*(omega*sin(phi) - lambda(1)*cos(phi)))/(lambda(1) - lambda(2));

%complimentary solution
x_t_c = real(c1*exp(lambda(1)*time_span) + c2*exp(lambda(2)*time_span));
v_t_c = real(lambda(1)*c1*exp(lambda(1)*time_span) + lambda(2)*c2*exp(lambda(2)*time_span));

%particular solutionx`  
x_t_p = x_max*cos(omega*time_span - phi);
v_t_p = -omega*x_max*sin(omega*time_span - phi);

%overall solution
x_t_ana = x_t_c + x_t_p;
v_t_ana = v_t_c + v_t_p;

%computational time for each iteration
computational_time_ana(ii) = toc;%toc is used to read the total time stored in the internal timer (introduced by tic) after each iteration ends
end

%comparing displacement solutions
figure(1)
hold on
aa = plot(time_span,x_t_sym,'-*','color','b')
bb = plot(time_span,x_t_num,'-*','color','r')
cc = plot(time_span,x_t_ana,'-*','color','k')
legend([aa,bb,cc],'Symbolic Displacement', 'Numerical Displacement', 'Analytical Displacment')


%comparing velocity solutions
figure(2)
hold on
dd = plot(time_span,v_t_sym,'-*','color','b')
ee = plot(time_span,v_t_num,'-*','color','r')
ff = plot(time_span,v_t_ana,'-*','color','k')
legend([dd,ee,ff],'Symbolic Velocity', 'Numerical Velocity', 'Analytical Velocity')


%comparing simulation times
time_analytical = sum(computational_time_ana)/n;
time_numerical = sum(computational_time_num)/n;
time_symbolical = sum(computational_time_sym)/n;

%comparing analytical and numerical
ana_vs_num = time_analytical/time_numerical;
%comparing analytical and symbolical
ana_vs_sym = time_analytical/time_symbolical;
%comapring numerical and symbolical
num_vs_sym = time_numerical/time_symbolical;

%printing in command window
fprintf('Average Simulation time in symbolic solution is %d\n',time_symbolical)
fprintf('Average Simulation time in numerical solution is %d\n',time_numerical)
fprintf('Average Simulation time in analytical solution is %d',time_analytical)
