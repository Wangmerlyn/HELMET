#!/bin/bash

# Check if the model path argument is provided
if [ -z "$1" ]; then
  echo "Error: No model path provided."
  echo "Usage: bash scripts/run_eval.sh <model_path>"
  exit 1
fi

# Store the model path in a variable
model_path=$1

# Extract the model name (last part of the path)
model_name=$(basename ${model_path})

# Run the 8k to 64k versions
for task in "recall" "rag" "longqa" "summ" "icl" "rerank" "cite"; do
    python eval.py --config configs/${task}.yaml --model_name_or_path ${model_path} --output_dir /mnt/longcontext/models/siyuan/HELMET/${model_name}
done

# Run the short versions
for task in "recall" "rag" "longqa" "summ" "icl" "rerank" "cite"; do
    python eval.py --config configs/${task}_short.yaml --model_name_or_path ${model_path} --output_dir /mnt/longcontext/models/siyuan/HELMET/${model_name}
done
