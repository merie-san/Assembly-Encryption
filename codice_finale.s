.data
myplaintext:.string "alfabeto1"
mycipher:.string "CAEDB"
sostK:.byte 1
blocKEY:.string "93a"
.text
la a0, myplaintext
la a1, mycipher
la a2, blocKEY
lb a3, sostK
li t0, 0                            #indice mycipher
cifrature:
add t2, t0, a1
lb t3, 0(t2)                        #carattere mycipher
beq t3, zero, decifratura
li t4, 65
beq t3, t4, cifrarioSostituzione    #determino quale funzione di cifratura applicare
li t4, 66
beq t3, t4, cifrarioABlocchi
li t4, 67        
beq t3, t4, cifraturaOccorrenze
li t4, 68
beq t3, t4, dizionario
li t4, 69
beq t3, t4, inversione
passoCifraturaFatto:
lw a0, 0(sp)
addi sp, sp, 4
lw a2, 0(sp)
addi sp, sp, 4
lb a3, 0(sp)
addi sp, sp, 1
lb t0, 0(sp)
addi sp, sp, 1
lw a1, 0(sp)
addi sp, sp, 4
addi t0, t0, 1
j cifrature

cifrarioSostituzione:               #mi preparo alla chiamata dei metodi salvando i dati importanti in pila
addi sp, sp, -4
sw a1, 0(sp)
addi sp, sp, -1
sb t0, 0(sp)
addi sp, sp, -1
sb a3, 0(sp)
addi sp, sp, -4
sw a2, 0(sp)
addi sp, sp, -4
sw a0, 0(sp)
addi a1, a3, 0                                    #organizzo gli argomenti nei registri giusti prima di chiamare il metodo
addi a0, a0, 0
jal cifrarioSostituzioneM
j passoCifraturaFatto
cifrarioABlocchi:
addi sp, sp, -4
sw a1, 0(sp)
addi sp, sp, -1
sb t0, 0(sp)
addi sp, sp, -1
sb a3, 0(sp)
addi sp, sp, -4
sw a2, 0(sp)
addi sp, sp, -4
sw a0, 0(sp)
addi a0, a0, 0
addi, a1, a2, 0
jal cifrarioABlocchiM
j passoCifraturaFatto
cifraturaOccorrenze:
addi sp, sp, -4
sw a1, 0(sp)
addi sp, sp, -1
sb t0, 0(sp)
addi sp, sp, -1
sb a3, 0(sp)
addi sp, sp, -4
sw a2, 0(sp)
addi sp, sp, -4
sw a0, 0(sp)
addi a0, a0, 0
jal cifrarioOccorrenzeM
j passoCifraturaFatto
dizionario:
addi sp, sp, -4
sw a1, 0(sp)
addi sp, sp, -1
sb t0, 0(sp)
addi sp, sp, -1
sb a3, 0(sp)
addi sp, sp, -4
sw a2, 0(sp)
addi sp, sp, -4
sw a0, 0(sp)
addi a0, a0, 0
jal dizionarioM
j passoCifraturaFatto
inversione:
addi sp, sp, -4
sw a1, 0(sp)
addi sp, sp, -1
sb t0, 0(sp)
addi sp, sp, -1
sb a3, 0(sp)
addi sp, sp, -4
sw a2, 0(sp)
addi sp, sp, -4
sw a0, 0(sp)
addi a0, a0, 0
addi a1, a0, 100
jal inversioneM
j passoCifraturaFatto



