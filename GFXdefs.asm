 NOLIST
G_SPNOOP               EQU  0               ;/* handle 0 gracefully */
G_MTX                  EQU  1
G_RESERVED0            EQU  2               ;/* not implemeted */
G_MOVEMEM              EQU  3               ;/* move a block of memory (up to 4 words) to dmem */
G_VTX                  EQU  4
G_RESERVED1            EQU  5               ;/* not implemeted */
G_DL                   EQU  6
G_RESERVED2            EQU  7               ;/* not implemeted */
G_RESERVED3            EQU  8               ;/* not implemeted */
G_SPRITE2D             EQU  9               ;/* sprite command */
G_SPRITE2D_BASE        EQU  9               ;/* sprite command */

G_IMMFIRST             EQU  $BF
G_SPRITE2D_SCALEFLIP   EQU  $BE
G_SPRITE2D_DRAW        EQU  $BD
G_TRI1                 EQU  $BF
G_CULLDL               EQU  $BE
G_POPMTX               EQU  $BD
G_MOVEWORD             EQU  $BC
G_TEXTURE              EQU  $BB
G_SETOTHERMODE_H       EQU  $BA
G_SETOTHERMODE_L       EQU  $B9
;    if (F3DEX2)
;G_ENDDL		       EQU  $df
;    else
G_ENDDL                EQU  $B8
;    endif
G_SETGEOMETRYMODE      EQU  $B7
G_CLEARGEOMETRYMODE    EQU  $B6
G_LINE3D               EQU  $B5
G_RDPHALF_1            EQU  $B4
G_RDPHALF_2            EQU  $B3
G_RDPHALF_CONT         EQU  $B2
G_NOOP                 EQU  0xc0            ;/*   0 */
G_SETCIMG              EQU  0xff            ;/*  -1 */
G_SETZIMG              EQU  0xfe            ;/*  -2 */
G_SETTIMG              EQU  0xfd            ;/*  -3 */
G_SETCOMBINE           EQU  0xfc            ;/*  -4 */
G_SETENVCOLOR          EQU  0xfb            ;/*  -5 */
G_SETPRIMCOLOR         EQU  0xfa            ;/*  -6 */
G_SETBLENDCOLOR        EQU  0xf9            ;/*  -7 */
G_SETFOGCOLOR          EQU  0xf8            ;/*  -8 */
G_SETFILLCOLOR         EQU  0xf7            ;/*  -9 */
G_FILLRECT             EQU  0xf6            ;/* -10 */
G_SETTILE              EQU  0xf5            ;/* -11 */
G_LOADTILE             EQU  0xf4            ;/* -12 */
G_LOADBLOCK            EQU  0xf3            ;/* -13 */
G_SETTILESIZE          EQU  0xf2            ;/* -14 */
G_LOADTLUT             EQU  0xf0            ;/* -16 */
G_RDPSETOTHERMODE      EQU  0xef            ;/* -17 */
G_SETPRIMDEPTH         EQU  0xee            ;/* -18 */
G_SETSCISSOR           EQU  0xed            ;/* -19 */
G_SETCONVERT           EQU  0xec            ;/* -20 */
G_SETKEYR              EQU  0xeb            ;/* -21 */
G_SETKEYGB             EQU  0xea            ;/* -22 */
G_RDPFULLSYNC          EQU  0xe9            ;/* -23 */
G_RDPTILESYNC          EQU  0xe8            ;/* -24 */
G_RDPPIPESYNC          EQU  0xe7            ;/* -25 */
G_RDPLOADSYNC          EQU  0xe6            ;/* -26 */
G_TEXRECTFLIP          EQU  0xe5            ;/* -27 */
G_TEXRECT              EQU  0xe4            ;/* -28 */
G_TRI_FILL             EQU  0xc8            ;/* fill triangle:            11001000 :32  bytes!!*/
G_TRI_FILL_ZBUFF       EQU  0xc9            ;/* fill, zbuff triangle:     11001001 :40 bytes!!*/
G_TRI_TXTR             EQU  0xca            ;/* texture triangle:         11001010 :136 bytes!!*/
G_TRI_TXTR_ZBUFF       EQU  0xcb            ;/* texture, zbuff triangle:  11001011 :136 bytes!!*/
G_TRI_SHADE            EQU  0xcc            ;/* shade triangle:           11001100 :136 bytes!!*/
G_TRI_SHADE_ZBUFF      EQU  0xcd            ;/* shade, zbuff triangle:    11001101 :112 bytes!!*/
G_TRI_SHADE_TXTR       EQU  0xce            ;/* shade, texture triangle:  11001110 :176 bytes!!*/
G_TRI_SHADE_TXTR_ZBUFF EQU  0xcf            ;/* shade, txtr, zbuff trngl: 11001111 :176 bytes!!*/
G_RDP_TRI_FILL_MASK    EQU  0x08
G_RDP_TRI_SHADE_MASK   EQU  0x04
G_RDP_TRI_TXTR_MASK    EQU  0x02
G_RDP_TRI_ZBUFF_MASK   EQU  0x01
G_TEXTURE_IMAGE_FRAC   EQU  2
G_TEXTURE_SCALE_FRAC   EQU  16
G_ON		       EQU  1
G_OFF		       EQU  0
G_DL_PUSH		EQU 0x00
G_DL_NOPUSH	EQU 0x01

