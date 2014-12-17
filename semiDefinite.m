function [semiDef] = semiDefinite(A)
%A = [1 2 3;4 5 6;7 8 9]; % Example matrix
eig_A = eig(A)
flag = 0;
for i = 1:rank(A)
	if eig_A(i) < 0 
	flag = 1;
	end
end
if flag == 1
	disp('the matrix is not semi-positive definite')
    semiDef = 0;
	else
	disp('the matrix is semi-positive definite')
    semiDef = 1;
end


end

