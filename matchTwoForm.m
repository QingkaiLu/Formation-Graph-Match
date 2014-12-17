function [assignMat, cost] = matchTwoForm(pOrig, qOrig)
% p
% q
p = pOrig';
q = qOrig';

swap = 0;
if(size(p, 2) < size(q, 2))
   tmp = p;
   p = q;
   q = tmp;
   swap = 1;
end

pSz = size(p, 2);
qSz = size(q, 2);
H = zeros(pSz * qSz, pSz * qSz);

r = 0;
for i2 = 1:qSz
    for i1 = 1:pSz
        r = r + 1;
        c = 0;
        for j2 = 1:qSz
            for j1 = 1:pSz
                c = c + 1;
                
                if(r > c)
                    H(r, c) = H(c, r);
                else
                    if(i1 == j1 && i2 == j2)
                          H(r, c) = norm(p(:, i1) - q(:, i2));
%                         H(r, c) = 1 / norm(p(:, i1) - q(:, i2));
                    else if(i1 ~= j1 && i2 ~= j2)
                            edgeP = p(:, j1) - p(:, i1);
                            edgeQ = q(:, j2) - q(:, i2);
                            H(r, c) = norm(edgeP - edgeQ);
%                             H(r, c) = 1 / noif(swap == 1)rm(edgeP - edgeQ);
                        else
%                             H(r, c) = exp(30);
                              H(r, c) = 0;
                        end
                    end
                        
                end
            end
        end
    end
end
% H
% H(H == -1) = max(max(H)) + 1;
% H
% size(H)
% size(p)
% semiDef = semiDefinite(H)
f = zeros(pSz * qSz, 1);
lb = zeros(pSz * qSz, 1);
ub = ones(pSz * qSz, 1);
A = kron(eye(pSz, pSz), ones(1, qSz));
b = ones(pSz, 1);
Aeq = kron(eye(qSz, qSz), ones(1, pSz));
beq = ones(qSz, 1);

%fix losCnt 
% firstRow = zeros(1, pSz * qSz);
% firstRow(1) = 1;
% Aeq = [firstRow; Aeq];
% beq = [1; beq];

% x0 = 0.5 * ones(pSz * qSz, 1);
x0 = zeros(pSz * qSz, 1);
%x0(1) = 1;
% x0 = eye(pSz, qSz);
% x0 = reshape(x0, pSz * qSz, 1);
% opts = optimoptions('quadprog', 'Algorithm','interior-point-convex','Display','iter');
H = 2 * H;
opts = optimoptions('quadprog','Algorithm','active-set');%,'Display','off');
[x, cost] = quadprog(H,f,A,b,Aeq,beq,lb,ub,x0,opts);
% x0 = x;
% [x, cost] = quadprog(H,f,A,b,Aeq,beq,lb,ub,x0,'Algorithm','active-set');
% semiDefinite(H)
%[x, cost] = quadprog(H,f,A,b,Aeq,beq,lb,ub);
% x
assignMat = reshape(x, pSz, qSz);
[assignMat, HungCost] = Hungarian(1 - assignMat);
x = reshape(assignMat, pSz * qSz, 1);
cost = 0.5 * x' * H * x + f' * x;
if(swap == 1)
    assignMat = assignMat';
end
%compensation of extra unmatched nodes of query image p
% if(swap ~= 1)
%     cost = cost + 5 * cost / qSz * (pSz - qSz);
% end

% threshold = 0.1;
% assignMat(assignMat < threshold) = 0;
% assignMat(assignMat >= threshold) = 1;
% for i = 1:size(assignMat, 2)
%    tmp = assignMat(:, i);
%    tmp(tmp == max(tmp)) = 1;
%    tmp(tmp ~= 1) = 0;
%    assignMat(:, i) = tmp;
% end
% assignMat
% cost

% [assignMat, HungCost] = Hungarian(1 - assignMat);
% x = reshape(assignMat, pSz * qSz, 1);
% cost = 0.5 * x' * H * x + f' * x


end