G_SCALE_FRAC           EQU  8
G_ROTATE_FRAC          EQU  16
G_MTX_MODELVIEW        EQU  0x00            ;/* matrix types */
G_MTX_PROJECTION       EQU  0x01
G_MTX_MUL              EQU  0x00            ;/* concat or load */
G_MTX_LOAD             EQU  0x02
G_MTX_NOPUSH           EQU  0x00            ;/* push or not */
G_MTX_PUSH             EQU  0x04
G_MAXFBZ               EQU  0x3fff          ;/* 3b exp, 11b mantissa */
G_ZBUFFER              EQU  0x00000001
G_TEXTURE_ENABLE       EQU  0x00000002      ;/* Microcode use only */
G_SHADE                EQU  0x00000004      ;/* enable Gouraud interp */
G_SHADING_SMOOTH       EQU  0x00000200      ;/* flat or smooth shaded */
G_CULL_FRONT           EQU  0x00001000
G_CULL_BACK            EQU  0x00002000
G_CULL_BOTH            EQU  0x00003000      ;/* To make code cleaner */
G_FOG                  EQU  0x00010000
G_LIGHTING             EQU  0x00020000
G_TEXTURE_GEN          EQU  0x00040000
G_TEXTURE_GEN_LINEAR   EQU  0x00080000
G_LOD                  EQU  0x00100000      ;/* NOT IMPLEMENTED */
G_FOG_H                EQU  (G_FOG/0x10000)
G_LIGHTING_H           EQU  (G_LIGHTING/0x10000)
G_TEXTURE_GEN_H        EQU  (G_TEXTURE_GEN/0x10000)
G_TEXTURE_GEN_LINEAR_H EQU  (G_TEXTURE_GEN_LINEAR/0x10000)
G_LOD_H                EQU  (G_LOD/0x10000) ;/* NOT IMPLEMENTED */
G_TX_LOADTILE          EQU  7
G_TX_RENDERTILE        EQU  0
G_TX_NOMIRROR          EQU  0
G_TX_WRAP              EQU  0
G_TX_MIRROR            EQU  0x1
G_TX_CLAMP             EQU  0x2
G_TX_NOMASK            EQU  0
G_TX_NOLOD             EQU  0
G_TX_DXT_FRAC          EQU  11
G_IM_FMT_RGBA          EQU  0
G_IM_FMT_YUV           EQU 1
G_IM_FMT_CI            EQU 2
G_IM_FMT_IA            EQU 3
G_IM_FMT_I             EQU 4
G_IM_SIZ_4b            EQU 0
G_IM_SIZ_8b            EQU 1
G_IM_SIZ_16b           EQU 2
G_IM_SIZ_32b           EQU 3
G_IM_SIZ_16b_INCR      EQU 0
G_IM_SIZ_16b_SHIFT     EQU 0

