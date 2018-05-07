unit OpFlags;

interface

const
 (*
 * AVX512 Decorator (decoflags_t) bits distribution (counted from 0)
 *  3         2         1
 * 10987654321098765432109876543210
 *                |
 *                | word boundary
 * ............................1111 opmask
 * ...........................1.... zeroing / merging
 * ..........................1..... broadcast
 * .........................1...... static rounding
 * ........................1....... SAE
 * ......................11........ broadcast element size
 * ....................11.......... number of broadcast elements
 *)

(*
 * Number of broadcasting elements
 *
 * Bits: 10 - 11
 *)
BRNUM_SHIFT    =   10;

Z              =   $10;
OPMASK_MASK    =   $0F;
MASK           =   OPMASK_MASK;                     (* Opmask (k1 ~ 7) can be used *)
B32            =   $120;                            (* {1to16} : broadcast 32b * 16 to zmm(512b) *)
B64            =   $220;                            (* {1to8}  : broadcast 64b *  8 to zmm(512b) *)
ER             =   $40;                             (* ER(Embedded Rounding) == Static rounding mode *)
SAE            =   $80;                             (* SAE(Suppress All Exception) *)
BRNUM_MASK     =   $C00;


BRDCAST_MASK   =   $20;

(*
 * Broadcasting element size.
 *
 * Bits: 8 - 9
 *)
BRSIZE_MASK    =   $300;
BR_BITS32      =   $100;
BR_BITS64      =   $200;

(*
 * Sizes of the operands and attributes.
 *
 * Bits: 32 - 42
 *)
SIZE_MASK      =   $000007FF00000000;


(*
 * Bits distribution (counted from 0)
 *
 *    6         5         4         3         2         1
 * 3210987654321098765432109876543210987654321098765432109876543210
 *                                 |
 *                                 | dword bound
 *
 * ............................................................1111 optypes
 * .........................................................111.... modifiers
 * ...............................................1111111111....... register classes
 * .......................................11111111................. subclasses
 * ................................1111111......................... specials
 * .....................11111111111................................ sizes
 *)


REGISTER_      =   $1;                              (* register number in 'basereg' *)
IMMEDIATE      =   $2;                                                                                          
REGMEM         =   $4;                              (* for r/m, ie EA, operands *)                              
MEMORY         =   $c;                                                                                          
                                                                                                                
                                                    
BITS8          =   $100000000;                      (*   8 bits (BYTE) *)                                        
BITS16         =   $200000000;                      (*  16 bits (WORD) *)                                        
BITS32         =   $400000000;                      (*  32 bits (DWORD) *)                                       
BITS64         =   $800000000;                      (*  64 bits (QWORD), x64 and FPU only *)                     
BITS80         =   $1000000000;                     (*  80 bits (TWORD), FPU only *)                             
BITS128        =   $2000000000;                     (* 128 bits (OWORD) *)                                       
BITS256        =   $4000000000;                     (* 256 bits (YWORD) *)                                       
BITS512        =   $8000000000;                     (* 512 bits (ZWORD) *)                                       
FAR_           =   $10000000000;                    (* grotty: this means 16:16 or 16:32, like in CALL/JMP *)    
NEAR_          =   $20000000000;                                                                                 
SHORT          =   $40000000000;                    (* and this means what it says :) *)


TO_            =   $10;                             (* reverse effect in FADD, FSUB &c *)                        
COLON          =   $20;                             (* operand is followed by a colon *)                         
STRICT_        =   $40;                             (* do not optimize this operand *)   


REG_CLASS_CDT    =   $80;
REG_CLASS_GPR    =   $100;
REG_CLASS_SREG   =   $200;
REG_CLASS_FPUREG =   $400;
REG_CLASS_RM_MMX =   $800;
REG_CLASS_RM_XMM =   $1000;
REG_CLASS_RM_YMM =   $2000;
REG_CLASS_RM_ZMM =   $4000;
REG_CLASS_OPMASK =   $8000;
REG_CLASS_BND    =   $10000;


