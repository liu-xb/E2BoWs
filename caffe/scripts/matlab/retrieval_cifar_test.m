function mAP = retrieval_cifar_test(test_code, test_label)
tic;

test_num = length(test_label);
category_num = length(unique(test_label));
M = test_num / category_num;
mAP = single(zeros(1,test_num));
feature_size = size(test_code);
if feature_size(1) == test_num
    test_code = test_code';
else
    if feature_size(2) ~= test_num
        sprintf('%s','error in size')
        mAP = 0;
        return 
    end
end
% test_code = norm_code(test_code);
sim = test_code' * test_code;
[~, ix] = sort(sim, 'descend');
parfor i = 1 : test_num
%     [~, ix] = sort(distance(:,i), 'descend');
    temp_test_label = test_label;
    test_id = temp_test_label(i);
    temp_vote = zeros(test_num, 1);
    right_num = 0;
    temp_ix = ix(:, i);
    for j = 1 : test_num
        if test_id == temp_test_label(temp_ix(j))
            temp_vote(j) = 1;
            right_num = right_num + 1;
            mAP(i) = mAP(i) + right_num / j / M;
            if right_num == M
                break;
            end
        end
    end
end
mAP = mean(mAP);
toc;