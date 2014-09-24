gSegment        macro           ;(base,segment,glist)
                if narg=2
                li      a0,0
                else
                la      a0,\1
                shift

                endif

                li      a1,\1
                lw      a3,\2
                jal     SPsegment
                nop
                sw      a3,\2
                endm

gSpriteInit     macro
                la      a0,spinitdata
                lw      a1,\1
                jal     SPdisplaylist
                nop
                sw      a1,\1
                endm

gMatrix         macro    ;matrix,params,glistp
                la      a0,\1
                li      a1,\2
                lw      a2,\3
                jal     SPmatrix
                nop
                sw      a2,\3
                endm

gViewport       macro   ;(viewport)
                la      a0,\1
                lw      a1,\2
                jal     SPviewport
                nop
                sw      a1,\2
                endm
gSetLights1     macro
                la      a0,\1
                lw      a1,\2
                jal     SPLights1
                nop
                sw      a1,\2
                endm



gSetScissor     macro           ;0, 0, SCREEN_WD, SCREEN_HT
                li      a0,\1\<<2
                li      a1,\2\<<2
                li      a2,\3\<<2
                li      a3,\4\<<2
                lw      a4,\5
                jal     DPsetscissor
                nop
                sw      a4,\5
                endm

gSetFillColor   macro
rval1 = (\1\>>3)<<11
gval1 = (\2\>>3)<<6
bval1 = (\3\>>3)<<1
  li      a0,(rval1|gval1|bval1|\4\)|((rval1|gval1|bval1|\4\)<<16)
                lw      a1,\5
                jal     DPsetfillcolor
                nop
                sw      a1,\5
                endm

gFillRectangle  macro
                li      a0,\1
                li      a1,\2
                li      a2,\3
                li      a3,\4
                lw      a4,\5
                jal     DPfillrectangle
                nop
                sw      a4,\5
                endm

gSetColorImage  macro
                lw      a0,\1
                lw      a1,\2
                jal     DPsetcolorimage
                nop
                sw      a1,\2
                endm
gSetDepthImage  macro
                lw      a0,\1
                lw      a1,\2
                jal     DPsetdepthimage
                nop
                sw      a1,\2
                endm


gTextureLOD  macro
                li      a0,\1
                lw      a1,\2
                jal     DPtextureLOD
                nop
                sw      a4,\2
                endm

gTextureLUT  macro
                li      a0,\1
                lw      a1,\2
                jal     DPtextureLUT
                nop
                sw      a4,\2
                endm
gTextureDetail     macro
                li      a0,\1
                lw      a1,\2
                jal     DPtexturedetail
                nop
                sw      a4,\2
                endm
gTexturePersp        macro
                li      a0,\1
                lw      a1,\2
                jal     DPtexturepersp
                nop
                sw      a4,\2
                endm
gTextureFilter  macro
                li      a0,\1
                lw      a1,\2
                jal     DPtexturefilter 
                nop
                sw      a4,\2
                endm

gTextureConvert macro
                li      a0,\1
                lw      a1,\2
                jal     DPtextureconvert
                nop
                sw      a4,\2
                endm

gCombineKey     macro
                li      a0,\1
                lw      a1,\2
                jal     DPcombinekey
                nop
                sw      a4,\2
                endm




gAlphaCompare   macro
                li      a0,\1
                lw      a1,\2
                jal     DPalphacompare  
                nop
                sw      a4,\2
                endm

gAlphaDither    macro
                li      a0,\1
                lw      a1,\2
                jal     DPalphadither   
                nop
                sw      a4,\2
                endm

gColorDither    macro
                li      a0,\1
                lw      a1,\2
                jal     DPcolordither
                nop
                sw      a4,\2
                endm


gCombineMode    macro   a0, b0, c0, d0, Aa0, Ab0, Ac0, Ad0,a1, b1, c1, d1, Aa1, Ab1, Ac1, Ad1

GCCc0w0 = (G_CCMUX_\a0\<<20)|(G_CCMUX_\c0\<<15)|(G_ACMUX_\Aa0\<<12)|(G_ACMUX_\Ac0\<<9)
GCCc1w0 = (G_CCMUX_\a1\<<5)|(G_CCMUX_\c1\)
GCCc0w1 = (G_CCMUX_\b0\<<28)|(G_CCMUX_\d0\<<15)|(G_ACMUX_\Ab0\<<12)|(G_ACMUX_\Ad0\<<9)
GCCc1w1 = (G_CCMUX_\b1\<<24)|(G_ACMUX_\Aa1\<<21)|(G_ACMUX_\Ac1\<<18)|(G_CCMUX_\d1\<<6)|(G_ACMUX_\Ab1\<<3)|(G_ACMUX_\Ad1\)
                li      r4,(GCCc0w0|GCCc0w1)
                li      r5,(GCCc0w1|GCCc1w1)
                lw      a2,\17
                jal     DPCombineLerp
                nop
                sw      a2,\17
                endm


GBL_c1          macro   m1a,m1b,m2a,m2b
GBL_c1value     = (m1a<<30)|(m1b<<26)|(m2a<<22)|(m2b<<18)
                endm
GBL_c2          macro   m1a,m1b,m2a,m2b
GBL_c2value     = (m1a<<28)|(m1b<<24)|(m2a<<20)|(m2b<<16)
                endm
G_RM_OPA_SURF             macro
                GBL_c\1\ G_BL_CLR_IN, G_BL_0, G_BL_CLR_IN, G_BL_1

