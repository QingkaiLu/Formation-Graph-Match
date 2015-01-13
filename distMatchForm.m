function dist = distMatchForm(Xi, Xj)

global playNodesCell;
global gamePlayIds;
% [~, dist] = matchTwoForm(q, p);
q = playNodesCell{gamePlayIds(:, 2) == Xi(:, 2)};
XjSize = size(Xj, 1);
dist = zeros(XjSize, 1);
for j = 1:XjSize
    p = playNodesCell{gamePlayIds(:, 2) == Xj(j, 2)};
    [~, dist(j)] = matchTwoForm(q, p);
    %dist(j) = j
end

end

