function [ ] = searchSimFormsForExmForms2()

figure;

gameId = 2;
gameIdStr = sprintf ('%02d', gameId);
playsIdToMatch = dlmread(['../formations/odGame' gameIdStr]);
playsIdToMatch = playsIdToMatch(:, 2);

playsIdExp = dlmread(['../formsExemplar/odGame' gameIdStr 'RectForm']);
playsIdExp = playsIdExp(:, 2);

gameODs = textread(['../formations/game' int2str(gameId) '_ODK'],'%c');

rectLosCntGts = dlmread(['../losCntGt/Game' gameIdStr 'LosCntGtRect']);

expPlaysSz = size(playsIdExp, 1);
matchPlaysSz = size(playsIdToMatch, 1);
for i = 1 : expPlaysSz
    costs = zeros(matchPlaysSz, 1);
    assignMats = cell(matchPlaysSz, 1);
    pCells = cell(matchPlaysSz, 1);
    
    expPlayId = playsIdExp(i);
    expPlayIdStr = sprintf ('%03d', expPlayId);
    q = dlmread(['../formsExemplar/Game' gameIdStr '/' 'vid' expPlayIdStr '.pos']);
    
    for j = 1 : matchPlaysSz
            curPlayId = playsIdToMatch(j);
            curPlayIdStr = sprintf ('%03d', curPlayId);
            p = dlmread(['../formations/Game' gameIdStr '/' 'vid' curPlayIdStr '.pos']);
%             rectLosCntGt = rectLosCntGts(rectLosCntGts(:, 1) == curPlayId, 2:3);
%             p(1, :) = rectLosCntGt;
            pCells{j} = p;
%             [assignMats{j}, costs(j)] = matchTwoForm(p, q);
            if(gameODs(expPlayId) ==  gameODs(curPlayId))
                [assignMats{j}, costs(j)] = matchTwoForm(q, p);
            else
                costs(j) = inf;
                assignMats{j} = [];
            end
    end
    [~, sortIdx] = sort(costs);
    