G_CCMUX_COMBINED       EQU  0
G_CCMUX_TEXEL0         EQU  1
G_CCMUX_TEXEL1         EQU  2
G_CCMUX_PRIMITIVE      EQU  3
G_CCMUX_SHADE          EQU  4
G_CCMUX_ENVIRONMENT    EQU  5
G_CCMUX_CENTER         EQU  6
G_CCMUX_SCALE          EQU  6
G_CCMUX_COMBINED_ALPHA EQU  7
G_CCMUX_TEXEL0_ALPHA   EQU  8
G_CCMUX_TEXEL1_ALPHA   EQU  9
G_CCMUX_PRIMITIVE_ALPHA EQU  10
G_CCMUX_SHADE_ALPHA    EQU  11
G_CCMUX_ENV_ALPHA      EQU  12
G_CCMUX_LOD_FRACTION   EQU  13
G_CCMUX_PRIM_LOD_FRAC  EQU  14
G_CCMUX_NOISE          EQU  7
G_CCMUX_K4             EQU  7
G_CCMUX_K5             EQU  15
G_CCMUX_1              EQU  6
G_CCMUX_0              EQU  31
G_ACMUX_COMBINED       EQU  0
G_ACMUX_TEXEL0         EQU  1
G_ACMUX_TEXEL1         EQU  2
G_ACMUX_PRIMITIVE      EQU  3
G_ACMUX_SHADE          EQU  4
G_ACMUX_ENVIRONMENT    EQU  5
G_ACMUX_LOD_FRACTION   EQU  0
G_ACMUX_PRIM_LOD_FRAC  EQU  6
G_ACMUX_1              EQU  6
G_ACMUX_0              EQU  7
G_MDSFT_ALPHACOMPARE   EQU  0
G_MDSFT_ZSRCSEL        EQU  2
G_MDSFT_RENDERMODE     EQU  3
G_MDSFT_BLENDER        EQU  16
G_MDSFT_BLENDMASK      EQU  0               ;/* unsupported */
G_MDSFT_ALPHADITHER    EQU  4
G_MDSFT_RGBDITHER      EQU  6
G_MDSFT_COMBKEY        EQU  8
G_MDSFT_TEXTCONV       EQU  9
G_MDSFT_TEXTFILT       EQU  12
G_MDSFT_TEXTLUT        EQU  14
G_MDSFT_TEXTLOD        EQU  16
G_MDSFT_TEXTDETAIL     EQU  17
G_MDSFT_TEXTPERSP      EQU  19
G_MDSFT_CYCLETYPE      EQU  20
G_MDSFT_COLORDITHER    EQU  22              ;/* unsupported in HW 2.0 */
G_MDSFT_PIPELINE       EQU  23
G_PM_1PRIMITIVE        EQU  (1<<G_MDSFT_PIPELINE)
G_PM_NPRIMITIVE        EQU  (0<<G_MDSFT_PIPELINE)
G_CYC_1CYCLE           EQU  (0<<G_MDSFT_CYCLETYPE)
G_CYC_2CYCLE           EQU  (1<<G_MDSFT_CYCLETYPE)
G_CYC_COPY             EQU  (2<<G_MDSFT_CYCLETYPE)
G_CYC_FILL             EQU  (3<<G_MDSFT_CYCLETYPE)
G_TP_NONE              EQU  (0<<G_MDSFT_TEXTPERSP)
G_TP_PERSP             EQU  (1<<G_MDSFT_TEXTPERSP)
G_TD_CLAMP             EQU  (0<<G_MDSFT_TEXTDETAIL)
G_TD_SHARPEN           EQU  (1<<G_MDSFT_TEXTDETAIL)
G_TD_DETAIL            EQU  (2<<G_MDSFT_TEXTDETAIL)
G_TL_TILE              EQU  (0<<G_MDSFT_TEXTLOD)
G_TL_LOD               EQU  (1<<G_MDSFT_TEXTLOD)
G_TT_NONE              EQU  (0<<G_MDSFT_TEXTLUT)
G_TT_RGBA16            EQU  (2<<G_MDSFT_TEXTLUT)
G_TT_IA16              EQU  (3<<G_MDSFT_TEXTLUT)
G_TF_POINT             EQU  (0<<G_MDSFT_TEXTFILT)
G_TF_AVERAGE           EQU  (3<<G_MDSFT_TEXTFILT)
G_TF_BILERP            EQU  (2<<G_MDSFT_TEXTFILT)
G_TC_CONV              EQU  (0<<G_MDSFT_TEXTCONV)
G_TC_FILTCONV          EQU  (5<<G_MDSFT_TEXTCONV)
G_TC_FILT              EQU  (6<<G_MDSFT_TEXTCONV)
G_CK_NONE              EQU  (0<<G_MDSFT_COMBKEY)
G_CK_KEY               EQU  (1<<G_MDSFT_COMBKEY)
G_CD_MAGICSQ           EQU  (0<<G_MDSFT_RGBDITHER)
G_CD_BAYER             EQU  (1<<G_MDSFT_RGBDITHER)
G_CD_NOISE             EQU  (2<<G_MDSFT_RGBDITHER)
G_CD_DISABLE           EQU  (3<<G_MDSFT_RGBDITHER)
G_CD_ENABLE            EQU  G_CD_NOISE      ;/* HW 1.0 compatibility mode */
G_AD_PATTERN           EQU  (0<<G_MDSFT_ALPHADITHER)
G_AD_NOTPATTERN        EQU  (1<<G_MDSFT_ALPHADITHER)
G_AD_NOISE             EQU  (2<<G_MDSFT_ALPHADITHER)
G_AD_DISABLE           EQU  (3<<G_MDSFT_ALPHADITHER)
G_AC_NONE              EQU  (0<<G_MDSFT_ALPHACOMPARE)
G_AC_THRESHOLD         EQU  (1<<G_MDSFT_ALPHACOMPARE)
G_AC_DITHER            EQU  (3<<G_MDSFT_ALPHACOMPARE)
G_ZS_PIXEL             EQU  (0<<G_MDSFT_ZSRCSEL)
G_ZS_PRIM              EQU  (1<<G_MDSFT_ZSRCSEL)
AA_EN                  EQU  0x8
Z_CMP                  EQU  0x10
Z_UPD                  EQU  0x20
IM_RD                  EQU  0x40
CLR_ON_CVG             EQU  0x80
CVG_DST_CLAMP          EQU  0
CVG_DST_WRAP           EQU  0x100
CVG_DST_FULL           EQU  0x200
CVG_DST_SAVE           EQU  0x300
ZMODE_OPA              EQU  0
ZMODE_INTER            EQU  0x400
ZMODE_XLU              EQU  0x800
ZMODE_DEC              EQU  0xc00
CVG_X_ALPHA            EQU  0x1000
ALPHA_CVG_SEL          EQU  0x2000
FORCE_BL               EQU  0x4000
TEX_EDGE               EQU  0x0000          ;/* used to be 0x8000 */
G_BL_CLR_IN            EQU  0
G_BL_CLR_MEM           EQU  1
G_BL_CLR_BL            EQU  2
G_BL_CLR_FOG           EQU  3
G_BL_1MA               EQU  0
G_BL_A_MEM             EQU  1
G_BL_A_IN              EQU  0
G_BL_A_FOG             EQU  1
G_BL_A_SHADE           EQU  2
G_BL_1                 EQU  2
G_BL_0                 EQU  3
G_MV_VIEWPORT          EQU  0x80
G_MV_LOOKATY           EQU  0x82
G_MV_LOOKATX           EQU  0x84
G_MV_L0                EQU  0x86
G_MV_L1                EQU  0x88
G_MV_L2                EQU  0x8a
G_MV_L3                EQU  0x8c
G_MV_L4                EQU  0x8e
G_MV_L5                EQU  0x90
G_MV_L6                EQU  0x92
G_MV_L7                EQU  0x94
G_MV_TXTATT            EQU  0x96
G_MV_MATRIX_1          EQU  0x9e            ;/* NOTE: this is in moveword table */
G_MV_MATRIX_2          EQU  0x98
G_MV_MATRIX_3          EQU  0x9a
G_MV_MATRIX_4          EQU  0x9c
G_MW_MATRIX            EQU  0x00            ;/* NOTE: also used by movemem */
G_MW_NUMLIGHT          EQU  0x02
G_MW_CLIP              EQU  0x04
G_MW_SEGMENT           EQU  0x06
G_MW_FOG               EQU  0x08
G_MW_LIGHTCOL          EQU  0x0a
G_MW_POINTS            EQU  0x0c
G_MW_PERSPNORM         EQU  0x0e
G_MWO_NUMLIGHT         EQU  0x00
G_MWO_CLIP_RNX         EQU  0x04
G_MWO_CLIP_RNY         EQU  0x0c
G_MWO_CLIP_RPX         EQU  0x14
G_MWO_CLIP_RPY         EQU  0x1c
G_MWO_SEGMENT_0        EQU  0x00
G_MWO_SEGMENT_1        EQU  0x01
G_MWO_SEGMENT_2        EQU  0x02
G_MWO_SEGMENT_3        EQU  0x03
G_MWO_SEGMENT_4        EQU  0x04
G_MWO_SEGMENT_5        EQU  0x05
G_MWO_SEGMENT_6        EQU  0x06
G_MWO_SEGMENT_7        EQU  0x07
G_MWO_SEGMENT_8        EQU  0x08
G_MWO_SEGMENT_9        EQU  0x09
G_MWO_SEGMENT_A        EQU  0x0a
G_MWO_SEGMENT_B        EQU  0x0b
G_MWO_SEGMENT_C        EQU  0x0c
G_MWO_SEGMENT_D        EQU  0x0d
G_MWO_SEGMENT_E        EQU  0x0e
G_MWO_SEGMENT_F        EQU  0x0f
G_MWO_FOG              EQU  0x00
G_MWO_aLIGHT_1         EQU  0x00
G_MWO_bLIGHT_1         EQU  0x04
G_MWO_aLIGHT_2         EQU  0x20
G_MWO_bLIGHT_2         EQU  0x24
G_MWO_aLIGHT_3         EQU  0x40
G_MWO_bLIGHT_3         EQU  0x44
G_MWO_aLIGHT_4         EQU  0x60
G_MWO_bLIGHT_4         EQU  0x64
G_MWO_aLIGHT_5         EQU  0x80
G_MWO_bLIGHT_5         EQU  0x84
G_MWO_aLIGHT_6         EQU  0xa0
G_MWO_bLIGHT_6         EQU  0xa4
G_MWO_aLIGHT_7         EQU  0xc0
G_MWO_bLIGHT_7         EQU  0xc4
G_MWO_aLIGHT_8         EQU  0xe0
G_MWO_bLIGHT_8         EQU  0xe4
G_MWO_MATRIX_XX_XY_I   EQU  0x00
G_MWO_MATRIX_XZ_XW_I   EQU  0x04
G_MWO_MATRIX_YX_YY_I   EQU  0x08
G_MWO_MATRIX_YZ_YW_I   EQU  0x0c
G_MWO_MATRIX_ZX_ZY_I   EQU  0x10
G_MWO_MATRIX_ZZ_ZW_I   EQU  0x14
G_MWO_MATRIX_WX_WY_I   EQU  0x18
G_MWO_MATRIX_WZ_WW_I   EQU  0x1c
G_MWO_MATRIX_XX_XY_F   EQU  0x20
G_MWO_MATRIX_XZ_XW_F   EQU  0x24
G_MWO_MATRIX_YX_YY_F   EQU  0x28
G_MWO_MATRIX_YZ_YW_F   EQU  0x2c
G_MWO_MATRIX_ZX_ZY_F   EQU  0x30
G_MWO_MATRIX_ZZ_ZW_F   EQU  0x34
G_MWO_MATRIX_WX_WY_F   EQU  0x38
G_MWO_MATRIX_WZ_WW_F   EQU  0x3c
G_MWO_POINT_RGBA       EQU  0x10
G_MWO_POINT_ST         EQU  0x14
G_MWO_POINT_XYSCREEN   EQU  0x18
G_MWO_POINT_ZSCREEN    EQU  0x1c