cifrarioSostituzioneM:
addi sp, sp, -4                               #salvo l'indirizzo di ritorno in pila
sw ra, 0(sp)
li t0, 0                                    #indice di scorrimento
cifrCesare:
add t1, a0, t0
lb t2, 0(t1)
beq t2, zero, fineCifraturaSost              #investigo la natura del carattere
li t3, 65
blt t2, t3, nonLettereS
li t3, 90
ble t2, t3, lettereMaiuscoleS
li t3, 97
blt t2, t3, nonLettereS
li t3, 122
ble t2, t3, lettereMinuscoleS
j nonLettereS
lettereMinuscoleS:                #applico la trasformazione per le lettere minuscole
addi t2, t2, -97
add t2, t2, a1
j modulo26lm
fineModulo26lettereMinuscole:
addi t2, t2, 97
sb t2, 0(t1)
addi t0, t0, 1
j cifrCesare
lettereMaiuscoleS:                 #applico la trasformazione per le lettere maiuscole
addi t2, t2, -65
add t2, t2, a1
j modulo26lM
fineModulo26lM:
addi t2, t2, 65
sb t2, 0(t1)
addi t0, t0, 1
j cifrCesare
nonLettereS:
addi t0, t0, 1
j cifrCesare
modulo26lm:                               #non ho voluto implementare un metodo apparte per il calcolo del modulo
blt t2, zero, casoNegativolm
li t3, 26
modulo26_lm:
blt t2, t3, fineModulo26lettereMinuscole
addi t2, t2, -26
j modulo26_lm
casoNegativolm:
addi t2, t2, 26
bge t2, zero modulo26_lm
j casoNegativolm
modulo26lM:
blt t2, zero, casoNegativolM
li t3, 26
modulo26_lM:
blt t2, t3, fineModulo26lM
addi t2, t2, -26
j modulo26_lM
casoNegativolM:
addi t2, t2, 26
bge t2, zero modulo26_lM
j casoNegativolM
fineCifraturaSost:
jal stampa
lw ra, 0(sp)
addi sp, sp, 4
jr ra



cifrarioABlocchiM:
addi sp, sp, -4
sw ra, 0(sp)
metodoVero:
addi sp, sp, -4                      #salvo in pila gli indirizzi e gli indici di scorrimento
sw a1, 0(sp)                        
addi sp, sp, -4
sw a0, 0(sp)                     
addi sp, sp, -4
sw zero 0(sp)
addi sp, sp, -4
sw zero 0(sp)                        
proceduraPrincipaleCB:
lw t0, 4(sp)
add t1, a0, t0         
lb t2, 0(t1)                         #byte plaintext
beq t2, zero fine_cifratura
addi sp, sp, -1
sb t2, 0(sp)
add a0, a1, zero
lw a1, 1(sp)
jal metodoScorrimentoRipetuto        #restituisce il byte del carattere i-esimo e l'indice successivo nel blocco
sw a1, 1(sp)
lb a1, 0(sp)
addi sp, sp, 1
add a0, a0, a1
li t0, 96
modulo96:
blt a0, t0, fine_modulo96
addi a0, a0, -96
j modulo96
fine_modulo96:
addi a0, a0, 32
lw t0, 4(sp)
lw t1, 8(sp)
add t2, t0, t1
sb a0, 0(t2)
addi t0, t0, 1
sw t0, 4(sp)
lw a0, 8(sp)
lw a1, 12(sp)
j proceduraPrincipaleCB
metodoScorrimentoRipetuto:
add t0, a1, a0              #calcolo indirizzo carattere da caricare 
lb t1, 0(t0)
beq t1, zero, gestioneIndice0
addi a1, a1, 1
addi a0, t1, 0
j fineMetodo
gestioneIndice0:
lb a0, 0(a0)                #il metodo restituisce la codifica ASCII del carattere indicato dall'indice e l'indice del prossimo elemento da scorrere
li a1, 1
fineMetodo:
jr ra
fine_cifratura:
lw a0, 8(sp)
addi sp, sp, 16             #svuoto la pila
jal stampa
lw ra, 0(sp)
addi sp, sp, 4
jr ra



