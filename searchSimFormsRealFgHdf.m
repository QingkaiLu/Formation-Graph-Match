function [ ] = searchSimFormsRealFgHdf()

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
%     assignMats = cell(matchPlaysSz, 1);
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
%     bestSearchRes = [bestSearchRes; [bestImg1{1} bestImg1{2}]; [bestImg1{3} bestImg1{4}]];
%     bestSearchResOrig = [bestSearchResOrig; [bestImg1Orig{1} bestImg1Orig{2}]; [bestImg1Orig{3} bestImg1Orig{4}]];
%     imshow(bestSearchRes);
%     hold on
%     plotPath = [expSearchVidPlotsPath '/vid' expPlayIdStr '_best_' int2str(searchResNum)  '.jpg'];
%     Image = getframe(gcf);
%     imwrite(Image.cdata, plotPath);
%     hndl = gcf();
%     close(hndl);
%     hold off;
%     imshow(bestSearchResOrig);
%     plotPath = [expSearchVidPlotsPath '/vid' expPlayIdStr '_best_' int2str(searchResNum)  'Orig.jpg'];
%     Image = getframe(gcf);
%     imwrite(Image.cdata, plotPath);
%     hndl = gcf();
%     close(hndl);
%     hold off;
%     
%     worstSearchRes = zeros(size(img2, 1), 2 * size(img2, 2), size(img2, 3));
%     worstSearchResOrig = zeros(size(img2Orig, 1), 2 * size(img2Orig, 2), size(img2Orig, 3));
%     worstSearchRes(:, (size(img2, 2) / 2 ) : (size(img2, 2) / 2  + size(img2, 2) - 1), :) = img2;
%     worstSearchResOrig(:, (size(img2Orig, 2) / 2 ) : (size(img2Orig, 2) / 2  + size(img2Orig, 2) - 1), : ) = img2Orig;
%     worstImg1 = cell(searchResNum, 1);
%     worstImg1Orig = cell(searchResNum, 1);
%     wstIdx = 1;
%     for k = matchPlaysSz : -1 : 1
%         if(costs(sortIdx(k)) ~= inf)
%             curPlayId = playsIdToMatch(sortIdx(k));
%             curPlayIdStr = sprintf ('%03d', curPlayId);
%             img1 = imread(['../fgNewGrids' winSz '/Game' gameIdStr '/' gameIdStr '0' curPlayIdStr 'Rect.jpg']);
%             img1Orig = imread(['../fgNewGrids' winSz '/Game' gameIdStr '/' gameIdStr '0' curPlayIdStr '.jpg']);
%             worstImg1{wstIdx} = img1;
%             worstImg1Orig{wstIdx} = img1Orig;
%             wstIdx = wstIdx + 1;
%         end
%         if((wstIdx - 1) == searchResNum)
%             break;
%         end
%     end
%     worstSearchRes = [worstSearchRes; [worstImg1{1} worstImg1{2}]; [worstImg1{3} worstImg1{4}]];
%     worstSearchResOrig = [worstSearchResOrig; [worstImg1Orig{1} worstImg1Orig{2}]; [worstImg1Orig{3} worstImg1Orig{4}]];
%     imshow(worstSearchRes);
%     plotPath = [expSearchVidPlotsPath '/vid' expPlayIdStr '_worst_' int2str(searchResNum)  '.png'];
%     Image = getframe(gcf);
%     imwrite(Image.cdata, plotPath);
%     hndl = gcf();
%     close(hndl);
%     hold off;
%     imshow(worstSearchResOrig);
%     plotPath = [expSearchVidPlotsPath '/vid' expPlayIdStr '_worst_' int2str(searchResNum)  'Orig.png'];
%     Image = getframe(gcf);
%     imwrite(Image.cdata, plotPath);
%     hndl = gcf();
%     close(hndl);
%     hold off;
%     
costs
 end
    findSelfRatio = findSelfNum / expPlaysSz
end

