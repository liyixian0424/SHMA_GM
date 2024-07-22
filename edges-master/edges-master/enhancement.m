%% threshlod
r=10; %rearch radium
angle_tolerance = 20;  % key parameter
E_new = E/max(E(:));  %normalize
loca = find(E<0.1);
E_new(loca)=0;
% figure;im(1-E_new);
% figure;im(1-E);
E_new(1:r,:)=0; E_new(end-r:end,:)=0; 
E_new(:,1:r)=0; E_new(:,end-r:end)=0; 
load('pier3_mask');
E_new = E_new.*mask;

%% hough line detection
BW = E_new;
[H,T,R] = hough(BW,'RhoResolution',0.5);
imshow(H,[],'XData',T,'YData',R,...
            'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

P  = houghpeaks(H,200,'threshold',ceil(0.2*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');

lines = houghlines(BW,T,R,P,'FillGap',30,'MinLength',40);
figure, imshow(I), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

%% line cluster
clus_num = 1;
line_lib = [1:size(lines,2)]';
group = {};
list  = [];
theta = extractfield(lines,'theta');
while size(line_lib,1)-size(list,1)>0
    begin_posi = clus_num;
    while sum(ismember(list,begin_posi))>=1
        begin_posi = begin_posi + 1;
    end
    position=find(abs(theta(begin_posi+1:end)-theta(begin_posi))<angle_tolerance);
    position = position+begin_posi;
    position(find(ismember(position,list)))=[];
    for k=1:size(position,2)
        if size(position,1)==0
            break
        end
        xy1 = [lines(begin_posi).point1; lines(begin_posi).point2];
        xy2 = [lines(position(k)).point1; lines(position(k)).point2];
        [xi(k),yi(k)] = linexline(xy1(:,1)',xy1(:,2)',xy2(:,1)',xy2(:,2)',0);
    end
    if isempty(position)
        group = [group;[begin_posi]];
    else
        group = [group;[begin_posi,position(find(~isnan(xi)))]'];
    end
    clear xi yi
    list = cell2mat(group);
    clus_num = clus_num + 1;
end
clear xy xy1 xy2 xy xy_long x y k list clus_num
figure;im(E_new);

BW3 = bwmorph(E_new,'skel',Inf);
length_edge = sum(sum(BW3));

%% length calculation
%% TODO: calculate the curve length
clear length_line
for k = 1:size(group,1)
category = group{k,1};
    xy = [lines(category').point1, lines(category').point2];
    xy = reshape(xy,2,size(xy,2)/2);
    xy = xy';
    [~,max_index]=max(xy(:,1));
    [~,min_index]=min(xy(:,1));
    max_coord = xy(max_index,:);
    min_coord = xy(min_index,:);
    clear max_index min_index xy
    length_line(k) = ((max_coord-min_coord)*(max_coord-min_coord)')^0.5;
end

ratio = sum(length_line)/length_edge;
        



