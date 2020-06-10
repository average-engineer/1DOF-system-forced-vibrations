function plotarrow(axis,arrow_head,arrowfoot,ya_offset,clr_a)

%x coordinates
x_a(1) = arrowfoot(1);
x_a(2) = arrowfoot(1);
x_a(3) = arrow_head(1) + (arrowfoot(1) - arrow_head(1))*0.3;
x_a(4) = arrow_head(1) + (arrowfoot(1) - arrow_head(1))*0.3;
x_a(5) = arrow_head(1) + (arrowfoot(1) - arrow_head(1))*0.3;
x_a(6) = arrow_head(1) + (arrowfoot(1) - arrow_head(1))*0.3;
x_a(7) = arrow_head(1);

%y coordinates
y_a(1) = 0.1 + ya_offset;
y_a(2) = -0.1 + ya_offset;
y_a(3) = 0.2 + ya_offset;
y_a(4) = 0.1 + ya_offset;
y_a(5) = -0.1 + ya_offset;
y_a(6) = -0.2 + ya_offset;
y_a(7) =  ya_offset;

%z coordinates
z_a = 0;

%vertices
vertices_a = [x_a(1),y_a(1),z_a;x_a(2),y_a(2),z_a;x_a(3),y_a(3),z_a;x_a(4),y_a(4),z_a;x_a(5),y_a(5),z_a;x_a(6),y_a(6),z_a;x_a(7),y_a(7),z_a];

%faces
faces_a = [1 2 5 6 7 3 4];

%plotting the arrow
patch(axis,'Vertices',vertices_a,'Faces',faces_a,'Facecolor',clr_a,'Edgecolor',clr_a)
end
