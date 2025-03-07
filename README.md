# Calcolatrice Scientifica in Assembly x86

## Panoramica
Questa è un'implementazione in linguaggio assembly x86 di una calcolatrice scientifica compatibile con emu8086. La calcolatrice offre operazioni aritmetiche di base e funzioni matematiche più complesse.

## Funzionalità
- Operazioni di base:
  - Addizione
  - Sottrazione
  - Moltiplicazione
  - Divisione (con resto)
- Operazioni avanzate:
  - Potenza
  - Fattoriale
  - Logaritmo in base personalizzata
  - Radice quadrata

## Requisiti
- Emulatore emu8086

## Istruzioni per l'uso
1. Caricare il programma in emu8086
2. Eseguire il programma
3. Seguire il menu a schermo per selezionare le operazioni
4. Inserire i numeri richiesti
5. Visualizzare i risultati
6. Premere 's' per continuare con un altro calcolo o 'n' per uscire

## Note Importanti
- **Non eseguire in modalità schermo intero** - il programma potrebbe non funzionare correttamente quando visualizzato a schermo intero
- La divisione per zero viene gestita con un messaggio di errore
- Gli esponenti negativi non sono supportati
- Il logaritmo richiede numeri positivi e una base maggiore di 1
- La radice quadrata funziona solo con numeri non negativi
- **La calcolatrice lavora esclusivamente con numeri interi**

## Autore
Conte-dev

## Come Funziona
La calcolatrice utilizza la libreria emu8086 per gestire le operazioni di input/output e implementa vari algoritmi matematici in assembly x86:
- La radice quadrata utilizza il metodo di Newton per l'approssimazione
- Il logaritmo viene calcolato utilizzando divisioni ripetute
- Il fattoriale viene calcolato utilizzando un semplice ciclo
- L'elevamento a potenza utilizza moltiplicazioni ripetute

Buon utilizzo della calcolatrice scientifica in assembly x86!
