clear all
close all
clc

%system parameters
%mass
m = 750;
%damping
c = 10;
%spring stiffness
k = 50000;
%simulation time
time_span = [0:0.01:10];
%natural eigenfrequency
omega_n = sqrt(k/m);
%frequency of the system/frequency of the harmonic force
omega = 2;
%magnitude of the harmonic force
force = 2000;
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

%eigenvalues of the system/roots of the characteristic equation of the
%system
lambda = roots([1,2*del,omega_n^2]);

%amplitude/particular solution magnitude
x_max = (force/k)/sqrt((2*damp_ratio*r)^2 + (1-(r)^2)^2);

%phase lag in the displacment wrt the harmonic force
phi = atan(2*damp_ratio*r/(1-(r)^2));

%integration constants in the complimentary solution
c1 = x_0 - x_max*cos(phi) - ((lambda(1)*x_0 - x_dot_0 + x_max*(omega*sin(phi) - lambda(1)*cos(phi)))/(lambda(1) - lambda(2)));
c2 = (lambda(1)*x_0 - x_dot_0 + x_max*(omega*sin(phi) - lambda(1)*cos(phi)))/(lambda(1) - lambda(2));

%complimentary solution
x_t_c = real(c1*exp(lambda(1)*time_span) + c2*exp(lambda(2)*time_span));
v_t_c = real(lambda(1)*c1*exp(lambda(1)*time_span) + lambda(2)*c2*exp(lambda(2)*time_span));

%particular solutionx`  
x_t_p = x_max*cos(omega*time_span - phi);
v_t_p = -omega*x_max*sin(omega*time_span - phi);

%overall solution
x_t = x_t_c + x_t_p;
v_t = v_t_c + v_t_p;

%plotting 
figure(1)
hold on
aa = plot(time_span,x_t,'-*','color','r')
bb = plot(time_span,x_t_p,'-*','color','k')
cc = plot(time_span,x_t_c,'-*','color','b')
legend([aa,bb,cc],'Overall Displacment','Particular Displacement','Complimentary displacment')

%%
%initialize figure
run('initialize_figure.m')

%draw ground
hold on
run('draw_ground.m')

%draw mass
run('draw_mass.m')

%draw spring
run('draw_spring.m')

%draw damper
run('draw_damper.m')

%draw Coordinate system
run('draw_cs')

%drawing excitation arrow
run('draw_arrow.m')

%animate the system
%initialize vectors for the graph
%these variables are the time dependent variables in the system which
%change 
%done to reduce computational times
%length of the displacement vector
x_t_length = length(x_t);
%plot time
%NaN() represents a vector whose elements are not numbers (all elements are
%NaN)
%NaN vector is basically an empty vector which can be filled 
t_plot = NaN(1,x_t_length);
x_t_plot = NaN(1,x_t_length);
v_t_plot = NaN(1,x_t_length);

%counting variable for each frame
ct = 1;
for i = 1:x_t_length
    cla %clearing the last frame
    %plotting graph (2nd subplot)
    %filling the NaN/empty vectors
    t_plot(i) = time_span(ct);
    x_t_plot(i) = x_t(ct);
    v_t_plot(i) = v_t(ct);
    
    %setting new values for the displacement graph and the velocity graph
    %setting new values for the displacement graph
    set(graph_plot(1),'Parent',axis_graph(1),'XData',t_plot,'YData',x_t_plot)
    %setting new values for the velocity graph
    set(graph_plot(2),'Parent',axis_graph(2),'XData',t_plot,'YData',v_t_plot)
    %since the dsiplacement and velocity is plotted inside the for loop, it
    %will be a dynamic plot chaging with each loop/or x(t) element/or
    %second
    
    %plotting animation
    %plotting ground
    plotcube(axis_ani,dim_g,pos_g,clr_g)
    %plotting mass
    %mass has a varying position
    pos_m = [x_t(ct) 0 0]; 
    plotcube(axis_ani,dim_m,pos_m,clr_m)
    
    %plotting spring
    %spring head is varying since it is attached to the mass
    %the new spring_head is given by
    %initially it may seem normal to not change the spring_head expression
    %as the pos_m has already changed but do remember the spring_head
    %calculated initially in the draw_spring script corresdponds to the one
    %calculated wrt a fixed mass and thus wont be valid
    %similarly, the X position (x xoordinates of the locus of spring) of
    %the spring also needs to be rewritten
    %dont forget to disable the values of x_pos_spring and spring_head
    %calculated previously 
    spring_head = x_t(ct) + dim_m(1)/2;
    x_pos_spring = (phi_s/phi_max)*(spring_head - spring_foot) + spring_foot;
    plot3(axis_ani,x_pos_spring,y_pos_spring,z_pos_spring,'color','b','linewidth',linewidth)

    %plot damper
    damper_head = [x_t(ct) + dim_m(1)/2,yd_offset,0.1];
    plotdamper(axis_ani,damper_foot,damper_head,stroke_damper_max,yd_offset)
    
    %plot Coordinate system
    %no change in coordinate system
    plotcs(axis_ani,xar,display_cs,y_csoffset,color_cs,linewidth,fontsize)
    
    %plot excitation arrow
    %position of arrow head
    arrow_head = [pos_m(1)-dim_m(1)/2,0,0];
    arrow_foot = [arrow_head(1) - max_length_arrow*cos(omega*time_span(ct)),0,0];
    plotarrow(axis_ani,arrow_head,arrow_foot,ya_offset,clr_a)
    
    %rotating the view
    %horizontal rotation (azimuth) = 90 degrees, rotation about Z axis
    %vertical elevation (elevation) = -90 degrees, negative value means it
    %moves below, positive value means it moves above
    view(90,-90)
    
    %to instruct MATLAB to draw all the above into the figure for every
    %loop
    drawnow
    
    ct = ct+1;
end



