ASCIITABLE:  DB "0123456789ABCDEF" 
string: DB "PEEKPOKE"
      ;  DB "P1  P2  "
      ;  DB "P3  "
      DB "COP0"
      DB "COP1"
      DB "COP2"
 cnop 0,4

showloc:       la     a0,rad
               la     a1,temp4   ;temp3 is actual loc
               lw     a2,frame2
               la     a3,ASCIITABLE
               addiu   a2,a2,$3988
               addiu   a2,a2,$6400   ;position it
               addu    d6,r0,r0      ;one line
               addiu   d11,r0,3
               addiu   d4,r0,0       ;counter to change color
               addiu   d9,r0,$3E|drawcolor     ;color
               j       nyblit
               nop
              
showposit:     la      a0,rad
               lw      d0,position2   ;position2 is actual loc
               srl     d0,d0,1
               sw      d0,positvalue
               la      a1,positvalue
               lw      a2,frame2
               la      a3,ASCIITABLE
               addiu   a2,a2,$4D88
               addiu   a2,a2,$6400   ;position it
               addu    d6,r0,r0      ;one line
               addiu   d11,r0,3
               addiu   d4,r0,0       ;counter to change color
               addiu   d9,r0,$3E|drawcolor     ;color
               j       nyblit
               nop
positvalue: DW 0

showmem:       la      a0,rad
               la      a1,memory  ;where to look in mem
               lw      a2,frame2
               la      a3,ASCIITABLE
               addiu   a2,a2,$280*10+(16*2)   ;position it
               addiu   d6,r0,3       ;numba of lines
               addiu   d4,r0,0       ;counter to change colors
               addiu   d9,r0,$3E|drawcolor     ;color

nextline:      addiu   d11,r0,15     ;numba of charsx2
nyblit:        lbu     d0,0(a1)      ;load byte->d0
               addiu   a1,a1,1
               addu    d10,r0,d0     ;move value to d10
               srl     d0,d0,4
               addu    a5,a3,d0      ;get ascii value
               lbu     d0,0(a5)

               beql    d4,r0,addspace
               addiu   a2,a2,8
addspace:      addiu   d4,d4,-1
               andi    d4,d4,3
               addiu   d8,r0,1       ;do both nibbles
               
nextchar:     
               addiu   d7,r0,7       ;numba of pixls high
               andi    d0,d0,$3F
               sll     d0,d0,3
               addu    a5,a0,d0
nextbyte:      lbu     d0,0(a5)
               addiu   a5,a5,1       ;inc pointer
               addiu   d2,r0,7       ;shifter
               addiu   d3,r0,7       ;counter
nextbit:       srlv    d1,d0,d2    
               andi    d1,d1,1
               beq     d1,r0,dontblit
               addiu   d2,d2,-1    ;dec shifter
               sh      d9,0(a2)
dontblit:      addiu   a2,a2,2
               bne     d3,r0,nextbit
               addiu   d3,d3,-1      ;dec counter
               addiu   a2,a2,$270    ;add modulo
               bne     d7,r0,nextbyte
               addiu   d7,d7,-1
               addiu   a2,a2,$FFFFEC10   ;reset screen position
               addu    d0,d10,r0     ;move d10 to d0
               andi    d0,d0,$F      ;just the low nibble
               addu    a5,a3,d0
               lbu     d0,0(a5)      ;get ascii of low nibble
               bne     d8,r0,nextchar
               addiu   d8,d8,-1
               bne     d11,r0,nyblit
               addiu   d11,d11,-1
               addiu   a2,a2,$1460
               bne     d6,r0,nextline
               addiu   d6,d6,-1
               jr      ra
               nop

peekmem:
               lw    a0,temp3        ;where to peek
               la    a1,memory       ;where to store
               lw    d0,xstat   ;0=peek
               addiu d1,r0,15        ;16 words copy
               addiu d2,r0,1
               beq   d0,d2,nopeeking
               addiu d2,r0,2
               beq   d0,d2,peekfromcop0
memblit:       lw    d0,0(a0)
               addiu  a0,a0,4
               sw    d0,0(a1)
               addiu a1,a1,4
               bne   d1,r0,memblit
               addiu d1,d1,-1
nopeeking:     jr ra
               nop
peekfromcop0:   mfc0  d0,r8
               sw    d0,0(a1)
               addiu a1,a1,4
               la    a2,peekfromcop0|$A0000000
               lw    d2,0(a2)
               sync
               move  d0,d2
               srl   d0,d0,11
               addiu d0,d0,1
               andi  d0,d0,%11111
               sll   d0,d0,11
               and   d2,~(%11111<<11)
               or    d2,d2,d0
               sw    d2,0(a2)    ;modify code
               sync
               cache $10,0(a2)
               nop
               bne   d1,r0,peekfromcop0
               addiu d1,d1,-1
               lw    d0,opcode
               sw    d0,0(a2)
               cache $10,0(a2)
               jr ra
               nop
