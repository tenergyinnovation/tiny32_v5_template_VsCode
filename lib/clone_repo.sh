#!/bin/bash
# ==============================================================================
# 📦 Library Installation Script for tiny32_v5 Project
# ==============================================================================
# This script clones required libraries for the tiny32_v5 development
# ==============================================================================

# Color codes for pretty output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Define the repository URLs
REPO_URL_TINY32="https://github.com/tenergyinnovation/tiny32_v5.git"
REPO_URL_DEBOUNCE="https://github.com/wkoch/Debounce.git"

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║  🚀 Starting Library Installation for tiny32_v5 Project       ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# ==============================================================================
# Clone tiny32_v5 Library
# ==============================================================================
echo -e "${BLUE}📚 [1/2] Cloning tiny32_v5 library...${NC}"
echo "   Repository: $REPO_URL_TINY32"
echo ""

if [ -d "tiny32_v5" ]; then
    echo -e "${YELLOW}⚠️  Warning: tiny32_v5 directory already exists. Skipping...${NC}"
else
    git clone $REPO_URL_TINY32
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ tiny32_v5 library cloned successfully!${NC}"
    else
        echo -e "${RED}❌ Failed to clone tiny32_v5 library${NC}"
        exit 1
    fi
fi
echo ""

# ==============================================================================
# Clone Debounce Library
# ==============================================================================
echo -e "${BLUE}🎯 [2/2] Cloning Debounce library...${NC}"
echo "   Repository: $REPO_URL_DEBOUNCE"
echo "   Target: tiny32_v5/src/Debounce/"
echo ""

cd tiny32_v5/src || exit

if [ -d "Debounce" ]; then
    echo -e "${YELLOW}⚠️  Warning: Debounce directory already exists. Skipping...${NC}"
else
    git clone $REPO_URL_DEBOUNCE
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Debounce library cloned successfully!${NC}"
    else
        echo -e "${RED}❌ Failed to clone Debounce library${NC}"
        cd ../../
        exit 1
    fi
fi

cd ../../

# ==============================================================================
# Installation Complete
# ==============================================================================
echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║  🎉 Installation Complete! All libraries ready to use! 🎊    ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo -e "${GREEN}📦 Installed Libraries:${NC}"
echo "   ✨ tiny32_v5 - Main hardware library"
echo "   ✨ Debounce - Button debouncing library"
echo ""
echo -e "${GREEN}📝 Next Steps:${NC}"
echo "   1. Open your project in VS Code"
echo "   2. Build with PlatformIO: ${BLUE}platformio run${NC}"
echo "   3. Upload to board: ${BLUE}platformio run --target upload${NC}"
echo ""
echo "   Happy Coding! 💻✨"
echo ""


