#!/bin/bash
# Zink acceleration script for Proot-Ubuntu/udroid
# Maps Android Vulkan drivers to provide OpenGL via Zink

echo "🚀 Initializing Zink GPU Acceleration..."

# 1. Install required packages
apt update
apt install -y mesa-utils libgl1-mesa-dri mesa-vulkan-drivers

# 2. Configure Vulkan ICD Path
# Standard Android Vulkan ICD location in Termux
VK_ICD_PATH="/data/data/com.termux/files/usr/share/vulkan/icd.d/freedreno_icd.aarch64.json"

if [ ! -f "$VK_ICD_PATH" ]; then
    echo "⚠️  Vulkan ICD not found at $VK_ICD_PATH"
    echo "Check if vulkan-loader is installed in Termux."
fi

# 3. Set environment variables
export GALLIUM_DRIVER=zink
export VK_ICD_FILENAMES=$VK_ICD_PATH
export MESA_LOADER_DRIVER_OVERRIDE=zink

echo "✅ Environment configured."
echo "Run 'glxinfo | grep OpenGL' to verify acceleration."
echo "---------------------------------------------------"
glxinfo | grep "OpenGL renderer"
