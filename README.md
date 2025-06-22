<img align="right" src="https://visitor-badge.laobi.icu/badge?page_id=platima.sbcimages" height="20" />

# Table of Contents
1. [Radxa Images](#radxa)
2. [Luckfox Images](#luckfox)
3. [Orange Pi Images](#orange-pi)

Apologies not all files have checksums. I get lazy, or forget. Either/or.
# Changes

## Radxa
**2025-06-03**
- Updated [Rock 3A MainsailOS 1.3.2 based on Armbian Bookworm current minimal 6.1](Radxa/Rock%203A/MainsailOS) image to fix install issues.

**2025-05-30**
- Added [Rock 3A MainsailOS 1.3.2 based on Armbian Bookworm current minimal 6.1](Radxa/Rock%203A/MainsailOS) image. Testing today.
- Minor structure cleanup

**2025-04-01**
- Added [Zero 3 rsdk Debian Bookworm CLI](Radxa/Zero%203/rsdk) image.
- Added [Zero 3 rsdk Debian Bookworm XFCE](Radxa/Zero%203/rsdk) image.
- Added [Zero 3 Armbian Unofficial 24.5 trunk Bookworm legacy 5.10 XFCE desktop](Radxa/Zero%203/Armbian/bookworm%20legcy%20desktop%20xfce) image. Untested as per [notes.md](Radxa/Zero%203/Armbian/bookworm%20legacy%20desktop%20xfce/notes.md) in that folder.
- Added [Zero 3 Armbian Unofficial 24.5 trunk Bookworm vendor 6.1 XFCE desktop](Radxa/Zero%203/Armbian/bookworm%20vendor%20desktop%20xfce) image. Untested as per [notes.md](Radxa/Zero%203/Armbian/bookworm%20vendor%20desktop%20xfce/notes.md) in that folder.
- Added [Zero 3 Armbian Unofficial 24.5 trunk Sid legacy 5.10 XFCE desktop](Radxa/Zero%203/Armbian/sid%20legacy%20desktop%20xfce) image. Untested as per [notes.md](Radxa/Zero%203/Armbian/bookworm%20legacy%20desktop%20xfce/notes.md) in that folder.
- Added [Zero 3 Armbian Unofficial 24.5 trunk Sid vendor 6.1 XFCE desktop](Radxa/Zero%203/Armbian/sid%20vendir%20desktop%20xfce) image. Untested as per [notes.md](Radxa/Zero%203/Armbian/bookworm%20vendor%20desktop%20xfce/notes.md) in that folder.
- Added [rk356x_spl_loader_ddr1056_v1.10.111.bin](Radxa/Zero%203/rk356x_spl_loader_ddr1056_v1.10.111.bin) for flashing this model with RkDevTool. Note, same as some other binaries, but just keeping it nearby as it's tiny anyway

**2024-11-24**
- Added [Rock 4 SE Armbian unofficial 24.11 trunk Bookworm current 6.6 CLI](Radxa/Rock%204%20SE/Armbian/bookworm%20current%20cli) for the below MainsailOS image.
- Added [Rock 4 SE MainsailOS 1.3.2 images based on Armbian Bookworm current CLI](Radxa/Rock%204%20SE/MainsailOS) from above, as covered in [this video](https://www.youtube.com/watch?v=-j_Q4sIfp40).

**2024-05-04**
- Added [RKDevTool_Release_v2.96_en.zip][Radxa/RKDevTool_Release_v2.96_en.zip] for ease of access.

**2024-04-01**
- Added [Rock 3A Armbian Unofficial 24.5 trunk Bookworm legacy 5.10 XFCE desktop](Radxa/Rock%203A/Armbian/bookworm%20legcy%20desktop%20xfce) image. Untested as per [notes.md](Radxa/Rock%203A/Armbian/bookworm%20legacy%20desktop%20xfce/notes.md) in that folder.
- Added [Rock 3A Armbian Unofficial 24.5 trunk Bookworm vendor 6.1 XFCE desktop](Radxa/Rock%203A/Armbian/bookworm%20vendor%20desktop%20xfce) image. Untested as per [notes.md](Radxa/Rock%203A/Armbian/bookworm%20legacy%20desktop%20xfce/notes.md) in that folder.
- Added [Rock 3A Armbian Unofficial 24.5 trunk Sid legacy 5.10 XFCE desktop](Radxa/Rock%203A/Armbian/sid%20legacy%20desktop%20xfce) image. Untested as pery [notes.md](Radxa/Rock%203A/Armbian/bookworm%20legacy%20desktop%20xfce/notes.md) in that folder.
- Added [Rock 3A Armbian Unofficial 24.5 trunk Sid vendor 6.1 XFCE desktop](Radxa/Rock%203A/Armbian/sid%20vendir%20desktop%20xfce) image. Tested and used for over a year now by me (as at 2025-05-31).

**2024-03-31**
- Added [rk356x_spl_loader_ddr1056_v1.10.111.bin](Radxa/Rock%203A/rk356x_spl_loader_ddr1056_v1.10.111.bin) to the Rock 3A folder for flashing this model with RkDevTool.

### Legacy Images
**NOTE:** This is relevant for images uploaded 2024-04 and earlier

At the time of writing (2024-04-01) the Radxa images for the Rock 3A and Zero 3W have a number of problems, namely;
 - Wifi needs 2.4GHz WPA2 to work
 - Locales and terminfo appear missing
 - GL is 3.1 Mesa 20.3.5 by Mesa
 - Based on Debian 11
 - Kernel is 5.10
 - Other annoyances such as packages I want not there

So I built an Armbian build using the Zero 3 WIP file, and it worked really bloody well, thus I decided to share them. Using [RKDevTool v2.96](https://github.com/platima/sbc-images/blob/main/Radxa/RKDevTool_Release_v2.96_en.zip) and [this loader](https://github.com/platima/sbc-images/blob/main/Radxa/Zero%203W/rk356x_spl_loader_ddr1056_v1.10.111.bin) worked a treat on both boards so far.

These are not perfect, and probably need fixes, but I like them. Starting with these Radxa images, I'm going to start adding all of my custom images here.

Packages I added:
 - libglx-mesa0
 - libgl1-mesa-dri
 - mesa-utils
 - mesa-utils-extra
 - vlc
 - glmark2-x11
 - net-tools
 - screen
 - vim
 - neofetch
 - chromium

## Orange Pi
These are MainsailOS

**2025-05-16**
- Added [5B MainsailOS 1.3.2 images based on Armbian 24.8 Jammy current 6.10](Orange%20Pi/5B/MainsailOS) which should work but are untested as per the [README.md](Orange%20Pi/5B/MainsailOS/README.md) in that folder.

**2023-05-12**
- Added [5B MainsailOS 1.3.2 images based on Armbian 24.8 Bookworm vendor 6.1](Orange%20Pi/5B/MainsailOS) which appeared to work but with Wi-Fi issues as per [README.md](Orange%20Pi/5B/MainsailOS/README.md) in that folder.
- Added [MiniLoader files](Orange%20Pi/Tools/MiniLoader), [RKDevTool_Release_v3.15.zip](Orange%20Pi/Tools/RKDevTool_Release_v3.15.zip) and [DriverAssitant_v5.12.zip](Orange%20Pi/Tools/DriverAssitant_v5.12.zip).
- Added [OrangePi_5B_RK3588S_User Manual_v1.5.1.pdf](Orange%20Pi/5B/OrangePi_5B_RK3588S_User%20Manual_v1.5.1.pdf).

## Luckfox
This repository contains SD card images for various configurations of the Luckfox Lyra development board, including both Buildroot and Ubuntu-based systems.

These are built from the downloads available at the time, and have matching filenames, but do not require special software to image the TF/SD card with.

**Last Updated:** 2024-06
**2025-05 Notes:** I know, I need to cut some new SD card images. I have built them, just not converted to SD format yet.

### Lyra (Base Model)
- Buildroot-based:
  - `Luckfox_Lyra_MicroSD_241230.img.bz2`
  - `Luckfox_Lyra_MicroSD_241230.img.sha256`
- Ubuntu-based:
  - `Luckfox_Lyra_Ubuntu_MicroSD_241230.img.bz2`
  - `Luckfox_Lyra_Ubuntu_MicroSD_241230.img.sha256`

### Lyra Plus
- Buildroot-based:
  - `Luckfox_Lyra_Plus_MicroSD_241230.img.bz2`
  - `Luckfox_Lyra_Plus_MicroSD_241230.img.sha256`
- Ubuntu-based:
  - `Luckfox_Lyra_Plus_Ubuntu_MicroSD_241230.img.bz2`
  - `Luckfox_Lyra_Plus_Ubuntu_MicroSD_241230.img.sha256`

### Usage

1. Download the appropriate image for your Luckfox Lyra board
2. Verify the SHA256 checksum of the uncompressed image using the provided .sha256 file
3. Extract the .bz2 file
4. Flash the image to your microSD card

### Verification

To verify your download after extraction:
```bash
sha256sum -c Luckfox_Lyra_MicroSD_241230.img.sha256
```

### Image Details

- Buildroot images provide a minimal, fast-booting system optimized for embedded applications
- Ubuntu images offer a fuller glibc environment with additional packages and development tools

### Flashing Instructions
#### Linux/macOS
```bunzip2 Luckfox_Lyra_MicroSD_241230.img.bz2
sudo dd if=Luckfox_Lyra_MicroSD_241230.img of=/dev/sdX bs=4M status=progress
```

Replace /dev/sdX with your SD card device (can be found using lsblk command).

#### Windows
Use Balena Etcher.

### Warning
Always verify you're using the correct device path before flashing. Using the wrong device path can result in data loss.

### Expanding Root Partition

After flashing, you may want to expand the root partition to use the full SD card space. You can do this using the provided Python script:

```bash
# Download the expansion script
wget https://raw.githubusercontent.com/[your-repo]/expand_partition.py

# Make it executable
chmod +x expand_partition.py

# Run as root (replace mmcblk0 with your device)
sudo ./expand_partition.py /dev/mmcblk0

# Update kernel partition table
sudo partx -u /dev/mmcblk0

# Expand the filesystem
sudo resize2fs /dev/mmcblk0p3
```

Note: If you're running this on the Lyra board itself, the device will typically be /dev/mmcblk0. If you're preparing the card on a PC with a card reader, the device might be something like /dev/sdX.

### Safety Checks
Before running the expansion:
1. Verify your device path using lsblk
2. Ensure you have a backup of important data
3. Make sure you're expanding the correct partition (usually partition 3)
