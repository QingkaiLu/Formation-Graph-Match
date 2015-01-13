function h = match_plot_Pgm(points1,points2)

colormap = {'b','m','y','g','c'};
hold on;
for i=1:size(points1,1)
    plot([points1(i,1) points2(i,1)],[points1(i,2) points2(i,2)],colormap{mod(i,5)+1}, 'LineWidth', 2);
end

end

