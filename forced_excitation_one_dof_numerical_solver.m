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

%initial state vector
w_0 = [x_0;x_dot_0];

%solving the EOM numerically
[time,results] = ode45(@(time,w) state_space_func(w,time,force_excitation,m,k,c,omega),time_span,w_0);
x_t = results(:,1)%displacment
v_t = results(:,2);%velocity

%comapring with the analytical solution
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

%plotting the displacment and velocity vs time
figure(1)
hold on
aa = plot(time,x_t,'-*','color','b')
bb = plot(time,v_t,'-*','color','r')
legend([aa,bb],'Displacement','Velocity')
xlabel('Time[s]')

%comapring analytical solution and the numerical one
figure(2)
hold on
cc = plot(time,x_t,'-*','color','b')
dd = plot(time,x_t_ana,'-*','color','r')
legend([cc,dd],'Numerical Solution','Analytical Solution')