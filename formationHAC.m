function [ ] = formationHAC(  )

global playNodesCell;
global gamePlayIds;

OD = 'O';
gameId = 2;
gameIdStr = sprintf ('%02d', gameId);
gamePlayIds = dlmread(['../formations/odGame' gameIdStr]); 
playsIds = gamePlayIds(:, 2);

gameODs = textread(['../formations/game' int2str(gameId) '_ODK'],'%c');
gameODs = gameODs(playsIds);
playsIds = playsIds(gameODs == OD);
gamePlayIds = gamePlayIds(gameODs == OD, :);

% playsSz = size(playsIds, 1);
% playNodesCell = cell(playsSz, 1);
% for i = 1 : playsSz
%     pId = playsIds(i);
%     pIdStr = sprintf ('%03d', pId);
%     playNodesCell{i} = dlmread(['../formations/Game' gameIdStr '/' 'vid' pIdStr '.pos']);  
% end
% 
% Z = linkage(gamePlayIds, 'average', {@(Xi, Xj) distMatchForm(Xi, Xj)});
% save Z.mat
% save gamePlayIds.mat

load Z.mat
load gamePlayIds.mat
dendrogram(Z)
clusterIdx = cluster(Z, 'maxclust', 10)
% clusterIdx = cluster(Z, 'cutoff', 10)

gamePath = ['../cluster/Game' gameIdStr];
if(exist(gamePath, 'file') ~= 0)
    rmdir(gamePath, 's');
end
mkdir(gamePath); 
    
for i = 1 : size(playsIds, 1)
    imgPath = [gamePath '/cluster' int2str(clusterIdx(i))];
    if(exist(imgPath, 'file') == 0)
        mkdir(imgPath); 
    end
    curPlayId = playsIds(i);
    curPlayIdStr = sprintf ('%03d', curPlayId);
    img = imread(['../formImgs/Game' gameIdStr 'DetLos/' gameIdStr '0' curPlayIdStr 'Rect.jpg']);
    imgOrig = imread(['../formImgs/Game' gameIdStr 'DetLos/' gameIdStr '0' curPlayIdStr '.jpg']);
    imwrite(img, [imgPath '/' gameIdStr '0' curPlayIdStr 'Rect.jpg']);
    imwrite(imgOrig, [imgPath '/' gameIdStr '0' curPlayIdStr '.jpg']);
end

end
