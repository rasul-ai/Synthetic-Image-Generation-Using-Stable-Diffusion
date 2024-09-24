import torch
from diffusers.pipelines.stable_diffusion.pipeline_stable_diffusion import StableDiffusionPipeline

# Load the Stable Diffusion model
model_path = "model_path"
pipe = StableDiffusionPipeline.from_pretrained(model_path, torch_dtype=torch.float16)
pipe.to("cuda")

sample = 240
# Loop to generate 10 images
for i in range(1,sample+1):
    image = pipe(prompt="A single pair of denim jeans laid flat on a white background, viewed from the back. The jeans have a slightly faded appearance with visible back pockets. The legs are spread apart with natural creases, and the back rise area is clearly visible. A small black square reference marker is placed near the upper right corner of the image.", height=512, width=512).images[0]
    image.save(f"./Diffusion/Generated_image/{i}.png")

print("Generation complete.")