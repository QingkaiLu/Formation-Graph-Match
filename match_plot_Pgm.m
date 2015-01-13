function h = match_plot_Pgm(points1,points2)

% h = figure;
colormap = {'b','m','y','g','c'};
% height = max(size(img1,1),size(img2,1));
% img1_ratio = height/size(img1,1);
% img2_ratio = height/size(img2,1);
% img1 = imresize(img1,img1_ratio);
% img2 = imresize(img2,img2_ratio);
% points1 = points1 * img1_ratio;
% points2 = points2 * img2_ratio;
% points1 = [points1(:,2) points1(:,1)];
% points2 = [points2(:,2) points2(:,1)];
% match_img = zeros(height, size(img1,2)+size(img2,2), size(img2,3));
% match_img(1:size(img1,1),1:size(img1,2),:) = img1;
% match_img(1:size(img2,1),size(img1,2)+1:end,:) = img2;
% imshow(uint8(match_img));
hold on;
for i=1:size(points1,1)
    plot([points1(i,1) points2(i,1)],[points1(i,2) points2(i,2)],colormap{mod(i,5)+1}, 'LineWidth', 2);
end

% 
% for i=1:size(points1,1)
% %         points1(i, :)
% %         points2(i, :)
%         if((~isequal(round(points1(i, :)), [0, 0])) && (~isequal(round(points2(i, :)), [0, 0])))
%             plot([points1(i,1) points2(i,1)],[points1(i,2) points2(i,2)],colormap{mod(i,5)+1}, 'LineWidth', 2);
%         end
% end

% hold off;

end

