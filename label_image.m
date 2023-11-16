function [L, num] = label_image(bw, conn)
    [rows, cols] = size(bw);
    L = zeros(rows, cols);
    next_label = 1;

    if nargin < 2
        conn = 8; % 默认为 8-连通
    end

    for i = 1:rows
        for j = 1:cols
            if bw(i, j) == 1
                neighbors = find_neighbors(L, i, j, conn);

                if isempty(neighbors)
                    L(i, j) = next_label;
                    next_label = next_label + 1;
                else
                    L(i, j) = min(neighbors);
                end
            end
        end
    end

    num = max(L(:));
end

function neighbors = find_neighbors(L, i, j, conn)
    [rows, cols] = size(L);
    neighbors = [];

    if conn == 4
        % 4-连通
        offsets = [-1, 0; 0, -1];
    else
        % 8-连通 (默认)
        offsets = [-1, -1; -1, 0; -1, 1; 0, -1];
    end

    for k = 1:size(offsets, 1)
        x = i + offsets(k, 1);
        y = j + offsets(k, 2);

        if x >= 1 && x <= rows && y >= 1 && y <= cols
            neighbor_label = L(x, y);
            if neighbor_label > 0
                neighbors = [neighbors, neighbor_label];
            end
        end
    end

    neighbors = unique(neighbors);
end
