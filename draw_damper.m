%coordinates of the damper
%damper foot
%y offset of the damper as a whole
yd_offset = -0.2
damper_foot = [pos_g(1) - dim_g(1)/2, yd_offset, 0.1];

%damper head
%the damper head position will be variable and move with the oscillating
%mass
%the mass center will have positions according to the oscillating motion
%x_t
%the damper head will always be at a postion which is to the left
%(increasing x) of the mass center
%damper_head = [x_t(1) + dim_m(1)/2, yd_offset, 0.1];
%damper_head = [pos_m(1) + dim_m(1)/2, yd_offset, 0.1];

%maximum stroke length of the damper
%the stroke length of the damper will be maximum when the mass is most
%negative wrt x axis, ie. when the mass has the most negative amplitude
%thus the mimimum value of the oscillation x_t is taken and mod is taken
%(ie. absolute value) and according to that the position of the damper head
%is taken. 
stroke_damper_max = damper_foot(1) + abs(min(x_t) + dim_m(1)/2);

%plotting the damper
%plotdamper(axis_ani,damper_foot,damper_head, stroke_damper_max,yd_offset)