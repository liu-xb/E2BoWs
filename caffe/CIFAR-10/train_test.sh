../build/tools/caffe train -solver solver.prototxt -weights googlenet_bn_stepsize_6400_iter_1200000.caffemodel -gpu 0
../build/tools/caffe train -solver solver_fc2conv.prototxt -weights snapshot/cifar10_iter_15000.caffemodel -gpu 0
../build/tools/my_extract_feature snapshot/cifar10_fc2conv_iter_15000.caffemodel train_val_fc2conv.prototxt codes10-l2-reduce,label cifar10-test-features.data,cifar10-test-label.data 1000 0
/usr/local/MATLAB/R2015b/bin//matlab -nodesktop -nosplash -nojvm -r "read_test_cifar10"
