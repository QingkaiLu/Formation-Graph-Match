function [ ] = matchFormOneGame()

figure;

gameId = 2;
gameIdStr = sprintf ('%02d', gameId);
playsIdToMatch = dlmread(['../formations/odGame' gameIdStr]);
playsIdToMatch = playsIdToMatch(:, 2);

playsIdExp = dlmread(['../formsExemplar/odGame' gameIdStr 'RectForm']);
playsIdExp = playsIdExp(:, 2);

expPlaysSz = size(playsIdExp, 1);
for i = 1:size(playsIdToMatch, 1)
    costs = zeros(expPlaysSz, 1);
    assignMats = cell(expPlaysSz, 1);
    pCells = cell(expPlaysSz, 1);
    curPlayId = playsIdToMatch(i);
    curPlayIdStr = sprintf ('%03d', curPlayId);
    q = dlmread(['../formations/Game' gameIdStr '/' 'vid' curPlayIdStr '.pos']);
    
    for j = 1 : expPlaysSz
            expPlayId = playsIdExp(j);
            expPlayIdStr = sprintf ('%03d', expPlayId);
            p = dlmread(['../formsExemplar/Game' gameIdStr '/' 'vid' expPlayIdStr '.pos']);
            pCells{j} = p;
%             [assignMat, cost] = matchTwoForm(p, q);
            [assignMats{j}, costs(j)] = matchTwoForm(p, q);
    end
    [~, sortIdx] = sort(costs);
    
    curVidPlotsPath = ['../plots/Game' gameIdStr '/vid' curPlayIdStr];
    if(exist(curVidPlotsPath, 'file') ~= 0)
        rmdir(curVidPlotsPath, 's');
    end
    mkdir(curVidPlotsPath);
    img2 = imread(['../formImgs/Game' gameIdStr '/' gameIdStr '0' curPlayIdStr 'Rect.jpg']);  
    for k = 1:expPlaysSz
        expPlayId = playsIdExp(sortIdx(k));
        expPlayIdStr = sprintf ('%03d', expPlayId);
        img1 = imread(['../formExmpImgs/Game' gameIdStr '/' gameIdStr '0' expPlayIdStr 'Rect.jpg']);
%         figure;
        match_plot(img1, img2, assignMats{sortIdx(k)}' * pCells{sortIdx(k)}, q);
        plotPath = [curVidPlotsPath '/vid' curPlayIdStr '_' int2str(k) '_' int2str(playsIdExp(sortIdx(k))) '.png'];
        Image = getframe(gcf);
        imwrite(Image.cdata, plotPath);
        hndl = gcf();
        close(hndl);
        hold off;
    
    end
end


end

