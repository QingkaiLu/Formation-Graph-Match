function [ ] = matchFormOneGameModelTest()

% p = dlmread('../formsExemplar/Game02/vid017.pos');
% q = dlmread('../formations/Game02/vid002.pos');
p = dlmread('../formsExemplar/Game02/vid020.pos');
q = dlmread('../formations/Game02/vid020.pos');
%q = p;
%q = p;
[assignMat, cost] = matchTwoFormModelTst(p, q);
% [assignMat, cost] = matchTwoForm(p, q);
cost

% img1 = imread('../formExmpImgs/Game02/020017Rect.jpg');
% img2 = imread('../formImgs/Game02/020002Rect.jpg');
img1 = imread('../formExmpImgs/Game02/020020Rect.jpg');
img2 = imread('../formImgs/Game02/020020Rect.jpg');
match_plot(img1,img2,assignMat'*p,q);
% match_plot(img2,img1,q,assignMat'*p);

end