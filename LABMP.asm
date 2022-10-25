%include "io.inc"
section .bss 
counta resD 1
rowa resd 1
cola resd 1
mata resd 1000

countb resd 1
rowb resd 1
colb resd 1
matb resd 1000

counter resd 1
rowc resd 1
colc resd 1
countc resd 1
matc resd 1000

temp resd 1
temp1 resd 1
tempi resd 1
tempj resd 1
tempk resd 1
temp3 resd 1
temp4 resd 1
tempvar resd 1
acc resd 1
section .text
global CMAIN
CMAIN:
    ;write your code here
    ;MATRIX 1
    
    GET_DEC 2, EAX
    GET_DEC 2, EBX
    
    
   MOV [rowa], EAX
   MOV [cola], EBX
    
    IMUL EAX, EBX
    
    MOV [counta], EAX
    LEA EAX, [mata]
    MOV ECX, [counta]
    MOV EBX, 0
    
    mov edx, 0
    L1: GET_DEC 2, [mata+EBX]
        add EBX, 2
        LOOP L1
       
        
    
    ;TESTING
    MOV ECX, [counta]
    MOV EBX, 0
    L3: PRINT_DEC 2, [mata+EBX]
        add EBX, 2
        LOOP L3
            
    ;MATRIX 2
    GET_DEC 2, EAX
    GET_DEC 2, EBX
    
    MOV [rowb], EAX
    MOV [colb], EBX
   
    MOV EBX, [colb]
 
    IMUL EAX, EBX
   
    MOV [countb], EAX
    LEA EAX, [matb]
    MOV ECX, [countb]
    MOV EBX, 0
    
    L2: GET_DEC 2, [matb+EBX]
        add EBX, 2
        LOOP L2
        
   ;test print   
   NEWLINE
    MOV ECX, [countb]
    MOV EBX, 0
    L4: PRINT_DEC 2, [matb+EBX]
        add EBX, 2
        LOOP L4
    
 mov dword[tempi], 0 ; i
 mov dword[tempvar], 0
NEWLINE
outerLoop:
           MOV ECX, [tempi]
           cmp ECX, [rowa]   ; ECX has to be lesser than rowa
           je done
           mov dword[tempj], 0 ; ebx = q

innerLoop1:
           ; val = j * 
           MOV EAX, dword[colb]
           MOV EBX, dword[tempi]
           IMUL EBX
           LEA ESI, [matc]
           ADD EAX, [tempj]
           MOV dword[ESI+eax*2], 0                 ;res[i][j] = 0;
           MOV EBX, [tempj]
           cmp EBX, [colb] ; ebx has to be lesser than colb
           je innerLoop1Done
           MOV dword[tempk], 0; eax = p
           mov dword[acc], 0
           jmp innerLoop2
           
innerLoop2:
                   ;  res[i][j] += a[i][k] * b[k][j];
           MOV EAX, dword[cola]
           MOV EBX, dword[tempi]
           IMUL EBX
           LEA ESI, [mata]
           add eax, [tempk]
           MOV Ecx,  dword[ESI+eax*2]
           MOV [temp3], ECX
           
           MOV EAX, dword[colb]
           MOV EBX, dword[tempk]
           IMUL EBX
           LEA ESI, [matb]
           ADD EAX, [tempj]
           MOV EDX, dword[ESI+eax*2]
           mov [temp4], EDX
           
           
           
           MOV EAX, [temp3]
           MOV EBX,[temp4]
           IMUL EBX
           MOV ECX, [acc]
           
           ADD ECX, EAX
          MOV [acc], ECX
           MOV [temp], EAX
           
           inc dword[tempk]
           MOV EAX, [tempk]
           cmp EAX, [rowb]
           je innerLoop2Done
           jmp innerLoop2



innerLoop2Done:
    MOV EAX, [acc]
    MOV EBX, [tempvar]
    MOV [matc+EBX*2], eax
    inc dword[tempj]
    inc dword[tempvar]
    jmp innerLoop1

innerLoop1Done:

           inc dword[tempi]
           
           jmp outerLoop
done:

    ;test print
    MOV EAX, [rowa]
    MOV EBX, [colb]
    IMUL EBX
    MOV [countc], EAX
       
    MOV ECX, [countc]
    MOV EBX, 0
    
    
    NEWLINE
    L5: PRINT_DEC 2,  [matc+EBX*2]
        PRINT_STRING " "
        INC EBX
        INC EDX
        CMP EDX, [colb]
        JE RES
        CONTINUE:
            CMP EBX, [countc]
            JE FINIS
            JMP L5
    
    RES: MOV EDX, 0
        NEWLINE
        JMP CONTINUE
FINIS:     
    xor eax, eax
    ret