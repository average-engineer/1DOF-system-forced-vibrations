%script initializes the figures representing the displacement and velocity
%variation with time of the 1DOF spring mass system in the form of a graph
%and the animation of the spring mass system in the form of an aniation

%clear all and close all not used since we will be using the results of the
%main script to run this script properly. In order to run this script, the
%variables and all defined by the main script should not get cleared
%otherwise no point of this script


%setting variable for BG color, units, linewidth and font size
clr = [236/255 237/255 237/255];
units = 'normalized';
linewidth = 2;
fontsize = 15;

%variable for position of the figure = [position from bottom left, height, width]
pos_fig = [0.01 0.25 0.75 0.65];

%title of the graph
title_graph = 'Displacement and Velocity vs. Time';

%title of the animation
title_ani = 'Forced Excitation 1DOF system';

%variable for x-label of the animation
xlabel_ani = 'Displacement[m]';

%variable for x-label of the graph
xlabel_graph = 'Time[secs]';

%variable for y-label of the displacement plot in the graph
ylabel_graph{1} = 'Displacement x[m]';
%variable for y-label of the velocity plot in the graph
ylabel_graph{2} = 'Velocity v[m/s]';

%plotting the figure
%defining a variable for storing the figure
fig = figure('color',clr,'units',units,'position',pos_fig);

%creating subplots
%figure will have 2 subplots
%1st subplot is for the animation
%2nd subplot is for the diplacement and velocity plot vs time

subplot(1,2,2) %2nd subplot = graph
%initializing the graph 
graph_plot = plot(1,1,1,1);

%the graph_plot will have 2 components: the displacment plot and the
%velocity plot
%the displacment plot (graph_plot(1)) will be black in color
%the velocity plot (graph_plot(2)) will be red in color
set(graph_plot(1),'color','k','linewidth',linewidth);
set(graph_plot(2),'color','r','linewidth',linewidth);

%setting the axis to the displacment plot (Y-axis on the left side)
axis_graph(1) = gca; %get current axis
set(axis_graph(1),'fontsize',fontsize);

%setting the axis to the displacement plot (Y-axis on the right side)
axis_graph(2) = axes('Position',axis_graph(1).Position,'YAxisLocation','right','Ycolor','r','color','none','XTicklabel',[],'fontsize',fontsize);
%the velocity plot axis can't be given gca since the Y axis does not
%conincide with the displacment plot and gca has already been alloted to
%displacment plot in this subplot
set(axis_graph(2),'fontsize',fontsize);


%the velocity and displacment plots have the same x axis (time). Thus the X
%axes of the two have to be linked

linkaxes([axis_graph(1) axis_graph(2)],'x')

%giving xlabel to one of the plot axis (since the X axis of both the plots
%are linked, giving label to only one works

xlabel(axis_graph(1),xlabel_graph, 'fontsize',fontsize)

%giving Y axis label to the displacment plot
ylabel(axis_graph(1),ylabel_graph{1},'fontsize',fontsize)


%giving Y axis label to the velocity plot
ylabel(axis_graph(2),ylabel_graph{2},'fontsize',fontsize)

%we need to reverse the Y axis directions
set(axis_graph(1),'Ydir','reverse')
set(axis_graph(2),'Ydir','reverse')


%providing limits to the y axis
x_t_max = max(abs(x_t)) + 0.05*(max(abs(x_t)));

ylim(axis_graph(1),[-x_t_max x_t_max]);

v_t_max = max(abs(v_t)) + 0.05*(max(abs(v_t)));

ylim(axis_graph(2), [-v_t_max v_t_max]);

%providing limits to the y axis
xlim(axis_graph(1),[time_span(1) time_span(end)]);


%plotting for the animation
subplot(1,2,1)
axis_ani = gca;

set(axis_ani,'fontsize',fontsize,'color',clr)

%in the anmination our X axis has to be reversed
set(axis_ani,'Xdir','reverse')

%providing limits to the X axis
xlim([-3*x_t_max 4*x_t_max])
%providing limits to the Y axis
ylim([-2 2])

%title of the animation
title(title_ani,'fontsize',fontsize)
xlabel(xlabel_ani,'fontsize',fontsize)
