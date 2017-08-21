addpath(genpath('../scripts/matlab'));
testcode = read_code('cifar10-test-features.data',10000,100);
testlabel = read_code('cifar10-test-label.data',10000,1);
retrieval_cifar10_test(testcode,testlabel)
