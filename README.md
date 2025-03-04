# Calcolatrice in Assembly x86

## Descrizione
Questa calcolatrice scritta in Assembly x86 permette di eseguire diverse operazioni matematiche fondamentali, tra cui:
- **Fattoriale** di un numero
- **Potenza** con esponente arbitrario
- **Logaritmo** in qualsiasi base
- **Somma**, **differenza**, **moltiplicazione** e **divisione** tra due numeri

## Requisiti
- Processore x86
- Assemblatore compatibile (es. TASM)
- Emulatori compatibili (es. DOSBox o Emu8086)

## Installazione
1. Clona o scarica questo repository.
2. Compila il codice sorgente con TASM:
   ```bash
   tasm calcolatrice.asm
   tlink calcolatrice.obj
   ```
3. Avvia l'emulatore e carica il file:
   - **DOSBox**: Copia il file `.exe` in una cartella accessibile e avvialo da DOSBox con:
     ```bash
     mount c C:\percorso_cartella
     c:
     calcolatrice.exe
     ```
   - **Emu8086**: Apri il file `.asm` direttamente nell'IDE di Emu8086 e avvialo.

## Utilizzo
Il programma presenta un'interfaccia testuale dove l'utente può scegliere l'operazione desiderata e inserire i numeri richiesti.

### Operazioni disponibili:
- **1:** Fattoriale (n!)
- **2:** Potenza (base^esponente)
- **3:** Logaritmo (log_base(numero))
- **4:** Somma (a + b)
- **5:** Differenza (a - b)
- **6:** Moltiplicazione (a * b)
- **7:** Divisione (a / b)

L'utente seleziona un'opzione e inserisce i numeri necessari per l'operazione.

## Struttura del codice
Il codice è organizzato in sezioni:
- **Input dell'utente**: Lettura dell'operazione e dei numeri
- **Elaborazione**: Implementazione delle operazioni matematiche
- **Output**: Stampa del risultato a schermo

## Note
- Il fattoriale è implementato ricorsivamente fino al valore massimo supportato da un intero a 32-bit.
- Il logaritmo viene calcolato tramite la formula `log_b(x) = ln(x) / ln(b)` utilizzando approssimazioni.
- La divisione utilizza registri EAX ed EDX per gestire quoziente e resto.

## Autore
Creato da [Il Tuo Nome].

## Licenza
Questo progetto è distribuito sotto la licenza MIT.

