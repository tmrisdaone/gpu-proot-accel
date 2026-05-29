# 🚀 GPU Proot Acceleration (Zink)

A lightweight utility to enable **GPU Acceleration** (OpenGL over Vulkan via Zink) inside `proot-distro` Ubuntu or `udroid` environments on Android.

## 🛠️ Why is this needed?
By default, Linux environments running via proot on Android use **software rendering** (llvmpipe), which is extremely slow for any GUI application, browser, or game. 

This tool leverages **Zink**, a Gallium driver that translates OpenGL calls to Vulkan. By mapping the host Android Vulkan ICD (usually `freedreno` for Adreno GPUs) into the proot container, you get hardware-accelerated OpenGL.

## 🚀 Quick Start

Run the installer directly from your Ubuntu proot terminal:

```bash
curl -Ls https://raw.githubusercontent.com/tmrisdaone/gpu-proot-accel/main/zink-accel.sh | bash
```

## ⚙️ How it Works

The script automates the following configuration:
1. **Dependency Install**: Installs `mesa-utils`, `libgl1-mesa-dri`, and `mesa-vulkan-drivers`.
2. **ICD Mapping**: Points the environment to the Android host's Vulkan ICD:
   - `/data/data/com.termux/files/usr/share/vulkan/icd.d/freedreno_icd.aarch64.json`
3. **Env Variable Injection**:
   - `GALLIUM_DRIVER=zink`
   - `MESA_LOADER_DRIVER_OVERRIDE=zink`
   - `VK_ICD_FILENAMES=[path_to_icd]`

## ✅ Verification

After running the script, verify that the GPU is being used by running:

```bash
glxinfo | grep "OpenGL renderer"
```

**Expected output:** You should see `Zink` or your GPU name (e.g., `Adreno`) instead of `llvmpipe`.

## 📋 Requirements

- **OS**: Android 13+ (Recommended for better Vulkan support).
- **Environment**: `proot-distro` (Ubuntu) or `udroid`.
- **Host**: Termux with `vulkan-loader` installed on the host side.

## 🤝 Contributing
Feel free to open an issue or submit a PR if you have updated ICD paths for different chipsets (Mali, etc.)!