cifrarioOccorrenzeM:
addi sp, sp, -4
sw ra, 0(sp)
lb a2, 0(a0)
addi a1, a0, 100
addi sp, sp, -4
sw a0, 0(sp)                       #memorizzo l'indirizzo nella pila
jal cicloInterno
addi t1, a0, 0                     #indice scorrimento ciphertext
li t0, 1                           #indice scorrimento plaintext
lw a0, 0(sp)
addi sp, sp, 4
cicloEsterno:
add t2, a0, t0
lb t3, 0(t2)
lb t4, 0(a0)
beq t3, zero, fineCifratura
beq t3, t4, carGiaVisto
addi sp, sp, -4
sw a0, 0(sp)
addi sp, sp, -4
sw t0, 0(sp)
addi sp, sp, -4
sw t1, 0(sp)
addi a1, a0, 100
add a1, a1, t1
addi a2, t3, 0
jal cicloInterno
lw t1, 0(sp)
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
add t1, t1, a0
lw a0, 0(sp)
addi sp, sp, 4
addi t0, t0, 1
j cicloEsterno
carGiaVisto:
addi t0, t0, 1
j cicloEsterno
cicloInterno:
addi sp, sp, -4
sw ra, 0(sp)
sb a2, 0(a1)
li t0, 1                                #indice ciphertext
li t1, 0                                #indice plaintext
li t2, 45                               #carattere -
occorrenze:
add t3, t1, a0
lb t4, 0(t3)
beq t4, zero, fineMetodoOcc
beq t4, a2, occorrenza
addi t1, t1, 1
j occorrenze
occorrenza:
add t3, t0, a1
sb t2, 0(t3)                              #salvo i dati importanti nella pila prima di chiamare il metodo e inserisco il trattino
addi t0, t0, 1
addi sp, sp, -4
sw a0, 0(sp)
addi sp, sp, -4
sw a1, 0(sp)
addi sp, sp, -1
sb a2, 0(sp)
addi sp, sp, -4
sw t0, 0(sp)
addi sp, sp, -4
sw t1, 0(sp)
add a1, a1, t0
addi a0, t1, 1
jal conversioneIntChar
lw t1, 0(sp)                                #recupero i dati salvati e aggiorno inoltre l'indice della ciphertext
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
add t0, t0, a0                
lb a2, 0(sp)
addi sp, sp, 1
lw a1, 0(sp)
addi sp, sp, 4
lw a0, 0 (sp)
addi sp, sp, 4
li t2, 45
lb t3, 0(a0)
add t4, t1, a0
sb t3, 0(t4)                                #modifico il carattere della plaintext in maniera tale che verr? ignorato nei cicli esterni successivi
addi t1, t1, 1
j occorrenze
conversioneIntChar:
addi sp, sp, -1
sb zero, 0(sp)
li t0, 10
li t3, 0                               #quoziente
inizio:
addi t1, a0, 0
divisione:                             #individuo le singole cifre del numero
blt t1, t0, fineDivisione
addi t1, t1, -10
addi t3, t3, 1
j divisione
fineDivisione:                         #converto il resto della divisione in caratteri
addi t1, t1, 48
addi sp, sp, -1
sb t1, 0(sp)
addi a0, t3, 0
li t3, 0
beq a0, zero, fine1
j inizio
fine1:
li t0, 0
fine1_2:                            #copio i caratteri in memoria ad un dato indirizzo
lb t1, 0(sp)
addi sp, sp, 1
beq t1, zero, fine2
add t2, t0, a1
sb t1, 0(t2)
addi t0, t0, 1
j fine1_2
fine2:
addi a0, t0, 0
jr ra
fineMetodoOcc:
add t3, a1, t0                         #aggiunta carattere dello spazio
li t4, 32
sb t4, 0(t3)
addi a0, t0, 1
lw ra, 0(sp)
addi sp, sp, 4
jr ra
fineCifratura:
addi a0, a0, 100
add t3, t1, a0
sb zero, 0(t3)                           #aggiunta carattere fine stringa
sw a0, 4(sp)                            #aggiorno l'indirizzo della plaintext cifrata pi? volte (nella cifratura ad occorrenze la ciphertext ? salvato in un indirizzo di memoria nuovo)
jal stampa
lw ra, 0(sp)
addi sp, sp, 4
jr ra



