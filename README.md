# 🌱 Smart Irrigation with tiny32_v5

[![Platform](https://img.shields.io/badge/platform-ESP32-green.svg)](https://www.espressif.com/en/products/socs/esp32)
[![Framework](https://img.shields.io/badge/framework-Arduino-blue.svg)](https://www.arduino.cc/)
[![PlatformIO](https://img.shields.io/badge/PlatformIO-5.0+-orange.svg)](https://platformio.org/)
[![Wokwi](https://img.shields.io/badge/simulator-Wokwi-purple.svg)](https://wokwi.com/)

A complete smart irrigation system template for **tiny32_v3** board development with VS Code and PlatformIO. This project includes hardware control, button debouncing, and Wokwi simulation support.

## 📋 Table of Contents

- [Features](#features)
- [Hardware Overview](#hardware-overview)
- [Circuit Diagram](#circuit-diagram)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Configuration](#configuration)
- [Wokwi Simulation](#wokwi-simulation)
- [Hardware Testing](#hardware-testing)
- [API Usage](#api-usage)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## ✨ Features

- 🎯 **Hardware Abstraction** - Easy-to-use API for tiny32_v3 board
- 🔘 **Button Debouncing** - Clean button press detection with edge detection
- 💡 **LED Control** - Built-in support for Red and Blue LEDs with blinking
- 🔊 **Buzzer Control** - Audio feedback with beep patterns
- 🔄 **Relay Control** - Switch external devices (pumps, valves, etc.)
- 🎮 **Multiple Input Types** - Push buttons and slide switch
- 🖥️ **Wokwi Simulation** - Test your code without hardware
- 📦 **PlatformIO** - Modern development environment
- 🛡️ **Watchdog Timer** - Automatic system recovery
- 🔧 **Modular Code** - Clean and maintainable structure

## 🔧 Hardware Overview

### tiny32_v3 Board Specifications

- **MCU**: ESP32 (Dual-Core, 240MHz)
- **Memory**: 320KB RAM, 4MB Flash
- **GPIO**: Multiple digital I/O pins
- **Communication**: RS485 (Modbus RTU) x2, UART, I2C, SPI
- **Connectivity**: WiFi, Bluetooth

### Connected Peripherals

| Component | GPIO Pin | Description |
|-----------|----------|-------------|
| **SW1** (Green Button) | GPIO 34 | Push button with debouncing |
| **SW2** (Red Button) | GPIO 35 | Push button with debouncing |
| **Slide Switch** | GPIO 36 (VP) | Toggle switch |
| **Blue LED** | GPIO 4 | Status indicator with 330Ω resistor |
| **Red LED** | GPIO 12 | Status indicator with 330Ω resistor |
| **Buzzer** | GPIO 13 | Audio feedback |
| **Relay** | GPIO 25 | Switch external devices (5V) |

### Pull-up Resistors

- SW1, SW2: 4.7kΩ pull-up to VCC
- Slide Switch: 4.7kΩ pull-up to VCC
- Buttons are active LOW (pressed = GND)

## 📐 Circuit Diagram

The project includes a complete Wokwi simulation diagram (`diagram.json`) with:

- ESP32 DevKit V1
- 2x Push buttons (SW1: Green, SW2: Red)
- 1x Slide switch
- 2x LEDs (Red, Blue) with 330Ω current-limiting resistors
- 1x Buzzer (10% volume)
- 1x Relay module (5V)
- Pull-up resistors (4.7kΩ)

See [diagram.json](diagram.json) for complete wiring details.

## 📦 Prerequisites

### Software Requirements

- **VS Code**: Latest version
- **PlatformIO IDE**: Extension for VS Code
- **Git**: For cloning repositories
- **Python**: 3.6+ (usually installed with PlatformIO)

### Optional (for simulation)

- **Wokwi VS Code Extension**: For circuit simulation

### Hardware Requirements (for physical testing)

- tiny32_v3 board
- USB cable (Type-C or Micro-USB depending on board version)
- Optional: External 5V power supply for relay

## 🚀 Installation

### Step 1: Clone the Repository

```bash
cd your_workspace
git clone https://github.com/tenergyinnovation/tiny32_v5_template_VsCode.git
cd tiny32_v5_template_VsCode
```

### Step 2: Install Required Libraries

#### Automatic Installation (Recommended)

**macOS/Linux:**
```bash
cd lib
chmod +x clone_repo.sh
./clone_repo.sh
```

**Windows:**
```cmd
cd lib
clone_repo.bat
```

Or double-click `clone_repo.bat` in Windows Explorer.

#### Manual Installation

See [lib/README.md](lib/README.md) for detailed manual installation instructions.

### Step 3: Open Project in VS Code

```bash
code .
```

Or: `File` → `Open Folder` → Select `tiny32_v5_template_VsCode`

### Step 4: Build the Project

Using PlatformIO toolbar or:

```bash
platformio run
```

## 🎯 Quick Start

### Basic Example (Default in main.cpp)

```cpp
#include <Arduino.h>
#include <tiny32_v3.h>
#include <esp_task_wdt.h>

tiny32_v3 mcu;

void setup() {
    Serial.begin(115200);
    
    // Configure watchdog timer (10 seconds)
    esp_task_wdt_init(10, true);
    esp_task_wdt_add(NULL);
    
    // Welcome beeps
    mcu.buzzer_beep(2);
}

void loop() {
    // Edge detection - triggers once per press
    if (mcu.Sw1()) {
        Serial.println("SW1 Pressed!");
        mcu.BlueLED(true);
        mcu.buzzer_beep(1);
        mcu.TickBlueLED(0.5);  // Blink at 0.5s interval
    }
    
    if (mcu.Sw2()) {
        Serial.println("SW2 Pressed!");
        mcu.RedLED(true);
        mcu.buzzer_beep(2);
        mcu.TickRedLED(0.5);   // Blink at 0.5s interval
    }
    
    // Reset watchdog timer
    esp_task_wdt_reset();
    vTaskDelay(100);
}
```

### Upload to Board

1. Connect your tiny32_v3 board via USB
2. Verify the correct port in `platformio.ini`:
   ```ini
   monitor_port = /dev/cu.usbserial-XXXXXX  ; Update this
   upload_port = /dev/cu.usbserial-XXXXXX   ; Update this
   ```
3. Upload:
   ```bash
   platformio run --target upload
   ```

### Monitor Serial Output

```bash
platformio device monitor
```

Or use the PlatformIO toolbar icon.

## 📁 Project Structure

```
tiny32_v5_template_VsCode/
├── README.md                    # This file
├── platformio.ini              # PlatformIO configuration
├── diagram.json                # Wokwi circuit diagram
├── wokwi.toml                  # Wokwi configuration
│
├── lib/                        # Libraries folder
│   ├── README.md              # Library installation guide
│   ├── clone_repo.sh          # Auto-install script (Mac/Linux)
│   ├── clone_repo.bat         # Auto-install script (Windows)
│   └── tiny32_v3/             # Main hardware library
│       ├── src/
│       │   ├── tiny32_v3.h
│       │   ├── tiny32_v3.cpp
│       │   └── Debounce/      # Button debouncing library
│       ├── examples/          # Example sketches
│       └── README.md
│
├── src/                        # Source code
│   └── main.cpp               # Main application code
│
├── include/                    # Header files (optional)
│   └── README
│
└── test/                       # Unit tests (optional)
    └── README
```

## ⚙️ Configuration

### PlatformIO Configuration (platformio.ini)

```ini
[env:nodemcu-32s]
platform = espressif32
board = nodemcu-32s
framework = arduino
monitor_speed = 115200

; Update these for your system
upload_port = /dev/cu.usbserial-111440
monitor_port = /dev/cu.usbserial-111440
```

### Watchdog Timer

Adjust timeout in `src/main.cpp`:

```cpp
#define WDT_TIMEOUT 10  // seconds
esp_task_wdt_init(WDT_TIMEOUT, true);
```

### Button Debounce Delay

Default: 50ms (configured in tiny32_v3 library)

To adjust, modify in `lib/tiny32_v3/src/tiny32_v3.cpp`:

```cpp
_sw1Debounce = new Debounce(SW1, 50, true); // Change 50 to desired ms
```

## 🖥️ Wokwi Simulation

### Run Simulation

1. Install **Wokwi for VS Code** extension
2. Press `F1` → `Wokwi: Start Simulator`
3. Or click the Wokwi icon in the toolbar

### Features in Simulation

- ✅ Interactive buttons and switches
- ✅ LED visual feedback
- ✅ Serial monitor output
- ✅ Real-time debugging
- ❌ Relay operation (visual only)
- ❌ Buzzer sound (not supported in Wokwi)

### Simulation Tips

- Click buttons for single press
- Use slide switch for continuous input
- Monitor Serial output in the terminal
- Watchdog timer works in simulation

## 🔬 Hardware Testing

### Initial Board Test

1. **Power LED Check**: Board should have power LED on
2. **Upload Test Code**: Use the default `main.cpp`
3. **Serial Monitor**: Should show startup messages
4. **Button Test**: Press SW1 and SW2
5. **LED Test**: Should light up when buttons pressed
6. **Buzzer Test**: Should beep on button press
7. **Relay Test**: LED on relay module should toggle

### Expected Behavior

| Action | Expected Result |
|--------|----------------|
| Power on | 2 beeps, startup message |
| Press SW1 | Blue LED on, 1 beep, LED blinks |
| Press SW2 | Red LED on, 2 beeps, LED blinks |
| Slide switch ON | Reports HIGH on GPIO 36 |
| Hold button | Only triggers once (debouncing works) |

## 💻 API Usage

### Button Functions

```cpp
// Edge detection (recommended for counting presses)
if (mcu.Sw1()) {
    // Triggered once per button press
    counter++;
}

// Continuous read (for hold actions)
if (mcu.Sw1_read()) {
    // True while button is held down
    performContinuousAction();
}
```

### LED Control

```cpp
// Direct control
mcu.BlueLED(true);   // Turn on
mcu.RedLED(false);   // Turn off

// Blinking
mcu.TickBlueLED(0.5);  // Blink every 0.5 seconds
mcu.TickRedLED(1.0);   // Blink every 1 second
mcu.TickBlueLED(0);    // Stop blinking, LED off
```

### Buzzer

```cpp
mcu.buzzer_beep(1);   // Beep once
mcu.buzzer_beep(3);   // Beep 3 times
```

### Relay

```cpp
mcu.Relay(true);   // Turn relay ON
mcu.Relay(false);  // Turn relay OFF
```

### Slide Switch

```cpp
if (mcu.Slid_sw()) {
    // Switch is ON
}
```

## 🐛 Troubleshooting

### Compilation Errors

**Problem**: `Debounce.h: No such file or directory`

**Solution**: Install libraries using scripts in `lib/` folder
```bash
cd lib
./clone_repo.sh  # or clone_repo.bat on Windows
```

---

**Problem**: `WDT timeout` error

**Solution**: Ensure `esp_task_wdt_reset()` is called regularly in `loop()`

### Upload Issues

**Problem**: Upload fails or device not found

**Solutions**:
1. Check USB cable (data cable, not charging-only)
2. Update upload_port in `platformio.ini`
3. Hold BOOT button while uploading (if required)
4. Check driver installation (CH340/CP2102)

### Button Not Working

**Problem**: Button triggers multiple times or doesn't work

**Solutions**:
1. Verify Debounce library is installed
2. Use `Sw1()` for edge detection, not `Sw1_read()`
3. Check wiring (buttons should connect to GND when pressed)
4. Increase debounce delay if needed

### Wokwi Simulation Issues

**Problem**: Simulation doesn't start

**Solutions**:
1. Install Wokwi for VS Code extension
2. Check `diagram.json` is valid
3. Restart VS Code
4. Check Wokwi extension logs

## 🎓 Learning Resources

### Official Documentation

- [tiny32_v3 Library](https://github.com/tenergyinnovation/tiny32_v3)
- [PlatformIO Docs](https://docs.platformio.org/)
- [ESP32 Arduino Core](https://docs.espressif.com/projects/arduino-esp32/)
- [Wokwi Simulator](https://docs.wokwi.com/)

### Example Projects

Check `lib/tiny32_v3/examples/` for more examples:
- LED and Buzzer control
- PWM generation
- Modbus RTU communication
- RS485 sensors
- OTA updates
- And 20+ more examples!

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## 📧 Support

- **Author**: Tenergy Innovation Co., Ltd.
- **Email**: uten.boonliam@tenergyinnovation.co.th
- **Website**: http://www.tenergyinnovation.co.th
- **Tel**: +66 89-140-7205
- **Repository**: https://github.com/tenergyinnovation/tiny32_v5_template_VsCode

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- **tiny32_v3 Library**: Tenergy Innovation Team
- **Debounce Library**: William Koch ([wkoch/Debounce](https://github.com/wkoch/Debounce))
- **ESP32 Arduino Core**: Espressif Systems
- **PlatformIO**: PlatformIO Labs
- **Wokwi**: Uri Shaked and the Wokwi team

---

**Version**: 0.1  
**Last Updated**: December 2025  
**Project Type**: Smart Irrigation Template  

Made with 💙 by Tenergy Innovation Co., Ltd.

---

## 🚀 Next Steps

After getting familiar with this template:

1. 📡 Add WiFi connectivity for remote monitoring
2. 🌡️ Integrate environmental sensors (temperature, humidity, soil moisture)
3. 💧 Connect water flow sensors
4. ⏰ Implement scheduling system
5. 📊 Add data logging (SD card or cloud)
6. 📱 Create mobile app integration
7. 🔋 Add battery backup system
8. 🌐 Implement MQTT or HTTP API

Happy Coding! 🌱💻✨
