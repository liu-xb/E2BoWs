function [prec, mAP, P_R] = retrieval_l2(test_code, test_label, category_num)
%function prec_H = query_H(cifar10_train_image,cifar10_train_label,...
 %                           cifar10_test_image,cifar10_test_label,net)

%[cifar10_trainH, cifar10_testH] = generate_feature(...
    %cifar10_train_image,cifar10_test_image,net);
tic;
% test_code = norm_code(test_code);
test_num = length(test_label);
number = [1 10 20 40 100 200 300 400 500 1000];
node_num = length(number);
M = test_num / category_num;
prec = single(zeros(node_num, test_num));
mAP = single(zeros(1,test_num));
P_R = single(zeros(test_num,M));
distance = test_code' * test_code;
[~, ix] = sort(distance, 'descend');
parfor i = 1 : test_num
%     [~, ix] = sort(distance(:,i), 'descend');
    number = [1 10 20 40 100 200 300 400 500 1000];
    temp_test_label = test_label;
    test_id = temp_test_label(i);
    tempH = zeros(node_num,1);
    temp_vote = zeros(test_num, 1);
    right_num = 0;
    temp_pr = zeros(1,M);
    temp_ix = ix(:, i);
    for j = 1 : test_num
        if test_id == temp_test_label(temp_ix(j))
            temp_vote(j) = 1;
            right_num = right_num + 1;
            mAP(i) = mAP(i) + right_num / j / M;
            temp_pr(right_num) = right_num / j;
            if right_num == M
                break;
            end
        end
    end
    
    for j = 1 : node_num
        tempH(j) = mean( temp_vote( 1 : number(j) ) );
    end    
    prec(:,i) = tempH;
    P_R(i,:) = temp_pr;
end
prec = mean(prec, 2);
mAP = mean(mAP);
P_R = mean(P_R);
toc;