dizionarioM:
addi sp, sp, -4
sw ra, 0(sp)
li t0, 0
dizionario__:                                    #seleziono e divido i caratteri caricati in base al loro tipo
add t1, t0, a0
lb t2, 0(t1)
beq t2, zero, finisci                          #se trovo il carattere di fine stringa finisco
li t3, 48
bge t2, t3, CODcimaggiore_o_uguale48
j altriCaratteri
CODcimaggiore_o_uguale48:
li t3, 57
ble t2, t3, caratteriNumerici
li t3, 65
blt t2, t3, altriCaratteri
li t3, 90
ble t2, t3, caratteriMaiuscoli&Minuscoli
li t3, 97
blt t2, t3, altriCaratteri
li t3, 122
ble t2, t3, caratteriMaiuscoli&Minuscoli
j altriCaratteri
caratteriNumerici:                              #questa parte del codice applica le varie trasformazioni ai caratteri
li t3, 105
sub t2, t3, t2
sb t2, 0(t1)
addi t0, t0, 1
j dizionario__
caratteriMaiuscoli&Minuscoli:    
li t3, 187
sub t2, t3, t2
sb t2, 0(t1)
addi t0, t0, 1
j dizionario__  
altriCaratteri:
addi t0, t0, 1
j dizionario__
finisci:
jal stampa
lw ra, 0(sp)
addi sp, sp, 4
jr ra



inversioneM:
addi sp, sp, -4
sw ra, 0(sp)
li t0, 0                               #indice plain
ricercaFineStringa:                    #arrivo alla fine della plaintext
add t1, a0, t0
lb t2, 0(t1)
beq zero, t2, trovato
addi t0, t0, 1
j ricercaFineStringa                              #indice della cipher
trovato:
li t3, 0
trovato1: 
add t1, a1, t3                         #posizione dove memorizzare la cipher
blt t0, zero, fineInversione
addi t0, t0, -1
add t2, t0, a0
lb t4, 0(t2)                            #carattere da memorizzare
sb t4 0(t1)
addi t3, t3, 1
j trovato1
fineInversione: 
add t1, a1, t3
sb zero, 0(t1)                         #inserisco null
addi a0, a1, 0
sw a0, 4(sp)
jal stampa
lw ra, 0(sp)
addi sp, sp, 4
jr ra



stampa:
li t0, 0
addi t3, a0, 100                               #indirizzo dove copio temporaneamente la stringa da stampare
cicloscorr:
add t1, a0, t0                                #indirizzo caratteri stringa originale
add t4, t3, t0                                #indirizzo caratteri stringa copiata
lb t2, 0(t1)
beq zero, t2, uscita
sb t2, 0(t4)
addi t0, t0, 1
j cicloscorr
uscita:
li t5, 10                                     #inserisco il carattere della newline e della fine nella stringa copiata e la stampo
sb t5, 0(t4)
addi t4, t4, 1
sb zero, 0(t4)
addi a0, t3, 0
li a7, 4 
ecall
jr ra



decifratura:
addi t0, a2, 0
addi a2, a3, 0
addi a3, t0, 0
addi sp, sp, -4                                #memorizzo i dati importanti prima di invertire la mycipher
sw a1, 0(sp)
addi sp, sp, -4
sw a2, 0(sp)
addi sp, sp, -4
sw a3, 0(sp)
addi sp, sp, -4
sw a0, 0(sp)
addi a0, a1, 0
addi a1, a0, -50
jal _inversioneMycipher
sw a0, 12(sp)                                 #recupero e aggiorno i dati oltre a atrovare l'opposto di sostK
lw a0, 0(sp)
addi sp, sp, 4
lw a3, 0(sp)
addi sp, sp, 4
lw a2, 0(sp)
addi sp, sp, 4
lw a1, 0(sp)
addi sp, sp, 4
li t0, -1
xor a2, t0, a2
addi a2, a2, 1
li t0, 0                                    #aggiorno l'indice
ciclodecifratura:
add t1, t0, a1
lb t2, 0(t1)
beq zero, t2, fineDecodifica
li t3, 65
beq t2, t3, decSostituzione    #determino quale funzione di decifratura applicare
li t3, 66
beq t2, t3, decBlocchi
li t3, 67        
beq t2, t3, decOccorrenze
li t3, 68
beq t2, t3, decDizionario
li t3, 69
beq t2, t3, decInversione
addi t0, t0, 1
j ciclodecifratura
finePassoConversione:
lw a0, 0(sp)                 #chiudo il ciclo recuperando e aggiornando i dati nella pila
addi sp, sp, 4
lw t0, 0(sp)
addi sp, sp, 4
lw a3, 0(sp)
addi sp, sp, 4
lw a2, 0(sp)
addi sp, sp, 4
lw a1, 0(sp)
addi sp, sp, 4
addi t0, t0, 1
j ciclodecifratura