%     expVidPlotsPath = ['../plotsSearch/Game' gameIdStr '/vid' expPlayIdStr];
%     if(exist(expVidPlotsPath, 'file') ~= 0)
%         rmdir(expVidPlotsPath, 's');
%     end
%     mkdir(expVidPlotsPath);
%     
%     img2 = imread(['../formExmpImgs/Game' gameIdStr '/' gameIdStr '0' expPlayIdStr 'Rect.jpg']);  
%     for k = 1:matchPlaysSz
%         curPlayId = playsIdToMatch(sortIdx(k));
%         curPlayIdStr = sprintf ('%03d', curPlayId);
%         img1 = imread(['../formImgs/Game' gameIdStr '/' gameIdStr '0' curPlayIdStr 'Rect.jpg']);
% %         figure;
% %          match_plot(img1, img2, assignMats{sortIdx(k)}' * pCells{sortIdx(k)}, q);
%         match_plot(img2, img1, assignMats{sortIdx(k)}' * q,  pCells{sortIdx(k)});
%         plotPath = [expVidPlotsPath '/vid' expPlayIdStr '_' int2str(k) '_' int2str(playsIdToMatch(sortIdx(k))) '.png'];
%         Image = getframe(gcf);
%         imwrite(Image.cdata, plotPath);
%         hndl = gcf();
%         close(hndl);
%         hold off;
%     
%     end
    
    expSearchVidPlotsPath = ['../plotsSearch/Game' gameIdStr '/vid' expPlayIdStr '_search'];
    if(exist(expSearchVidPlotsPath, 'file') ~= 0)
        rmdir(expSearchVidPlotsPath, 's');
    end
    mkdir(expSearchVidPlotsPath);
    
%     img2 = imread(['../formExmpImgs/Game' gameIdStr '/' gameIdStr '0' expPlayIdStr 'Rect.jpg']);
%     img2Orig = imread(['../formExmpImgs/Game' gameIdStr '/' gameIdStr '0' expPlayIdStr '.jpg']);
    img2 = imread(['../formExmpImgs/Game' gameIdStr 'Los/' gameIdStr '0' expPlayIdStr 'Rect.jpg']);
    img2Orig = imread(['../formExmpImgs/Game' gameIdStr 'Los/' gameIdStr '0' expPlayIdStr '.jpg']);
    searchResNum = 4;
    bestSearchRes = zeros(size(img2, 1), 2 * size(img2, 2), size(img2, 3));
    bestSearchResOrig = zeros(size(img2Orig, 1), 2 * size(img2Orig, 2), size(img2Orig, 3));
    bestSearchRes(:, (size(img2, 2) / 2 ) : (size(img2, 2) / 2  + size(img2, 2) - 1), :) = img2;
    bestSearchResOrig(:, (size(img2Orig, 2) / 2 ) : (size(img2Orig, 2) / 2  + size(img2Orig, 2) - 1), : ) = img2Orig;
%     bestSearchRes(:, 1 : size(img2, 2)) = img2;
%     bestSearchResOrig(:, 1 : size(img2Orig, 2)) = img2Orig;
%     bestSearchRes = [];
%     bestSearchResOrig = [];

%     bestSearchRes = [img2 zeros(size(img2, 1), size(img2, 2), size(img2, 3))];
%     bestSearchResOrig = [img2Orig zeros(size(img2Orig, 1), size(img2Orig, 2), size(img2Orig, 3))];
%     bestSearchRes(:, (size(img2, 2) / 2) : (size(img2, 2) / 2 + size(img2, 2)), :) = bestSearchRes(:, 1 : size(img2, 2), :);
%     bestSearchRes(:, (230 : 230 + size(img2, 2) - 1), :) = bestSearchRes(:, 1 : size(img2, 2), :);
    bestImg1 = cell(searchResNum, 1);
    bestImg1Orig = cell(searchResNum, 1);
    for k = 1:searchResNum
        curPlayId = playsIdToMatch(sortIdx(k));
        curPlayIdStr = sprintf ('%03d', curPlayId);
%         img1 = imread(['../formImgs/Game' gameIdStr '/' gameIdStr '0' curPlayIdStr 'Rect.jpg']);
%         img1Orig = imread(['../formImgs/Game' gameIdStr '/' gameIdStr '0' curPlayIdStr '.jpg']);
%         img1 = imread(['../formImgs/Game' gameIdStr 'GtLos/' gameIdStr '0' curPlayIdStr 'Rect.jpg']);
%         img1Orig = imread(['../formImgs/Game' gameIdStr 'GtLos/' gameIdStr '0' curPlayIdStr '.jpg']);
        img1 = imread(['../formImgs/Game' gameIdStr 'GtLos/' gameIdStr '0' curPlayIdStr 'Rect.jpg']);
        img1Orig = imread(['../formImgs/Game' gameIdStr 'GtLos/' gameIdStr '0' curPlayIdStr '.jpg']);
        bestImg1{k} = img1;
        bestImg1Orig{k} = img1Orig;
%         if(k == 1)
%             bestSearchRes = img1;
%             bestSearchResOrig = img1Orig;
%         else
%             bestSearchRes = [bestSearchRes; img1];
%             bestSearchResOrig = [bestSearchResOrig; img1Orig];
% %         end
%         bestSearchRes = [bestSearchRes; img1];
%         bestSearchResOrig = [bestSearchResOrig; img1Orig];
    end
    bestSearchRes = [bestSearchRes; [bestImg1{1} bestImg1{2}]; [bestImg1{3} bestImg1{4}]];
    bestSearchResOrig = [bestSearchResOrig; [bestImg1Orig{1} bestImg1Orig{2}]; [bestImg1Orig{3} bestImg1Orig{4}]];
    imshow(bestSearchRes);
    hold on
    plotPath = [expSearchVidPlotsPath '/vid' expPlayIdStr '_best_' int2str(searchResNum)  '.jpg'];
    Image = getframe(gcf);
    imwrite(Image.cdata, plotPath);
    hndl = gcf();
    close(hndl);
    hold off;
    imshow(bestSearchResOrig);
    plotPath = [expSearchVidPlotsPath '/vid' expPlayIdStr '_best_' int2str(searchResNum)  'Orig.jpg'];
    Image = getframe(gcf);
    imwrite(Image.cdata, plotPath);
    hndl = gcf();
    close(hndl);
    hold off;
    

%     worstSearchRes = img2;
%     worstSearchResOrig = img2Orig;
    worstSearchRes = zeros(size(img2, 1), 2 * size(img2, 2), size(img2, 3));
    worstSearchResOrig = zeros(size(img2Orig, 1), 2 * size(img2Orig, 2), size(img2Orig, 3));
    worstSearchRes(:, (size(img2, 2) / 2 ) : (size(img2, 2) / 2  + size(img2, 2) - 1), :) = img2;
    worstSearchResOrig(:, (size(img2Orig, 2) / 2 ) : (size(img2Orig, 2) / 2  + size(img2Orig, 2) - 1), : ) = img2Orig;
    worstImg1 = cell(searchResNum, 1);
    worstImg1Orig = cell(searchResNum, 1);
    wstIdx = 1;
%     for k = (matchPlaysSz - searchResNum) : matchPlaysSz
    for k = matchPlaysSz : -1 : 1
        if(costs(sortIdx(k)) ~= inf)
            curPlayId = playsIdToMatch(sortIdx(k));
            curPlayIdStr = sprintf ('%03d', curPlayId);
%             img1 = imread(['../formImgs/Game' gameIdStr '/' gameIdStr '0' curPlayIdStr 'Rect.jpg']);
%             img1Orig = imread(['../formImgs/Game' gameIdStr '/' gameIdStr '0' curPlayIdStr '.jpg']);
%             img1 = imread(['../formImgs/Game' gameIdStr 'GtLos/' gameIdStr '0' curPlayIdStr 'Rect.jpg']);
%             img1Orig = imread(['../formImgs/Game' gameIdStr 'GtLos/' gameIdStr '0' curPlayIdStr '.jpg']);
            img1 = imread(['../formImgs/Game' gameIdStr 'GtLos/' gameIdStr '0' curPlayIdStr 'Rect.jpg']);
            img1Orig = imread(['../formImgs/Game' gameIdStr 'GtLos/' gameIdStr '0' curPlayIdStr '.jpg']);
    %         worstSearchRes = [worstSearchRes; img1];
    %         worstSearchResOrig = [worstSearchResOrig; img1Orig];
            worstImg1{wstIdx} = img1;
            worstImg1Orig{wstIdx} = img1Orig;
            wstIdx = wstIdx + 1;
%         else
%            k = k - 1; 
        end
        if((wstIdx - 1) == searchResNum)
            break;
        end
    end
    worstSearchRes = [worstSearchRes; [worstImg1{1} worstImg1{2}]; [worstImg1{3} worstImg1{4}]];
    worstSearchResOrig = [worstSearchResOrig; [worstImg1Orig{1} worstImg1Orig{2}]; [worstImg1Orig{3} worstImg1Orig{4}]];
    imshow(worstSearchRes);
    plotPath = [expSearchVidPlotsPath '/vid' expPlayIdStr '_worst_' int2str(searchResNum)  '.png'];
    Image = getframe(gcf);
    imwrite(Image.cdata, plotPath);
    hndl = gcf();
    close(hndl);
    hold off;
    imshow(worstSearchResOrig);
    plotPath = [expSearchVidPlotsPath '/vid' expPlayIdStr '_worst_' int2str(searchResNum)  'Orig.png'];
    Image = getframe(gcf);
    imwrite(Image.cdata, plotPath);
    hndl = gcf();
    close(hndl);
    hold off;
    
end

end

