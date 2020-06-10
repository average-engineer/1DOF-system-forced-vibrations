function plotcube(axis,dimension,position,color)

%the cube defined here is assumed to be having a coordinate system of tis
%own at the center of the cube
%x coordinates of the vertices
%the first element of the dimension matrix in the main script is the
%dimension of the cube in X direction
%the first element of the dimension matrix in the main script is the
%dimension of the cube in X direction
%the first element of the dimension matrix in the main script is the
%dimension of the cube in X direction
x_c(1) = -dimension(1)/2;
x_c(2) = dimension(1)/2;
x_c(3) = dimension(1)/2;
x_c(4) = -dimension(1)/2;
x_c(5) = -dimension(1)/2;
x_c(6) = dimension(1)/2;
x_c(7) = dimension(1)/2;
x_c(8) = -dimension(1)/2;

%y coordinates of the vertices
y_c(1) = dimension(2)/2;
y_c(2) = dimension(2)/2;
y_c(3) = -dimension(2)/2;
y_c(4) = -dimension(2)/2;
y_c(5) = dimension(2)/2;
y_c(6) = dimension(2)/2;
y_c(7) = -dimension(2)/2;
y_c(8) = -dimension(2)/2;

%z coordinates of the vertices
z_c(1) = -dimension(3)/2;
z_c(2) = -dimension(3)/2;
z_c(3) = -dimension(3)/2;
z_c(4) = -dimension(3)/2;
z_c(5) = dimension(3)/2;
z_c(6) = dimension(3)/2;
z_c(7) = dimension(3)/2;
z_c(8) = dimension(3)/2;

%faces to be defined
faces = [4 3 2 1; 2 3 7 6; 3 4 8 7; 1 2 6 5; 2 3 7 6; 1 4 8 5];

%vertices
vertices = [x_c(1) y_c(1) z_c(1); x_c(2) y_c(2) z_c(2); x_c(3) y_c(3) z_c(3); x_c(4) y_c(4) z_c(4); x_c(5) y_c(5) z_c(5); x_c(6) y_c(6) z_c(6); x_c(7) y_c(7) z_c(7); x_c(8) y_c(8) z_c(8)];

%vertices translated wrt the position of the ground in the figure wrt the
%axis
%the first element of the position vector refers to the position of the
%ground cube coordinate system wrt x axis of the figure in which is to be
%placed

%the second element of the position vector refers to the position of the
%ground cube coordinate system wrt y axis of the figure in which is to be
%placed

%the third element of the position vector refers to the position of the
%ground cube coordinate system wrt z axis of the figure in which is to be
%placed
vertices_trans = [vertices(:,1) + position(1), vertices(:,2) + position(2), vertices(:,3) + position(3)];

%plotting the cube
%inbuilt MATLAB function
patch(axis,'Vertices',vertices_trans,'Faces',faces,'Facecolor',color,'Edgecolor',color)
end