_inversioneMycipher:
addi sp, sp, -4
sw ra 0(sp)
li t0, 0
_ricercaFineStringa:                    #arrivo alla fine della plaintext
add t1, a0, t0
lb t2, 0(t1)
beq zero, t2, _trovato
addi t0, t0, 1
j _ricercaFineStringa
_trovato:
li t3, 0                               #indice della cipher
_trovato1:
add t1, a1, t3                         #posizione dove memorizzare la cipher
blt t0, zero, _fineInversione
addi t0, t0, -1
add t2, t0, a0
lb t4, 0(t2)                            #carattere da memorizzare
sb t4 0(t1)
addi t3, t3, 1
j _trovato1
_fineInversione: 
add t1, a1, t3
sb zero, 0(t1)                         #inserisco null
addi a0, a1, 0
lw ra 0(sp)
addi sp, sp, 4
jr ra



decSostituzione:
addi sp, sp, -4
sw a1, 0(sp)
addi sp, sp, -4
sw a2, 0(sp)
addi sp, sp, -4
sw a3, 0(sp)
addi sp, sp, -4
sw t0, 0(sp)
addi sp, sp, -4
sw a0, 0(sp)
addi a1, a2, 0
jal decodificaSOS
j finePassoConversione

decBlocchi:
addi sp, sp, -4
sw a1, 0(sp)
addi sp, sp, -4
sw a2, 0(sp)
addi sp, sp, -4
sw a3, 0(sp)
addi sp, sp, -4
sw t0, 0(sp)
addi sp, sp, -4
sw a0, 0(sp)
addi a1, a3, 0
jal decodificaBLO
j finePassoConversione

decOccorrenze:
addi sp, sp, -4
sw a1, 0(sp)
addi sp, sp, -4
sw a2, 0(sp)
addi sp, sp, -4
sw a3, 0(sp)
addi sp, sp, -4
sw t0, 0(sp)
addi sp, sp, -4
sw a0, 0(sp) 
jal decodificaSCO
j finePassoConversione

decDizionario:   
addi sp, sp, -4
sw a1, 0(sp)
addi sp, sp, -4
sw a2, 0(sp)
addi sp, sp, -4
sw a3, 0(sp)
addi sp, sp, -4
sw t0, 0(sp)
addi sp, sp, -4
sw a0, 0(sp)    
jal decodificaDIZ
j finePassoConversione

decInversione:
addi sp, sp, -4
sw a1, 0(sp)
addi sp, sp, -4
sw a2, 0(sp)
addi sp, sp, -4
sw a3, 0(sp)
addi sp, sp, -4
sw t0, 0(sp)
addi sp, sp, -4
sw a0, 0(sp)    
addi a1, a0, 300
jal decodificaINV
j finePassoConversione

stampadec:
li t0, 0
addi t3, a0, 100                               #indirizzo dove copio temporaneamente la stringa da stampare
cicloscorrdec:
add t1, a0, t0                                #indirizzo caratteri stringa originale
add t4, t3, t0                                #indirizzo caratteri stringa copiata
lb t2, 0(t1)
beq zero, t2, uscitadec
sb t2, 0(t4)
addi t0, t0, 1
j cicloscorrdec
uscitadec:
li t5, 10                                     #inserisco il carattere della newline e della fine nella stringa copiata e la stampo
sb t5, 0(t4)
addi t4, t4, 1
sb zero, 0(t4)
addi a0, t3, 0
li a7, 4 
ecall
jr ra



