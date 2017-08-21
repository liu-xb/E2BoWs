% function [prec, mAP, P_R] = retrieval_l2_2(train_code,train_label, train_num, ...
%                            test_code, test_label, test_num)
function mAP = retrieval_l2_2(train_code,train_label, ...
                           test_code, test_label)
% number = [1 10 20];
% node_num = length(number);
cat_num = length(unique(test_label));
train_num = length(train_label);
test_num = length(test_label);
% M = train_num / cat_num;
% prec = single(zeros(node_num, test_num));
mAP = single(zeros(1,test_num));
% P_R = single(zeros(test_num,M));

tic;
% train_code = norm_code(train_code);
% test_code = norm_code(test_code);
distance = train_code' * test_code;
for i = 1 : test_num
    [~, ix] = sort(distance(:,i), 'descend');
    test_id = test_label(i);
    M = sum(train_label==test_id);
%     tempH = zeros(node_num,1);
%     temp_vote = zeros(test_num, 1);
    right_num = 0;
%     temp_pr = zeros(1,M);
    for j = 1 : train_num
        if test_id == train_label(ix(j))
%             temp_vote(j)=1;
            right_num = right_num + 1;
            mAP(i) = mAP(i) + right_num / j / M;
%             temp_pr(right_num) = right_num / j;
            if right_num == M
                break;
            end
        end
    end
    
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