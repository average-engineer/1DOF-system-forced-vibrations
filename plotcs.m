function plotcs(axis,x_ar,displayed_variable,y_offset,color,linewidth,fontsize)
%computing vertices x coords
xcs(1) = 0;
xcs(2) = 0;
xcs(3) = 0;
xcs(4) = 0.6*x_ar;
xcs(5) = 0.6*x_ar;
xcs(6) = x_ar;

%computing vertices y coords
ycs(1) = x_ar*20 + y_offset;
ycs(2) = -x_ar*20 + y_offset;
ycs(3) = y_offset;
ycs(4) = x_ar*16 + y_offset;
ycs(5) = -x_ar*16 + y_offset;
ycs(6) = y_offset;

zcs(1) = -0.1;
zcs(2) = 0.1;

%vertices
vertices_cs = [xcs(1),ycs(1),zcs(1);xcs(2),ycs(2),zcs(1);xcs(2),ycs(2),zcs(1);xcs(3),ycs(3),zcs(1);xcs(4),ycs(4),zcs(1);xcs(5),ycs(5),zcs(1);xcs(6),ycs(6),zcs(1);xcs(1),ycs(1),zcs(2);xcs(2),ycs(2),zcs(2);xcs(3),ycs(3),zcs(2);xcs(4),ycs(4),zcs(2);xcs(5),ycs(5),zcs(2);xcs(6),ycs(6),zcs(2)];

%faces
faces_cs = [1 2 8 7;3 6 12 9;5 6 12 11;4 6 12 10];

%plotting the CS
patch(axis,'Vertices',vertices_cs,'Faces',faces_cs,'Facecolor',color,'linewidth',linewidth)

%displaying the variable on the CS
text(xcs(4),ycs(2),displayed_variable,'color',color,'fontsize',fontsize);

end