decodificaSOS:
addi sp, sp, -4
sw ra, 0(sp)
li t0, 0                                    #indice di scorrimento
cifrCesare\:
add t1, a0, t0
lb t2, 0(t1)
beq t2, zero, fineCifraturaSost\             #investigo la natura del carattere
li t3, 65
blt t2, t3, nonLettereS\
li t3, 90
ble t2, t3, lettereMaiuscoleS\
li t3, 97
blt t2, t3, nonLettereS\
li t3, 122
ble t2, t3, lettereMinuscoleS\
j nonLettereS\
lettereMinuscoleS\:                #applico la trasformazione per le lettere minuscole
addi t2, t2, -97
add t2, t2, a1
j modulo26lm\
fineModulo26lettereMinuscole\:
addi t2, t2, 97
sb t2, 0(t1)
addi t0, t0, 1
j cifrCesare\
lettereMaiuscoleS\:                 #applico la trasformazione per le lettere maiuscole
addi t2, t2, -65
add t2, t2, a1
j modulo26lM\
fineModulo26lM\:
addi t2, t2, 65
sb t2, 0(t1)
addi t0, t0, 1
j cifrCesare\
nonLettereS\:
addi t0, t0, 1
j cifrCesare\
modulo26lm\:                               #non ho voluto implementare un metodo apparte per il calcolo del modulo
blt t2, zero, casoNegativolm\
li t3, 26
modulo26_lm\:
blt t2, t3, fineModulo26lettereMinuscole\
addi t2, t2, -26
j modulo26_lm\
casoNegativolm\:
addi t2, t2, 26
bge t2, zero modulo26_lm\
j casoNegativolm\
modulo26lM\:
blt t2, zero, casoNegativolM\
li t3, 26
modulo26_lM\:
blt t2, t3, fineModulo26lM\
addi t2, t2, -26
j modulo26_lM\
casoNegativolM\:
addi t2, t2, 26
bge t2, zero modulo26_lM\
j casoNegativolM\
fineCifraturaSost\:
jal stampadec
lw ra, 0(sp)
addi sp, sp, 4
jr ra



decodificaBLO:
addi sp, sp, -4
sw ra 0(sp)
decif_cifrarioABlocchi:
addi sp, sp, -4
sw a1, 0(sp)                         #salvo l'indirizzo del blocco cifratura
addi sp, sp, -4
sw a0, 0(sp)                         #salvo l'indirizzo del testo in chiaro
addi sp, sp, -4
sw zero 0(sp)
addi sp, sp, -4
sw zero 0(sp)                        #salvo gli indici nella pila
proceduraPrincipaleDB:
lw t0, 4(sp)
add t1, t0, a0                        
lb t2, 0(t1)                         #byte da cypthertext
beq t2, zero, fine_dec_cifraturaABlocchi
lw t3, 0(sp)
add t4, t3, a1
lb t5, 0(t4)                         #byte da BlocKey
beq t5, zero, gestione_fineblocco
addi t3, t3, 1
sw t3, 0(sp)                         #avanzo l'indice del BlocKey di uno se il byte caricato non fosse nullo
problema_gestito:
sub t2, t2, t5
addi t2, t2, -32
addi t0, t0, 1
sw t0, 4(sp)
add a0, t2, zero
j somma_ripetuta96
fine_somma:
lw t0, 8(sp)
lw t1, 4(sp)
addi t1, t1, -1                      #per prendere in considerazione lo scorrimento avvenuto prima
add t2, t1, t0
sb a0, 0(t2)
lw a0, 8(sp)
lw a1, 12(sp)
j proceduraPrincipaleDB
gestione_fineblocco:
lb t5, 0(a1)
li t6, 1
sw t6, 0(sp)
j problema_gestito
somma_ripetuta96:
li t0, 32
bge a0, t0, fine_somma
addi a0, a0, 96
j somma_ripetuta96
fine_dec_cifraturaABlocchi:
addi sp, sp, 16
jal stampadec
lw ra, 0(sp)
addi sp, sp, 4
jr ra



