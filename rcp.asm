 NOLIST
RDRAM_0_START          EQU  0x00000000
RDRAM_0_END            EQU  0x001FFFFF
RDRAM_1_START          EQU  0x00200000
RDRAM_1_END            EQU  0x003FFFFF
RDRAM_START            EQU  RDRAM_0_START
RDRAM_END              EQU  RDRAM_1_END
RDRAM_BASE_REG         EQU  0x03F00000
RDRAM_CONFIG_REG       EQU  (RDRAM_BASE_REG+0x00)
RDRAM_DEVICE_TYPE_REG  EQU  (RDRAM_BASE_REG+0x00)
RDRAM_DEVICE_ID_REG    EQU  (RDRAM_BASE_REG+0x04)
RDRAM_DELAY_REG        EQU  (RDRAM_BASE_REG+0x08)
RDRAM_MODE_REG         EQU  (RDRAM_BASE_REG+0x0c)
RDRAM_REF_INTERVAL_REG EQU  (RDRAM_BASE_REG+0x10)
RDRAM_REF_ROW_REG      EQU  (RDRAM_BASE_REG+0x14)
RDRAM_RAS_INTERVAL_REG EQU  (RDRAM_BASE_REG+0x18)
RDRAM_MIN_INTERVAL_REG EQU  (RDRAM_BASE_REG+0x1c)
RDRAM_ADDR_SELECT_REG  EQU  (RDRAM_BASE_REG+0x20)
RDRAM_DEVICE_MANUF_REG EQU  (RDRAM_BASE_REG+0x24)
RDRAM_0_DEVICE_ID      EQU  0
RDRAM_1_DEVICE_ID      EQU  1
RDRAM_RESET_MODE       EQU  0
RDRAM_ACTIVE_MODE      EQU  1
RDRAM_STANDBY_MODE     EQU  2
RDRAM_LENGTH           EQU  (2*512*2048)
RDRAM_0_BASE_ADDRESS   EQU  (RDRAM_0_DEVICE_ID*RDRAM_LENGTH)
RDRAM_1_BASE_ADDRESS   EQU  (RDRAM_1_DEVICE_ID*RDRAM_LENGTH)
RDRAM_0_CONFIG         EQU  0x00000
RDRAM_1_CONFIG         EQU  0x00400
RDRAM_GLOBAL_CONFIG    EQU  0x80000
PIF_ROM_START          EQU  0x1FC00000
PIF_ROM_END            EQU  0x1FC007BF
PIF_RAM_START          EQU  0x1FC007C0
PIF_RAM_END            EQU  0x1FC007FF
CHNL_ERR_NORESP        EQU  0x80            ;/* Bit 7 (Rx): No response error */
CHNL_ERR_OVERRUN       EQU  0x40            ;/* Bit 6 (Rx): Overrun error */
CHNL_ERR_FRAME         EQU  0x80            ;/* Bit 7 (Tx): Frame error */
CHNL_ERR_COLLISION     EQU  0x40            ;/* Bit 6 (Tx): Collision error */
CHNL_ERR_MASK          EQU  0xC0            ;/* Bit 6-7: channel errors */
DEVICE_TYPE_CART       EQU  0               ;/* ROM cartridge */
DEVICE_TYPE_BULK       EQU  1               ;/* ROM bulk */
DEVICE_TYPE_64DD       EQU  2               ;/* 64 Disk Drive */
SP_DMEM_START          EQU  0xA4000000      ;/* read/write */
SP_DMEM_END            EQU  0xA4000FFF
SP_IMEM_START          EQU  0xA4001000      ;/* read/write */
SP_IMEM_END            EQU  0xA4001FFF
SP_BASE_REG            EQU  0xA4040000
SP_MEM_ADDR_REG        EQU  (SP_BASE_REG+0x00)   ;/* Master */
SP_DRAM_ADDR_REG       EQU  (SP_BASE_REG+0x04)   ;/* Slave */
SP_RD_LEN_REG          EQU  (SP_BASE_REG+0x08)   ;/* R/W: read len */
SP_WR_LEN_REG          EQU  (SP_BASE_REG+0x0C)   ;/* R/W: write len */
SP_STATUS_REG          EQU  (SP_BASE_REG+0x10)
SP_DMA_FULL_REG        EQU  (SP_BASE_REG+0x14)
SP_DMA_BUSY_REG        EQU  (SP_BASE_REG+0x18)
SP_SEMAPHORE_REG       EQU  (SP_BASE_REG+0x1C)
SP_PC_REG              EQU  0xA4080000
SP_DMA_DMEM            EQU  0x0000          ;/* Bit 12: 0=DMEM, 1=IMEM */
SP_DMA_IMEM            EQU  0x1000          ;/* Bit 12: 0=DMEM, 1=IMEM */
SP_CLR_HALT            EQU  0x00001         ;/* Bit  0: clear halt */
SP_SET_HALT            EQU  0x00002         ;/* Bit  1: set halt */
SP_CLR_BROKE           EQU  0x00004         ;/* Bit  2: clear broke */
SP_CLR_INTR            EQU  0x00008         ;/* Bit  3: clear intr */
SP_SET_INTR            EQU  0x00010         ;/* Bit  4: set intr */
SP_CLR_SSTEP           EQU  0x00020         ;/* Bit  5: clear sstep */
SP_SET_SSTEP           EQU  0x00040         ;/* Bit  6: set sstep */
SP_CLR_INTR_BREAK      EQU  0x00080         ;/* Bit  7: clear intr on break */
SP_SET_INTR_BREAK      EQU  0x00100         ;/* Bit  8: set intr on break */
SP_CLR_SIG0            EQU  0x00200         ;/* Bit  9: clear signal 0 */
SP_SET_SIG0            EQU  0x00400         ;/* Bit 10: set signal 0 */
SP_CLR_SIG1            EQU  0x00800         ;/* Bit 11: clear signal 1 */
SP_SET_SIG1            EQU  0x01000         ;/* Bit 12: set signal 1 */
SP_CLR_SIG2            EQU  0x02000         ;/* Bit 13: clear signal 2 */
SP_SET_SIG2            EQU  0x04000         ;/* Bit 14: set signal 2 */
SP_CLR_SIG3            EQU  0x08000         ;/* Bit 15: clear signal 3 */
SP_SET_SIG3            EQU  0x10000         ;/* Bit 16: set signal 3 */
SP_CLR_SIG4            EQU  0x20000         ;/* Bit 17: clear signal 4 */
SP_SET_SIG4            EQU  0x40000         ;/* Bit 18: set signal 4 */
SP_CLR_SIG5            EQU  0x80000         ;/* Bit 19: clear signal 5 */
SP_SET_SIG5            EQU  0x100000        ;/* Bit 20: set signal 5 */
SP_CLR_SIG6            EQU  0x200000        ;/* Bit 21: clear signal 6 */
SP_SET_SIG6            EQU  0x400000        ;/* Bit 22: set signal 6 */
SP_CLR_SIG7            EQU  0x800000        ;/* Bit 23: clear signal 7 */
SP_SET_SIG7            EQU  0x1000000       ;/* Bit 24: set signal 7 */
SP_STATUS_HALT         EQU  0x001           ;/* Bit  0: halt */
SP_STATUS_BROKE        EQU  0x002           ;/* Bit  1: broke */
SP_STATUS_DMA_BUSY     EQU  0x004           ;/* Bit  2: dma busy */
SP_STATUS_DMA_FULL     EQU  0x008           ;/* Bit  3: dma full */
SP_STATUS_IO_FULL      EQU  0x010           ;/* Bit  4: io full */
SP_STATUS_SSTEP        EQU  0x020           ;/* Bit  5: single step */
SP_STATUS_INTR_BREAK   EQU  0x040           ;/* Bit  6: interrupt on break */
SP_STATUS_SIG0         EQU  0x080           ;/* Bit  7: signal 0 set */
SP_STATUS_SIG1         EQU  0x100           ;/* Bit  8: signal 1 set */
SP_STATUS_SIG2         EQU  0x200           ;/* Bit  9: signal 2 set */
SP_STATUS_SIG3         EQU  0x400           ;/* Bit 10: signal 3 set */
SP_STATUS_SIG4         EQU  0x800           ;/* Bit 11: signal 4 set */
SP_STATUS_SIG5         EQU  0x1000          ;/* Bit 12: signal 5 set */
SP_STATUS_SIG6         EQU  0x2000          ;/* Bit 13: signal 6 set */
SP_STATUS_SIG7         EQU  0x4000          ;/* Bit 14: signal 7 set */
SP_CLR_YIELD           EQU  SP_CLR_SIG0
SP_SET_YIELD           EQU  SP_SET_SIG0
SP_STATUS_YIELD        EQU  SP_STATUS_SIG0
SP_CLR_YIELDED         EQU  SP_CLR_SIG1
SP_SET_YIELDED         EQU  SP_SET_SIG1
SP_STATUS_YIELDED      EQU  SP_STATUS_SIG1
SP_CLR_TASKDONE        EQU  SP_CLR_SIG2
SP_SET_TASKDONE        EQU  SP_SET_SIG2
SP_STATUS_TASKDONE     EQU  SP_STATUS_SIG2
SP_IBIST_REG           EQU  0xA4080004
SP_IBIST_CHECK         EQU  0x01            ;/* Bit 0: BIST check */
SP_IBIST_GO            EQU  0x02            ;/* Bit 1: BIST go */
SP_IBIST_CLEAR         EQU  0x04            ;/* Bit 2: BIST clear */
SP_IBIST_DONE          EQU  0x04            ;/* Bit 2: BIST done */
SP_IBIST_FAILED        EQU  0x78            ;/* Bit [6:3]: BIST fail */
DPC_BASE_REG           EQU  0xA4100000
DPC_START_REG          EQU  (DPC_BASE_REG+0x00)
DPC_END_REG            EQU  (DPC_BASE_REG+0x04)
DPC_CURRENT_REG        EQU  (DPC_BASE_REG+0x08)
DPC_STATUS_REG         EQU  (DPC_BASE_REG+0x0C)
DPC_CLOCK_REG          EQU  (DPC_BASE_REG+0x10)
DPC_BUFBUSY_REG        EQU  (DPC_BASE_REG+0x14)
DPC_PIPEBUSY_REG       EQU  (DPC_BASE_REG+0x18)
DPC_TMEM_REG           EQU  (DPC_BASE_REG+0x1C)
DPC_CLR_XBUS_DMEM_DMA  EQU  0x0001          ;/* Bit 0: clear xbus_dmem_dma */
DPC_SET_XBUS_DMEM_DMA  EQU  0x0002          ;/* Bit 1: set xbus_dmem_dma */
DPC_CLR_FREEZE         EQU  0x0004          ;/* Bit 2: clear freeze */
DPC_SET_FREEZE         EQU  0x0008          ;/* Bit 3: set freeze */
DPC_CLR_FLUSH          EQU  0x0010          ;/* Bit 4: clear flush */
DPC_SET_FLUSH          EQU  0x0020          ;/* Bit 5: set flush */
DPC_CLR_TMEM_CTR       EQU  0x0040          ;/* Bit 6: clear tmem ctr */
DPC_CLR_PIPE_CTR       EQU  0x0080          ;/* Bit 7: clear pipe ctr */
DPC_CLR_CMD_CTR        EQU  0x0100          ;/* Bit 8: clear cmd ctr */
DPC_CLR_CLOCK_CTR      EQU  0x0200          ;/* Bit 9: clear clock ctr */
DPC_STATUS_XBUS_DMEM_DMA EQU  0x001         ;/* Bit  0: xbus_dmem_dma */
DPC_STATUS_FREEZE      EQU  0x002           ;/* Bit  1: freeze */
DPC_STATUS_FLUSH       EQU  0x004           ;/* Bit  2: flush */
DPC_STATUS_START_GCLK  EQU  0x008           ;/* Bit  3: start gclk */
DPC_STATUS_TMEM_BUSY   EQU  0x010           ;/* Bit  4: tmem busy */
DPC_STATUS_PIPE_BUSY   EQU  0x020           ;/* Bit  5: pipe busy */
DPC_STATUS_CMD_BUSY    EQU  0x040           ;/* Bit  6: cmd busy */
DPC_STATUS_CBUF_READY  EQU  0x080           ;/* Bit  7: cbuf ready */
DPC_STATUS_DMA_BUSY    EQU  0x100           ;/* Bit  8: dma busy */
DPC_STATUS_END_VALID   EQU  0x200           ;/* Bit  9: end valid */
DPC_STATUS_START_VALID EQU  0x400           ;/* Bit 10: start valid */
DPS_BASE_REG           EQU  0xA4200000
DPS_TBIST_REG          EQU  (DPS_BASE_REG+0x00)
DPS_TEST_MODE_REG      EQU  (DPS_BASE_REG+0x04)
DPS_BUFTEST_ADDR_REG   EQU  (DPS_BASE_REG+0x08)
DPS_BUFTEST_DATA_REG   EQU  (DPS_BASE_REG+0x0C)
DPS_TBIST_CHECK        EQU  0x01            ;/* Bit 0: BIST check */
DPS_TBIST_GO           EQU  0x02            ;/* Bit 1: BIST go */
DPS_TBIST_CLEAR        EQU  0x04            ;/* Bit 2: BIST clear */
DPS_TBIST_DONE         EQU  0x004           ;/* Bit 2: BIST done */
DPS_TBIST_FAILED       EQU  0x7F8           ;/* Bit [10:3]: BIST fail */
MI_BASE_REG            EQU  0xA4300000
MI_INIT_MODE_REG       EQU  (MI_BASE_REG+0x00)
MI_MODE_REG            EQU  MI_INIT_MODE_REG
MI_CLR_INIT            EQU  0x0080          ;/* Bit  7: clear init mode */
MI_SET_INIT            EQU  0x0100          ;/* Bit  8: set init mode */
MI_CLR_EBUS            EQU  0x0200          ;/* Bit  9: clear ebus test */
MI_SET_EBUS            EQU  0x0400          ;/* Bit 10: set ebus test mode */
MI_CLR_DP_INTR         EQU  0x0800          ;/* Bit 11: clear dp interrupt */
MI_CLR_RDRAM           EQU  0x1000          ;/* Bit 12: clear RDRAM reg */
MI_SET_RDRAM           EQU  0x2000          ;/* Bit 13: set RDRAM reg mode */
MI_MODE_INIT           EQU  0x0080          ;/* Bit  7: init mode */
MI_MODE_EBUS           EQU  0x0100          ;/* Bit  8: ebus test mode */
MI_MODE_RDRAM          EQU  0x0200          ;/* Bit  9: RDRAM reg mode */
MI_VERSION_REG         EQU  (MI_BASE_REG+0x04)
MI_NOOP_REG            EQU  MI_VERSION_REG
MI_INTR_REG            EQU  (MI_BASE_REG+0x08)
MI_INTR_MASK_REG       EQU  (MI_BASE_REG+0x0C)
MI_INTR_SP             EQU  0x01            ;/* Bit 0: SP intr */
MI_INTR_SI             EQU  0x02            ;/* Bit 1: SI intr */
MI_INTR_AI             EQU  0x04            ;/* Bit 2: AI intr */
MI_INTR_VI             EQU  0x08            ;/* Bit 3: VI intr */
MI_INTR_PI             EQU  0x10            ;/* Bit 4: PI intr */
MI_INTR_DP             EQU  0x20            ;/* Bit 5: DP intr */
MI_INTR_MASK_CLR_SP    EQU  0x0001          ;/* Bit  0: clear SP mask */
MI_INTR_MASK_SET_SP    EQU  0x0002          ;/* Bit  1: set SP mask */
MI_INTR_MASK_CLR_SI    EQU  0x0004          ;/* Bit  2: clear SI mask */
MI_INTR_MASK_SET_SI    EQU  0x0008          ;/* Bit  3: set SI mask */
MI_INTR_MASK_CLR_AI    EQU  0x0010          ;/* Bit  4: clear AI mask */
MI_INTR_MASK_SET_AI    EQU  0x0020          ;/* Bit  5: set AI mask */
MI_INTR_MASK_CLR_VI    EQU  0x0040          ;/* Bit  6: clear VI mask */
MI_INTR_MASK_SET_VI    EQU  0x0080          ;/* Bit  7: set VI mask */
MI_INTR_MASK_CLR_PI    EQU  0x0100          ;/* Bit  8: clear PI mask */
MI_INTR_MASK_SET_PI    EQU  0x0200          ;/* Bit  9: set PI mask */
MI_INTR_MASK_CLR_DP    EQU  0x0400          ;/* Bit 10: clear DP mask */
MI_INTR_MASK_SET_DP    EQU  0x0800          ;/* Bit 11: set DP mask */
MI_INTR_MASK_SP        EQU  0x01            ;/* Bit 0: SP intr mask */
MI_INTR_MASK_SI        EQU  0x02            ;/* Bit 1: SI intr mask */
MI_INTR_MASK_AI        EQU  0x04            ;/* Bit 2: AI intr mask */
MI_INTR_MASK_VI        EQU  0x08            ;/* Bit 3: VI intr mask */
MI_INTR_MASK_PI        EQU  0x10            ;/* Bit 4: PI intr mask */
MI_INTR_MASK_DP        EQU  0x20            ;/* Bit 5: DP intr mask */
VI_BASE_REG            EQU  0xA4400000
VI_STATUS_REG          EQU  (VI_BASE_REG+0x00)
VI_CONTROL_REG         EQU  VI_STATUS_REG
VI_ORIGIN_REG          EQU  (VI_BASE_REG+0x04)
VI_DRAM_ADDR_REG       EQU  VI_ORIGIN_REG
VI_WIDTH_REG           EQU  (VI_BASE_REG+0x08)
VI_H_WIDTH_REG         EQU  VI_WIDTH_REG
VI_INTR_REG            EQU  (VI_BASE_REG+0x0C)
VI_V_INTR_REG          EQU  VI_INTR_REG
VI_CURRENT_REG         EQU  (VI_BASE_REG+0x10)
VI_V_CURRENT_LINE_REG  EQU  VI_CURRENT_REG
VI_BURST_REG           EQU  (VI_BASE_REG+0x14)
VI_TIMING_REG          EQU  VI_BURST_REG
VI_V_SYNC_REG          EQU  (VI_BASE_REG+0x18)
VI_H_SYNC_REG          EQU  (VI_BASE_REG+0x1C)
VI_LEAP_REG            EQU  (VI_BASE_REG+0x20)
VI_H_SYNC_LEAP_REG     EQU  VI_LEAP_REG
VI_H_START_REG         EQU  (VI_BASE_REG+0x24)
VI_H_VIDEO_REG         EQU  VI_H_START_REG
VI_V_START_REG         EQU  (VI_BASE_REG+0x28)
VI_V_VIDEO_REG         EQU  VI_V_START_REG
VI_V_BURST_REG         EQU  (VI_BASE_REG+0x2C)
VI_X_SCALE_REG         EQU  (VI_BASE_REG+0x30)
VI_Y_SCALE_REG         EQU  (VI_BASE_REG+0x34)
VI_CTRL_TYPE_16        EQU  0x00002         ;/* Bit [1:0] pixel size: 16 bit */
VI_CTRL_TYPE_32        EQU  0x00003         ;/* Bit [1:0] pixel size: 32 bit */
VI_CTRL_GAMMA_DITHER_ON EQU 0x00004        ;/* Bit 2: default = on */
VI_CTRL_GAMMA_ON       EQU  0x00008         ;/* Bit 3: default = on */
VI_CTRL_DIVOT_ON       EQU  0x00010         ;/* Bit 4: default = on */
VI_CTRL_SERRATE_ON     EQU  0x00040         ;/* Bit 6: on if interlaced */
VI_CTRL_ANTIALIAS_MASK EQU  0x00300         ;/* Bit [9:8] anti-alias mode */
VI_CTRL_DITHER_FILTER_ON EQU  0x10000       ;/* Bit 16: dither-filter mode */
VI_NTSC_CLOCK          EQU  48681812        ;/* Hz = 48.681812 MHz */
VI_PAL_CLOCK           EQU  49656530        ;/* Hz = 49.656530 MHz */
VI_MPAL_CLOCK          EQU  48628316        ;/* Hz = 48.628316 MHz */
AI_BASE_REG            EQU  0xA4500000
AI_DRAM_ADDR_REG       EQU  (AI_BASE_REG+0x00)   ;/* R0: DRAM address */
AI_LEN_REG             EQU  (AI_BASE_REG+0x04)   ;/* R1: Length */
AI_CONTROL_REG         EQU  (AI_BASE_REG+0x08)   ;/* R2: DMA Control */
AI_STATUS_REG          EQU  (AI_BASE_REG+0x0C)   ;/* R3: Status */
AI_DACRATE_REG         EQU  (AI_BASE_REG+0x10)   ;/* R4: DAC rate 14-lsb*/
AI_BITRATE_REG         EQU  (AI_BASE_REG+0x14)   ;/* R5: Bit rate 4-lsb */
AI_CONTROL_DMA_ON      EQU  0x01            ;/* LSB = 1: DMA enable*/
AI_CONTROL_DMA_OFF     EQU  0x00            ;/* LSB = 1: DMA enable*/
AI_STATUS_FIFO_FULL    EQU  0x80000000      ;/* Bit 31: full */
AI_STATUS_DMA_BUSY     EQU  0x40000000      ;/* Bit 30: busy */
AI_MAX_DAC_RATE        EQU  16384           ;/* 14-bit+1 */
AI_MIN_DAC_RATE        EQU  132
AI_MAX_BIT_RATE        EQU  16              ;/* 4-bit+1 */
AI_MIN_BIT_RATE        EQU  2
AI_NTSC_MAX_FREQ       EQU  368000          ;/* 368 KHz */
AI_NTSC_MIN_FREQ       EQU  3000            ;/*   3 KHz ~ 2971 Hz */
AI_PAL_MAX_FREQ        EQU  376000          ;/* 376 KHz */
AI_PAL_MIN_FREQ        EQU  3050            ;/*   3 KHz ~ 3031 Hz */
AI_MPAL_MAX_FREQ       EQU  368000          ;/* 368 KHz */
AI_MPAL_MIN_FREQ       EQU  3000            ;/*   3 KHz ~ 2968 Hz */
PI_BASE_REG            EQU  0xA4600000
PI_DRAM_ADDR_REG       EQU  (PI_BASE_REG+0x00)   ;/* DRAM address */
PI_CART_ADDR_REG       EQU  (PI_BASE_REG+0x04)
PI_RD_LEN_REG          EQU  (PI_BASE_REG+0x08)
PI_WR_LEN_REG          EQU  (PI_BASE_REG+0x0C)
PI_STATUS_REG          EQU  (PI_BASE_REG+0x10)
PI_BSD_DOM1_LAT_REG    EQU  (PI_BASE_REG+0x14)
PI_BSD_DOM1_PWD_REG    EQU  (PI_BASE_REG+0x18)
PI_BSD_DOM1_PGS_REG    EQU  (PI_BASE_REG+0x1C)   ;/*   page size */
PI_BSD_DOM1_RLS_REG    EQU  (PI_BASE_REG+0x20)
PI_BSD_DOM2_LAT_REG    EQU  (PI_BASE_REG+0x24)   ;/* Domain 2 latency */
PI_BSD_DOM2_PWD_REG    EQU  (PI_BASE_REG+0x28)   ;/*   pulse width */
PI_BSD_DOM2_PGS_REG    EQU  (PI_BASE_REG+0x2C)   ;/*   page size */
PI_BSD_DOM2_RLS_REG    EQU  (PI_BASE_REG+0x30)   ;/*   release duration */
PI_DOMAIN1_REG         EQU  PI_BSD_DOM1_LAT_REG
PI_DOMAIN2_REG         EQU  PI_BSD_DOM2_LAT_REG
PI_DOM_LAT_OFS         EQU  0x00
PI_DOM_PWD_OFS         EQU  0x04
PI_DOM_PGS_OFS         EQU  0x08
PI_DOM_RLS_OFS         EQU  0x0C
PI_STATUS_ERROR        EQU  0x04
PI_STATUS_IO_BUSY      EQU  0x02
PI_STATUS_DMA_BUSY     EQU  0x01
PI_STATUS_RESET        EQU  0x01
PI_SET_RESET           EQU  PI_STATUS_RESET
PI_STATUS_CLR_INTR     EQU  0x02
PI_CLR_INTR            EQU  PI_STATUS_CLR_INTR
PI_DMA_BUFFER_SIZE     EQU  128
PI_DOM1_ADDR1          EQU  0x06000000      ;/* to 0x07FFFFFF */
PI_DOM1_ADDR2          EQU  0x10000000      ;/* to 0x1FBFFFFF */
PI_DOM1_ADDR3          EQU  0x1FD00000      ;/* to 0x7FFFFFFF */
PI_DOM2_ADDR1          EQU  0x05000000      ;/* to 0x05FFFFFF */
PI_DOM2_ADDR2          EQU  0x08000000      ;/* to 0x0FFFFFFF */
RI_BASE_REG            EQU  0xA4700000
RI_MODE_REG            EQU  (RI_BASE_REG+0x00)
RI_CONFIG_REG          EQU  (RI_BASE_REG+0x04)
RI_CURRENT_LOAD_REG    EQU  (RI_BASE_REG+0x08)
RI_SELECT_REG          EQU  (RI_BASE_REG+0x0C)
RI_REFRESH_REG         EQU  (RI_BASE_REG+0x10)
RI_COUNT_REG           EQU  RI_REFRESH_REG
RI_LATENCY_REG         EQU  (RI_BASE_REG+0x14)
RI_RERROR_REG          EQU  (RI_BASE_REG+0x18)
RI_WERROR_REG          EQU  (RI_BASE_REG+0x1C)
SI_BASE_REG            EQU  0xA4800000
SI_DRAM_ADDR_REG       EQU  (SI_BASE_REG+0x00)   ;/* R0: DRAM address */
SI_PIF_ADDR_RD64B_REG  EQU  (SI_BASE_REG+0x04)   ;/* R1: 64B PIF->DRAM */
SI_PIF_ADDR_WR64B_REG  EQU  (SI_BASE_REG+0x10)   ;/* R4: 64B DRAM->PIF */
SI_STATUS_REG          EQU  (SI_BASE_REG+0x18)   ;/* R6: Status */
SI_STATUS_DMA_BUSY     EQU  0x0001
SI_STATUS_RD_BUSY      EQU  0x0002
SI_STATUS_DMA_ERROR    EQU  0x0008
SI_STATUS_INTERRUPT    EQU  0x1000
GIO_BASE_REG           EQU  0x18000000
GIO_GIO_INTR_REG       EQU  (GIO_BASE_REG+0x000)
GIO_GIO_SYNC_REG       EQU  (GIO_BASE_REG+0x400)
GIO_CART_INTR_REG      EQU  (GIO_BASE_REG+0x800)
 LIST