# Synthetic-Image-Generation-Using-Stable-Diffusion
## Overview
I have created this project to focus on generating synthetic images using a text-to-image model based on stable diffusion techniques. The model allows users to input descriptive text and generate corresponding images, simulating real-world scenarios or artistic visuals.
## Directory Structure
The folder structure for the project is as follows:
```
Diffusion/
│
├── dataset/
├── Generated_sample/
├── text_to_image/
    ├── data_format.py
    ├── inference.py
    ├── job.sh
    ├── job_5256095.txt
    ├── train_text_to_image.py
```

### 1. `dataset`
This directory contains three images and a `metadata.jsonl` file. Each image represents a pair of denim jeans laid flat on a white background. The JSONL file contains metadata for each image, including the file name and a detailed description of the image content. I have used these descriptions for training the text-to-image model.

Example entries in `metadata.jsonl`:

```json
{
  "file_name": "11 (3).JPG",
  "text": "A single pair of denim jeans laid flat on a white background, viewed from the back. The jeans have a slightly faded appearance with visible back pockets. The legs are spread apart with natural creases, and the back rise area is clearly visible. A small black square reference marker is placed near the upper right corner of the image."
}
```

### 2. `Generated_sample`

This folder stores the synthetic images generated by the trained model. After running the `inference.py` script, this directory was populated with images based on the text prompts provided.

### 3. `text_to_image`

This folder contains the primary code for training and inferring the model.

- **data_format.py**: This script handles the file format to fine tuning stable diffusion model. It created a metadata.jsonl file.
  
- **inference.py**: This script handles the inference process for generating images from text. It takes in a textual prompt and outputs an image that represents the prompt.

- **job.sh**: This is a shell script which I used to submit a job to a computing cluster (likely for large-scale training) to automate some steps in the model training/inference process. (This is optional. I haved used this to run my code in a cluster.)

- **job_5256095.txt**: This is a output file created when the job run on the system. It contains error logs, output results, or training progress.(This is optional. I haved used this to run my code in a cluster.)

- **train_text_to_image.py**: This script handles the training of the text-to-image diffusion model. It leverages a dataset of text-image pairs to fine-tune a model capable of synthesizing images from new text prompts.

## How to Use
To successfully fine tune stable diffusion model using `train_text_to_image.py` script, I have done these things given below,
I have cloned a github repository and change the directory to diffusers.
```bash
git clone https://github.com/huggingface/diffusers
cd diffusers
pip install .
```
Then cd in the example folder and run
```
pip install -r requirements.txt
```
After that I initialized an environment with,
```
accelerate config
```
Then I have accepted the model license before downloading or using the weights. In this example I have used model version v1-4.
I have used an access token for the code to work. To do that, I have registered an account on Huggingface Hub.

I have run this command to authenticate my token,
```
huggingface-cli login
```
To run with my own training files, I prepared the dataset according to the format required by datasets. The format is given in the dataset folder.
Then I have run this script to finally fine tune the stable diffusion model with my own dataset.
```
export MODEL_NAME="CompVis/stable-diffusion-v1-4"
export TRAIN_DIR="path_to_the_dataset"

accelerate launch --mixed_precision="fp16" train_text_to_image.py \
  --pretrained_model_name_or_path=$MODEL_NAME \
  --train_data_dir=$TRAIN_DIR \
  --use_ema \
  --resolution=512 --center_crop --random_flip \
  --train_batch_size=1 \
  --gradient_accumulation_steps=4 \
  --gradient_checkpointing \
  --max_train_steps=15000 \
  --learning_rate=1e-05 \
  --max_grad_norm=1 \
  --lr_scheduler="constant" --lr_warmup_steps=0 \
  --output_dir="my_diffusion_model"
```

