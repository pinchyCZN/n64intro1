gsLoadTextureBlock       macro
                
                dw      (G_SETTIMG<<24)|(G_IM_FMT_RGBA<<21)|(G_IM_SIZ_16b<<19)
                dw      \1\&$FFFFFF
                      
                dw      (G_SETTILE<<24)|(G_IM_FMT_RGBA<<21)|(G_IM_SIZ_16b<<19)
                dw      (G_TX_LOADTILE<<24)

                dw      G_RDPLOADSYNC<<24
                dw      0

  dw      (G_LOADBLOCK<<24)
   if ((\2\*2)>>3=0)
  dw    (G_TX_LOADTILE<<24)|(1<<G_TX_DXT_FRAC)
   else
  dw    (G_TX_LOADTILE<<24)|((\2\*\3\-1)<<12)|(((1<<G_TX_DXT_FRAC)+(\2\>>2)-1)/(\2\>>2))
   endif
  dw G_RDPPIPESYNC<<24
  dw 0

  dw (G_SETTILE<<24)|(G_IM_FMT_RGBA<<21)|(G_IM_SIZ_16b<<19)|((((\2\<<1)+7)>>3)<<9)
  dw (G_TX_RENDERTILE<<24)

  dw (G_SETTILESIZE<<24)
  dw (G_TX_RENDERTILE<<24)|((\2\-1)<<(G_TEXTURE_IMAGE_FRAC+12))|((\3\-1)<<G_TEXTURE_IMAGE_FRAC)

  endm

gsVertex        macro
        dw      $04000000|(\2\*$10)|((((\2\-1)<<4)|\3\)<<16)
        dw      \1\&$FFFFFF
        endm

gsTRI1  macro
        dw      $BF000000
        dw      ((\1\*10)<<16)|((\2\*10)<<8)|(\3\*10)
        endm


gsViewport      macro
        dw      $03000000|($80<<16)|$10
        dw      \1\
        endm

gsSetScissor    macro
        dw      (G_SETSCISSOR<<24)|(\1\<<14)|(\2\<<2)
        dw      (\3\<<14)|(\4\<<2)
        endm

gsSetfillcolor  macro
        dw      G_SETFILLCOLOR<<24
rval1 = (\1\>>3)<<11
gval1 = (\2\>>3)<<6
bval1 = (\3\>>3)<<1
        dw      (rval1|gval1|bval1|\4\)|((rval1|gval1|bval1|\4\)<<16)
        endm
gsSetPrimColor  macro
        dw      G_SETPRIMCOLOR<<24
        dw      (\1\<<24)|(\2\<<16)|(\3\)<<8)|\4\
        endm
gsSetBlendColor  macro
        dw      G_SETBLENDCOLOR<<24
        dw      (\1\<<24)|(\2\<<16)|(\3\)<<8)|\4\
        endm
gsSetFogColor  macro
        dw      G_SETFOGCOLOR<<24
        dw      (\1\<<24)|(\2\<<16)|(\3\)<<8)|\4\
        endm

gsFillRectangle      macro
        dw      (G_FILLRECT<<24)|(\3\<<14)|(\4\<<2)
        dw      (\1\<<14)|(\2\<<2)
        endm
gsSetColorImage         macro
        dw      (G_SETCIMG<<24)|(G_IM_FMT_RGBA<<21)|(G_IM_SIZ_16b<<19)|$13F
        dw      \1\
        endm
gsSetDepthImage macro
        dw      (G_SETZIMG<<24)
        dw      \1\
        endm
gsMatrix        macro
        dw      $01000000|$40|(\2\<<16)
        dw      \1\
        endm
gsSetLights1       macro
        dw      (G_MOVEWORD<<24)|(G_MWO_NUMLIGHT<<8)|(G_MW_NUMLIGHT)
        dw      (((1)+1)*32+0x80000000)

        dw      (G_MOVEMEM<<24)|((((1)-1)*2+G_MV_L0)<<16)|(4*4)
        dw      \1\+8
        dw      (G_MOVEMEM<<24)|((((2)-1)*2+G_MV_L0)<<16)|(4*4)
        dw      \1\
        endm
