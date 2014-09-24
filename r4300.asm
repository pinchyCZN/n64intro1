 NOLIST
KUBASE                 EQU  0
KUSIZE                 EQU  0x80000000
K0BASE                 EQU  0x80000000
K0SIZE                 EQU  0x20000000
K1BASE                 EQU  0xA0000000
K1SIZE                 EQU  0x20000000
K2BASE                 EQU  0xC0000000
K2SIZE                 EQU  0x20000000
SIZE_EXCVEC            EQU  0x80            ;/* Size of an exc. vec */
UT_VEC                 EQU  K0BASE          ;/* utlbmiss vector */
R_VEC                  EQU  (K1BASE+0x1fc00000)   ;/* reset vector */
XUT_VEC                EQU  (K0BASE+0x80)   ;/* extended address tlbmiss */
ECC_VEC                EQU  (K0BASE+0x100)  ;/* Ecc exception vector */
E_VEC                  EQU  (K0BASE+0x180)  ;/* Gen. exception vector */
;K0_TO_K1(x)            EQU  ((x)|0xA0000000)   ;/* kseg0 to kseg1 */
;K1_TO_K0(x)            EQU  ((x)&0x9FFFFFFF)   ;/* kseg1 to kseg0 */
;K0_TO_PHYS(x)          EQU  ((x)&0x1FFFFFFF)   ;/* kseg0 to physical */
;K1_TO_PHYS(x)          EQU  ((x)&0x1FFFFFFF)   ;/* kseg1 to physical */
;KDM_TO_PHYS(x)         EQU  ((x)&0x1FFFFFFF)   ;/* direct mapped to physical */
;PHYS_TO_K0(x)          EQU  ((x)|0x80000000)   ;/* physical to kseg0 */
;PHYS_TO_K1(x)          EQU  ((x)|0xA0000000)   ;/* physical to kseg1 */
;K0_TO_K1(x)            EQU  ((u32)(x)|0xA0000000)   ;/* kseg0 to kseg1 */
;K1_TO_K0(x)            EQU  ((u32)(x)&0x9FFFFFFF)   ;/* kseg1 to kseg0 */
;K0_TO_PHYS(x)          EQU  ((u32)(x)&0x1FFFFFFF)   ;/* kseg0 to physical */
;K1_TO_PHYS(x)          EQU  ((u32)(x)&0x1FFFFFFF)   ;/* kseg1 to physical */
;KDM_TO_PHYS(x)         EQU  ((u32)(x)&0x1FFFFFFF)   ;/* direct mapped to physical */
;PHYS_TO_K0(x)          EQU  ((u32)(x)|0x80000000)   ;/* physical to kseg0 */
;PHYS_TO_K1(x)          EQU  ((u32)(x)|0xA0000000)   ;/* physical to kseg1 */
;IS_KSEG0(x)            EQU  ((u32)(x) >= K0BASE && (u32)(x) < K1BASE)
;IS_KSEG1(x)            EQU  ((u32)(x) >= K1BASE && (u32)(x) < K2BASE)
;IS_KSEGDM(x)           EQU  ((u32)(x) >= K0BASE && (u32)(x) < K2BASE)
;IS_KSEG2(x)            EQU  ((u32)(x) >= K2BASE && (u32)(x) < KPTE_SHDUBASE)
;IS_KPTESEG(x)          EQU  ((u32)(x) >= KPTE_SHDUBASE)
;IS_KUSEG(x)            EQU  ((u32)(x) < K0BASE)
NTLBENTRIES            EQU  31              ;/* entry 31 is reserved by rdb */
TLBHI_VPN2MASK         EQU  0xffffe000
TLBHI_VPN2SHIFT        EQU  13
TLBHI_PIDMASK          EQU  0xff
TLBHI_PIDSHIFT         EQU  0
TLBHI_NPID             EQU  255             ;/* 255 to fit in 8 bits */
TLBLO_PFNMASK          EQU  0x3fffffc0
TLBLO_PFNSHIFT         EQU  6
TLBLO_CACHMASK         EQU  0x38            ;/* cache coherency algorithm */
TLBLO_CACHSHIFT        EQU  3
TLBLO_UNCACHED         EQU  0x10            ;/* not cached */
TLBLO_NONCOHRNT        EQU  0x18            ;/* Cacheable non-coherent */
TLBLO_EXLWR            EQU  0x28            ;/* Exclusive write */
TLBLO_D                EQU  0x4             ;/* writeable */
TLBLO_V                EQU  0x2             ;/* valid bit */
TLBLO_G                EQU  0x1             ;/* global access bit */
TLBINX_PROBE           EQU  0x80000000
TLBINX_INXMASK         EQU  0x3f
TLBINX_INXSHIFT        EQU  0
TLBRAND_RANDMASK       EQU  0x3f
TLBRAND_RANDSHIFT      EQU  0
TLBWIRED_WIREDMASK     EQU  0x3f
TLBCTXT_BASEMASK       EQU  0xff800000
TLBCTXT_BASESHIFT      EQU  23
TLBCTXT_BASEBITS       EQU  9
TLBCTXT_VPNMASK        EQU  0x7ffff0
TLBCTXT_VPNSHIFT       EQU  4
TLBPGMASK_4K           EQU  0x0
TLBPGMASK_16K          EQU  0x6000
TLBPGMASK_64K          EQU  0x1e000
SR_CUMASK              EQU  0xf0000000      ;/* coproc usable bits */
SR_CU3                 EQU  0x80000000      ;/* Coprocessor 3 usable */
SR_CU2                 EQU  0x40000000      ;/* Coprocessor 2 usable */
SR_CU1                 EQU  0x20000000      ;/* Coprocessor 1 usable */
SR_CU0                 EQU  0x10000000      ;/* Coprocessor 0 usable */
SR_RP                  EQU  0x08000000      ;/* Reduced power (quarter speed) */
SR_FR                  EQU  0x04000000      ;/* MIPS III FP register mode */
SR_RE                  EQU  0x02000000      ;/* Reverse endian */
SR_ITS                 EQU  0x01000000      ;/* Instruction trace support */
SR_BEV                 EQU  0x00400000      ;/* Use boot exception vectors */
SR_TS                  EQU  0x00200000      ;/* TLB shutdown */
SR_SR                  EQU  0x00100000      ;/* Soft reset occured */
SR_CH                  EQU  0x00040000      ;/* Cache hit for last 'cache' op */
SR_CE                  EQU  0x00020000      ;/* Create ECC */
SR_DE                  EQU  0x00010000      ;/* ECC of parity does not cause error */
SR_IMASK               EQU  0x0000ff00      ;/* Interrupt mask */
SR_IMASK8              EQU  0x00000000      ;/* mask level 8 */
SR_IMASK7              EQU  0x00008000      ;/* mask level 7 */
SR_IMASK6              EQU  0x0000c000      ;/* mask level 6 */
SR_IMASK5              EQU  0x0000e000      ;/* mask level 5 */
SR_IMASK4              EQU  0x0000f000      ;/* mask level 4 */
SR_IMASK3              EQU  0x0000f800      ;/* mask level 3 */
SR_IMASK2              EQU  0x0000fc00      ;/* mask level 2 */
SR_IMASK1              EQU  0x0000fe00      ;/* mask level 1 */
SR_IMASK0              EQU  0x0000ff00      ;/* mask level 0 */
SR_IBIT8               EQU  0x00008000      ;/* bit level 8 */
SR_IBIT7               EQU  0x00004000      ;/* bit level 7 */
SR_IBIT6               EQU  0x00002000      ;/* bit level 6 */
SR_IBIT5               EQU  0x00001000      ;/* bit level 5 */
SR_IBIT4               EQU  0x00000800      ;/* bit level 4 */
SR_IBIT3               EQU  0x00000400      ;/* bit level 3 */
SR_IBIT2               EQU  0x00000200      ;/* bit level 2 */
SR_IBIT1               EQU  0x00000100      ;/* bit level 1 */
SR_IMASKSHIFT          EQU  8
SR_KX                  EQU  0x00000080      ;/* extended-addr TLB vec in kernel */
SR_SX                  EQU  0x00000040      ;/* xtended-addr TLB vec supervisor */
SR_UX                  EQU  0x00000020      ;/* xtended-addr TLB vec in user mode */
SR_KSU_MASK            EQU  0x00000018      ;/* mode mask */
SR_KSU_USR             EQU  0x00000010      ;/* user mode */
SR_KSU_SUP             EQU  0x00000008      ;/* supervisor mode */
SR_KSU_KER             EQU  0x00000000      ;/* kernel mode */
SR_ERL                 EQU  0x00000004      ;/* Error level, 1=>cache error */
SR_EXL                 EQU  0x00000002      ;/* Exception level, 1=>exception */
SR_IE                  EQU  0x00000001      ;/* interrupt enable, 1=>enable */
CAUSE_BD               EQU  0x80000000      ;/* Branch delay slot */
CAUSE_CEMASK           EQU  0x30000000      ;/* coprocessor error */
CAUSE_CESHIFT          EQU  28
CAUSE_IP8              EQU  0x00008000      ;/* External level 8 pending - COMPARE */
CAUSE_IP7              EQU  0x00004000      ;/* External level 7 pending - INT4 */
CAUSE_IP6              EQU  0x00002000      ;/* External level 6 pending - INT3 */
CAUSE_IP5              EQU  0x00001000      ;/* External level 5 pending - INT2 */
CAUSE_IP4              EQU  0x00000800      ;/* External level 4 pending - INT1 */
CAUSE_IP3              EQU  0x00000400      ;/* External level 3 pending - INT0 */
CAUSE_SW2              EQU  0x00000200      ;/* Software level 2 pending */
CAUSE_SW1              EQU  0x00000100      ;/* Software level 1 pending */
CAUSE_IPMASK           EQU  0x0000FF00      ;/* Pending interrupt mask */
CAUSE_IPSHIFT          EQU  8
CAUSE_EXCMASK          EQU  0x0000007C      ;/* Cause code bits */
CAUSE_EXCSHIFT         EQU  2
EXC_INT                EQU  0     ;/* interrupt */
EXC_MOD                EQU  4     ;/* TLB mod */
EXC_RMISS              EQU  8     ;/* Read TLB Miss */
EXC_WMISS              EQU  $C    ;/* Write TLB Miss */
EXC_RADE               EQU  $10   ;/* Read Address Error */
EXC_WADE               EQU  $14   ;/* Write Address Error */
EXC_IBE                EQU  $18   ;/* Instruction Bus Error */
EXC_DBE                EQU  $1C   ;/* Data Bus Error */
EXC_SYSCALL            EQU  $20   ;/* SYSCALL */
EXC_BREAK              EQU  $24   ;/* BREAKpoint */
EXC_II                 EQU  $28   ;/* Illegal Instruction */
EXC_CPU                EQU  $2C   ;/* CoProcessor Unusable */
EXC_OV                 EQU  $30   ;/* OVerflow */
EXC_TRAP               EQU  $34   ;/* Trap exception */
EXC_VCEI               EQU  $38   ;/* Virt. Coherency on Inst. fetch */
EXC_FPE                EQU  $3C   ;/* Floating Point Exception */
EXC_WATCH              EQU  $5C   ;/* Watchpoint reference */
EXC_VCED               EQU  $7C   ;/* Virt. Coherency on data read */
C0_IMPMASK             EQU  0xff00
C0_IMPSHIFT            EQU  8
C0_REVMASK             EQU  0xff
C0_MAJREVMASK          EQU  0xf0
C0_MAJREVSHIFT         EQU  4
C0_MINREVMASK          EQU  0xf
C0_READI               EQU  0x1             ;/* read ITLB entry addressed by C0_INDEX */
C0_WRITEI              EQU  0x2             ;/* write ITLB entry addressed by C0_INDEX */
C0_WRITER              EQU  0x6             ;/* write ITLB entry addressed by C0_RAND */
C0_PROBE               EQU  0x8             ;/* probe for ITLB entry addressed by TLBHI */
C0_RFE                 EQU  0x10            ;/* restore for exception */
CACH_PI                EQU  0x0             ;/* specifies primary inst. cache */
CACH_PD                EQU  0x1             ;/* primary data cache */
CACH_SI                EQU  0x2             ;/* secondary instruction cache */
CACH_SD                EQU  0x3             ;/* secondary data cache */
C_IINV                 EQU  0x0             ;/* index invalidate (inst, 2nd inst) */
C_IWBINV               EQU  0x0             ;/* index writeback inval (d, sd) */
C_ILT                  EQU  0x4             ;/* index load tag (all) */
C_IST                  EQU  0x8             ;/* index store tag (all) */
C_CDX                  EQU  0xc             ;/* create dirty exclusive (d, sd) */
C_HINV                 EQU  0x10            ;/* hit invalidate (all) */
C_HWBINV               EQU  0x14            ;/* hit writeback inv. (d, sd) */
C_FILL                 EQU  0x14            ;/* fill (i) */
C_HWB                  EQU  0x18            ;/* hit writeback (i, d, sd) */
C_HSV                  EQU  0x1c            ;/* hit set virt. (si, sd) */
ICACHE_SIZE            EQU  0x4000          ;/* 16K */
ICACHE_LINESIZE        EQU  32              ;/* 8 words */
ICACHE_LINEMASK        EQU  (ICACHE_LINESIZE-1)
DCACHE_SIZE            EQU  0x2000          ;/* 8K */
DCACHE_LINESIZE        EQU  16              ;/* 4 words */
DCACHE_LINEMASK        EQU  (DCACHE_LINESIZE-1)
CONFIG_CM              EQU  0x80000000      ;/* 1 == Master-Checker enabled */
CONFIG_EC              EQU  0x70000000      ;/* System Clock ratio */
CONFIG_EC_1_1          EQU  0x6             ;/* System Clock ratio 1 :1 */
CONFIG_EC_3_2          EQU  0x7             ;/* System Clock ratio 1.5 :1 */
CONFIG_EC_2_1          EQU  0x0             ;/* System Clock ratio 2 :1 */
CONFIG_EC_3_1          EQU  0x1             ;/* System Clock ratio 3 :1 */
CONFIG_EP              EQU  0x0f000000      ;/* Transmit Data Pattern */
CONFIG_SB              EQU  0x00c00000      ;/* Secondary cache block size */
CONFIG_SS              EQU  0x00200000      ;/* Split scache: 0 == I&D combined */
CONFIG_SW              EQU  0x00100000      ;/* scache port: 0==128, 1==64 */
CONFIG_EW              EQU  0x000c0000      ;/* System Port width: 0==64, 1==32 */
CONFIG_SC              EQU  0x00020000      ;/* 0 -> 2nd cache present */
CONFIG_SM              EQU  0x00010000      ;/* 0 -> Dirty Shared Coherency enabled*/
CONFIG_BE              EQU  0x00008000      ;/* Endian-ness: 1 --> BE */
CONFIG_EM              EQU  0x00004000      ;/* 1 -> ECC mode, 0 -> parity */
CONFIG_EB              EQU  0x00002000      ;/* Block order:1->sequent,0->subblock */
CONFIG_IC              EQU  0x00000e00      ;/* Primary Icache size */
CONFIG_DC              EQU  0x000001c0      ;/* Primary Dcache size */
CONFIG_IB              EQU  0x00000020      ;/* Icache block size */
CONFIG_DB              EQU  0x00000010      ;/* Dcache block size */
CONFIG_CU              EQU  0x00000008      ;/* Update on Store-conditional */
CONFIG_K0              EQU  0x00000007      ;/* K0SEG Coherency algorithm */
CONFIG_UNCACHED        EQU  0x00000002      ;/* K0 is uncached */
CONFIG_NONCOHRNT       EQU  0x00000003
CONFIG_COHRNT_EXLWR    EQU  0x00000005
CONFIG_SB_SHFT         EQU  22              ;/* shift SB to bit position 0 */
CONFIG_IC_SHFT         EQU  9               ;/* shift IC to bit position 0 */
CONFIG_DC_SHFT         EQU  6               ;/* shift DC to bit position 0 */
CONFIG_BE_SHFT         EQU  15              ;/* shift BE to bit position 0 */
SADDRMASK              EQU  0xFFFFE000      ;/* 31..13 -> scache paddr bits 35..17 */
SVINDEXMASK            EQU  0x00000380      ;/* 9..7: prim virt index bits 14..12 */
SSTATEMASK             EQU  0x00001c00      ;/* bits 12..10 hold scache line state */
SINVALID               EQU  0x00000000      ;/* invalid --> 000 == state 0 */
SCLEANEXCL             EQU  0x00001000      ;/* clean exclusive --> 100 == state 4 */
SDIRTYEXCL             EQU  0x00001400      ;/* dirty exclusive --> 101 == state 5 */
SECC_MASK              EQU  0x0000007f      ;/* low 7 bits are ecc for the tag */
SADDR_SHIFT            EQU  4               ;/* shift STagLo (31..13) to 35..17 */
PADDRMASK              EQU  0xFFFFFF00      ;/* PTagLo31..8->prim paddr bits35..12 */
PADDR_SHIFT            EQU  4               ;/* roll bits 35..12 down to 31..8 */
PSTATEMASK             EQU  0x00C0          ;/* bits 7..6 hold primary line state */
PINVALID               EQU  0x0000          ;/* invalid --> 000 == state 0 */
PCLEANEXCL             EQU  0x0080          ;/* clean exclusive --> 10 == state 2 */
PDIRTYEXCL             EQU  0x00C0          ;/* dirty exclusive --> 11 == state 3 */
PPARITY_MASK           EQU  0x0001          ;/* low bit is parity bit (even). */
CACHERR_ER             EQU  0x80000000      ;/* 0: inst ref, 1: data ref */
CACHERR_EC             EQU  0x40000000      ;/* 0: primary, 1: secondary */
CACHERR_ED             EQU  0x20000000      ;/* 1: data error */
CACHERR_ET             EQU  0x10000000      ;/* 1: tag error */
CACHERR_ES             EQU  0x08000000      ;/* 1: external ref, e.g. snoop*/
CACHERR_EE             EQU  0x04000000      ;/* error on SysAD bus */
CACHERR_EB             EQU  0x02000000      ;/* complicated, see spec. */
CACHERR_EI             EQU  0x01000000      ;/* complicated, see spec. */
CACHERR_SIDX_MASK      EQU  0x003ffff8      ;/* secondary cache index */
CACHERR_PIDX_MASK      EQU  0x00000007      ;/* primary cache index */
CACHERR_PIDX_SHIFT     EQU  12              ;/* bits 2..0 are paddr14..12 */
WATCHLO_WTRAP          EQU  0x00000001
WATCHLO_RTRAP          EQU  0x00000002
WATCHLO_ADDRMASK       EQU  0xfffffff8
WATCHLO_VALIDMASK      EQU  0xfffffffb
WATCHHI_VALIDMASK      EQU  0x0000000f
C0_INX                 EQUR 0
C0_RAND                EQUR 1
C0_ENTRYLO0            EQUR 2
C0_ENTRYLO1            EQUR 3
C0_CONTEXT             EQUR 4
C0_PAGEMASK            EQUR 5               ;/* page mask */
C0_WIRED               EQUR 6               ;/* # wired entries in tlb */
C0_BADVADDR            EQUR 8
C0_COUNT               EQUR 9               ;/* free-running counter */
C0_ENTRYHI             EQUR 10
C0_COMPARE             EQUR 11              ;/* counter comparison reg. */
C0_SR                  EQUR 12
C0_CAUSE               EQUR 13
C0_EPC                 EQUR 14
C0_PRID                EQUR 15              ;/* revision identifier */
C0_CONFIG              EQUR 16              ;/* hardware configuration */
C0_LLADDR              EQUR 17              ;/* load linked address */
C0_WATCHLO             EQUR 18              ;/* watchpoint */
C0_WATCHHI             EQUR 19              ;/* watchpoint */
C0_ECC                 EQUR 26              ;/* S-cache ECC and primary parity */
C0_CACHE_ERR           EQUR 27              ;/* cache error status */
C0_TAGLO               EQUR 28              ;/* cache operations */
C0_TAGHI               EQUR 29              ;/* cache operations */
C0_ERROR_EPC           EQUR 30              ;/* ECC error prg. counter */
FPCSR_FS               EQU  0x01000000      ;/* flush denorm to zero */
FPCSR_C                EQU  0x00800000      ;/* condition bit */
FPCSR_CE               EQU  0x00020000      ;/* cause: unimplemented operation */
FPCSR_CV               EQU  0x00010000      ;/* cause: invalid operation */
FPCSR_CZ               EQU  0x00008000      ;/* cause: division by zero */
FPCSR_CO               EQU  0x00004000      ;/* cause: overflow */
FPCSR_CU               EQU  0x00002000      ;/* cause: underflow */
FPCSR_CI               EQU  0x00001000      ;/* cause: inexact operation */
FPCSR_EV               EQU  0x00000800      ;/* enable: invalid operation */
FPCSR_EZ               EQU  0x00000400      ;/* enable: division by zero */
FPCSR_EO               EQU  0x00000200      ;/* enable: overflow */
FPCSR_EU               EQU  0x00000100      ;/* enable: underflow */
FPCSR_EI               EQU  0x00000080      ;/* enable: inexact operation */
FPCSR_FV               EQU  0x00000040      ;/* flag: invalid operation */
FPCSR_FZ               EQU  0x00000020      ;/* flag: division by zero */
FPCSR_FO               EQU  0x00000010      ;/* flag: overflow */
FPCSR_FU               EQU  0x00000008      ;/* flag: underflow */
FPCSR_FI               EQU  0x00000004      ;/* flag: inexact operation */
FPCSR_RM_MASK          EQU  0x00000003      ;/* rounding mode mask */
FPCSR_RM_RN            EQU  0x00000000      ;/* round to nearest */
FPCSR_RM_RZ            EQU  0x00000001      ;/* round to zero */
FPCSR_RM_RP            EQU  0x00000002      ;/* round to positive infinity */
FPCSR_RM_RM            EQU  0x00000003      ;/* round to negative infinity */
 LIST