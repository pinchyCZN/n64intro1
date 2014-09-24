; modikbuffer needs to be defined somewhere
;----------------------------------
;module player
MODIK_SONGLENGTH       equ 0
MODIK_SONGLOOP         equ 4
MODIK_NUMBERPATTERNS   equ 8
MODIK_SAMPLESDATAPOS   equ 12

MODIK_PATTERNSORDER    equ $20
MODIK_SAMPLESINFO      equ $a0
MODIK_PATTERNS         equ $480

VOIX_POS               equ 0
VOIX_STEP              equ 4
VOIX_SAMPLE            equ 8
VOIX_VOLUME            equ 12
VOIX_EQUALIZER         equ 16
VOIX_ChanInfoLength    equ 20

SAMPLE_POS             equ 0
SAMPLE_LONG            equ 4
SAMPLE_VOLUME          equ 8
SAMPLE_FINETUNE        equ 12
SAMPLE_REPSTART        equ 16
SAMPLE_REPEND          equ 20
NOTE_SAMPLENUMBER      equ 0
NOTE_PERIODFREQ        equ 4
NOTE_EFFECTNUMBER      equ 8
NOTE_EFFECTPARAMETER   equ 12

TICK_LENGTH            equ 880
modikspeed equ 4
;module player end
;-----------------------------------




;±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
; CODE
;±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

updatemod:
        lui     d0,$a450
        lw      d1,$0c(d0)
        and     d1,$80000000 ;8
        bne     d1,zero,no_refresh
        nop

        lw      d0,(whatbuffer)
        xor     d0,$10000
        sw      d0,(whatbuffer)

        la      a0,modikbuffer
        lw      d0,(whatbuffer)
        addu    a0,d0
   sw ra,-4(a8)
        jal     ModikRefresh
        nop
   lw ra,-4(a8)

refresh_mod:

        lui     d0,$a450
        la      a2,modikbuffer&$FFFFFF
        lw      d1,(whatbuffer)
     ;        xor     d1,$8000
        addu    a2,a2,d1
        sw      a2,0(d0)
        li      d1,1
        sw      d1,8(d0)
        li      d1,$465
        sw      d1,$10(d0)
        li      d1,$f
        sw      d1,$14(d0)
        li      d1,TICK_LENGTH*4
        sw      d1,4(d0)
;------------------------------
no_refresh
        jr ra
        nop
;°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
; ModikRefresh
;°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°


ModikRefresh:

        lw       t0,(Tick)      ; Reactualisation des variable de positions
        addu     t0,1
        sw       t0,(Tick)

;===== start loop1
        la       t9,voixinfo
        li       t8,3
loopticktrack
        lw       t0,VOIX_EQUALIZER(t9)
        blt      t0,4,no_decequ
        sw       zero,VOIX_EQUALIZER(t9)
        subu     t0,4
        sw       t0,VOIX_EQUALIZER(t9)
no_decequ:

        addu     t9,VOIX_ChanInfoLength
        bne      t8,zero,loopticktrack
        subu     t8,1

;========= endloop

ModikStartPlay:
        lw       t0,(Tick)
        lw       t1,(Speed)
        blt      t0,t1,EndRefresh
        nop
        sw       zero,(Tick)
        lw       t0,(Position)
        addu     t0,1
        sw       t0,(Position)
        bne      t0,64,EndRefresh
        nop
        sw       zero,(Position)
        lw       t0,(Sequence)
        addu     t0,1
        sw       t0,(Sequence)
        lw       t1,module
        addiu    t1,MODIK_PATTERNSORDER
        addu     t1,t0
        lbu      t2,(t1)
        sw       t2,(CurrentPattern)

        lw       t1,module
        addiu    t1,MODIK_SONGLENGTH
        lw       t2,0(t1)
        bne      t0,t2,EndRefresh
        nop
        sw       zero,(Sequence)
EndRefresh:

        lw       t0,(Tick)
        bne      t0,zero,no_position_refresh
        nop
