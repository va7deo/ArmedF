
# Nichibutsu M68000 (Armed F) FPGA Implementation

FPGA compatible core of Nichibutsu M68000 (Terra Force Based) arcade hardware for [**MiSTerFPGA**](https://github.com/MiSTer-devel/Main_MiSTer/wiki) written by [**Darren Olafson**](https://twitter.com/Darren__O). Terra Force PCB (different board revisions) donated by [**@atrac17**](https://twitter.com/_atrac17) / [**@djhardrich**](https://twitter.com/djhardrich).

The intent is for this core to be a 1:1 implementation of the Nichibutsu (Terra Force based) 68000 hardware. Currently in an beta state, this core is in active development with assistance from [**atrac17**](https://github.com/atrac17).

<br>
<img width="" height="" src="https://user-images.githubusercontent.com/32810066/170655863-5b1418f1-1020-46f6-9e72-6ad08ec96b49.png">
<br>

## Supported Games

| Title | Status | Released | Protection | Unprotected Sets |
|------|---------|----------|------------|------------------|
[**Terra Force**](https://en.wikipedia.org/wiki/Nihon_Bussan)           | Implemented   | **terraf, terrfj, terrafu**         | NB1414M4 | **terrafjb, terrafb**   |
[**Kozure Ōkami**](https://en.wikipedia.org/wiki/Nihon_Bussan)          | Implemented   | **kozure**                          | NB1414M4 | N/A                     |
[**Chouji Meikyuu Legion**](https://en.wikipedia.org/wiki/Nihon_Bussan) | Implemented   | **legion, legionj2**                | NB1414M4 | **legionjb, legionjb2** |
[**Crazy Climber 2**](https://en.wikipedia.org/wiki/Nihon_Bussan)       | Implemented   | **cclimbr2, cclimbr2a**             | NB1414M4 | N/A                     |
[**Armed F**](https://en.wikipedia.org/wiki/Formation_Armed_F)          | Implemented   | **armedf, armedff**                 | None     | N/A                     |
[**Tatakae! Big Fighter**](https://en.wikipedia.org/wiki/Nihon_Bussan)  | Pending       | N                                   | i8751    | N/A                     |

## External Modules

|Name| Purpose | Author |
|----|---------|--------|
| [**fx68k**](https://github.com/ijor/fx68k)                                                   | [**Motorola 68000 CPU**](https://en.wikipedia.org/wiki/Motorola_68000) | Jorge Cwik                    |
| [**t80**](https://opencores.org/projects/t80)                                                | [**Zilog Z80 CPU**](https://en.wikipedia.org/wiki/Zilog_Z80)           | Daniel Wallner                |
| [**jtopl2**](https://github.com/jotego/jtopl)                                                | [**Yamaha OPL 2**](https://en.wikipedia.org/wiki/Yamaha_OPL#OPL2)      | Jose Tejada                   |
| [**jt8751**](https://github.com/jotego/jtframe/blob/master/hdl/cpu/jtframe_8751mcu.v)        | [**Intel 8751**](https://en.wikipedia.org/wiki/Intel_8051)             | Oregano Systems / Jose Tejada |

# Known Issues / Tasks

- ~~Clock domains need to be verified~~  
- ~~Sprite Handling for 6MHz pxl clk and sdram memory controller~~  
- ~~Player 2 controls tied to screen flip/table mode~~  
- ~~Implement keyboard handler / service menu~~  
- ~~Dot Crawl on Y/C video output~~  
- ~~Y/C video output~~  
- ~~Sprite size adjusted per PCB~~  
- ~~Scroll implementation - **Terra Force (Japan, bootleg set 2)**~~  
- ~~Layer alignment per PCB~~  
- ~~Sprite alignment per PCB~~  
- ~~Individual Text Layer **NB1414M4** implementation~~  
- ~~Text Layer **NB1414M4** implementation~~  
- ~~Scroll handling done by **NB1414M4**~~  
- Protection MCU i8571 implementation (**Tatakae! Big Fighter**)    
- Protection Chip **NB1414M4** reverse engineer  
- Service Menu Text Layer **NB1414M4**  
- Layer priority - **Chouji Meikyuu Legion (Japan ver 1.05) [legionj, legionjb]**  
- Add turbo OSD toggle for overclocking **Chouji Meikyuu Legion**  
- H/V clock timings for CRT need to be verified  
- Screen Flip implementation  
- Shared memory between fx68k and jt8751  
- Reverse engineer Terra Force and provide schematics  
- Audio issues known, may be an issue with the jtopl2 core or the current usage<br>(No need to report further audio issues)

# PCB Check List

FPGA implementation is based on Terra Force and will be verified against an authentic Nichibutsu U.S.A Terra Force PCB and bootleg PCB.

Reverse engineering of an authentic Terra Force PCB will be done by [**Darren Olafson**](https://twitter.com/Darren__O) and schematics will be included in the repository.

### Clock Information

H-Sync      | V-Sync      | Source                                   |
------------|-------------|------------------------------------------|
15.51kHz    | 59.092993Hz | [DSLogic +](https://www.is.gd/AFLNoI)    |

### Crystal Oscillators

Location           | Freq (MHz) | Use          |
-------------------|------------|--------------|
C1 (Top Board)     | 16.000     | M68000       |
F1 (Bottom Board)  | 24.000     | Z80 / YM3812 |

**Pixel clock:** 6.00 MHz

**Estimated geometry:**

_(Terra Force, Kozure Ōkami, Armed F, Tatakae! Big Fighter)_

    387 pixels/line
  
    262 pixels/line

_(Chouji Meikyuu Legion, Crazy Climber 2)_

    352 pixels/line
  
    248 pixels/line

### Main Components

Location | Chip | Use |
---------|------|-----|
D1  (Top Board)      | [**Motorola 68000 CPU**](https://en.wikipedia.org/wiki/Motorola_68000)   | Main CPU                                  |
H17 (Bottom Board)   | [**Zilog Z80 CPU**](https://en.wikipedia.org/wiki/Zilog_Z80)             | Sound CPU                                 |
K15 (Bottom Board)   | [**Yamaha YM3812**](https://en.wikipedia.org/wiki/Yamaha_OPL#OPL2)       | OPL2                                      |
D1  (Daughter Board) | [**Intel 8751**](https://en.wikipedia.org/wiki/Intel_8051)               | Protection MCU **(Tatakae! Big Fighter)** |

### Nichibutsu Custom Components

| Location | Chip | Use | PCB | ROM set |
|----------|-----|------|-----|---------|
A9  (Top Board) | [**NB1414M4**](https://raw.githubusercontent.com/va7deo/TerraForce/main/doc/Terra%20Force%2026494/Terra%20Force%2026494%20Front.jpg?token=GHSAT0AAAAAABKJR6W6CVBT5FROK2UKF75KYTXT2BA) | Protection IC | <u>**Chouji Meikyuu Legion**</u> <br><br> <u>**Terra Force**</u> <br><br> <u>**Kozure Ōkami**</u> <br><br> <u>**Crazy Climber 2**</u> | **legion, legionj, legionj2** <br><br> **terraf, terrafu, terrafj** <br><br> **kozure** <br><br> **cclimbr2, cclimbr2a** |

# PCB Features

### Debugging Menu

|<p align="center">Game Debugging|
|:---:|
|<table><tr><th>Chouji Meikyuu<br>Legion</th><th>Debugging Features [legion, legionj, legionjb]</th></tr><tr><td><img src="https://user-images.githubusercontent.com/32810066/173247174-3ff281fe-89b1-4bae-8340-8e482c5d92b8.png"></img></td><td><p align="left">Chouji Meikyuu Legion has hidden debug dipswitches by enabling offsets at 0x000488 and 0x0001d6.<br><br>This enables P1 and P2 Invunerability and the ability to overclock the games framerate by holding the<br> 2P Start Bttn.<br><br>The dipswitch information was taken from mame, the overclocked framerate was discovered during<br> core development.<br><br>These features are enabled in the MRA's for the corresponding sets.</p></td></table>

<br>

A hidden debug menu can be accessed for **Terra Force, Kozure Ōkami, Chouji Meikyuu Legion, Crazy Climber 2 and Armed F**.  For more information on each debugging menu per game visit "[**The Cutting Room Floor**](https://tcrf.net/Category:Games_developed_by_Nichibutsu)".<br><br>**Tatakae! Big Fighter** has debug options set via dipswitches. Each debug menu has different features to display Character, Object, Scoll, Foreground, Background, or Priority tests.

**Follow these steps to access the debug menu (OSD or Keyboard):** 

> - Turn on **Service Menu** in the debug OSD options or press **F2**. Then turn on **Debug Menu** or press and hold **R**, **A**, **S**. For **Crazy Climber 2** press and hold  **Up**, **LCtrl**, **Spacebar**.<br><br>
> - Toggle the **Service Menu** option off; then toggle **Debug Menu** off in the OSD or keep those corresponding keys held and press **F2**.<br><br>
> - To utilize the OSD method for accessing the Debug Method do the following, **Pause when OSD is open: Off**.

<br>

| **Armed F Debugging Menu** |
|:--:|
|<table> <tr><th>Character Graphics ROM</th><th>Object Graphics ROM</th><th>Vertical Scroll Test</th></tr><tr><td>![1](https://user-images.githubusercontent.com/32810066/173248139-b60228f0-c0c0-4768-bf28-b26bbc9271c9.png)</td><td> ![2](https://user-images.githubusercontent.com/32810066/173248152-41b9cffb-4221-42cd-9bc5-dff1472d97ea.png)</td><td>![3](https://user-images.githubusercontent.com/32810066/173248161-5b8db7e2-efbd-4f8d-8075-5ef066c49e2c.png)</td></tr></table> |

| **Chouji Meikyuu Legion Debugging Menu** |
|:--:|
|<table> <tr><th>Character Graphics ROM</th><th>Object Graphics ROM</th><th>Vertical Scroll Test</th><th>Foreground /<br> Background Bank Test</th></tr><tr><td>![1](https://user-images.githubusercontent.com/32810066/173248203-f99d7ff8-7389-40c3-a0c4-10ee5f9d6b1f.png)</td><td>![2](https://user-images.githubusercontent.com/32810066/173248211-7d8140a0-9e0e-464c-a009-c0256f89866a.png)</td><td>![3](https://user-images.githubusercontent.com/32810066/173248215-70b78879-2097-495b-8c4c-f22967f69a09.png)</td><td>![4](https://user-images.githubusercontent.com/32810066/173248218-66228428-41ef-461c-b37b-22c8a0bfd0d1.png)</td></tr></table> |

| **Crazy Climber 2 Debugging Menu** |
|:--:|
|<table> <tr><th>Character Graphics ROM</th><th>Object Graphics ROM</th><th>Vertical Scroll Test</th></tr><tr><td>![1](https://user-images.githubusercontent.com/32810066/173248250-d7e25b6b-7859-4a03-a3ee-a934dfd12cec.png)</td><td> ![2](https://user-images.githubusercontent.com/32810066/173248252-99b5a7a7-a3e7-4216-9657-12f8b3db58bb.png)</td><td>![3](https://user-images.githubusercontent.com/32810066/173248253-1d69d607-7058-49bc-a399-4508d461e543.png)</td></tr></table> |

| **Kozure Ōkami Debugging Menu** |
|:--:|
|<table> <tr><th>Character Graphics ROM</th><th>Object Graphics ROM</th><th>Basic Stage Viewer</th><th>Sprite Priority Test</th></tr><tr><td>![1](https://user-images.githubusercontent.com/32810066/173248334-143ce6d1-0d43-40bf-acfe-333f32bb0059.png)</td><td>![2](https://user-images.githubusercontent.com/32810066/173248338-578e49ec-1836-4752-9dea-04aef77b6ecc.png)</td><td>![3](https://user-images.githubusercontent.com/32810066/173248342-f01e2f65-2c6d-4a09-953f-55899a51bb25.png)</td><td>![4](https://user-images.githubusercontent.com/32810066/173248343-1e6e2017-2117-4abd-bf2e-98cf3f9efb07.png)</td></tr></table> |

| **Terra Force Debugging Menu** |
|:--:|
|<table> <tr><th>Character Graphics ROM</th><th>Object Graphics ROM</th><th>Vertical Scroll Test</th></tr><tr><td>![1](https://user-images.githubusercontent.com/32810066/173248409-739f7414-1fad-43f1-9b66-21c0a6d5ec81.png)</td><td> ![2](https://user-images.githubusercontent.com/32810066/173248419-2a24c5ad-5935-4fa4-b8b6-773e2ec8be8e.png)</td><td>![3](https://user-images.githubusercontent.com/32810066/173248424-2f6e6ff2-976c-4f30-98fb-ae5fe2493e11.png)</td></tr></table> |

<br>

### GFX Layer Toggle

The four graphical layers can be toggled in the OSD under the Debug options or by pressing F7-F10 on the keyboard.
<br>
|Layer Debug|
|:--:|
|<table><tr><th>Text Layer</th><th>Background Layer</th><th>Foreground Layer</th><th>Sprite Layer</th><th>All Layers</th></tr><tr><td><img width="120" height="160" src="https://user-images.githubusercontent.com/32810066/170846019-e70e74b9-1e88-4991-b8c3-3b9b52935ad8.png"></p></td><td><img width="120" height="160" src="https://user-images.githubusercontent.com/32810066/170846020-8459d346-0a97-41ff-ae5f-f7793a4c7bcb.png"></p></td><td><img width="120" height="160" src="https://user-images.githubusercontent.com/32810066/170846021-08f8506d-e764-42b6-8c4a-ea19b059060b.png"></td><td><img width="120" height="160" src="https://user-images.githubusercontent.com/32810066/170846022-5237caf6-bf3a-4461-b324-5e44733310ff.png"></td><td><img width="120" height="160" src="https://user-images.githubusercontent.com/32810066/170846026-eefddb1b-6a81-4c20-9a99-509dcb888735.png"></td></tr></table>

# Control Layout

Game | Joystick | Service Menu | Shared Controls | Dip Default |
:---: | :---: | :---: | :---: | :---: |
Armed F                   | 8-Way | <img width="" height="" src="https://user-images.githubusercontent.com/32810066/170657740-f1781b3a-f50b-41eb-aff3-63d8b891ccf6.png"> | Upright | **Upright** |
Chouji Meikyuu<br> Legion | 8-Way | <img width="" height="" src="https://user-images.githubusercontent.com/32810066/170711151-9d7e8a34-b715-48a5-b89f-9b8004cb04f0.png"> | Co-Op   | **Upright** |
Crazy Climber 2           | 4-Way | <img width="" height="" src="https://user-images.githubusercontent.com/32810066/170847086-105099f0-2e8a-4bdb-af1a-b8fa5a9c5f6d.png"> | Upright | **Upright** |
Kozure Ōkami              | 8-Way | <img width="" height="" src="https://user-images.githubusercontent.com/32810066/173246143-91d3441b-6993-4860-b739-73ac920bfd9c.png"> | Upright | **Upright** |
Terra Force               | 8-Way | <img width="" height="" src="https://user-images.githubusercontent.com/32810066/173246181-54916a4f-bf6a-47fb-ae93-b40db12cfab8.png"> | Upright | **Upright** |

<br>

### Note: (Only applies once screen flip is implemented)

> Upright cabinets share a **1L3B** control panel layout. Players are required to switch controller. If set the cabinet type is set to table, the screen inverts for cocktail mode per player and has multiple controls. <br><br>Push button 3 may have no function in game, but corresponds to the original hardware and service menu. Crazy Climber 2 uses two 4-way joysticks and the second stick (right) corresponds to buttons 1 thru 4 for movement.

<br>

### Keyboard Handler

- Keyboard inputs mapped to mame defaults for all functions.

|Services|Coin/Start|
|--|--|
|<table> <tr><th>Functions</th><th>Keymap</th></tr><tr><td>Test</td><td>F2</td></tr><tr><td>Reset</td><td>F3</td></tr><tr><td>Service</td><td>9</td></tr><tr><td>Pause</td><td>P</td></tr> </table> | <table><tr><th>Functions</th><th>Keymap</th><tr><tr><td>P1 Start</td><td>1</td></tr><tr><td>P2 Start</td><td>2</td></tr><tr><td>P1 Coin</td><td>5</td></tr><tr><td>P2 Coin</td><td>6</td></tr> </table>|

|Player 1|Player 2|
|--|--|
|<table> <tr><th>Functions</th><th>Keymap</th></tr><tr><td>P1 Up</td><td>Up</td></tr><tr><td>P1 Down</td><td>Down</td></tr><tr><td>P1 Left</td><td>Left</td></tr><tr><td>P1 Right</td><td>Right</td></tr><tr><td>P1 Bttn 1</td><td>L-Ctrl</td></tr><tr><td>P1 Bttn 2</td><td>L-Alt</td></tr><tr><td>P1 Bttn 3</td><td>Space</td></tr><tr><td>P1 Bttn 4</td><td>L-Shift</td></tr> </table> | <table> <tr><th>Functions</th><th>Keymap</th></tr><tr><td>P2 Up</td><td>R</td></tr><tr><td>P2 Down</td><td>F</td></tr><tr><td>P2 Left</td><td>D</td></tr><tr><td>P2 Right</td><td>G</td></tr><tr><td>P2 Bttn 1</td><td>A</td></tr><tr><td>P2 Bttn 2</td><td>S</td></tr><tr><td>P2 Bttn 3</td><td>Q</td></tr><tr><td>P2 Bttn 4</td><td>W</td></tr> </table>|

|Debug|
|--|
|<table> <tr><th>Functions</th><th>Keymap</th></tr><tr><td>Layer (Txt)</td><td>F7</td><tr><td>Layer (FG)</td><td>F8</td></tr><tr><td>Layer (BG)</td><td>F9</td><tr><td>Layer (SP)</td><td>F10</td></tr> </table>|

# Support

Please consider showing support for this and future projects via [**Ko-fi**](https://ko-fi.com/darreno). While it isn't necessary, it's greatly appreciated.

# Licensing

Contact the author for special licensing needs. Otherwise follow the GPLv2 license attached.
