include emu8086.inc
org 100h

.data
    num1 dw ?            ; Variabile per il primo numero inserito
    base_log dw ?        ; Variabile per la base del logaritmo
    continue_msg db 'Premi s per continuare o n per uscire: $'   ; Messaggio per continuare o uscire
    start_msg db 'Premi s per iniziare: $'  ; Messaggio per iniziare

.code
main proc
    mov ax, @data         ; Carica l'indirizzo del segmento dati in ax
    mov ds, ax            ; Inizializza il registro ds con il segmento dati

calculator_loop:
    call clear_screen     ; Pulisce lo schermo

menu_operazioni:
    printn
    print '------------------------------'
    printn
    print '|  CALCOLATRICE SCIENTIFICA  |'
    printn
    print '|----------------------------|'
    printn
    print '| 1. Addizione               |'
    printn
    print '| 2. Sottrazione             |'
    printn
    print '| 3. Moltiplicazione         |'
    printn
    print '| 4. Divisione               |'
    printn
    print '| 5. Potenza                 |'
    printn
    print '| 6. Fattoriale              |'
    printn
    print '| 7. Logaritmo in base X     |'
    printn
    print '| 8. Radice quadrata         |'
    printn
    print '------------------------------'
    printn
    print ' Scelta: '
    call scan_num
    push cx                ; Salva il valore di cx per usarlo più tardi

    cmp cl, 5              ; Verifica se l'opzione è potenza
    je salta_input_numero  ; Se è potenza, salta l'input del numero

    printn
    print 'Inserisci il numero: '   ; Chiede di inserire un numero
    call scan_num          ; Legge il numero inserito
    mov num1, cx           ; Memorizza il numero in num1

salta_input_numero:
so:
    pop cx                 ; Ripristina la scelta dell'operazione
    cmp cl, 1              ; Confronta la scelta con 1 (Addizione)
    je addizione           ; Se  1, salta all'operazione di addizione
    cmp cl, 2              ; Confronta la scelta con 2 (Sottrazione)
    je sottrazione         ; Se  2, salta all'operazione di sottrazione
    cmp cl, 3              ; Confronta la scelta con 3 (Moltiplicazione)
    je moltiplicazione     ; Se  3, salta all'operazione di moltiplicazione
    cmp cl, 4              ; Confronta la scelta con 4 (Divisione)
    je divisione           ; Se  4, salta all'operazione di divisione
    cmp cl, 5              ; Confronta la scelta con 5 (Potenza)
    je potenza             ; Se  5, salta all'operazione di potenza
    cmp cl, 6              ; Confronta la scelta con 6 (Fattoriale)
    je fattoriale          ; Se  6, salta all'operazione di fattoriale
    cmp cl, 7              ; Confronta la scelta con 7 (Logaritmo)
    je logaritmo_base_x    ; Se  7, salta all'operazione di logaritmo
    cmp cl, 8              ; Confronta la scelta con 8 (Radice quadrata)
    je radice_quadrata     ; Se  8, salta all'operazione di radice quadrata
    print 'Errore, operazione non valida'  ;scelta  invalida, mostra un errore
    jmp ask_continue       ; Chiede se continuare o uscire

addizione:
    call cn
    mov ax, num1           ; Carica il primo numero in ax
    add ax, cx             ; Somma il secondo numero al primo
    call check_overflow    ; Controlla se c'è overflow
    jc overflow_error      ; Salta a overflow_error se c'è overflow
    jmp stampa_risultato   ; Mostra il risultato

sottrazione:
    call cn
    mov ax, num1           ; Carica il primo numero in ax
    sub ax, cx             ; Sottrae il secondo numero dal primo
    call check_overflow    ; Controlla se c'è overflow
    jc overflow_error      ; Salta a overflow_error se c'è overflow
    jmp stampa_risultato   ; Mostra il risultato

moltiplicazione:
    call cn
    mov ax, num1           ; Carica il primo numero in ax
    imul cx                ; Moltiplica ax per il secondo numero
    call check_overflow    ; Controlla se c'è overflow
    jc overflow_error      ; Salta a overflow_error se c'è overflow
    jmp stampa_risultato   ; Mostra il risultato

divisione:
    call cn
    mov ax, num1
    mov bx, cx
    mov cx, 0 ; uso cx come variabile che controlla il segno
    cmp ax, 0
    jge checkval
    neg ax
    add cx, 2 ; viene messa a 2 se numeronegativo
    checkval:
    cmp bx, 0
    je errore_div_zero
    cmp bx, 0
    jge faidivisione
    neg bx
    add cx, 1 ; viene messa 1 se numeronegativo
    faidivisione:
    mov dx, 0
    idiv bx
    call check_overflow    ; Controlla se c'è overflow
    jc overflow_error      ; Salta a overflow_error se c'è overflow
    cmp cx, 1
    jl finedivisione
    cmp cx, 3
    je finedivisione
    neg ax
    finedivisione:
    cmp cx, 2 ; se il primo numeronegativo anche il resto
    jl presto
    neg dx
    presto:
    printn
    print 'Risultato: '
    call print_num
    printn
    mov ax, dx
    printn
    print 'Resto: '
    call print_num
    printn
         ; Mostra il risultato
    jmp ask_continue       ; Chiede se continuare o uscire

