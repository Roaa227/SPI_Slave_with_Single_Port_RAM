# SPI Slave with Single Port RAM

This project implements an **SPI (Serial Peripheral Interface) Slave** connected to a **Single-Port RAM**, written in Verilog HDL. The design uses a **Finite State Machine (FSM)** for SPI protocol handling and synchronous RAM for storage.
---
##  FSM
<img width="1196" height="781" alt="FSM" src="https://github.com/user-attachments/assets/4e79d09f-45fb-4be4-badc-2b0ca040433c" />

---

##  Features

* SPI Slave with FSM (supports multiple state encodings).
* Single-port synchronous RAM with configurable depth & address size.
* Active-low synchronous reset (`rst_n`).
* Complete set of project assets:

  * ✅ Verilog source files
  * ✅ Testbench for simulation
  * ✅ Constraint file (`.xdc` / `.ucf`)
  * ✅ Simulation automation (`run.do`)
  * ✅ Synthesized netlist
  * ✅ FPGA bitstream (`.bit`)

---

##  Repository Structure

```
├── src/
│   ├── SPI_slave.v            # SPI Slave FSM
│   ├── RAM.v                  # Single-port RAM
│   ├── SPI_slave_with_RAM.v   # Top-level design
│
├── tb/
│   ├── TestBench_tb.v         # Testbench
│   └── run.do                 # Simulation script
│
├── constraints/
│   └── Constraints_basys3.xdc    # FPGA pin mapping
│
├── netlist/
│   └── Netlist.v # Post-synthesis netlist
│
├── bitstream/
│   └── SPI_slave_with_RAM.bit      # Ready-to-use FPGA bitstream
│
└── README.md
```

---

##  Modules Overview

### 1. `SPI_slave`

Implements SPI protocol using FSM with states:

* **IDLE**
* **CHK\_CMD**
* **WRITE**
* **READ\_ADD**
* **READ\_DATA**

### 2. `RAM`

* Configurable parameters:

  * `MEM_DEPTH` = 256
  * `ADDR_SIZE` = 8
* Handles four SPI commands:

  * `00` → Write address
  * `01` → Write data
  * `10` → Read address
  * `11` → Read data

### 3. `SPI_slave_with_RAM`

* Integrates SPI slave and RAM.
* Passes `rx_data` to RAM and returns `tx_data` on MISO.

---

##  Expected Waveform
<img width="897" height="407" alt="Screenshot 2025-09-05 154719" src="https://github.com/user-attachments/assets/9339f0f6-4f98-4a25-ad69-4111cb879306" />

---

##  How to Run

###  Simulation (Questa)

1. Navigate to `tb/`:

   ```bash
   cd tb
   ```
2. Run the script:

   ```tcl
   do run.do
   ```
3. View MOSI, MISO, clk, SS\_n, and FSM states in the waveform.

###  Running on Vivado

1. **Open Vivado** → Create a new RTL project.
2. **Add Sources** → add:

   * `SPI_slave.v`
   * `RAM.v`
   * `SPI_slave_with_RAM.v` (set this as **Top Module**)
3. **Add Constraints** → add `Constraints_basys3.xdc`.
4. Click **Run Synthesis** → **Run Implementation** → **Generate Bitstream**.
5. Connect your FPGA board → open **Hardware Manager** → **Program Device** with the generated `.bit` file (or use the one included in `/bitstream/`).

### Important Note

Before running the simulation or Vivado implementation:

* Make sure that **all source files (RAM.v, SPI\_slave.v, instantiation.v, etc.)** and the **testbench file (TestBench.v)** are placed in the **same folder**.
* This ensures that the `run.do` script and Vivado project can find the files correctly.
  
---

##  Testbench

* Automates write & read SPI transactions.
* Verifies correct data transfer via MOSI/MISO.

---

##  Parameters

* `MEM_DEPTH` – Memory depth (default: 256).
* `ADDR_SIZE` – Address size (default: 8).