opcode:  mfc0 d0,r8

pokemem:       lw    a1,temp3
               lw    d0,position2
               srl   d0,d0,1      ;only poke where the cursor is at
               andi  d0,d0,$FFFC
               addu  a1,a1,d0
               la    a0,memory
               addu  a0,a0,d0
               addiu d1,r0,0         ;only one word
               j     memblit
               nop

adjustmem:  lbu     d0,0(a0)     ;a0=mem to adjust
            andi    d2,d1,1      ;d1=position
            beql    d2,r0,uppernib
            addu    d9,d0,d3     ;d3=$10 for up,$FFF0 for down
            addu    d9,d0,d4     ;d4=1 for up  ,$FFFF for down
uppernib:   sb      d9,0(a0)     ;put back
            jr      ra
            nop

textdraw:      addu     t1,a0,r0    ;A0=SOURCE OF TEXT (T1)
               lbu      t1,0(t1)   
            ;   addiu    t1,t1,-1   ;account for missing null
               andi     t1,t1,$3F   
               sll      t2,t1,7       ;A2=NUMBA OF CHARACTERS
               la       t1,pixels  ;POINTER TO TEXT GRAPHICS
               
               add     t1,t1,t2
               addiu   t9,r0,7
line2:         addiu   t8,r0,7
line1:         lhu     t3,0(t1)   ;CHARSET IS 8x8 pixels
               beq     t3,r0,dontdraw          ;16x16 bytes
               addiu   t1,t1,2
          xori t3,(1&(~drawcolor))
               sh      t3,0(a1)
dontdraw:      addiu   a1,a1,2
               bne     t8,r0,line1
               addiu   t8,t8,-1
               addiu   a1,a1,$270   ;ADD MODULO FOR SCREEN(640-16)
               bne     t9,r0,line2
               addiu   t9,t9,-1
               addiu   a1,a1,$FFFFEC10   ;SET SCREEN POSITION BACK TO START+16
               addiu   a0,a0,1
               bne     a2,r0,textdraw
               addiu   a2,a2,-1
               jr      ra
               nop



cursor:        lw   a0,frame2
               lw   d0,position1
               addiu   a0,a0,$3990
               addiu   a0,a0,$6400   ;screen place
               addiu  d1,r0,16
               multu  d1,d0
               mflo   d0
               addu   a0,a0,d0       ;place it
               lw     d2,color      ;green\red color
               ori    d2,drawcolor
               addiu  d4,r0,7       ;numba of pixels tall
blit2:         addiu  d5,r0,7       ;pixels wide
blit1:         sh     d2,0(a0)
               addiu  a0,a0,2
               bne    d5,r0,blit1
               addiu  d5,d5,-1
               addiu  a0,a0,$270
               bne    d4,r0,blit2
               addiu  d4,d4,-1
               jr  ra
               nop

cursor2:       lw   a0,frame2
               lw   d0,position2
               addiu   a0,a0,$280*10+(16*2)+8  ;position on screen
               addiu   d1,r0,32
               divu    d0,d1
               mflo    d3           ;position/32
               nop
               nop
               mult    d3,d1        ;*32
               mflo    d4
               subu    d0,d0,d4     ;position-((position/32)*32)

               addiu  d2,r0,$1680
               mult   d2,d3         ;1680 * position/32
               mflo   d2
               nop
               addu   a0,a0,d2
               
               addiu  d1,r0,16
               multu  d1,d0
               mflo   d9
               andi   d0,d0,$18      ;account for spaces
               addu   a0,a0,d0       ;add amount for #od spaces
               addu   a0,a0,d9       ;place it
               lw     d2,color2      ;green\red color
               ori    d2,drawcolor
               addiu  d4,r0,7       ;numba of pixels tall
blit2b:        addiu  d5,r0,7       ;pixels wide
blit1b:        sh     d2,0(a0)
               addiu  a0,a0,2
               bne    d5,r0,blit1b
               addiu  d5,d5,-1
               addiu  a0,a0,$270
               bne    d4,r0,blit2b
               addiu  d4,d4,-1
               jr  ra
               nop

tellstatus:    lw     a1,frame2
               ori    d1,r0,$C590
               addu   a1,a1,d1       ;position on screen
               lw     d0,xstat
               sll    d0,d0,2
               la     a0,string
               addu   a0,a0,d0       ;draw either PEEK/poke
               addiu  a2,r0,3        ;number of characters
               j      textdraw
               nop

memory: DCB 64,0

rad:
 incbin 64fonts
 cnop 0,4
pixels:
 incbin new84.AA
