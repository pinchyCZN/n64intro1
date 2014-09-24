swapframebuffers:

            lui a0,$A440
            lw  d0,frame  
            lw  d1,frame2 
            sync
            sw  d0,frame2 
            sw  d1,frame  
            sw  d1,4(a0)  ;display frame2
            jr ra
            nop




frame: DW $80400000-(320*240*2)*2 ;       $80330500
frame2: DW $80400000-(320*240*2)  ;$80370500
Zimg:   DW $80400000-(320*240*2)*3







system_reset:
               j   system_reset
               nop
