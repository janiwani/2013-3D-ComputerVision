% Set the known values for the real scene (in mm)
h1 = 30;
h2 = 20;
h3 = 10;

a = 100;
D = 265;
Href = 15.5;
hy = 10;

% Load and show image.
I = imread('img.jpg');
figure,imshow(I);

% Transform coordinates to homogeneous system
% hx1a = toHom(x1a);
% hx1b = toHom(x1b);
% hx2a = toHom(x2a);
% hx2b = toHom(x2b);
% hx3a = toHom(x3a);
% hx3b = toHom(x3b);
% hv1a = toHom(v1a);
% hv1b = toHom(v1b);
% hv2a = toHom(v2a);
% hv2b = toHom(v2b);

% Calculate/Ask points t and b
% t = toHom(ti);
% b = toHom(bi);
disp('Select point t.')
[x,y] = ginput(1);
t = [x;y;1];
disp('Select point b.')
[x,y] = ginput(1);
b = [x;y;1];

% Calculate three horizontal lines
% L1 = cross(hx1a,hx1b);
% L2 = cross(hx2a,hx2b);
% L3 = cross(hx3a,hx3b);
disp('Select 2 points to mark line L1.')
L1 = get_line();
disp('Select 2 points to mark line L2.')
L2 = get_line();
disp('Select 2 points to mark line L3.')
L3 = get_line();

% Calculate the vertical point at infinity
% V1 = cross(hv1a,hv1b);
% V2 = cross(hv2a,hv2b);
% V = cross(V1,V2);

% Calculate Camera height (hc) in mm
hc = hy + (Href - hy)*(D/a);

% Calculate line between T and B
tb = cross(t,b);

% Find x1,x2,x3
x1 = cross(tb,L1);
x2 = cross(tb,L2);
x3 = cross(tb,L3);

% Compute hTp hBp
A = ( d(t,x2)*d(x1,x3)*(h1-h2) ) / ( d(x1,x2)*d(t,x3)*(h1-h3) );
hTp = (h2 - A*h3) / ( 1-A );

B = ( d(b,x2)*d(x1,x3)*(h2-h3) ) / ( d(x2,x3)*d(b,x1)*(h1-h3) );
hBp = (B*h1 - h2) / (1-B);

% Finally, calculate human height H.
H = ((hTp+hBp)*hc) / (hc+hBp);

disp('The measured human height is:');
disp(H);
