%dimesnsion of the ground
%dimension = [x dim, y dim, z dim]
dim_g = [0.75*x_t_max, 2, 2];

%position of the ground
pos_g = [abs(min(x_t))+0.01 0 0];

%color of the ground
clr_g = 'k';

%plotting the ground
%using a function to plot a cube
%plotcube(axis_ani,dim_g,pos_g,clr_g)