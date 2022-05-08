
# Nichibutsu M68000 (Terra Force) FPGA Implementation

FPGA compatible core of Nichibutsu M68000 (Terra Force Based) arcade hardware for [**MiSTerFPGA**](https://github.com/MiSTer-devel/Main_MiSTer/wiki) written by [**Darren Olafson**](https://twitter.com/Darren__O). 

Currently in an alpha state, this core is in active development with assistance from [**atrac17**](https://github.com/atrac17).

![Logo](https://user-images.githubusercontent.com/32810066/160257413-889da2d8-f968-4bd1-9adc-fb22552f0455.png)

## Supported Games

| Title | Status | Released | Protection |
|------|---------|----------|------------|
[**Terra Force**](https://en.wikipedia.org/wiki/Nihon_Bussan)           | Pending | N | NB1414M4 |
[**Kozure Ōkami**](https://en.wikipedia.org/wiki/Nihon_Bussan)          | Pending | N | NB1414M4 |
[**Chouji Meikyuu Legion**](https://en.wikipedia.org/wiki/Nihon_Bussan) | Pending | N | NB1414M4 |
[**Crazy Climber 2**](https://en.wikipedia.org/wiki/Nihon_Bussan)       | Pending | N | NB1414M4 |
[**Armed F**](https://en.wikipedia.org/wiki/Formation_Armed_F)          | Pending | N | None     |
[**Tatakae! Big Fighter**](https://en.wikipedia.org/wiki/Nihon_Bussan)  | Pending | N | i8751    |

## External Modules

|Name| Purpose | Author |
|----|---------|--------|
| [**fx68k**](https://github.com/ijor/fx68k)                                                   | [**Motorola 68000 CPU**](https://en.wikipedia.org/wiki/Motorola_68000) | Jorge Cwik                    |
| [**t80**](https://opencores.org/projects/t80)                                                | [**Zilog Z80 CPU**](https://en.wikipedia.org/wiki/Zilog_Z80)           | Daniel Wallner                |
| [**jtopl**](https://github.com/jotego/jtopl)                                                 | [**Yamaha OPL**](https://en.wikipedia.org/wiki/Yamaha_OPL#OPL)         | Jose Tejada                   |
| [**8051 IP Core**](https://github.com/jotego/jtframe/blob/master/hdl/cpu/jtframe_8751mcu.v)  | [**Intel 8051**](https://en.wikipedia.org/wiki/Intel_8051)             | Oregano Systems / Jose Tejada |

# Known Issues / Tasks

- Clock domains need to be verified  
- H/V clock timings for CRT need to be verified  
- Reverse engineer Terra Force and provide schematics  
- Protection MCU i8571  
- Protection Chip `nb1414m4` implementation  

# PCB Check List

FPGA implementation is based on Terra Force and will be verified against an original Terra Force PCB. Terra Force PCB and Terra Force bootleg PCB donated by [**@atrac17**](https://twitter.com/_atrac17) / [**@djhardrich**](https://twitter.com/djhardrich).

Reverse engineering of an authentic Terra Force PCB will be done by [**Darren Olafson**](https://twitter.com/Darren__O) and schematics will be included in the repository.

### Clock Information

H-Sync      | V-Sync      | Source           |
------------|-------------|------------------|
15.625kHz   | 59.092993Hz | [DSLogic +]()    |

### Crystal Oscillators

Location           | Freq (MHz) | Use          |
-------------------|------------|--------------|
C1 (Top Board)     | 16.000     | M68000       |
F1 (Bottom Board)  | 24.000     | Z80 / YM3526 |

**Pixel clock:** 6.00 MHz

**Estimated geometry:**

    511 pixels/line
  
    255 pixels/line

### Main Components

Location | Chip | Use |
---------|------|-----|
D1  (Top Board)      | [**Motorola 68000 CPU**](https://en.wikipedia.org/wiki/Motorola_68000)                                                                                                                           | Main CPU                                  |
H17 (Bottom Board)   | [**Zilog Z80 CPU**](https://en.wikipedia.org/wiki/Zilog_Z80)                                                                                                                                     | Sound CPU                                 |
K15 (Bottom Board)   | [**Yamaha YM3812**](https://en.wikipedia.org/wiki/Yamaha_OPL#OPL2)                                                                                                                               | OPL                                       |
A9  (Top Board)      | [**Nichibutsu NB1414M4**](https://raw.githubusercontent.com/va7deo/TerraForce/main/doc/Terra%20Force%2026494/Terra%20Force%2026494%20Front.jpg?token=GHSAT0AAAAAABKJR6W6CVBT5FROK2UKF75KYTXT2BA) | NB1414M4 Protection MCU                   |
D1  (Daughter Board) | [**Intel 8051**](https://en.wikipedia.org/wiki/Intel_8051)                                                                                                                                       | Protection MCU **(Tatakae! Big Fighter)** |

# Support

Please consider showing support for this and future projects via [**Ko-fi**](https://ko-fi.com/darreno). While it isn't necessary, it's greatly appreciated.

# Licensing

Contact the author for special licensing needs. Otherwise follow the GPLv2 license attached.
