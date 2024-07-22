%% Comparison with Canny detector
% I_gray = rgb2gray(I);
% E1 = edge(I_gray);
% figure; 
% h1 = im(1-E1);
% set(gcf, ...
%     'units', 'centimeters', ...
%     'position', [10 5 11 12]);
% set(gca, ...
%     'FontName','Times New Roman',...
%     'FontSize',12)
% xlabel('x','FontSize',12)
% ylabel('y','FontSize',12)
% 
% figure;
% h2 = im(1-E);
% set(gcf, ...
%     'units', 'centimeters', ...
%     'position', [10 5 11 12]);
% set(gca, ...
%     'FontName','Times New Roman',...
%     'FontSize',12)
% xlabel('x','FontSize',12)
% ylabel('y','FontSize',12)

%% erosion and skeleton

% E_new = E/max(E(:));  %normalize
% loca = find(E<0.1);
% E_new(loca)=0;
% BW3 = bwmorph(E_new,'skel',Inf);
% figure; 
% h1 = im(1-BW3);
% set(gcf, ...
%     'units', 'centimeters', ...
%     'position', [10 5 11 12]);
% set(gca, ...
%     'FontName','Times New Roman',...
%     'FontSize',12,...
%     'xlim',[2100,2500],...
%     'ylim',[2200,2700])
% % xlabel('x','FontSize',12)
% % ylabel('y','FontSize',12)
% 
% figure;
% h2 = im(1-E);
% set(gcf, ...
%     'units', 'centimeters', ...
%     'position', [10 5 11 12]);
% set(gca, ...
%     'FontName','Times New Roman',...
%     'FontSize',12,...
%     'xlim',[2100,2500],...
%     'ylim',[2200,2700])
% 
% 
% figure;
% h3 = im(I);
% set(gcf, ...
%     'units', 'centimeters', ...
%     'position', [10 5 11 12]);
% set(gca, ...
%     'FontName','Times New Roman',...
%     'FontSize',12,...
%     'xlim',[2100,2500],...
%     'ylim',[2200,2700])

%% Hough line detection
% [H,T,R] = hough(BW,'RhoResolution',0.5);
% h1 = imshow(-H,[],'XData',T,'YData',R,...
%             'InitialMagnification','fit');
% set(gcf, ...
%     'units', 'centimeters', ...
%     'position', [10 5 11 12]);
% set(gca, ...
%     'FontName','Times New Roman',...
%     'FontSize',12,...
%     'xtick',[-90,-50,0,50,89],...
%     'xticklabel',[-90,-50,0,50,90])
%         
% xlabel('\theta'), ylabel('d');
% axis on, axis normal, hold on;
% 
% P  = houghpeaks(H,200,'threshold',ceil(0.3*max(H(:))));
% x = T(P(:,2)); y = R(P(:,1));
% plot(x,y,'s','color','green');
% 
% lines = houghlines(BW,T,R,P,'FillGap',10,'MinLength',20);
% figure, imshow(I), hold on
% max_len = 0;
% for k = 1:length(lines)
%    xy = [lines(k).point1; lines(k).point2];
%    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
% 
%    % Plot beginnings and ends of lines
%    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
% 
%    % Determine the endpoints of the longest line segment
%    len = norm(lines(k).point1 - lines(k).point2);
%    if ( len > max_len)
%       max_len = len;
%       xy_long = xy;
%    end
% end

%% Detection results
% h1 =im(1-E_new);
% set(gcf, ...
%     'units', 'centimeters', ...
%     'position', [10 5 11 12]);
% set(gca, ...
%     'FontName','Times New Roman',...
%     'FontSize',0.01)
% box on
% 
% 
% lines = houghlines(BW,T,R,P,'FillGap',10,'MinLength',20);
% figure, imshow(I), hold on
% max_len = 0;
% for k = 1:length(lines)
%    xy = [lines(k).point1; lines(k).point2];
%    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
% 
%    % Plot beginnings and ends of lines
%    plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%    plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
% 
%    % Determine the endpoints of the longest line segment
%    len = norm(lines(k).point1 - lines(k).point2);
%    if ( len > max_len)
%       max_len = len;
%       xy_long = xy;
%    end
% end
% set(gcf, ...
%     'units', 'centimeters', ...
%     'position', [10 5 11 12]);
% box on

%% FOR video r plot
% damage_moment = 32;
% figure; h1 = plot(1:damage_moment,ratio(1:damage_moment));hold on
% h2 = plot(damage_moment:size(ratio,2),ratio(damage_moment:end)); hold off
% set(h1(1),'Marker','o','LineStyle','-','LineWidth',1,'Color',[64 142 198]/255)
% set(h2(1),'Marker','*','LineStyle','-','LineWidth',1,'Color',[183 91 72]/255)
% 
% 
% set(gcf, ...
%     'units', 'centimeters', ...
%     'position', [10 5 14 8]);
% set(gca, ...
%     'FontName','Times New Roman',...
%     'FontSize',12)
% box on 
% grid on
% xlabel('Frame number','FontSize',12)
% ylabel('r','FontSize',12)
% h3=legend({'Undamaged','Damaged'},'Location','northeast','Orientation','vertical');

%% For video edge ploting
figure;h1=im(1-E_new);
title('');
colorbar('off')
set(gcf, ...
    'units', 'centimeters', ...
    'position', [10 5 14 8]);
set(gca, ...
    'FontName','Times New Roman',...
    'FontSize',0.01,...
    'xlim',[100,900],...
    'ylim',[200,400])
savefig(['D:\WorkFiles\Edge_Based\TestBed\video\Skeleton',num2str(kkk)]) 
saveas(gcf,['D:\WorkFiles\Edge_Based\TestBed\video\Skeleton',num2str(kkk)],'tiff')
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
set(gcf, ...
    'units', 'centimeters', ...
    'position', [10 5 14 8]);
set(gca, ...
    'FontName','Times New Roman',...
    'FontSize',0.01,...
    'xlim',[100,900],...
    'ylim',[200,400])
saveas(gcf,['D:\WorkFiles\Edge_Based\TestBed\video\line',num2str(kkk)],'tiff')
close all