gsTexture       macro
        dw      $BB000000|(\3\<<11)|(\4\<<8)|\5\
        dw      (\1\<<16)|(\2\&$FFFF)
        endm
gsPerspective   macro
        dw      $BC000000|$0E
        dw      \1\
        endm
gsPipelineMode      macro
        dw      ($BA<<24)|(23<<8)|1  
        dw      \1\
        endm

gsSetCycleType     macro
        dw      ($BA<<24)|(20<<8)|2  
        dw      \1\
        endm


gsTextureDetail macro
        dw      (G_SETOTHERMODE_H<<24)|(G_MDSFT_TEXTDETAIL<<8)|2
        dw      \1\
        endm
gsTexturePersp  macro
        dw      (G_SETOTHERMODE_H<<24)|(G_MDSFT_TEXTPERSP<<8)|1
        dw      \1\
        endm
gsTextureLOD    macro
        dw      (G_SETOTHERMODE_H<<24)|(G_MDSFT_TEXTLOD<<8)|1
        dw      \1\
        endm
gstextureLUT    macro
        dw      (G_SETOTHERMODE_H<<24)|(G_MDSFT_TEXTLUT<<8)|2
        dw      \1\
        endm

gstexturefilter macro
        dw      (G_SETOTHERMODE_H<<24)|(G_MDSFT_TEXTFILT<<8)|2
        dw      \1\
        endm
gstextureconvert        macro
        dw      (G_SETOTHERMODE_H<<24)|(G_MDSFT_TEXTCONV<<8)|3
        dw      \1\
        endm
gsCombineKey    macro
        dw      (G_SETOTHERMODE_H<<24)|(G_MDSFT_COMBKEY<<8)|1
        dw      \1\
        endm
gsColorDither   macro

        dw      (G_SETOTHERMODE_H<<24)|(G_MDSFT_COLORDITHER<<8)|2
        dw      \1\
        endm

gsAlphaCompare  macro
        dw      (G_SETOTHERMODE_L<<24)|(G_MDSFT_ALPHACOMPARE<<8)|2
        dw      \1\
        endm

gsAlphaDither  macro
        dw      (G_SETOTHERMODE_H<<24)|(G_MDSFT_ALPHADITHER<<8)|2
        dw      \1\
        endm
gsRendermode macro
        dw      (G_SETOTHERMODE_L<<24)|(G_MDSFT_RENDERMODE<<8)|29
        dw      (muxo1val|muxo2val)
        endm
gsCombineMode    macro   a0, b0, c0, d0, Aa0, Ab0, Ac0, Ad0,a1, b1, c1, d1, Aa1, Ab1, Ac1, Ad1

GCCc0w0 = (G_CCMUX_\a0\<<20)|(G_CCMUX_\c0\<<15)|(G_ACMUX_\Aa0\<<12)|(G_ACMUX_\Ac0\<<9)
GCCc1w0 = (G_CCMUX_\a1\<<5)|(G_CCMUX_\c1\)
GCCc0w1 = (G_CCMUX_\b0\<<28)|(G_CCMUX_\d0\<<15)|(G_ACMUX_\Ab0\<<12)|(G_ACMUX_\Ad0\<<9)
GCCc1w1 = (G_CCMUX_\b1\<<24)|(G_ACMUX_\Aa1\<<21)|(G_ACMUX_\Ac1\<<18)|(G_CCMUX_\d1\<<6)|(G_ACMUX_\Ab1\<<3)|(G_ACMUX_\Ad1\)
        dw      (G_SETCOMBINE<<24)|(GCCc0w0|GCCc0w1)
        dw      (GCCc0w1|GCCc1w1)
        endm
               
gsPipeSync       macro
        dw      $E7000000
        dw      0
        endm

gsCleargeometryMode     macro
        dw      $B6000000
        dw      \1\
        endm
gsSetGeometryMode       macro
        dw      $B7000000
        dw      \1\
        endm    

gsDisplaylist   macro
        dw      (G_DL<<24)|(G_DL_PUSH<<16)
        dw      \1\&$FFFFFF
        endm

gsEnddisplaylist macro
        dw     $B8000000
        dw      0
        endm

gsSpriteinit    macro
        dw      (G_DL<<24)|(G_DL_PUSH<<16)
        dw      spinitdata&$FFFFFF
        endm