potenza:
    printn
    print 'Inserisci la base: '      ; Chiede di inserire la base
    call scan_num                    ; Legge la base inserita
    mov bx, cx                       ; Memorizza la base in bx
    
    printn
    print 'Inserisci l''esponente: ' ; Chiede di inserire l'esponente
    call scan_num                    ; Legge l'esponente inserito
    
    mov ax, 1                        ; Inizializza il risultato a 1
    cmp cx, 0                        ; Controlla se l'esponente è 0
    je fine_potenza                  ; Se l'esponente è 0, il risultato è 1, vai alla fine
    
    cmp cx, 0                        ; Controlla se l'esponente è negativo
    jl errore_exp_negativo           ; Se è negativo, vai all'errore

potenza_loop:
    cmp cx, 0                        ; Controlla se l'esponente è 0
    je fine_potenza                  ; Se è 0, vai alla fine
    
    push ax                          ; Salva il valore corrente di ax
    mul bx                           ; Moltiplica ax per bx (base)
    call check_overflow              ; Controlla se c'è overflow
    jc overflow_potenza              ; Salta a overflow_potenza se c'è overflow
    dec cx                           ; Decrementa l'esponente
    jmp potenza_loop                 ; Ripeti il ciclo

overflow_potenza:
    pop ax                           ; Ripristina il valore precedente di ax
    jmp overflow_error               ; Salta all'errore di overflow

fine_potenza:
    jmp stampa_risultato             ; Stampa il risultato della potenza
    
errore_exp_negativo:
    print 'Errore: Esponente negativo non supportato!'  ; Messaggio di errore per esponente negativo
    jmp ask_continue                 ; Chiede se continuare o uscire

fattoriale:
    mov cx, num1           ; Carica il numero in cx
    cmp cx, 0              ; Controlla se il numero è negativo
    jl errore_fact_negativo ; Se è negativo, va in errore
    cmp cx, 12             ; Controlla se il numero è maggiore di 12 (limite per overflow in 16-bit)
    jg errore_fact_grande   ; Se è troppo grande, va in errore
    
    mov ax, 1              ; Inizializza il risultato a 1
fattoriale_loop:
    cmp cx, 1              ; Confronta cx con 1
    jle fine_fattoriale    ; Se cx è minore o uguale a 1, esce dal ciclo
    push ax                ; Salva il valore corrente di ax
    mul cx                 ; Moltiplica ax per cx
    call check_overflow    ; Controlla se c'è overflow
    jc overflow_fattoriale  ; Salta a overflow_fattoriale se c'è overflow
    dec cx                 ; Decrementa cx
    jmp fattoriale_loop    ; Ripete il ciclo

overflow_fattoriale:
    pop ax                 ; Ripristina il valore precedente di ax
    jmp overflow_error     ; Salta all'errore di overflow

errore_fact_negativo:
    print 'Errore: Fattoriale non definito per valori negativi!'  ; Errore per fattoriale di numeri negativi
    jmp ask_continue       ; Chiede se continuare o uscire

errore_fact_grande:
    print 'Errore: Numero troppo grande per il calcolo del fattoriale!'  ; Errore per numeri troppo grandi
    jmp ask_continue       ; Chiede se continuare o uscire

fine_fattoriale:
    jmp stampa_risultato   ; Mostra il risultato

logaritmo_base_x:
    mov ax, num1           ; Carica il numero in ax
    cmp ax, 0              ; Controlla se il numero è minore o uguale a zero
    jle errore_log         ; Se è minore o uguale a zero, va in errore

    print 'Inserisci la base del logaritmo: '  ; Chiede la base del logaritmo
    call scan_num          ; Legge la base
    mov bx, cx             ; Salva la base in bx
    cmp bx, 1              ; Controlla se la base è minore o uguale a 1
    jle errore_log_base_uno  ; Se la base è uguale o minore di 1, va in errore

    mov cx, 0              ; Inizializza cx a 0
    mov dx, 0              ; Inizializza dx a 0

log_x_loop:
    cmp ax, 1              ; Controlla se il numero è uguale a 1
    jle log_x_done         ; Se è 1, termina il ciclo
    div bx                 ; Divide ax per bx
    inc cx                 ; Incrementa il contatore cx
    cmp ax, 0              ; Controlla se ax è uguale a 0
    je log_x_done          ; Se ax è 0, termina il ciclo
    mov dx, 0              ; Inizializza dx a 0
    jmp log_x_loop         ; Ripete il ciclo