G_CC_PRIMITIVE         EQUS  "0, 0, 0, PRIMITIVE, 0, 0, 0, PRIMITIVE"
G_CC_SHADE             EQUS  "0, 0, 0, SHADE, 0, 0, 0, SHADE"
G_CC_MODULATEI         EQUS  "TEXEL0, 0, SHADE, 0, 0, 0, 0, SHADE"
G_CC_MODULATEIA        EQUS  "TEXEL0, 0, SHADE, 0, TEXEL0, 0, SHADE, 0"
G_CC_MODULATEIDECALA   EQUS  "TEXEL0, 0, SHADE, 0, 0, 0, 0, TEXEL0"
G_CC_MODULATERGB       EQUS  G_CC_MODULATEI
G_CC_MODULATERGBA      EQUS  G_CC_MODULATEIA
G_CC_MODULATERGBDECALA EQUS  G_CC_MODULATEIDECALA
G_CC_MODULATEI_PRIM    EQUS  "TEXEL0, 0, PRIMITIVE, 0, 0, 0, 0, PRIMITIVE"
G_CC_MODULATEIA_PRIM   EQUS  "TEXEL0, 0, PRIMITIVE, 0, TEXEL0, 0, PRIMITIVE, 0"
G_CC_MODULATEIDECALA_PRIM EQUS  "TEXEL0, 0, PRIMITIVE, 0, 0, 0, 0, TEXEL0"
G_CC_MODULATERGB_PRIM  EQUS  G_CC_MODULATEI_PRIM
G_CC_MODULATERGBA_PRIM EQUS  G_CC_MODULATEIA_PRIM
G_CC_MODULATERGBDECALA_PRIM EQUS  G_CC_MODULATEIA_PRIM
G_CC_DECALRGB          EQUS  "0, 0, 0, TEXEL0, 0, 0, 0, SHADE"
G_CC_DECALRGBA         EQUS  "0, 0, 0, TEXEL0, 0, 0, 0, TEXEL0"
G_CC_BLENDI            EQUS  "ENVIRONMENT, SHADE, TEXEL0, SHADE, 0, 0, 0, SHADE"
G_CC_BLENDIA           EQUS  "ENVIRONMENT, SHADE, TEXEL0, SHADE, TEXEL0, 0, SHADE, 0"
G_CC_BLENDIDECALA      EQUS  "ENVIRONMENT, SHADE, TEXEL0, SHADE, 0, 0, 0, TEXEL0"
G_CC_BLENDRGBA         EQUS  "TEXEL0, SHADE, TEXEL0_ALPHA, SHADE, 0, 0, 0, SHADE"
G_CC_BLENDRGBDECALA    EQUS  "TEXEL0, SHADE, TEXEL0_ALPHA, SHADE, 0, 0, 0, TEXEL0"
G_CC_ADDRGB            EQUS  "1, 0, TEXEL0, SHADE, 0, 0, 0, SHADE"
G_CC_ADDRGBDECALA      EQUS  "1, 0, TEXEL0, SHADE, 0, 0, 0, TEXEL0"
G_CC_REFLECTRGB        EQUS  "ENVIRONMENT, 0, TEXEL0, SHADE, 0, 0, 0, SHADE"
G_CC_REFLECTRGBDECALA  EQUS  "ENVIRONMENT, 0, TEXEL0, SHADE, 0, 0, 0, TEXEL0"
G_CC_HILITERGB         EQUS  "PRIMITIVE, SHADE, TEXEL0, SHADE, 0, 0, 0, SHADE"
G_CC_HILITERGBA        EQUS  "PRIMITIVE, SHADE, TEXEL0, SHADE, PRIMITIVE, SHADE, TEXEL0, SHADE"
G_CC_HILITERGBDECALA   EQUS  "PRIMITIVE, SHADE, TEXEL0, SHADE, 0, 0, 0, TEXEL0"
G_CC_SHADEDECALA       EQUS  "0, 0, 0, SHADE, 0, 0, 0, TEXEL0"
G_CC_BLENDPE           EQUS  "PRIMITIVE, ENVIRONMENT, TEXEL0, ENVIRONMENT, TEXEL0, 0, SHADE, 0"
G_CC_BLENDPEDECALA     EQUS  "PRIMITIVE, ENVIRONMENT, TEXEL0, ENVIRONMENT, 0, 0, 0, TEXEL0"
_G_CC_BLENDPE          EQUS  "ENVIRONMENT, PRIMITIVE, TEXEL0, PRIMITIVE, TEXEL0, 0, SHADE, 0"
_G_CC_BLENDPEDECALA    EQUS  "ENVIRONMENT, PRIMITIVE, TEXEL0, PRIMITIVE, 0, 0, 0, TEXEL0"
_G_CC_TWOCOLORTEX      EQUS  "PRIMITIVE, SHADE, TEXEL0, SHADE, 0, 0, 0, SHADE"
_G_CC_SPARSEST         EQUS  "PRIMITIVE, TEXEL0, LOD_FRACTION, TEXEL0, PRIMITIVE, TEXEL0, LOD_FRACTION, TEXEL0"
G_CC_TEMPLERP          EQUS  "TEXEL1, TEXEL0, PRIM_LOD_FRAC, TEXEL0, TEXEL1, TEXEL0, PRIM_LOD_FRAC, TEXEL0"
G_CC_TRILERP           EQUS  "TEXEL1, TEXEL0, LOD_FRACTION, TEXEL0, TEXEL1, TEXEL0, LOD_FRACTION, TEXEL0"
G_CC_INTERFERENCE      EQUS  "TEXEL0, 0, TEXEL1, 0, TEXEL0, 0, TEXEL1, 0"
G_CC_1CYUV2RGB         EQUS  "TEXEL0, K4, K5, TEXEL0, 0, 0, 0, SHADE"
G_CC_YUV2RGB           EQUS  "TEXEL1, K4, K5, TEXEL1, 0, 0, 0, 0"
G_CC_PASS2             EQUS  "0, 0, 0, COMBINED, 0, 0, 0, COMBINED"
G_CC_MODULATEI2        EQUS  "COMBINED, 0, SHADE, 0, 0, 0, 0, SHADE"
G_CC_MODULATEIA2       EQUS  "COMBINED, 0, SHADE, 0, COMBINED, 0, SHADE, 0"
G_CC_MODULATERGB2      EQUS  G_CC_MODULATEI2
G_CC_MODULATERGBA2     EQUS  G_CC_MODULATEIA2
G_CC_MODULATEI_PRIM2   EQUS  "COMBINED, 0, PRIMITIVE, 0, 0, 0, 0, PRIMITIVE"
G_CC_MODULATEIA_PRIM2  EQUS  "COMBINED, 0, PRIMITIVE, 0, COMBINED, 0, PRIMITIVE, 0"
G_CC_MODULATERGB_PRIM2 EQUS  "G_CC_MODULATEI_PRIM2"
G_CC_MODULATERGBA_PRIM2 EQUS  "G_CC_MODULATEIA_PRIM2"
G_CC_DECALRGB2         EQUS  "0, 0, 0, COMBINED, 0, 0, 0, SHADE"
G_CC_DECALRGBA2        EQUS  "COMBINED, SHADE, COMBINED_ALPHA, SHADE, 0, 0, 0, SHADE"
G_CC_BLENDI2           EQUS  "ENVIRONMENT, SHADE, COMBINED, SHADE, 0, 0, 0, SHADE"
G_CC_BLENDIA2          EQUS  "ENVIRONMENT, SHADE, COMBINED, SHADE, COMBINED, 0, SHADE, 0"
G_CC_CHROMA_KEY2       EQUS  "TEXEL0, CENTER, SCALE, 0, 0, 0, 0, 0"
G_CC_HILITERGB2        EQUS  "ENVIRONMENT, COMBINED, TEXEL0, COMBINED, 0, 0, 0, SHADE"
G_CC_HILITERGBA2       EQUS  "ENVIRONMENT, COMBINED, TEXEL0, COMBINED, ENVIRONMENT, COMBINED, TEXEL0, COMBINED"
G_CC_HILITERGBDECALA2  EQUS  "ENVIRONMENT, COMBINED, TEXEL0, COMBINED, 0, 0, 0, TEXEL0"
G_CC_HILITERGBPASSA2   EQUS  "ENVIRONMENT, COMBINED, TEXEL0, COMBINED, 0, 0, 0, COMBINED"
 LIST

