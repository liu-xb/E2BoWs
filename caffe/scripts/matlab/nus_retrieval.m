function mAP = nus_retrieval(test_code, SAM, RECALL_NUM)
% function [prec, mAP, P_R] = nus_retrieval(test_code)
tic;
% SAM = load('sam.mat');
% RECALL_NUM = load('recall_num.mat');
test_num = length(RECALL_NUM);
test_size = size(test_code);
if ~ test_size(2) == test_num
    sprintf('Wrong size of test_code');
    return;
end
% number = [1 10 20 40 100 200 300 400 500 1000];
% node_num = length(number);
% M = test_num / category_num;
% prec = single(zeros(node_num, test_num));
mAP = single(zeros(1,test_num));
% P_R = single(zeros(test_num,M));
sim= test_code' * test_code;
[~, ix] = sort(sim, 'descend');
parfor i = 1 : test_num
%     [~, ix] = sort(distance(:,i), 'descend');
%     number = [1 10 20 40 100 200 300 400 500 1000];
%     temp_test_label = test_label;
%     test_id = temp_test_label(i);
    M = RECALL_NUM(i);
%     tempH = zeros(node_num,1);
%     temp_vote = zeros(test_num, 1);
    right_num = 0;
%     temp_pr = zeros(1,M);
    temp_ix = ix(:, i);
    sam = SAM(:, i);
    for j = 1 : test_num
        if sam( temp_ix(j) )
%             temp_vote(j) = 1;
            right_num = right_num + 1;
            mAP(i) = mAP(i) + right_num / j;
%             temp_pr(right_num) = right_num / j;
            if right_num == M
                break;
            end
        end
    end
    mAP(i) = mAP(i) / M;
    
%     for j = 1 : node_num
%         tempH(j) = mean( temp_vote( 1 : number(j) ) );
%     end    
%     prec(:,i) = tempH;
%     P_R(i,:) = temp_pr;
end
toc;
% prec = mean(prec, 2);
mAP = mean(mAP);
% P_R = mean(P_R);