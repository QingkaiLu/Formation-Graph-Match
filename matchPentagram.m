function [ ] = matchPentagram( )
figure
p = Pentagram(2, 0, 0, 5);
q = Pentagram(2, 5, 5, 5);
p = p';
q = q';
% q(2, :) = q(2, :) - 1;
% q = p + 5;
% q = p;
size(p, 1)
size(q, 1)
% if(size(p, 2) ~= size(q, 2))
%     return;
step = 100;
p = p(1:step:size(p, 1), :);
q = q(1:step:size(q, 1), :);
% [assignMat, cost] = matchTwoFormModelTst(p, q);
[assignMat, cost] = matchTwoForm(p, q);
cost
% img1 = imread('../pentagram1.jpg');
% img2 = imread('../pentagram2.jpg');
% match_plot(img1,img2,assignMat'*p,q);
match_plot_Pgm(assignMat' * p, q);

end

