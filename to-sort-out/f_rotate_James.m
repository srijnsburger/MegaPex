function out = f_rotate(X,Y,R,O,options)

%Function to rotate inputs
%IN:    X:  x-coordinates
%       Y:  y-coordinates
%       R:  anngle of rotation [degr.]l +ve is anticlockwise!
%       O:  coordinates of origin
%
%OUT:   out.
%           X0:     x-coordinates (original)
%           Y0:     y-coordinates (original)
%           X1:     x-coordinates (rotated)
%           Y1:     y-coordinates (rotated)
%           M0.X:
%             .Y:   matrix of x-y (original)
%           M1.X: 
%             .Y:   matrix of x-y (rotated)

%% Arg. in check 
if nargin <= 4
    if nargin == 3
        O = [0,0];
		options = [];
	elseif nargin ==4
		options = [];
    else
        error('###Input error\n')
    end
end

%% Input check
if isequal(isvector(X),isvector(Y))
    [out.M0.X,out.M0.Y] = meshgrid(X,Y);
else
    if isequal(size(X),size(Y))  
        out.M0.X = X;
        out.M0.Y = Y;
    else
        error('###Size of X and Y not equal!\n')
    end
end

out.X0 = X;
out.Y0 = Y;

%% Visualise
if options.plot
figure
plot(out.M0.X,out.M0.Y,'xb','MarkerSize',6,'LineWidth',2)
hold on
plot(O(1),O(2),'or','MarkerSize',6)
end

%% Rotate
out.M1.X = zeros(size(out.M0.X));
out.M1.Y = zeros(size(out.M0.Y));

for ir=1:size(out.M0.X,1)
    for ic=1:size(out.M0.X,2)
        rad = sqrt((out.M0.X(ir,ic)-O(1))^2+(out.M0.Y(ir,ic)-O(2))^2);
        deg = rad2deg(atan2((out.M0.Y(ir,ic)-O(2)),(out.M0.X(ir,ic)-O(1))));
        out.M1.X(ir,ic) = O(1) + rad*cosd(R+deg);
        out.M1.Y(ir,ic) = O(2) + rad*sind(R+deg);
        clear rad deg
    end
end

if options.plot
plot(out.M1.X,out.M1.Y,'+g','MarkerSize',6,'LineWidth',2)
end

out.X1 = out.M1.X;
out.Y1 = out.M1.Y;









end