log_x_done:
    mov ax, cx             ; Carica il contatore in ax
    printn
    print 'Risultato: '     ; Stampa il risultato
    call print_num         ; Mostra il risultato
    jmp ask_continue       ; Chiede se continuare o uscire

radice_quadrata:
    mov ax, num1           ; Carica il numero in ax
    cmp ax, 0              ; Controlla se il numero è negativo
    jl errore_radice_negativa  ; Se è negativo, va in errore

    mov bx, 2              ; Imposta il valore iniziale di bx per il metodo di Newton
    mov dx, 0              ; Inizializza dx a zero
    div bx                 ; Divide ax per bx
    mov bx, ax             ; Aggiorna bx con il risultato

    mov cx, 6              ; Numero di iterazioni
newton_loop:
    push cx                ; Salva cx per il ciclo

    mov ax, num1           ; Carica il numero in ax
    mov dx, 0              ; Inizializza dx a zero
    div bx                 ; Divide ax per bx
    add ax, bx             ; Somma ax con bx
    mov bx, 2              ; Imposta bx a 2 per il calcolo successivo
    mov dx, 0              ; Inizializza dx a zero
    div bx                 ; Divide ax per 2
    mov bx, ax             ; Aggiorna bx con il risultato

    pop cx                 ; Ripristina cx
    loop newton_loop       ; Ripete il ciclo

    mov ax, bx             ; Carica il risultato in ax
    jmp stampa_risultato   ; Mostra il risultato

overflow_error:
    printn
    print 'Errore: Overflow rilevato! Il risultato e troppo grande.'
    jmp ask_continue       ; Chiede se continuare o uscire

errore_div_zero:
    print 'Errore: Divisione per zero!'   ; Messaggio di errore per divisione per zero
    jmp ask_continue       ; Chiede se continuare o uscire

errore_log:
    print 'Errore: Logaritmo non definito per valori minori o uguali a zero!'  ; Errore per logaritmo di numeri non validi
    jmp ask_continue       ; Chiede se continuare o uscire

errore_log_base_uno:
    print 'Errore: La base del logaritmo deve essere maggiore di 1!'  ; Errore per base del logaritmo uguale a 1
    jmp ask_continue       ; Chiede se continuare o uscire

errore_radice_negativa:
    print 'Errore: Non posso calcolare la radice quadrata di un numero negativo!'  ; Errore per radice quadrata di numero negativo
    jmp ask_continue       ; Chiede se continuare o uscire

stampa_risultato:
    printn
    print 'Risultato: '     ; Stampa il risultato
    call print_num         ; Mostra il risultato

ask_continue:
    printn
    printn
    lea dx, continue_msg   ; Mostra il messaggio per continuare o uscire
    mov ah, 9
    int 21h

    mov ah, 1              ; Legge il tasto premuto
    int 21h

    cmp al, 's'            ; Se il tasto è 's' o 'S', riparte il ciclo
    je calculator_loop
    cmp al, 'S'            
    je calculator_loop

fine_programma:
    mov ah, 4ch
    int 21h                ; Termina il programma

; Procedure per il controllo dell'overflow
check_overflow proc
    ; Input: AX = risultato dell'operazione
    ; Output: Carry flag impostato se rilevato overflow
    pushf                   ; Salva i flag
    push bx                 ; Salva i registri
    push cx
    
    ; Controlla se l'operazione ha generato overflow
    jo overflow_detected    ; Salta se il flag di overflow è impostato
    
    ; Per moltiplicazione e addizione, controlla anche i limiti del risultato
    cmp ax, 32767           ; Controlla se il risultato > massimo intero positivo (7FFFh)
    jg overflow_detected
    cmp ax, -32768          ; Controlla se il risultato < minimo intero negativo (8000h)
    jl overflow_detected
    
    ; Nessun overflow rilevato
    clc                     ; Pulisce il flag di carry
    jmp check_overflow_end
    
overflow_detected:
    stc                     ; Imposta il flag di carry per indicare overflow
    
check_overflow_end:
    pop cx                  ; Ripristina i registri
    pop bx
    popf                    ; Ripristina i flag (senza influenzare il nuovo flag di carry)
    pushf
    pop bx
    and bh, 11111110b       ; Pulisce il flag di overflow nei flag salvati
    push bx
    popf                    ; Ripristina i flag modificati
    ret
check_overflow endp

clear_screen proc
    mov ax, 0003h          ; Funzione per pulire lo schermo
    int 10h
    ret
clear_screen endp

cn proc
    printn
    print 'Inserisci il secondo numero: '  ; Chiede il secondo numero per la moltiplicazione
    call scan_num          ; Legge il secondo numero
    ret
cn endp

DEFINE_SCAN_NUM           ; Definizione per leggere un numero
DEFINE_PRINT_NUM          ; Definizione per stampare un numero
DEFINE_PRINT_NUM_UNS      ; Definizione per stampare un numero senza segno
end main