(* Register classes *)
REG_EA      =   $5;                                 (* 'normal' reg, qualifies as EA *)            
RM_GPR      =   $104;                               (* integer operand *)                          
REG_GPR     =   $105;                               (* integer register *)                         
REG8        =   $100000105;                         (*  8-bit GPR  *)                              
REG16       =   $200000105;                         (* 16-bit GPR *)                               
REG32       =   $400000105;                         (* 32-bit GPR *)                               
REG64       =   $800000105;                         (* 64-bit GPR *)                               
FPUREG      =   $401;                               (* floating point stack registers *)           
FPU0        =   $40401;                             (* FPU stack register zero *)                  
RM_MMX      =   $804;                               (* MMX operand *)                              
MMXREG      =   $805;                               (* MMX register *)                             
RM_XMM      =   $1004;                              (* XMM (SSE) operand *)                        
XMMREG      =   $1005;                              (* XMM (SSE) register *)                       
RM_YMM      =   $2004;                              (* YMM (AVX) operand *)                        
YMMREG      =   $2005;                              (* YMM (AVX) register *)                       
RM_ZMM      =   $4004;                              (* ZMM (AVX512) operand *)                     
ZMMREG      =   $4005;                              (* ZMM (AVX512) register *)                    
RM_OPMASK   =   $8004;                              (* Opmask operand *)                           
OPMASKREG   =   $8005;                              (* Opmask register *)                          
OPMASK0     =   $48005;                             (* Opmask register zero (k0) *)                
RM_K        =   $8004;                                                                             
KREG        =   $8005;                                                                             
RM_BND      =   $10004;                             (* Bounds operand *)                           
BNDREG      =   $10005;                             (* Bounds register *)                          
REG_CDT     =   $400000081;                         (* CRn, DRn and TRn *)                         
REG_CREG    =   $400040081;                         (* CRn *)                                      
REG_DREG    =   $400080081;                         (* DRn *)                                      
REG_TREG    =   $400100081;                         (* TRn *)                                      
REG_SREG    =   $200000201;                         (* any segment register *)                     


(* Segment registers *)
REG_ES      =   $2000A0201;                         (* ES *)                              
REG_CS      =   $2000C0201;                         (* CS *)                              
REG_SS      =   $200120201;                         (* SS *)                              
REG_DS      =   $200140201;                         (* DS *)                              
REG_FS      =   $200220201;                         (* FS *)                              
REG_GS      =   $200240201;                         (* GS *)                              
REG_FSGS    =   $200200201;                         (* FS or GS *)                        
REG_SEG67   =   $200400201;                         (* Unimplemented segment registers *) 


(* Special GPRs *)
REG_SMASK   =   $1FE0000;                           (* a mask for the following *)           
REG_ACCUM   =   $40105;                             (* accumulator: AL, AX, EAX, RAX *)     
REG_AL      =   $100040105;                                                                 
REG_AX      =   $200040105;                                                                 
REG_EAX     =   $400040105;                                                                 
REG_RAX     =   $800040105;                                                                 
REG_COUNT   =   $480105;                            (* counter: CL, CX, ECX, RCX *)         
REG_CL      =   $100480105;                                                                 
REG_CX      =   $200480105;                                                                 
REG_ECX     =   $400480105;                                                                 
REG_RCX     =   $800480105;                                                                 
REG_DL      =   $100500105;                         (* data: DL, DX, EDX, RDX *)            
REG_DX      =   $200500105;                                                                 
REG_EDX     =   $400500105;                                                                 
REG_RDX     =   $800500105;                                                                 
REG_HIGH    =   $100600105;                         (* high regs: AH, CH, DH, BH *)         
REG_NOTACC  =   $400000;                            (* non-accumulator register *)          
REG8NA      =   $100400105;                         (*  8-bit non-acc GPR  *)               
REG16NA     =   $200400105;                         (* 16-bit non-acc GPR *)                
REG32NA     =   $400400105;                         (* 32-bit non-acc GPR *)                
REG64NA     =   $800400105;                         (* 64-bit non-acc GPR *)                


(* special types of EAs *)
MEM_OFFS    =   $4000C;                             (* simple [address] offset - absolute! *)
IP_REL      =   $8000C;                             (* IP-relative offset *)
XMEM        =   $10000C;                            (* 128-bit vector SIB *)
YMEM        =   $20000C;                            (* 256-bit vector SIB *)
ZMEM        =   $40000C;                            (* 512-bit vector SIB *)


(* memory which matches any type of r/m operand *)
MEMORY_ANY  =   $81F90C;