muxo\1\val =   CVG_DST_CLAMP|FORCE_BL|ZMODE_OPA|GBL_c\1\value

                endm

G_RM_AA_ZB_OPA_TERR       macro
                GBL_c\1\    G_BL_CLR_IN, G_BL_A_IN, G_BL_CLR_MEM, G_BL_1MA
muxo\1\val =    AA_EN|Z_CMP|Z_UPD|IM_RD|CVG_DST_CLAMP|ZMODE_OPA|ALPHA_CVG_SEL|GBL_c\1\value
                endm

G_RM_PASS       macro
                GBL_c1 G_BL_CLR_IN, G_BL_0, G_BL_CLR_IN, G_BL_1
muxo1val        =   GBL_c1value
                endm
G_RM_AA_XLU_SURF        MACRO
                GBL_c\1\  G_BL_CLR_IN, G_BL_A_IN, G_BL_CLR_MEM, G_BL_1MA
muxo\1\val =    AA_EN|IM_RD|CVG_DST_WRAP|CLR_ON_CVG|FORCE_BL|ZMODE_OPA
                ENDM

gRenderMode     macro


                li      a0,(muxo1val|muxo2val)
                lw      a2,\1\
                jal     DPsetrendermode
                nop
                sw      a4,\1\
                endm

gVertex         macro      ;(address,number,index,glist)
                la      a0,\1
                li      a1,\2
                li      a2,\3
                lw      a4,\4
                jal     SPvertex
                nop
                sw      a4,\4
                endm
gTRi1           macro           ;v0,v1,v2,flag,glist
                li      a0,\1
                li      a1,\2
                li      a2,\3
                li      a3,\4
                lw      a4,\5
                jal     SPtri1
                nop
                sw      a4,\5
                endm

gTexture        macro   ;s,t,level,tile,G_on,glist)
                li      a0,\1
                li      a1,\2
                li      a2,\3
                li      a3,\4
                li      a4,\5
                lw      a5,\6
                jal     SPtexture
                nop
                sw      a5,\6
                endm

gLoadTextureBlock       macro   ;addy of data, xsize,ysize,glist
                la      a0,\1
                li      a1,\2
                li      a2,\3
                lw      a3,\4
                jal     DPloadtextureBlock
                nop
                sw      a3,\4
                endm

gTextureRectangle       macro
                li      a0,\1
                li      a1,\2
                li      a2,\3
                li      a3,\4
                lw      a4,\5
                jal     SPtexturerectangle
                nop
                sw      a4,\5
                endm

gSetPrimColor   macro
                li      a0,(\1\<<24)|(\2\<<16)|(\3\<<8)|(\4\)
                lw      a1,\5
                jal     DPsetprimcolor
                nop
                sw      a1,\5
                endm
gSetEnvColor   macro
                li      a0,(\1\<<24)|(\2\<<16)|(\3\<<8)|(\4\)
                lw      a1,\5
                jal     DPsetenvcolor
                nop
                sw      a1,\5
                endm

gSetBlendColor   macro
                li      a0,(\1\<<24)|(\2\<<16)|(\3\<<8)|(\4\)
                lw      a1,\5
                jal     DPsetblendcolor
                nop
                sw      a1,\5
                endm


gPerspective    macro   ;perspective.glist
                lw      a0,\1
                lw      a1,\2
                jal     SPperspective
                nop
                sw      a1,\2
                endm

gPIPElinemode       macro   ;pipeline,glist
                li      a0,\1
                lw      a1,\2
                jal     DPpipeline
                nop
                sw      a4,\2
                endm
gSetCycletype      macro        ;type,glist
                li      a0,\1
                lw      a1,\2
                jal     DPcycletype
                nop
                sw      a4,\2
                endm
gSETrendermode  macro   ;mode1,mode2,glistp
                li      a0,\1|\2
                lw      a2,\3
                jal     DPsetrendermode
                nop
                sw      a4,\2
                endm
gCLEARgeometrymode      macro
                ;modes,glistp
                li      a0,\1
                lw      a2,\2
                jal     SPclearGeometrymode
                nop
                sw      a2,\2
                endm
gSETgeometrymode        macro
                ;modes.glistp
                li      a0,\1
                lw      a2,\2
                jal     SPsetGeometrymode
                nop
                sw      a2,\2
                endm
gPIPEsync       macro
                lw      a0,\1
                li      t0,$E7000000
                sw      t0,0(a0)
                sw      r0,4(a0)
                addu    a0,8
                sw      a0,\1
                endm
gTILEsync       macro
                lw      a0,\1
                li      t0,$E8000000
                sw      t0,0(a0)
                sw      r0,4(a0)
                addu    a0,8
                sw      a0,\1
                endm
gFULLsync       macro
                lw      a0,\1
                li      t0,$E9000000
                sw      t0,0(a0)
                sw      r0,4(a0)
                addu    a0,8
                sw      a0,\1
                endm

gNOop           macro
                lw      a0,\1
                li      t0,$c0000000
                sw      t0,0(a0)
                sw      r0,4(a0)
                addu    a0,8
                sw      a0,\1
                endm
                



gENDdisplaylist macro
                lw      a2,\1
                jal     SPendDisplaylist
                nop
                sw      a2,\1
                endm

        
gDisplaylist    macro
                la      a0,\1
                lw      a1,\2
                jal     SPdisplaylist
                nop
                sw      a1,\2
                endm

