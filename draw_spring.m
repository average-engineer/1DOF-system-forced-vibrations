%general spring characteristics
%number of windings in spring
windings = 8;
%radius of spring
r_spring = 0.1;
%max angle subtended by the spring
%each winding subtends an angle of 360 deg
phi_max = 2*pi*windings;

%array of points which define the spring
%the step size is arbitrary but should be kept such that the spring is
%smooth
phi_s = [0:pi/50:phi_max];

%the X, Y and Z positions of the points of the spring (ie. locus of the
%spring)
y_offset = 0.2; %spring is not in the middle between ground and mass thus an offset has to be defined
y_pos_spring = r_spring*sin(phi_s) + y_offset;

%the Z axis has no offset
z_pos_spring = r_spring*cos(phi_s);

%to define X posn, we define the x coordinates of the spring head and foot
%the spring foot x coordinate is to the right (decreasing) of the ground
%central axis x position by a distance of exactly half of the x dimension
%of the ground cube
spring_foot = pos_g(1) - dim_g(1)/2;

%the spring head x coordinate is to the left (decreasing) of the mass
%central axis x position by a distance of exactly half of the x dimension
%of the mass cube
%spring_head = pos_m(1) + dim_m(1)/2;

%defining the x position
%x_pos_spring = (phi_s/phi_max)*(spring_head - spring_foot) + spring_foot;

%to plot the spring, plot3 command is used which plots a 3d line, since
%spring has x,y,z positions
%plot3(axis_ani,x_pos_spring,y_pos_spring,z_pos_spring,'color','b','linewidth',linewidth)
