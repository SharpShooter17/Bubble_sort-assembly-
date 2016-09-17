section .text
  global _start

  _start:
    ;print Bubble sort start!
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_bubble_start
    mov edx, msg_len_bubble_start
    int 0x80

    ;init
    xor edx, edx
    lea edx, [table_len]
    mov edx, [edx]  ; wielkość tablicy
    ;main bubble sort loop
    main_loop:
      dec edx ; dekremantacja wielkości tablicy
      mov [bChange], byte 0
      ;second Loop
      xor ecx, ecx
      mov ecx, 0x0   ;inicjalizacja licznika
        second_loop:
          ; if - porównanie sąsiadujących elementów
            mov al, [table + ecx]
            mov bl, [table + ecx + 1]
            cmp al, bl
            JG SWAP
            JMP end_if
            SWAP:
              mov [table + ecx], bl
              mov [table + ecx + 1], al
            ;end swap
            mov [bChange], byte 1
          ; end if
          end_if:
          inc ecx        ; inkrementacja licznik
          cmp ecx, edx    ; porównanie licznika
          JNE second_loop  ; jeżeli mniejszy to kontynuuj wykonywanie pętli
        ; end second loop
      cmp [bChange], byte 1
      JE main_loop      ;end main loop

    ;print table
    xor ecx, ecx
    print_loop:

      push ecx
      mov eax, 4
      mov ebx, 1
      mov edx, 1
      add [table + ecx], byte '0'
      lea ecx, [table + ecx]
      int 0x80
      pop ecx
      inc ecx
      cmp ecx, [table_len]
      JNE print_loop


    ;print Bubble sort stop!
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_bubble_stop
    mov edx, msg_len_bubble_stop
    int 0x80

    ;exit
    mov eax, 1
    int 0x80

  section .data
    msg_bubble_start: db 'Bubble_sort - start!', 0xa
    msg_len_bubble_start equ $ - msg_bubble_start
    msg_bubble_stop: db 0xa, 'Bubble_sort - stop!', 0xa
    msg_len_bubble_stop equ $ - msg_bubble_stop
    table: db 9, 3, 4, 6, 2, 1, 5, 2, 0, 8
    table_len: dd 0xA
  section .bss
    bChange resb 1
