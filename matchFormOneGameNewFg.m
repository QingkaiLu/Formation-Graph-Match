function [ ] = matchFormOneGameNewFg()
%match formations generated using new foreground
figure;

gameId = 2;
gameIdStr = sprintf ('%02d', gameId);
playsIdToMatch = dlmread(['../formations/odNewFgGame' gameIdStr]);
playsIdToMatch = playsIdToMatch(:, 2);

% playsIdExp = dlmread(['../formsExemplar/odGame' gameIdStr 'RectForm']);
% playsIdExp = playsIdExp(:, 2);

gameODs = textread(['../formations/game' int2str(gameId) '_ODK'],'%c');
playsIdExp = playsIdToMatch;

expPlaysSz = 10;%size(playsIdExp, 1);
for i = 1:size(playsIdToMatch, 1)
    costs = zeros(expPlaysSz, 1);
    assignMats = cell(expPlaysSz, 1);
    pCells = cell(expPlaysSz, 1);
    curPlayId = playsIdToMatch(i);
    curPlayIdStr = sprintf ('%03d', curPlayId);
    q = dlmread(['../playersFgNew/Game' gameIdStr '/' 'vid' curPlayIdStr '.pos']);
    %q = q(1:20, :);
    for j = 1 : expPlaysSz
            expPlayId = playsIdExp(j);
            expPlayIdStr = sprintf ('%03d', expPlayId);
            p = dlmread(['../playersFgNew/Game' gameIdStr '/' 'vid' expPlayIdStr '.pos']);
            %p = p(1:20, :);
            pCells{j} = p;
            [assignMats{j}, costs(j)] = matchTwoForm(p, q);
    end
    [~, sortIdx] = sort(costs);
    
    curVidPlotsPath = ['../plots/Game' gameIdStr '/vid' curPlayIdStr];
    if(exist(curVidPlotsPath, 'file') ~= 0)
        rmdir(curVidPlotsPath, 's');
    end
    mkdir(curVidPlotsPath);
    img2 = imread(['../fgNewGrids/Game' gameIdStr '/' gameIdStr '0' curPlayIdStr 'Rect.jpg']);  
    for k = 1:expPlaysSz
        expPlayId = playsIdExp(sortIdx(k));
        expPlayIdStr = sprintf ('%03d', expPlayId);
        img1 = imread(['../fgNewGrids/Game' gameIdStr '/' gameIdStr '0' expPlayIdStr 'Rect.jpg']);
%         match_plot(img1, img2, assignMats{sortIdx(k)}' * pCells{sortIdx(k)}, q);
        match_plot(img2, img1, q, assignMats{sortIdx(k)}' * pCells{sortIdx(k)});
        plotPath = [curVidPlotsPath '/vid' curPlayIdStr '_' int2str(k) '_' int2str(playsIdExp(sortIdx(k))) '.png'];
        Image = getframe(gcf);
        imwrite(Image.cdata, plotPath);
        hndl = gcf();
        close(hndl);
        hold off;
    
    end
end


end

