function thin_A = thin(Binary_A)

% I = Binary_A;  % 细化实验
% invertedImage = 255 - I; % 反色操作
% figure , imshow(invertedImage);
% J = im2bw(invertedImage);
thin_A = Binary_A; % 初始化 thin_A

J = ~Binary_A;

[row , col] = size(J);
K = J;

modified = true;    % 控制迭代的标记

while(modified)
    modified = false;
    for i = 6 : row - 5
        for j = 6 : col - 5
            if J(i , j) == true
                if thin_1(J , i , j) && thin_2(J , i , j) && thin_3(J , i , j) && thin_4(J , i , j)
                    K(i , j) = false;
                    modified = true;    % 是否继续迭代
                end
            end
        end
    end
    J = K;
%     figure , imshow(K)
end
thin_A = 1 - K;
%figure , imshow(K);

function flag = thin_1(J , i , j)
% --功能： 检测二值图J上坐标为(i , j)的点8邻域内是否满足白点个数为2到6个--
% --输入：二值图J，坐标(i , j)
% --返回值：true:满足 , false: 不满足

flag = false;
p_round = zeros(1 , 8); % p_round 记录该点8邻域的情况
p_round(1) = J(i - 1 , j - 1);
p_round(2) = J(i - 1 , j);
p_round(3) = J(i - 1 , j + 1);
p_round(4) = J(i , j - 1);
p_round(5) = J(i , j + 1);
p_round(6) = J(i + 1 , j - 1);
p_round(7) = J(i + 1 , j);
p_round(8) = J(i + 1 , j + 1);

if (sum(p_round) >= 2) && (sum(p_round) <= 6)    % 8邻域内只有2-6个白点
    flag = true;
end

return;
%%
function flag = thin_2(J , i , j)
% --功能： 检测二值图J上坐标为(i , j)的点8邻域内是否满足白点都连续--
% --输入：二值图J，坐标(i , j)
% --返回值：true:满足 , false: 不满足

nCount = 0;
flag = false;

if (J(i - 1 , j) == true) && (J(i - 1 , j - 1) == false) % 1
    nCount = nCount + 1;
    if nCount >1
        return;
    end
end

if (J(i - 1 , j - 1) == true) && (J(i , j - 1) == false) % 2
    nCount = nCount + 1;
    if nCount >1
        return;
    end
end

if (J(i , j - 1) == true) && (J(i + 1 , j - 1) == false) % 3
    nCount = nCount + 1;
    if nCount >1
        return;
    end
end

if (J(i + 1 , j - 1) == true) && (J(i + 1 , j) == false) % 4
    nCount = nCount + 1;
    if nCount >1
        return;
    end
end

if (J(i + 1 , j) == true) && (J(i + 1 , j + 1) == false) % 5
    nCount = nCount + 1;
    if nCount >1
        return;
    end
end

if (J(i + 1 , j + 1) == true) && (J(i , j + 1) == false) % 6
    nCount = nCount + 1;
    if nCount >1
        return;
    end
end

if (J(i , j + 1) == true) && (J(i - 1 , j + 1) == false) % 7
    nCount = nCount + 1;
    if nCount >1
        return;
    end
end

if (J(i - 1 , j + 1) == true) && (J(i - 1 , j) == false) % 8
    nCount = nCount + 1;
    if nCount >1
        return;
    end
end

if nCount == 1
    flag = true;
end
%%
function flag = thin_3(J , i , j)
% --功能： 检测二值图J上坐标为(i , j)的点是否满足 上，左，右"不全为"白点(前景色)，或该点上方的点不满足8邻域内的白点(前景色)连续--
% --输入：二值图J，坐标(i , j)
% --返回值：true:满足 , false: 不满足

flag = false;

if ~(J(i , j - 1) && J(i - 1 , j) && J(i , j + 1))
    flag = true;    % 左 上 右，任一为白
else
    if ~thin_2(J , i - 1 , j)
        flag = true;
    end
end
%%     
function flag = thin_4(J , i , j)
% --功能： 检测二值图J上坐标为(i , j)的点是否满足 上，左，下不全为白点(前景色)，或该点左侧的点不满足8邻域内的白点(前景色)连续--
% --输入：二值图J，坐标(i , j)
% --返回值：true:满足 , false: 不满足

flag = false;

if ~(J(i , j - 1) && J(i - 1 , j) && J(i + 1 , j))
    flag = true;
else
    if ~thin_2(J , i , j - 1)
        flag = true;
    end
end
       