position_refresh:

        la       t9,voixinfo
        li       t8,3
        li       t7,0             ; chan1=0 chan2=16 chan3=16*2 chan4=16*3
loopchan_posrefresh:

        lw       t2,module
        addiu    t2,MODIK_PATTERNS
        lw       t0,(CurrentPattern)
        sll      t0,12         ; comme ca on a en multiple de adresstrack
        addu     t0,t2
        lw       t1,(Position)
        sll      t1,6          ; par ligne
        addu     t0,t1          ; now dans t0 : adress de la note!

        addu     t0,t7
        lw       t1,NOTE_PERIODFREQ(t0)
;        sw       zero,(debug1)
        beq      t1,zero,no_new_sample
        nop

;--- new sample

;        li t1,1
;        sw       t1,(debug1)

        lw       t1,NOTE_PERIODFREQ(t0)

        lw       t3,NOTE_SAMPLENUMBER(t0)
        subu     t3,1
        sw       t3,VOIX_SAMPLE(t9)
        li       t2,0
        sw       t2,VOIX_POS(t9)

        li       t2,$a5ae00/2    ; constante relative a la frequence de play!
        nop
        nop
        nop
        div     t2,t1
        nop
        nop
        nop
        mflo     t2
        nop
        nop
        nop
        sw       t2,VOIX_STEP(t9)
        sll      t3,5
        lw       t1,module
        addiu    t1,MODIK_SAMPLESINFO
        addu     t1,t3
        lw       t3,SAMPLE_VOLUME(t1)     ;volume
        sw       t3,VOIX_VOLUME(t9)

        lw       t2,VOIX_EQUALIZER(t9)
        lw       t1,VOIX_VOLUME(t9)
        blt      t1,t2,no_updateequ
        nop
        sw       t1,VOIX_EQUALIZER(t9)
no_updateequ

no_new_sample

;---- effect

        lw       t3,NOTE_EFFECTNUMBER(t0)
        beq      t3,zero,no_effect
        nop
        bne      t3,$0c,no_volume
        lw       t4,NOTE_EFFECTPARAMETER(t0)
        sw       t4,VOIX_VOLUME(t9)
no_volume
        bne      t3,$0f,no_speed
        lw       t4,NOTE_EFFECTPARAMETER(t0)
        sw       t4,(Speed)
no_speed
        bne      t3,$0d,no_patternbreak
        li       t4,$3f
        sw       t4,(Position)
no_patternbreak
        bne      t3,$09,no_sampleoffset
        lw       t4,NOTE_EFFECTPARAMETER(t0)
        sll      t4,24
        sw       t4,VOIX_POS(t9)
no_sampleoffset

no_effect:


        addu     t9,VOIX_ChanInfoLength
        addu     t7,16
        bne      t8,zero, loopchan_posrefresh
        subu     t8,1

no_position_refresh


        li      t0,TICK_LENGTH
        move    t1,a0             ;a0=modikbuffer
loopprocess:

        la       t7,onebyteperchannelbuffer
        la       t9,voixinfo   
        li       t8,3    ;do four channels
loopchan_process:

        lw       t2,VOIX_POS(t9)
        lw       t3,VOIX_STEP(t9)
        addu     t3,t2
        sw       t3,VOIX_POS(t9)

        lw       t3,VOIX_SAMPLE(t9)

        sll      t3,5
        lw       t4,module
        addiu    t4,MODIK_SAMPLESINFO
        addu     t4,t3

        lw       t5,SAMPLE_REPEND(t4)
        blt      t5,3,not_loop_sample
        srl      t3,t2,16
        blt      t3,t5,not_loop_sample
        nop
        lw       t5,SAMPLE_REPSTART(t4)
        sll      t5,16
        sw       t5,VOIX_POS(t9)
        move     t2,t5
not_loop_sample:
        lw       t5,SAMPLE_LONG(t4)
        srl      t3,t2,16
        blt      t3,t5,continuenormal
        nop
        sw       zero,VOIX_VOLUME(t9)
        sw       zero,VOIX_STEP(t9)

