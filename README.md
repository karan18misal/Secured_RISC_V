## Aim: 
The primary objective is to develop a functional RISC-V processor based on the RV32I instruction set that incorporates a Security Unit (Encryption Module). This unit is strategically placed between the memory and the register bank to enforce data security for specific, designated critical address regions, ensuring data is encrypted upon storage and decrypted upon retrieval.

---
## Purpose

- **To enhance data security** by encrypting and decrypting sensitive data during transfers between memory and registers.

- **To implement a secure RISC-V RV32I processor** that follows the standard RISC-V instruction set while integrating encryption mechanisms.

- **To protect critical memory regions** by selectively applying encryption based on predefined address ranges.

- **To maintain simplicity and efficiency** of a load-store architecture without significantly impacting processor performance.

- **To provide a scalable and modular processor design** that can be extended with advanced cryptographic features in the future.

---
## BLOCK DIAGRAM
<img width="556" height="393" alt="image" src="https://github.com/user-attachments/assets/961b82e6-f08f-40c3-81c7-6327481df840" />

This architecture shows a **secured RISC-V processor** where a **Security Unit** is placed between the registers and memory to protect data. The **Control Unit** decodes instructions and controls data flow, the **ALU** performs operations on register data, and the **Memory Unit** handles memory access. Sensitive data is encrypted and decrypted during transfers, ensuring secure operation while maintaining the load-store architecture.


---
## Theory and Architecture: 
The secured processor is built upon a Load-Store Architecture (also known as register-register architecture) and incorporates a dedicated Security Unit (Encryption Module).

## 1. Load-Store Architecture
-  The processor adheres to a strict load-store model, which offers simplified instruction format and reduced complexity in control logic. Key characteristics include:


-  Computation: Arithmetic and logical operations are performed only on registers.


-  Memory Access: Memory is accessed exclusively through load and store instructions.


-  Data Flow: Data must be explicitly loaded from memory to registers before processing, and processed results must be explicitly stored back to memory.

## 2. Core Modules
### The processor system, integrated within the top main module, comprises several key functional blocks:


- Control Unit: Serves as the decision-making center, generating all necessary control signals (like alu_ctrl, wenable, renable) based on the instruction's opcode.


- Registers Module (Register Bank): A synchronous memory access system (1024-word, 32-bit words) that sustains multiple read and write operations in a single clock cycle.


-  Memory Module: A dual-access synchronous memory system (1024-word, 32-bit words) with an inbuilt access key mechanism.


-  ALU Module: Performs all arithmetic and logical operations (ADD, SUB, AND, OR, XOR, SLT, SLTU) required by the instruction set, and generates a zero flag for conditional branches.

## 3. Security Module (Encryption Unit)
- The security module is placed between the memory unit and the register bank to conditionally transform data during transfers.


-  Conditional Operation: The module performs conditional data transformation based on a 16-bit access key and a 10-bit address threshold.


-  Encryption: Data written from registers to memory is encrypted when the target address is between 0 and 127. The security module also checks if the access key matches the predefined value (0×0032).


-  Decryption: Data read from memory to registers is decrypted when the source address is between 0 and 127.

---

## Use Cases

- **Secure Embedded Systems**  
  The processor can be used in embedded applications where sensitive configuration data or control information must be protected from unauthorized memory access.

- **Internet of Things (IoT) Devices**  
  Suitable for IoT systems that handle confidential sensor data and require lightweight, hardware-level security with minimal performance overhead.

- **Edge Computing Applications**  
  Enables secure local processing by encrypting critical data stored in memory, reducing the risk of data leakage at edge nodes.

- **Academic and Research Platforms**  
  Serves as an educational and research-oriented processor for studying secure RISC-V architectures, encryption techniques, and hardware-based security mechanisms.

- **Industrial Automation Systems**  
  Can be deployed in industrial controllers to safeguard operational data, firmware, and control logic against tampering and reverse engineering.

---

## Limitations

**Simple encryption mechanism**

**Fixed address range for security**

**Static key management**

**Performance overhead due to encryption**

**Limited RV32I instruction set support**
