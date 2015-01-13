function [ ] = searchFormsFgQueryHdf()

figure;

gameId = 2;
gameIdStr = sprintf ('%02d', gameId);
playsIdToMatch = dlmread(['../formations/odNewFgGame' gameIdStr]);
playsIdToMatch = playsIdToMatch(:, 2);
% playsIdToMatch = playsIdToMatch(1:40, 2);

% playsIdExp = dlmread(['../formsExemplar/odGame' gameIdStr 'RectForm']);
% playsIdExp = playsIdExp(:, 2);
playsIdExp = playsIdToMatch;

gameODs = textread(['../formations/game' int2str(gameId) '_ODK'],'%c');

%rectLosCntGts = dlmread(['../losCntGt/Game' gameIdStr 'LosCntGtRect']);

winSz = '_Win45';
expPlaysSz = size(playsIdExp, 1);
matchPlaysSz = size(playsIdToMatch, 1);
findSelfNum = 0;
for i = 1 : expPlaysSz
    costs = zeros(matchPlaysSz, 1);
    pCells = cell(matchPlaysSz, 1);
    
    expPlayId = playsIdExp(i);
    expPlayIdStr = sprintf ('%03d', expPlayId);
    q = dlmread(['../playersFgNew' winSz '/Game' gameIdStr '/' 'vid' expPlayIdStr '.pos']);
    
    for j = 1 : matchPlaysSz
            curPlayId = playsIdToMatch(j);
            curPlayIdStr = sprintf ('%03d', curPlayId);
            p = dlmread(['../playersFgNew' winSz '/Game' gameIdStr '/' 'vid' curPlayIdStr '.pos']);
            pCells{j} = p;
            if(gameODs(expPlayId) ==  gameODs(curPlayId))
                [costs(j), ~] = HausdorffDist(q, p);
            else
                costs(j) = inf;
            end
    end
    [~, sortIdx] = sort(costs);
    
    expSearchVidPlotsPath = ['../plotsSearch/Game' gameIdStr '/vid' expPlayIdStr '_search']
    if(exist(expSearchVidPlotsPath, 'file') ~= 0)
        rmdir(expSearchVidPlotsPath, 's');
    end
    mkdir(expSearchVidPlotsPath);
    
    img2 = imread(['../fgNewGrids' winSz '/Game' gameIdStr '/' gameIdStr '0' expPlayIdStr 'Rect.jpg']);
    img2Orig = imread(['../fgNewGrids' winSz '/Game' gameIdStr '/' gameIdStr '0' expPlayIdStr '.jpg']);
    searchResNum = 4;
    bestSearchRes = zeros(size(img2, 1), 2 * size(img2, 2), size(img2, 3));
    bestSearchResOrig = zeros(size(img2Orig, 1), 2 * size(img2Orig, 2), size(img2Orig, 3));
    bestSearchRes(:, (size(img2, 2) / 2 ) : (size(img2, 2) / 2  + size(img2, 2) - 1), :) = img2;
    bestSearchResOrig(:, (size(img2Orig, 2) / 2 ) : (size(img2Orig, 2) / 2  + size(img2Orig, 2) - 1), : ) = img2Orig;
    bestImg1 = cell(searchResNum, 1);
    bestImg1Orig = cell(searchResNum, 1);
    for k = 1:searchResNum
        curPlayId = playsIdToMatch(sortIdx(k));
        if(curPlayId == expPlayId && k == 1)
            findSelfNum = findSelfNum + 1
        end
        curPlayIdStr = sprintf ('%03d', curPlayId);
        img1 = imread(['../fgNewGrids' winSz '/Game' gameIdStr '/' gameIdStr '0' curPlayIdStr 'Rect.jpg']);
        img1Orig = imread(['../fgNewGrids' winSz '/Game' gameIdStr '/' gameIdStr '0' curPlayIdStr '.jpg']);
        bestImg1{k} = img1;
        bestImg1Orig{k} = img1Orig;
    end
 end
    findSelfRatio = findSelfNum / expPlaysSz
end