decodificaSCO:
addi sp, sp, -4
sw ra, 0(sp)
li a1, 0                                #indice scorrimento
addi a2, a0, -100
li a3, 0                                #numero inserimenti
iterazioniVariCar:
jal inserimentiCarattere
addi a1, a1, 1
add t0, a1, a0
lb t1, 0(t0)
beq t1, zero, fineDecifraturaOcc
j iterazioniVariCar
inserimentiCarattere:
addi sp, sp, -4
sw ra 0(sp)
add t0, a1, a0
lb t1, 0(t0)
addi a1, a1, 2
mainScritturaCar:
addi sp, sp, -4                   #memorizzo i dati importanti
sw a2, 0(sp)
addi sp, sp, -1
sb t1, 0(sp)
addi sp, sp, -4
sw a0, 0(sp)
jal convertitoreASCIIinInt        
addi t0, a0, 0
lw a0, 0(sp)
addi sp, sp, 4                   #recupero i dati dalla pila e scrivo il carattere nella posizione giusta
lb t1, 0(sp)
addi sp, sp, 1
lw a2, 0(sp)
addi sp, sp, 4
addi, t0, t0, -1
add t2, a2, t0
sb t1, 0(t2)
addi a3, a3, 1
add t0, a0, a1
lb t0, 0(t0)
li t4, 32
beq t4, t0, fineScritturaCar
addi a1, a1, 1
j mainScritturaCar
convertitoreASCIIinInt:
li t0, 0                            #somma
li t3, 45
li t4, 32
cicloConvertitoreASCII:
add t1, a0, a1
lb t2, 0(t1)
beq t2, t3, fineConversione
beq t2, t4, fineConversione
addi t2, t2, -48
addi t5, t0, 0                       #moltiplicazione per dieci
slli t5, t5, 2
add t0, t5, t0
slli t0, t0, 1
add t0, t2, t0                       #somma parziale
addi a1, a1, 1
j cicloConvertitoreASCII
fineConversione:
addi a0, t0, 0
jr ra
fineScritturaCar:
lw ra, 0(sp)
addi sp, sp, 4
jr ra
fineDecifraturaOcc:
add t0, a3, a2
sb zero, 0(t0)                        #inserisce il carattere di fine stringa
sw a2, 4(sp)                          #? importante aggiornare all'indirizzo della cipher nuova prima che venga persa nel metodo della stampa
addi a0, a2, 0
jal stampadec
lw ra 0(sp)
addi sp, sp, 4
jr ra



decodificaDIZ:
addi sp, sp, -4
sw ra 0(sp)
li t0, 0
ddizionario:                                    #seleziono e divido i caratteri caricati in base al loro tipo
add t1, t0, a0
lb t2, 0(t1)
beq t2, zero, dfinisci                          #se trovo il carattere di fine stringa finisco
li t3, 48
bge t2, t3, dCODcimaggiore_o_uguale48
j daltriCaratteri
dCODcimaggiore_o_uguale48:
li t3, 57
ble t2, t3, dcaratteriNumerici
li t3, 65
blt t2, t3, daltriCaratteri
li t3, 90
ble t2, t3, dcaratteriMaiuscoli&Minuscoli
li t3, 97
blt t2, t3, daltriCaratteri
li t3, 122
ble t2, t3, dcaratteriMaiuscoli&Minuscoli
j daltriCaratteri
dcaratteriNumerici:                              #questa parte del codice applica le varie trasformazioni ai caratteri
li t3, 105
sub t2, t3, t2
sb t2, 0(t1)
addi t0, t0, 1
j ddizionario
dcaratteriMaiuscoli&Minuscoli:    
li t3, 187
sub t2, t3, t2
sb t2, 0(t1)
addi t0, t0, 1
j ddizionario  
daltriCaratteri:
addi t0, t0, 1
j ddizionario
dfinisci:
jal stampadec
lw ra, 0(sp)
addi sp, sp, 4
jr ra



decodificaINV:
addi sp, sp, -4
sw ra, 0(sp)
li t0, 0
ricercaFineStringaa:                    #arrivo alla fine della plaintext
add t1, a0, t0
lb t2, 0(t1)
beq zero, t2, trovatoa
addi t0, t0, 1
j ricercaFineStringaa
trovatoa:
li t3, 0                               #indice della cipher
trovato1a:
add t1, a1, t3                         #posizione dove memorizzare la cipher
blt t0, zero, fineInversionea
addi t0, t0, -1
add t2, t0, a0
lb t4, 0(t2)                            #carattere da memorizzare
sb t4 0(t1)
addi t3, t3, 1
j trovato1a
fineInversionea: 
add t1, a1, t3
sb zero, 0(t1)                         #inserisco null
addi a0, a1, 0
sw a0, 4(sp)
jal stampadec
lw ra, 0(sp)
addi sp, sp, 4
jr ra


fineDecodifica:
li t0, 0
