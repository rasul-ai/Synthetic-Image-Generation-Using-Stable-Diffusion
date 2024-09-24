#!/bin/bash
#SBATCH --job-name=Stable_Diffusion
#SBATCH --output=%j_output.txt
#SBATCH --error=%j_error.txt
#SBATCH --ntasks=1              # Number of tasks (usually = 1 for GPU jobs)
#SBATCH --cpus-per-task=8       # Number of CPU cores per task
#SBATCH --gres=gpu:1            # Request 1 GPU
#SBATCH --mem=48G               # Memory requested (48GB in this case)
#SBATCH --time=7-00:00:00       # Maximum time requested (7 days)
#SBATCH --partition=long



# conda activate /network/scratch/i/islamria/qcontrol/Diffusion/generativeai

# export HF_HOME=/network/scratch/i/islamria/qcontrol/Diffusion/generativeai

# export model="CompVis/stable-diffusion-v1-4"
# export train_dir="/network/scratch/i/islamria/qcontrol/Diffusion/codes/gen_train"
# export train_dir="/network/scratch/i/islamria/qcontrol/Diffusion/codes/joggers"

accelerate launch --mixed_precision="fp16" train_text_to_image.py \
  --pretrained_model_name_or_path=$model \
  --train_data_dir=$train_dir \
  --use_ema \
  --checkpoints_total_limit=2 \
  --resolution=512 --random_flip \
  --train_batch_size=1 \
  --gradient_accumulation_steps=4 \
  --gradient_checkpointing \
  --max_train_steps=3000 \
  --learning_rate=1e-05 \
  --max_grad_norm=1 \
  --lr_scheduler="constant" --lr_warmup_steps=0 \
  --output_dir="joggers_3_3000"


  # --center_crop
  # --resume_from_checkpoint="/network/scratch/i/islamria/qcontrol/Diffusion/diffusers/examples/text_to_image/model_5_11/checkpoint-3500" \