continuenormal:
        lw       t3,SAMPLE_POS(t4)
        lw       t4,module
        addiu    t4,MODIK_SamplesDataPos
        lw       t4,0(t4) ; d‚but des WAVES
        addu     t3,t4

        srl      t2,16
        addu     t3,t2
        lw       t4,module
        addu     t3,t4

        lb       t3,0(t3)               ; le byte du wave

        lw       t2,VOIX_VOLUME(t9)
        lw       t5,MASTERVOLUME
        subu     t2,t5
        blezl    t2,@make0
        li       t2,0
@make0
        mult     t2,t3
        nop
        nop
        nop
        mflo     t3
        nop
        nop
        nop
        sw       t3,(t7)
        addu     t9,VOIX_ChanInfoLength
        addu     t7,4
        bne      t8,zero,loopchan_process
        subu     t8,1

        lw       t3,-16(t7)   ;chan1         ; mixing!
        lw       t4,-12(t7)   ;chan2
        addu     t3,t4        ;left
        lw       t2,-8(t7)    ;chan3
        lw       t4,-4(t7)    ;chan4
        addu     t2,t4        ;right
        sh       t2,0(t1)     ;L/R
        sh       t3,2(t1)
        addu     t1,4
        bne      t0,zero,loopprocess
        subu     t0,1
endsample1

endref
        jr       ra
        nop

;°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
; ModikInit
;             
;°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°


ModikInit

        li       t0,modikspeed
        sw       t0,(Speed)
        sw       zero,(Sequence)
        sw       zero,(CurrentPattern)
        sw       zero,(Position)
        sw       zero,(Pattern)
        sw       zero,(Tick)
        la       t0,voixinfo
        la       t1,((whatbuffer-voixinfo)/4)-1
loopcleardik
        sw       zero,(t0)
        addu     t0,4
        bne      t1,zero,loopcleardik
        subu     t1,1

        lw       t0,(Sequence)     ; init le premier pattern
        lw       t1,module
        addiu    t1,MODIK_PATTERNSORDER
        addu     t1,t0
        lbu      t1,(t1)
        sw       t1,(CurrentPattern)

        lui     t0,$a450        ; init l'audio
        la      a2,modikbuffer  ;$80000000
        sw      a2,0(t0)
        li      t1,1
        sw      t1,8(t0)
        li      t1,$d000
        sw      t1,$10(t0)
        li      t1,1
        sw      t1,$14(t0)
        li      t1,0
        sw      t1,4(t0)

        jr       ra
        nop

;±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±

 cnop 0,8
BufferSize    dw       0

SongLength    dw       0
Speed         dw       0
Sequence      dw       0             ; position dans la patern-sequence
CurrentPattern dw      0
Pattern       dw       0
Position      dw       0             ; position dans la patern
Tick          dw       0
MASTERVOLUME  dw        0

voixinfo:
pos1          dw       0
step1         dw       0
sample1       dw       0
volume1       dw       0
equalizer1    dw       0
pos2          dw       0
step2         dw       0
sample2       dw       0
volume2       dw       0
equalizer2    dw       0
pos3          dw       0
step3         dw       0
sample3       dw       0
volume3       dw       0
equalizer3    dw       0
pos4          dw       0
step4         dw       0
sample4       dw       0
volume4       dw       0
equalizer4    dw       0

              dw       0
              dw       0
onebyteperchannelbuffer         ; le byte du channel ki est mix‚ … la fin
              dw       0
              dw       0
              dw       0
              dw       0

debug1        dw       0
debug2        dw       0
debug3        dw       0
debug4        dw       0
whatbuffer    dw       0

;°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
;-----------------------
;MUSAK selection
;-----------------------
module dw song1
; cnop 0,8
song1
 cnop 0,4
       incbin   14.dik 
;       incbin   fletch.dik
;       incbin   heimdall.dik
;       incbin    light1.dik
;       incbin    vanini.dik
;       incbin    wild.dik
;       incbin    light1.dik

 cnop 0,4
