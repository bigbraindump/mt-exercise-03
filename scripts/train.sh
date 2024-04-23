#! /bin/bash

scripts=$(dirname "$0")
base=$(realpath $scripts/..)

models=$base/models
data=$base/data
tools=$base/tools

mkdir -p $models

num_threads=4
device=""
epochs=40
log_interval=100
emsize=200
nhid=200
tied="--tied"

# dropouts
dropouts=(0 0.1 0.3 0.5 0.7)

for dropout in "${dropouts[@]}"; do
    echo "Training model with dropout $dropout"

    (cd $tools/pytorch-examples/word_language_model &&
        CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python main.py --data $data/grimm \
            --epochs $epochs \
            --log-interval $log_interval \
            --emsize $emsize --nhid $nhid --dropout $dropout --tied \
            --save $models/model_dropout_$dropout.pt --perplexities
    )

    echo "Model with dropout $dropout trained."
    echo "time taken for dropout $dropout: $SECONDS seconds"

done
