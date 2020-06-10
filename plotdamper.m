function plotdamper(axis,damper_foot,damper_head,stroke_length_max,y_offset)

%computing the x coordinates of the main points of the damper
xd(1) = damper_foot(1);
xd(2) = damper_foot(1) - 0.02*stroke_length_max;
xd(3) = damper_foot(1) - 0.02*stroke_length_max;
xd(4) = damper_foot(1) - 0.02*stroke_length_max;
xd(5) = damper_foot(1) - 0.8*stroke_length_max;
xd(6) = damper_foot(1) - 0.8*stroke_length_max;
xd(7) = damper_head(1) + 0.4*stroke_length_max;
xd(8) = damper_head(1) + 0.4*stroke_length_max;
xd(9) = damper_head(1) + 0.4*stroke_length_max;
xd(10) = damper_head(1);

%computing the Y coordinates of the main points of the damper
%the damper is not at the middle of the block and ground and thus needs to
%be offset
yd(1) = y_offset;
yd(2) = -0.1 + y_offset;
yd(3) = 0.1 + y_offset;
yd(4) = y_offset;
yd(5) = 0.1 + y_offset;
yd(6) = -0.1 + y_offset;
yd(7) = 0.09 + y_offset;
yd(8) = -0.09 + y_offset;
yd(9) = y_offset;
yd(10) = y_offset;

%computing the Z coordinates of the main points of the damper
zd(1) = 0.1;
zd(2) = -0.1;

%vertices
vertices_damper = [xd(1),yd(1),zd(1);xd(2),yd(2),zd(1);xd(3),yd(3),zd(1);xd(4),yd(4),zd(1);xd(5),yd(5),zd(1);xd(6),yd(6),zd(1);xd(7),yd(7),zd(1);xd(8),yd(8),zd(1);xd(9),yd(9),zd(1);xd(10),yd(10),zd(1);xd(1),yd(1),zd(2);xd(2),yd(2),zd(2);xd(3),yd(3),zd(2);xd(4),yd(4),zd(2);xd(5),yd(5),zd(2);xd(6),yd(6),zd(2);xd(7),yd(7),zd(2);xd(8),yd(8),zd(2);xd(9),yd(9),zd(2);xd(10),yd(10),zd(2)];

%faces
faces_damper = [1,4,14,11; 2,3,13,12; 3,5,15,13; 2,6,16,12; 7,8,18,17; 9,10,20,19];

%plotting the damper
patch(axis,'Vertices',vertices_damper,'Faces',faces_damper, 'Facecolor','k','Edgecolor','k')
end