(* special immediate values *)
UNITY       =   $20002;                             (* operand equals 1 *)                                 
SBYTEWORD   =   $40002;                             (* operand is in the range -128..127 mod 2^16 *)       
SBYTEDWORD  =   $80002;                             (* operand is in the range -128..127 mod 2^32 *)       
SDWORD      =   $100002;                            (* operand is in the range -0x80000000..0x7FFFFFFF *)  
UDWORD      =   $200002;                            (* operand is in the range 0..0xFFFFFFFF *)            


(*
 * Subset of vector registers: register 0 only and registers 0-15.
 * Avoid conflicts in subclass bitfield with any of special EA types!
 *)
RM_XMM_L16  =   $801004;                            (* XMM r/m operand  0 ~ 15 *)    
XMM0        =   $841005;                            (* XMM register   zero  *)       
XMM_L16     =   $801005;                            (* XMM register  0 ~ 15 *)       
                                                                                     
RM_YMM_L16  =   $802004;                            (* YMM r/m operand  0 ~ 15 *)    
YMM0        =   $842005;                            (* YMM register   zero  *)       
YMM_L16     =   $802005;                            (* YMM register  0 ~ 15 *)       
                                                                                     
RM_ZMM_L16  =   $804004;                            (* ZMM r/m operand  0 ~ 15 *)    
ZMM0        =   $844005;                            (* ZMM register   zero  *)       
ZMM_L16     =   $804005;                            (* ZMM register  0 ~ 15 *)


IF_SMASK    =  $3FC;
IF_ARMASK   =  $F800;


    function is_class(classe, op: Uint64) : Boolean;
    function is_reg_class(classe, reg : UInt64): Boolean;

    function IS_SREG(reg:UInt64): Boolean;
    function IS_FSGS(reg:UInt64): Boolean;
    function IF_GENBIT(bit: Cardinal):Cardinal;

    function OP_GENBIT(bits: Cardinal; shift:Cardinal): UInt64;
    function GEN_BRDCAST(bit: Cardinal): UInt64;
    function VAL_BRNUM(val: Integer): UInt64;
    function VAL_OPMASK(val: Integer): UInt64;
    function GEN_Z(bit: Cardinal): UInt64;

implementation
   uses
      Nasm_Def,
      NasmLib;

function is_class(classe, op: Uint64) : Boolean;
var
 res : UInt64;
begin
     res    :=   classe and  not(op)  ;
     Result := res  = 0;//(not( classe and not(op) ) ) <> 0
end;

function is_reg_class(classe, reg : UInt64): Boolean;
begin
     Result := False;
     if reg >  High(nasm_reg_flags) then
        nasm_Errore(ERR_WARNING,'Fuori Intervallo')
     else
        Result := is_class(classe, nasm_reg_flags[reg])
end;

function IS_SREG(reg:UInt64): Boolean;
begin
     Result := is_reg_class(REG_SREG, reg)
end;

function  IS_FSGS(reg:UInt64): Boolean;
begin
     Result := is_reg_class(REG_FSGS, reg)
end;
function IF_GENBIT(bit: Cardinal):Cardinal;
begin
     Result := (UInt32(1) shl (bit));
end;

function OP_GENMASK(bits: Cardinal; shift:Cardinal): UInt64;
begin
     Result := (((UInt64(1) shl (bits)) - 1) shl (shift))
end;

function OP_GENBIT(bits: Cardinal; shift:Cardinal): UInt64;
begin
     Result := (UInt64(1) shl ((shift) + (bits)))
end;

function GEN_BRDCAST(bit: Cardinal): UInt64;
const
  BRDCAST_SHIFT = 5;
begin
     Result := OP_GENBIT(bit, BRDCAST_SHIFT)
end;

function OP_GENVAL(val: Integer; bits, shift: Cardinal): UInt64;
begin
     Result := (((val) and ((Uint64(1) shl (bits)) - 1)) shl (shift))
end;

function VAL_BRNUM(val: Integer): UInt64;
 const
    BRNUM_BITS = 2;
    BRNUM_SHIFT= 10;
begin
     Result := OP_GENVAL(val, BRNUM_BITS, BRNUM_SHIFT)
end;

function VAL_OPMASK(val: Integer): UInt64;
 const
    OPMASK_BITS = 4;
    OPMASK_SHIFT= 0;
begin
     Result := OP_GENVAL(val, OPMASK_BITS, OPMASK_SHIFT)
end;

function GEN_Z(bit: Cardinal): UInt64;
const
  Z_SHIFT = 4;
  Z_BITS  = 1;
begin
     Result := OP_GENBIT(bit, Z_SHIFT)
end;

end.
