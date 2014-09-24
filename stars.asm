
RNDplot:       lui     a0,$A410
               lw      a1,positioner
               lw      d9,antstars    ;number of stars
               addu    d9,2000
               addiu   d1,r0,1245
               addiu   d2,r0,13
               addiu   d3,r0,2
RNDLoop:       lw      d0,$10(a0)
               mult    d0,d1
               mflo    d0
               addiu   d0,d0,$100
               andi    d0,d0,$1FF
               addiu   d0,d0,$FFFFFF00
               sh      d0,0(a1)
               mult    d2,d1
               mflo    d1
               addu    d2,d2,d3
               lw      d0,$10(a0)
               sll     d1,d1,16
               sra     d1,d1,16
               mult    d1,d0
               mflo    d0
               addiu   d0,d0,$100
               andi    d0,d0,$1FF
               addiu   d0,d0,$FFFFFF00
               sh      d0,2(a1)
               mult    d2,d1
               mflo    d1
               addu    d2,d2,d3
               lw      d0,$10(a0)
               sll     d1,d1,16
               sra     d1,d1,16
               mult    d1,d0
               mflo    d0
               addiu   d0,d0,$100
               andi    d0,d0,$1FF
               addiu   d0,d0,$FFFFFF00
               sh      d0,4(a1)
               mult    d2,d1
               mflo    d1
               addu    d2,d2,d3
               sll     d1,d1,16
               sra     d1,d1,16
               addiu   a1,a1,6
               addiu   d9,d9,-1
               bne     d9,r0,RNDLoop
               nop
               jr ra
               nop
ADDz:        lw    a0,positioner
             addiu d0,r0,511
             lw    d1,Zadd
             addiu d3,r0,256
             lw    d7,antstars  ;number of stars
ZLoop:       lh    d2,4(a0)        ;(y,x,z) format
             addu  d2,d2,d3
             addu  d2,d2,d1
             and   d2,d2,d0
             subu  d2,d2,d3
             sh    d2,4(a0)
             addiu a0,a0,6
             bne   d7,r0,ZLoop
             addiu d7,d7,$FFFFFFFF
             jr ra
             nop


positioner: dw $80200000
antstars dw 300    ;490

Vadds:   DW 3,0,0
Vinklar: DW 0,0,0
zoom:    DW 50   ;180 is good
;xcenter: DW 16
;ycenter: DW 16
Zadd:    dw -11

drawstars:  la      a0,sinuslist
            addiu   a1,a0,254    ;cos
            la      a3,Vinklar
            lw      a4,positioner
            lw      a9,antstars    ;number of stars
@plotloop:
            lh  d0,0(a4)     ;coords
            lh  d1,2(a4)
            lh  d2,4(a4)
            lw  d3,0(a3)     ;angles
            lw  d4,4(a3)
            lw  d5,8(a3)
      sll  d3,d3,1   ;rotate 3 points with 3 angles
      sll  d4,d4,1   ;d0-d2  points (x,y,z)
      sll  d5,d5,1   ;d3-d5  angles (dx,dy,dz)
      addu a2,a0,d3  ;a0,a1  pointers to sin cos table
      lh   d6,0(a2)   ;sin(+x)
      mult d2,d6
      mflo d9         ;z*sin(+x)
      addu a2,a1,d3
      lh   d7,0(a2)   ;cos(+x)
      mult d1,d7
      mflo d10        ;y*cos(+x)
      subu d9,d10,d9  ;y*cos(+x)-z*sin(+x)
      sra  d9,d9,14   ;Y1/$4000
      mult d1,d6
      mflo d6         ;y*sin(+x)
      nop
      nop
      mult d2,d7
      mflo d7         ;z*cos(+x)
      addu d3,d7,d6   ;z*cos(+x)+ysin(+x)
      sra  d3,d3,14   ;Z1 /$4000
      addu a2,a0,d4
      lh   d6,0(a2)   ;sin(+y)
      mult d3,d6
      mflo d8         ;Z1*sin(+y)
      addu a2,a1,d4
      lh   d7,0(a2)   ;cos(+y)
      mult d0,d7
      mflo d10        ;x*cos(+y)
      subu d4,d10,d8  ;x*cos(+y)-z*sin(+y)
      sra  d4,d4,14   ;X2 /$4000
      mult d0,d6
      mflo d6         ;z*sin(+y)
      nop
      nop
      mult d3,d7
      mflo d7         ;Z1*cos(+y)
      addu d2,d7,d6   ;x*sin(+y) + Z1*cos(+y)
      sra  d2,d2,14   ;final z coordinate
      addu a2,a0,d5
      lh   d6,0(a2)   ;sin(+z)
      mult d6,d9
      mflo d10        ;Y1 * sin(+z)
      addu a2,a1,d5
      lh   d7,0(a2)   ;cos(+z)
      mult d7,d4
      mflo d11        ;X2 * cos(+z)
      subu d0,d11,d10 ;X2*cos(+z)-Y1*sin(+z)
      sra  d0,d0,14   ;final X coordinate
      mult d4,d6
      mflo d6         ;X2*sin(+z)
      nop
      nop
      mult d9,d7
      mflo d7         ;Y1*cos(+z)
      addu d1,d6,d7   ;X2*sin(+z)+Y1*cos(+z)
      sra  d1,d1,14   ;final y coordinate

      addiu a4,a4,6     ;increment coord  pointer

      addiu d2,d2,256    ;make values 0<z<512
      blez  d2,@skip
      bgt   d2,511,@skip

      lw    d3,zoom
      mult  d3,d0     ;x*zoom
      mflo  d0
      nop
      nop
      div   d0,d2     ;/z
      mflo  d0        ;projected x
      nop
      nop
      mult  d3,d1     ;y*zoom
      mflo  d1
      nop
      nop
      div   d1,d2     ;/z
      mflo  d1        ;projected y

      addu  d0,16
      bltz  d0,@skip
      bgt   d0,31,@skip
      sll   d0,1
      addu  d1,16
      bltz  d1,@skip
      bgt   d1,31,@skip
      li    d3,32*2
      multu d3,d1
      mflo  d1
      addu  d0,d1
      la    a5,texture|$A0000000
      addu  a5,d0
;      negu  d2
;      addu  d2,511
      srl   d2,4
      sll   d4,d2,5+5+1
      sll   d3,d2,5+1
      or    d4,d3
      sll   d2,1
      or    d4,d2
      or    d4,1


      sh    d4,0(a5)

@skip
      addiu a9,a9,-1
      bgtz  a9,@plotloop
      nop

      jr        ra
      nop
addangles:
         li    d8,3

@loop:
         lw    d0,0(a0)       ;vadd
         lw    d1,4*3(a0)      ;vinklar
         addu  d0,d0,d1       ;x+[x]
         andi  d0,d0,511      ;keep <511
         sw    d0,4*3(a0)
         addiu d8,d8,-1
         bnez  d8,@loop
         addiu a0,a0,4
         jr ra
         nop



sinuslist:
 incbin sinus
