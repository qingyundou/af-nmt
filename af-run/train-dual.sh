#!/bin/bash
#$ -S /bin/bash

unset LD_PRELOAD # when run on the stack it has /usr/local/grid/agile/admin/cudadevice.so which will give core dumped
export PATH=/home/mifs/ytl28/anaconda3/bin/:$PATH

# export CUDA_VISIBLE_DEVICES=0 #note on nausicaa no.2 is no.0
export CUDA_VISIBLE_DEVICES=$X_SGE_CUDA_DEVICE
echo $CUDA_VISIBLE_DEVICES

# python 3.6 
# pytorch 1.1
source activate pt11-cuda9
# source activate pt12-cuda10

export PYTHONBIN=/home/mifs/ytl28/anaconda3/envs/pt11-cuda9/bin/python3
$PYTHONBIN /home/alta/BLTSpeaking/exp-ytl28/local-ytl/embedding-encdec-v9/train.py \
	--train_path_src lib/iwslt15-enfr/iwslt15_en_fr/train.tags.en-fr.en \
	--train_path_tgt lib/iwslt15-enfr/iwslt15_en_fr/train.tags.en-fr.en \
	--path_vocab_src lib/iwslt15-enfr/iwslt15_en_fr/dict.50k.en \
	--path_vocab_tgt lib/iwslt15-enfr/iwslt15_en_fr/dict.50k.en \
	--random_seed 16 \
	--embedding_size_enc 200 \
	--embedding_size_dec 200 \
	--hidden_size_enc 200 \
	--num_bilstm_enc 2 \
	--num_unilstm_enc 0 \
	--hidden_size_dec 200 \
	--num_unilstm_dec 4 \
	--hidden_size_att 10 \
	--hard_att False \
	--att_mode bilinear \
	--residual True \
	--hidden_size_shared 200 \
	--dropout 0.2 \
	--max_seq_len 64 \
	--batch_size 100 \
	--batch_first True \
	--eval_with_mask False \
	--scheduled_sampling False \
	--embedding_dropout 0.0 \
	--learning_rate 0.002 \
	--max_grad_norm 1.0 \
	--use_gpu True \
	--checkpoint_every 500 \
	--print_every 200 \
	--num_epochs 60 \
	--train_mode dual \
	--teacher_forcing_ratio 1.0 \
	--attention_loss_coeff 10.0 \
	--save models-v9enfr/dual-enen-v0001/ \

	# bahdanau / hybrid
	# --train_path_src lib/iwslt15-enfr/iwslt15_en_fr/train.tags.en-fr.en \
	# --train_path_tgt lib/iwslt15-enfr/iwslt15_en_fr/train.tags.en-fr.fr \
	# --path_vocab_src lib/iwslt15-enfr/iwslt15_en_fr/dict.50k.en \
	# --path_vocab_tgt lib/iwslt15-enfr/iwslt15_en_fr/dict.50k.fr \
























