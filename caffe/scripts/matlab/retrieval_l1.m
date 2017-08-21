function mAP = retrieval_l1(train_code,train_label,...
    train_num, test_code, test_label, test_num)
tic;
% number = [1 10 20];
% node_num = length(number);
% M = 60;
% prec = single(zeros(node_num, test_num));
temp_check = size(train_code);
temp_check = temp_check(2);
if ~(temp_check==train_num)
    sprintf('!!!!!!!!!! WRONG input dim !!!!!!!!!!');
    return;
end
if ~(train_num == length(train_label))
    sprintf('EEOR: train_num != length( train_label )');
    return;
end
if ~(test_num == length(test_label))
    sprintf('EEOR: test_num != length( test_label )');
    return;
end
temp_check = size(test_code);
temp_check = temp_check(2);
if ~(temp_check == test_num)
    sprintf('!!!!!!!!!! WRONG input dim !!!!!!!!!!');
    return;
end
mAP = single(zeros(1,test_num));
% P_R = single(zeros(test_num,M));

% distance = train_code' * test_code;
parfor i = 1 : test_num
    distance = bsxfun(@minus, train_code, test_code(:,i));
    distance = sum(abs(distance));
    [~, ix] = sort(distance);
    test_id = test_label(i);
    M = sum(sum(train_label == test_id));
    M=1000;
    % tempH = zeros(node_num,1);
    % temp_vote = zeros(test_num, 1);
    right_num = 0;
    % temp_pr = zeros(1,M);
    for j = 1 : test_num
        if test_id == train_label(ix(j))
            % temp_vote(j)=1;
            right_num = right_num + 1;
            mAP(i) = mAP(i) + right_num / j;
            % temp_pr(right_num) = right_num / j;
            if right_num == M
                break;
            end
        end
    end
    mAP(i) = mAP(i) / M;
    % for j = 1 : node_num
    %     tempH(j) = mean( temp_vote( 1 : number(j) ) );
    % end    
    % prec(:,i) = tempH;
    % P_R(i,:) = temp_pr;
end
mAP = mean(mAP);
% P_R = mean(P_R);
% prec = mean(prec, 2);
toc;