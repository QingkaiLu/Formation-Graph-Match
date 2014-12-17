function [ ] = searchSimFormsForExmForms()

figure;

gameId = 2;
gameIdStr = sprintf ('%02d', gameId);
playsIdToMatch = dlmread(['../formations/odGame' gameIdStr]);
playsIdToMatch = playsIdToMatch(:, 2);

playsIdExp = dlmread(['../formsExemplar/odGame' gameIdStr 'RectForm']);
playsIdExp = playsIdExp(:, 2);

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
            pCells{j} = p;
%             [assignMats{j}, costs(j)] = matchTwoForm(p, q);
            [assignMats{j}, costs(j)] = matchTwoForm(q, p);
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
    
    img2 = imread(['../formExmpImgs/Game' gameIdStr '/' gameIdStr '0' expPlayIdStr 'Rect.jpg']);
    img2Orig = imread(['../formExmpImgs/Game' gameIdStr '/' gameIdStr '0' expPlayIdStr '.jpg']);
    searchResNum = 5;
    bestSearchRes = img2;
    bestSearchResOrig = img2Orig;
%     bestSearchRes = [];
%     bestSearchResOrig = [];
    for k = 1:searchResNum
        curPlayId = playsIdToMatch(sortIdx(k));
        curPlayIdStr = sprintf ('%03d', curPlayId);
        img1 = imread(['../formImgs/Game' gameIdStr '/' gameIdStr '0' curPlayIdStr 'Rect.jpg']);
        img1Orig = imread(['../formImgs/Game' gameIdStr '/' gameIdStr '0' curPlayIdStr '.jpg']);
%         if(k == 1)
%             bestSearchRes = img1;
%             bestSearchResOrig = img1Orig;
%         else
%             bestSearchRes = [bestSearchRes; img1];
%             bestSearchResOrig = [bestSearchResOrig; img1Orig];
%         end
        bestSearchRes = [bestSearchRes; img1];
        bestSearchResOrig = [bestSearchResOrig; img1Orig];
    end
    imshow(bestSearchRes);
    plotPath = [expSearchVidPlotsPath '/vid' expPlayIdStr '_best_' int2str(searchResNum)  '.png'];
    Image = getframe(gcf);
    imwrite(Image.cdata, plotPath);
    hndl = gcf();
    close(hndl);
    hold off;
    imshow(bestSearchResOrig);
    plotPath = [expSearchVidPlotsPath '/vid' expPlayIdStr '_best_' int2str(searchResNum)  'Orig.png'];
    Image = getframe(gcf);
    imwrite(Image.cdata, plotPath);
    hndl = gcf();
    close(hndl);
    hold off;
    

    worstSearchRes = img2;
    worstSearchResOrig = img2Orig;
    for k = (matchPlaysSz - searchResNum) : matchPlaysSz
        curPlayId = playsIdToMatch(sortIdx(k));
        curPlayIdStr = sprintf ('%03d', curPlayId);
        img1 = imread(['../formImgs/Game' gameIdStr '/' gameIdStr '0' curPlayIdStr 'Rect.jpg']);
        img1Orig = imread(['../formImgs/Game' gameIdStr '/' gameIdStr '0' curPlayIdStr '.jpg']);
        worstSearchRes = [worstSearchRes; img1];
        worstSearchResOrig = [worstSearchResOrig; img1Orig];
    end
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

