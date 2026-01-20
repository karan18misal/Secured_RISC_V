🎯 Aim: 
The primary objective is to develop a functional RISC-V processor based on the RV32I instruction set that incorporates a Security Unit (Encryption Module). This unit is strategically placed between the memory and the register bank to enforce data security for specific, designated critical address regions, ensuring data is encrypted upon storage and decrypted upon retrieval.
---
<img width="556" height="393" alt="image" src="https://github.com/user-attachments/assets/961b82e6-f08f-40c3-81c7-6327481df840" />

---

💡 Theory and Architecture: 
The secured processor is built upon a Load-Store Architecture (also known as register-register architecture) and incorporates a dedicated Security Unit (Encryption Module).

1. Load-Store Architecture
The processor adheres to a strict load-store model, which offers simplified instruction format and reduced complexity in control logic. Key characteristics include:


Computation: Arithmetic and logical operations are performed only on registers.


Memory Access: Memory is accessed exclusively through load and store instructions.


Data Flow: Data must be explicitly loaded from memory to registers before processing, and processed results must be explicitly stored back to memory.

2. Core Modules
The processor system, integrated within the top main module, comprises several key functional blocks:


Control Unit: Serves as the decision-making center, generating all necessary control signals (like alu_ctrl, wenable, renable) based on the instruction's opcode.


Registers Module (Register Bank): A synchronous memory access system (1024-word, 32-bit words) that sustains multiple read and write operations in a single clock cycle.


Memory Module: A dual-access synchronous memory system (1024-word, 32-bit words) with an inbuilt access key mechanism.


ALU Module: Performs all arithmetic and logical operations (ADD, SUB, AND, OR, XOR, SLT, SLTU) required by the instruction set, and generates a zero flag for conditional branches.

3. Security Module (Encryption Unit)
The security module is placed between the memory unit and the register bank to conditionally transform data during transfers.


Conditional Operation: The module performs conditional data transformation based on a 16-bit access key and a 10-bit address threshold.


Encryption: Data written from registers to memory is encrypted when the target address is between 0 and 127. The security module also checks if the access key matches the predefined value (0×0032).


Decryption: Data read from memory to registers is decrypted when the source address is between 0 and 127.
---
