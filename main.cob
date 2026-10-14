       IDENTIFICATION DIVISION.
       PROGRAM-ID. TeoriaConjuntos.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       77 I              PIC 99.
       77 J              PIC 99.
       77 K              PIC 999.
       77 OPCAO          PIC 99.
       77 ELEMENTO       PIC S9(5).
       77 QTD-LER        PIC 999.
       77 CAPACIDADE     PIC 99.
       77 CARDINAL       PIC 99.
       77 CONJ-ESCOLHIDO PIC 9.
       77 BUSCA-ELEM     PIC S9(5).
       77 BUSCA-CONJ     PIC 9.
       77 ELEM-EDIT      PIC -(5)9.
       77 QTD-EDIT       PIC Z9.
       77 K-EDIT         PIC ZZ9.

       77 VAZIO-VAL      PIC S9(5) VALUE 99999.
       77 ELEM-MOSTRAR   PIC S9(5).
       77 TEXTO-ELEM     PIC X(6).
       77 ENTRADA        PIC X(10).
       77 TITULO         PIC X(20).
       77 PERT-X         PIC S9(5).
       77 TEXTO-SN       PIC X(3).
       77 L              PIC 999.
       77 PTR            PIC 999.
       77 TOKEN          PIC X(10).
       77 IDX-OP         PIC 9.
       77 TMP            PIC 9.
       77 S1             PIC X(3).
       77 S2             PIC X(3).
       77 S3             PIC X(3).
       77 S4             PIC X(3).
       77 OBT-TEXTO      PIC X(15).
       77 ESP-INC        PIC X(15).
       77 ESP-PERT       PIC X(7).
       77 ESP-QA         PIC 99.
       77 ESP-QB         PIC 99.
       77 ESP-QU         PIC 99.
       77 CONF-OK        PIC 999 VALUE 0.
       77 CONF-TOTAL     PIC 999 VALUE 0.
       77 T-EDIT         PIC ZZ9.

       77 CONF-FLAG      PIC 9 VALUE 0.
          88 CONFERE       VALUE 1.
          88 NAO-CONFERE   VALUE 0.

       77 ENTRADA-FLAG   PIC 9 VALUE 0.
          88 ENTRADA-OK        VALUE 1.
          88 ENTRADA-INVALIDA  VALUE 0.

       77 ACHOU-FLAG     PIC 9 VALUE 0.
          88 ACHOU       VALUE 1.
          88 NAO-ACHOU   VALUE 0.

       77 ACEITO-FLAG    PIC 9 VALUE 0.
          88 ACEITO      VALUE 1.
          88 NAO-ACEITO  VALUE 0.

       77 CONTINUAR-FLAG PIC 9 VALUE 1.
          88 CONTINUAR   VALUE 1.
          88 SAIR        VALUE 0.

       77 A-DEF-FLAG     PIC 9 VALUE 0.
          88 A-DEFINIDO    VALUE 1.
          88 A-INDEFINIDO  VALUE 0.

       77 B-DEF-FLAG     PIC 9 VALUE 0.
          88 B-DEFINIDO    VALUE 1.
          88 B-INDEFINIDO  VALUE 0.

       77 U-DEF-FLAG     PIC 9 VALUE 0.
          88 U-DEFINIDO    VALUE 1.
          88 U-INDEFINIDO  VALUE 0.

       77 INCLUSO-FLAG   PIC 9 VALUE 0.
          88 INCLUSO       VALUE 1.
          88 NAO-INCLUSO   VALUE 0.

       01 CONJUNTO-A.
          05 A-QTD       PIC 99 VALUE 0.
          05 A-ELEM      PIC S9(5) OCCURS 20 TIMES.

       01 CONJUNTO-B.
          05 B-QTD       PIC 99 VALUE 0.
          05 B-ELEM      PIC S9(5) OCCURS 20 TIMES.

       01 CONJUNTO-U.
          05 U-QTD       PIC 99 VALUE 0.
          05 U-ELEM      PIC S9(5) OCCURS 40 TIMES.

       01 RESULTADO.
          05 R-QTD       PIC 99 VALUE 0.
          05 R-ELEM      PIC S9(5) OCCURS 40 TIMES.

       01 ESPERADOS.
          05 ESP-LINHA   PIC X(60) OCCURS 6 TIMES.

       01 ESPERADO.
          05 ESP-QTD     PIC 99 VALUE 0.
          05 ESP-ELEM    PIC S9(5) OCCURS 40 TIMES.

       PROCEDURE DIVISION.
       PRINCIPAL.
           PERFORM UNTIL SAIR
               PERFORM MOSTRAR-MENU
               ACCEPT OPCAO
               EVALUATE OPCAO
                   WHEN 1
                       MOVE 1 TO CONJ-ESCOLHIDO
                       PERFORM LER-CONJUNTO
                   WHEN 2
                       MOVE 2 TO CONJ-ESCOLHIDO
                       PERFORM LER-CONJUNTO
                   WHEN 3
                       PERFORM LER-UNIVERSO
                   WHEN 4
                       PERFORM EXIBIR-TODOS
                   WHEN 5
                       PERFORM TESTAR-PERTINENCIA
                   WHEN 6
                       PERFORM TESTAR-INCLUSAO
                   WHEN 7
                       PERFORM UNIAO
                   WHEN 8
                       PERFORM INTERSECAO
                   WHEN 9
                       PERFORM DIFERENCA-AB
                   WHEN 10
                       PERFORM DIFERENCA-BA
                   WHEN 11
                       PERFORM DIF-SIMETRICA
                   WHEN 12
                       PERFORM CARDINALIDADE
                   WHEN 13
                       PERFORM COMPLEMENTO-A
                   WHEN 14
                       PERFORM EXEMPLOS
                   WHEN 0
                       SET SAIR TO TRUE
                   WHEN OTHER
                       DISPLAY "Opcao invalida."
               END-EVALUATE
           END-PERFORM
           STOP RUN.

       MOSTRAR-MENU.
           DISPLAY " "
           DISPLAY "=== TEORIA DOS CONJUNTOS ==="
           DISPLAY "1 - Informar conjunto A"
           DISPLAY "2 - Informar conjunto B"
           DISPLAY "3 - Informar universo U (apos A e B)"
           DISPLAY "4 - Exibir conjuntos"
           DISPLAY "5 - Testar pertinencia (x em A ou B)"
           DISPLAY "6 - Testar inclusao (A e B)"
           DISPLAY "7 - Uniao (A U B)"
           DISPLAY "8 - Interseccao (A n B)"
           DISPLAY "9 - Diferenca A - B"
           DISPLAY "10 - Diferenca B - A"
           DISPLAY "11 - Diferenca simetrica"
           DISPLAY "12 - Cardinalidade"
           DISPLAY "13 - Complemento de A em U"
           DISPLAY "14 - Executar exemplos obrigatorios"
           DISPLAY "0 - Sair"
           DISPLAY "Opcao: " WITH NO ADVANCING.

       LER-ELEMENTO.
           SET ENTRADA-INVALIDA TO TRUE
           PERFORM UNTIL ENTRADA-OK
               ACCEPT ENTRADA
               MOVE FUNCTION UPPER-CASE(FUNCTION TRIM(ENTRADA))
                    TO ENTRADA
               IF ENTRADA = "V" OR ENTRADA = "VAZIO"
                   MOVE VAZIO-VAL TO ELEMENTO
                   SET ENTRADA-OK TO TRUE
               ELSE
                   IF FUNCTION TEST-NUMVAL(ENTRADA) = 0
                      AND FUNCTION NUMVAL(ENTRADA) >= -9999
                      AND FUNCTION NUMVAL(ENTRADA) <= 9999
                       COMPUTE ELEMENTO = FUNCTION NUMVAL(ENTRADA)
                       SET ENTRADA-OK TO TRUE
                   ELSE
                       DISPLAY "Invalido. Digite um numero "
                               "(-9999 a 9999) ou V para vazio: "
                               WITH NO ADVANCING
                   END-IF
               END-IF
           END-PERFORM.

       FORMATAR-ELEM.
           IF ELEM-MOSTRAR = VAZIO-VAL
               MOVE "∅" TO TEXTO-ELEM
           ELSE
               MOVE ELEM-MOSTRAR TO ELEM-EDIT
               MOVE FUNCTION TRIM(ELEM-EDIT) TO TEXTO-ELEM
           END-IF.

       LER-UNIVERSO.
           IF A-INDEFINIDO OR B-INDEFINIDO
               DISPLAY "Aviso: defina primeiro os conjuntos A e B"
               DISPLAY "(opcoes 1 e 2) antes de definir o universo U."
           ELSE
               MOVE 3 TO CONJ-ESCOLHIDO
               PERFORM LER-CONJUNTO
           END-IF.

       INCLUIR-A-B-EM-U.
           MOVE 3 TO BUSCA-CONJ
           PERFORM VARYING J FROM 1 BY 1 UNTIL J > A-QTD
               MOVE A-ELEM(J) TO BUSCA-ELEM
               PERFORM ADICIONAR-EM-U
           END-PERFORM
           PERFORM VARYING J FROM 1 BY 1 UNTIL J > B-QTD
               MOVE B-ELEM(J) TO BUSCA-ELEM
               PERFORM ADICIONAR-EM-U
           END-PERFORM.

       ADICIONAR-EM-U.
           PERFORM PERTENCE
           IF NAO-ACHOU
               IF U-QTD >= 40
                   DISPLAY "U cheio: elemento de A ou B nao incluido."
               ELSE
                   ADD 1 TO U-QTD
                   MOVE BUSCA-ELEM TO U-ELEM(U-QTD)
               END-IF
           END-IF.

       LER-CONJUNTO.
           PERFORM LIMPAR-CONJUNTO
           IF CONJ-ESCOLHIDO = 3
               PERFORM INCLUIR-A-B-EM-U
               MOVE U-QTD TO QTD-EDIT
               DISPLAY "U ja recebeu os elementos de A e B ("
                       FUNCTION TRIM(QTD-EDIT) " no total)."
               COMPUTE CAPACIDADE = 40 - U-QTD
           ELSE
               MOVE 20 TO CAPACIDADE
           END-IF
           IF CAPACIDADE = 0
               DISPLAY "Nao ha espaco para elementos extras."
               MOVE 0 TO QTD-LER
           ELSE
               MOVE 999 TO QTD-LER
               PERFORM UNTIL QTD-LER <= CAPACIDADE
                   IF CONJ-ESCOLHIDO = 3
                       DISPLAY "Quantos elementos EXTRAS (max "
                               CAPACIDADE ")? " WITH NO ADVANCING
                   ELSE
                       DISPLAY "Quantos elementos (max "
                               CAPACIDADE ")? " WITH NO ADVANCING
                   END-IF
                   ACCEPT QTD-LER
                   IF QTD-LER > CAPACIDADE
                       DISPLAY "Nao e possivel: o maximo e "
                               CAPACIDADE " elementos."
                   END-IF
               END-PERFORM
               IF QTD-LER > 0
                   DISPLAY "(Digite V para o elemento vazio)"
               END-IF
           END-IF
           MOVE 1 TO K
           PERFORM UNTIL K > QTD-LER
               MOVE K TO K-EDIT
               DISPLAY "Elemento " FUNCTION TRIM(K-EDIT) ": "
                       WITH NO ADVANCING
               PERFORM LER-ELEMENTO
               EVALUATE CONJ-ESCOLHIDO
                   WHEN 1 PERFORM INSERIR-A
                   WHEN 2 PERFORM INSERIR-B
                   WHEN 3 PERFORM INSERIR-U
               END-EVALUATE
               IF ACEITO
                   ADD 1 TO K
               END-IF
           END-PERFORM
           EVALUATE CONJ-ESCOLHIDO
               WHEN 1 SET A-DEFINIDO TO TRUE
               WHEN 2 SET B-DEFINIDO TO TRUE
               WHEN 3 SET U-DEFINIDO TO TRUE
           END-EVALUATE
           IF CONJ-ESCOLHIDO NOT = 3 AND U-DEFINIDO
               PERFORM INCLUIR-A-B-EM-U
               DISPLAY "U atualizado: elementos de A e B incluidos."
           END-IF.

       LIMPAR-CONJUNTO.
           EVALUATE CONJ-ESCOLHIDO
               WHEN 1 INITIALIZE CONJUNTO-A
               WHEN 2 INITIALIZE CONJUNTO-B
               WHEN 3 INITIALIZE CONJUNTO-U
           END-EVALUATE.

       INSERIR-A.
           SET NAO-ACEITO TO TRUE
           SET NAO-ACHOU TO TRUE
           PERFORM VARYING I FROM 1 BY 1
                   UNTIL I > A-QTD OR ACHOU
               IF A-ELEM(I) = ELEMENTO
                   SET ACHOU TO TRUE
               END-IF
           END-PERFORM
           IF ACHOU
               DISPLAY "Elemento repetido, ignorado."
           ELSE
               IF A-QTD >= 20
                   DISPLAY "Conjunto cheio, elemento recusado."
               ELSE
                   ADD 1 TO A-QTD
                   MOVE ELEMENTO TO A-ELEM(A-QTD)
                   SET ACEITO TO TRUE
               END-IF
           END-IF.

       INSERIR-B.
           SET NAO-ACEITO TO TRUE
           SET NAO-ACHOU TO TRUE
           PERFORM VARYING I FROM 1 BY 1
                   UNTIL I > B-QTD OR ACHOU
               IF B-ELEM(I) = ELEMENTO
                   SET ACHOU TO TRUE
               END-IF
           END-PERFORM
           IF ACHOU
               DISPLAY "Elemento repetido, ignorado."
           ELSE
               IF B-QTD >= 20
                   DISPLAY "Conjunto cheio, elemento recusado."
               ELSE
                   ADD 1 TO B-QTD
                   MOVE ELEMENTO TO B-ELEM(B-QTD)
                   SET ACEITO TO TRUE
               END-IF
           END-IF.

       INSERIR-U.
           SET NAO-ACEITO TO TRUE
           SET NAO-ACHOU TO TRUE
           PERFORM VARYING I FROM 1 BY 1
                   UNTIL I > U-QTD OR ACHOU
               IF U-ELEM(I) = ELEMENTO
                   SET ACHOU TO TRUE
               END-IF
           END-PERFORM
           IF ACHOU
               DISPLAY "Elemento repetido, ignorado."
           ELSE
               IF U-QTD >= 40
                   DISPLAY "Conjunto cheio, elemento recusado."
               ELSE
                   ADD 1 TO U-QTD
                   MOVE ELEMENTO TO U-ELEM(U-QTD)
                   SET ACEITO TO TRUE
               END-IF
           END-IF.

       EXIBIR-TODOS.
           DISPLAY " "
           DISPLAY "A = " WITH NO ADVANCING
           IF A-QTD = 0
               DISPLAY "{} (vazio)" WITH NO ADVANCING
           ELSE
               DISPLAY "{ " WITH NO ADVANCING
               PERFORM VARYING I FROM 1 BY 1 UNTIL I > A-QTD
                   MOVE A-ELEM(I) TO ELEM-MOSTRAR
                   PERFORM FORMATAR-ELEM
                   DISPLAY FUNCTION TRIM(TEXTO-ELEM) " "
                           WITH NO ADVANCING
               END-PERFORM
               DISPLAY "}" WITH NO ADVANCING
           END-IF
           MOVE A-QTD TO QTD-EDIT
           DISPLAY "  |A| = " FUNCTION TRIM(QTD-EDIT)

           DISPLAY "B = " WITH NO ADVANCING
           IF B-QTD = 0
               DISPLAY "{} (vazio)" WITH NO ADVANCING
           ELSE
               DISPLAY "{ " WITH NO ADVANCING
               PERFORM VARYING I FROM 1 BY 1 UNTIL I > B-QTD
                   MOVE B-ELEM(I) TO ELEM-MOSTRAR
                   PERFORM FORMATAR-ELEM
                   DISPLAY FUNCTION TRIM(TEXTO-ELEM) " "
                           WITH NO ADVANCING
               END-PERFORM
               DISPLAY "}" WITH NO ADVANCING
           END-IF
           MOVE B-QTD TO QTD-EDIT
           DISPLAY "  |B| = " FUNCTION TRIM(QTD-EDIT)

           DISPLAY "U = " WITH NO ADVANCING
           IF U-QTD = 0
               DISPLAY "{} (vazio)" WITH NO ADVANCING
           ELSE
               DISPLAY "{ " WITH NO ADVANCING
               PERFORM VARYING I FROM 1 BY 1 UNTIL I > U-QTD
                   MOVE U-ELEM(I) TO ELEM-MOSTRAR
                   PERFORM FORMATAR-ELEM
                   DISPLAY FUNCTION TRIM(TEXTO-ELEM) " "
                           WITH NO ADVANCING
               END-PERFORM
               DISPLAY "}" WITH NO ADVANCING
           END-IF
           MOVE U-QTD TO QTD-EDIT
           DISPLAY "  |U| = " FUNCTION TRIM(QTD-EDIT).

       PERTENCE.
           SET NAO-ACHOU TO TRUE
           EVALUATE BUSCA-CONJ
               WHEN 1
                   PERFORM VARYING I FROM 1 BY 1
                           UNTIL I > A-QTD OR ACHOU
                       IF A-ELEM(I) = BUSCA-ELEM
                           SET ACHOU TO TRUE
                       END-IF
                   END-PERFORM
               WHEN 2
                   PERFORM VARYING I FROM 1 BY 1
                           UNTIL I > B-QTD OR ACHOU
                       IF B-ELEM(I) = BUSCA-ELEM
                           SET ACHOU TO TRUE
                       END-IF
                   END-PERFORM
               WHEN 3
                   PERFORM VARYING I FROM 1 BY 1
                           UNTIL I > U-QTD OR ACHOU
                       IF U-ELEM(I) = BUSCA-ELEM
                           SET ACHOU TO TRUE
                       END-IF
                   END-PERFORM
               WHEN 4
                   PERFORM VARYING I FROM 1 BY 1
                           UNTIL I > R-QTD OR ACHOU
                       IF R-ELEM(I) = BUSCA-ELEM
                           SET ACHOU TO TRUE
                       END-IF
                   END-PERFORM
           END-EVALUATE.

       TESTAR-PERTINENCIA.
           DISPLAY "Elemento x (numero ou V para vazio): "
                   WITH NO ADVANCING
           PERFORM LER-ELEMENTO
           MOVE ELEMENTO TO BUSCA-ELEM
           MOVE BUSCA-ELEM TO ELEM-MOSTRAR
           PERFORM FORMATAR-ELEM
           MOVE 1 TO BUSCA-CONJ
           PERFORM PERTENCE
           IF ACHOU
               DISPLAY FUNCTION TRIM(TEXTO-ELEM) " pertence a A"
           ELSE
               DISPLAY FUNCTION TRIM(TEXTO-ELEM) " NAO pertence a A"
           END-IF
           MOVE 2 TO BUSCA-CONJ
           PERFORM PERTENCE
           IF ACHOU
               DISPLAY FUNCTION TRIM(TEXTO-ELEM) " pertence a B"
           ELSE
               DISPLAY FUNCTION TRIM(TEXTO-ELEM) " NAO pertence a B"
           END-IF.

       VERIFICAR-A-EM-B.
           SET INCLUSO TO TRUE
           MOVE 2 TO BUSCA-CONJ
           PERFORM VARYING J FROM 1 BY 1
                   UNTIL J > A-QTD OR NAO-INCLUSO
               MOVE A-ELEM(J) TO BUSCA-ELEM
               PERFORM PERTENCE
               IF NAO-ACHOU
                   SET NAO-INCLUSO TO TRUE
               END-IF
           END-PERFORM.

       VERIFICAR-B-EM-A.
           SET INCLUSO TO TRUE
           MOVE 1 TO BUSCA-CONJ
           PERFORM VARYING J FROM 1 BY 1
                   UNTIL J > B-QTD OR NAO-INCLUSO
               MOVE B-ELEM(J) TO BUSCA-ELEM
               PERFORM PERTENCE
               IF NAO-ACHOU
                   SET NAO-INCLUSO TO TRUE
               END-IF
           END-PERFORM.

       TESTAR-INCLUSAO.
           IF A-INDEFINIDO OR B-INDEFINIDO
               DISPLAY "Aviso: defina primeiro A e B "
                       "(opcoes 1 e 2)."
           ELSE
               DISPLAY " "
               PERFORM VERIFICAR-A-EM-B
               IF INCLUSO
                   DISPLAY "A esta contido em B (A c= B): SIM"
                   IF A-QTD < B-QTD
                       DISPLAY "A esta contido em B (propria): SIM"
                   ELSE
                       DISPLAY "A esta contido em B (propria): "
                               "NAO (A = B)"
                   END-IF
               ELSE
                   DISPLAY "A esta contido em B (A c= B): NAO"
                   DISPLAY "A esta contido em B (propria): NAO"
               END-IF
               PERFORM VERIFICAR-B-EM-A
               IF INCLUSO
                   DISPLAY "B esta contido em A (B c= A): SIM"
                   IF B-QTD < A-QTD
                       DISPLAY "B esta contido em A (propria): SIM"
                   ELSE
                       DISPLAY "B esta contido em A (propria): "
                               "NAO (B = A)"
                   END-IF
               ELSE
                   DISPLAY "B esta contido em A (B c= A): NAO"
                   DISPLAY "B esta contido em A (propria): NAO"
               END-IF
           END-IF.

       ADICIONAR-EM-R.
           ADD 1 TO R-QTD
           MOVE BUSCA-ELEM TO R-ELEM(R-QTD).

       EXIBIR-RESULTADO.
           DISPLAY " "
           DISPLAY FUNCTION TRIM(TITULO) " = " WITH NO ADVANCING
           IF R-QTD = 0
               DISPLAY "{} (vazio)" WITH NO ADVANCING
           ELSE
               DISPLAY "{ " WITH NO ADVANCING
               PERFORM VARYING I FROM 1 BY 1 UNTIL I > R-QTD
                   MOVE R-ELEM(I) TO ELEM-MOSTRAR
                   PERFORM FORMATAR-ELEM
                   DISPLAY FUNCTION TRIM(TEXTO-ELEM) " "
                           WITH NO ADVANCING
               END-PERFORM
               DISPLAY "}" WITH NO ADVANCING
           END-IF
           MOVE R-QTD TO QTD-EDIT
           DISPLAY "  |R| = " FUNCTION TRIM(QTD-EDIT).

       UNIAO.
           IF A-INDEFINIDO OR B-INDEFINIDO
               DISPLAY "Aviso: defina primeiro A e B "
                       "(opcoes 1 e 2)."
           ELSE
               INITIALIZE RESULTADO
               PERFORM VARYING J FROM 1 BY 1 UNTIL J > A-QTD
                   ADD 1 TO R-QTD
                   MOVE A-ELEM(J) TO R-ELEM(R-QTD)
               END-PERFORM
               MOVE 4 TO BUSCA-CONJ
               PERFORM VARYING J FROM 1 BY 1 UNTIL J > B-QTD
                   MOVE B-ELEM(J) TO BUSCA-ELEM
                   PERFORM PERTENCE
                   IF NAO-ACHOU
                       PERFORM ADICIONAR-EM-R
                   END-IF
               END-PERFORM
               MOVE "A uniao B" TO TITULO
               PERFORM EXIBIR-RESULTADO
           END-IF.

       INTERSECAO.
           IF A-INDEFINIDO OR B-INDEFINIDO
               DISPLAY "Aviso: defina primeiro A e B "
                       "(opcoes 1 e 2)."
           ELSE
               INITIALIZE RESULTADO
               MOVE 2 TO BUSCA-CONJ
               PERFORM VARYING J FROM 1 BY 1 UNTIL J > A-QTD
                   MOVE A-ELEM(J) TO BUSCA-ELEM
                   PERFORM PERTENCE
                   IF ACHOU
                       PERFORM ADICIONAR-EM-R
                   END-IF
               END-PERFORM
               MOVE "A inter B" TO TITULO
               PERFORM EXIBIR-RESULTADO
           END-IF.

       A-MENOS-B-EM-R.
           MOVE 2 TO BUSCA-CONJ
           PERFORM VARYING J FROM 1 BY 1 UNTIL J > A-QTD
               MOVE A-ELEM(J) TO BUSCA-ELEM
               PERFORM PERTENCE
               IF NAO-ACHOU
                   PERFORM ADICIONAR-EM-R
               END-IF
           END-PERFORM.

       B-MENOS-A-EM-R.
           MOVE 1 TO BUSCA-CONJ
           PERFORM VARYING J FROM 1 BY 1 UNTIL J > B-QTD
               MOVE B-ELEM(J) TO BUSCA-ELEM
               PERFORM PERTENCE
               IF NAO-ACHOU
                   PERFORM ADICIONAR-EM-R
               END-IF
           END-PERFORM.

       DIFERENCA-AB.
           IF A-INDEFINIDO OR B-INDEFINIDO
               DISPLAY "Aviso: defina primeiro A e B "
                       "(opcoes 1 e 2)."
           ELSE
               INITIALIZE RESULTADO
               PERFORM A-MENOS-B-EM-R
               MOVE "A - B" TO TITULO
               PERFORM EXIBIR-RESULTADO
           END-IF.

       DIFERENCA-BA.
           IF A-INDEFINIDO OR B-INDEFINIDO
               DISPLAY "Aviso: defina primeiro A e B "
                       "(opcoes 1 e 2)."
           ELSE
               INITIALIZE RESULTADO
               PERFORM B-MENOS-A-EM-R
               MOVE "B - A" TO TITULO
               PERFORM EXIBIR-RESULTADO
           END-IF.

       DIF-SIMETRICA.
           IF A-INDEFINIDO OR B-INDEFINIDO
               DISPLAY "Aviso: defina primeiro A e B "
                       "(opcoes 1 e 2)."
           ELSE
               INITIALIZE RESULTADO
               PERFORM A-MENOS-B-EM-R
               PERFORM B-MENOS-A-EM-R
               MOVE "A dif. simetrica B" TO TITULO
               PERFORM EXIBIR-RESULTADO
           END-IF.

       CARDINALIDADE.
           DISPLAY " "
           IF A-DEFINIDO
               MOVE A-QTD TO QTD-EDIT
               DISPLAY "|A| = " FUNCTION TRIM(QTD-EDIT)
           ELSE
               DISPLAY "|A| = (A ainda nao definido)"
           END-IF
           IF B-DEFINIDO
               MOVE B-QTD TO QTD-EDIT
               DISPLAY "|B| = " FUNCTION TRIM(QTD-EDIT)
           ELSE
               DISPLAY "|B| = (B ainda nao definido)"
           END-IF
           IF U-DEFINIDO
               MOVE U-QTD TO QTD-EDIT
               DISPLAY "|U| = " FUNCTION TRIM(QTD-EDIT)
           ELSE
               DISPLAY "|U| = (U ainda nao definido)"
           END-IF.

       COMPLEMENTO-A.
           IF A-INDEFINIDO OR U-INDEFINIDO
               DISPLAY "Aviso: defina primeiro A e o universo U "
                       "(opcoes 1 e 3)."
           ELSE
               INITIALIZE RESULTADO
               MOVE 1 TO BUSCA-CONJ
               PERFORM VARYING J FROM 1 BY 1 UNTIL J > U-QTD
                   MOVE U-ELEM(J) TO BUSCA-ELEM
                   PERFORM PERTENCE
                   IF NAO-ACHOU
                       PERFORM ADICIONAR-EM-R
                   END-IF
               END-PERFORM
               MOVE "Complemento de A" TO TITULO
               PERFORM EXIBIR-RESULTADO
               COMPUTE CARDINAL = A-QTD + R-QTD
               IF CARDINAL = U-QTD
                   DISPLAY "Conferencia |A| + |Ac| = |U|: OK"
               ELSE
                   DISPLAY "Conferencia |A| + |Ac| = |U|: ERRO"
               END-IF
           END-IF.

       EXEMPLOS.
           DISPLAY " "
           DISPLAY "######## EXEMPLOS DE EXECUCAO ########"
           DISPLAY "Aviso: A, B e U atuais serao substituidos."
           MOVE 0 TO CONF-OK
           MOVE 0 TO CONF-TOTAL
           PERFORM CENARIO-1
           PERFORM CENARIO-2
           PERFORM CENARIO-3
           PERFORM CENARIO-4
           DISPLAY " "
           MOVE CONF-OK TO K-EDIT
           MOVE CONF-TOTAL TO T-EDIT
           DISPLAY "Conferencias esperado x obtido: "
                   FUNCTION TRIM(K-EDIT) " de "
                   FUNCTION TRIM(T-EDIT) " OK"
           DISPLAY "######## FIM DOS EXEMPLOS ########".

       PAUSAR.
           DISPLAY " "
           DISPLAY "(ENTER para continuar)" WITH NO ADVANCING
           ACCEPT ENTRADA.

       MARCAR-DEFINIDOS.
           SET A-DEFINIDO TO TRUE
           SET B-DEFINIDO TO TRUE
           SET U-DEFINIDO TO TRUE.

       EXECUTAR-OPERACOES.
           DISPLAY " "
           DISPLAY "--- Saida do programa ---"
           PERFORM EXIBIR-TODOS
           PERFORM UNIAO
           MOVE 1 TO IDX-OP
           PERFORM CONFERIR-ESPERADO
           PERFORM INTERSECAO
           MOVE 2 TO IDX-OP
           PERFORM CONFERIR-ESPERADO
           PERFORM DIFERENCA-AB
           MOVE 3 TO IDX-OP
           PERFORM CONFERIR-ESPERADO
           PERFORM DIFERENCA-BA
           MOVE 4 TO IDX-OP
           PERFORM CONFERIR-ESPERADO
           PERFORM DIF-SIMETRICA
           MOVE 5 TO IDX-OP
           PERFORM CONFERIR-ESPERADO
           PERFORM COMPLEMENTO-A
           MOVE 6 TO IDX-OP
           PERFORM CONFERIR-ESPERADO
           PERFORM CARDINALIDADE
           PERFORM CONFERIR-CARDINAL
           PERFORM TESTAR-INCLUSAO
           PERFORM CONFERIR-INCLUSAO
           PERFORM PERT-EXEMPLO.

       PERT-EXEMPLO.
           MOVE PERT-X TO BUSCA-ELEM
           MOVE BUSCA-ELEM TO ELEM-MOSTRAR
           PERFORM FORMATAR-ELEM
           DISPLAY " "
           DISPLAY "Pertinencia de x = " FUNCTION TRIM(TEXTO-ELEM)
           MOVE 1 TO BUSCA-CONJ
           MOVE "A" TO TITULO
           PERFORM PERT-MOSTRAR
           MOVE TEXTO-SN TO S1
           MOVE 2 TO BUSCA-CONJ
           MOVE "B" TO TITULO
           PERFORM PERT-MOSTRAR
           MOVE TEXTO-SN TO S2
           MOVE SPACES TO OBT-TEXTO
           STRING S1 " " S2 DELIMITED BY SIZE INTO OBT-TEXTO
           DISPLAY "Esperado (a mao): " ESP-PERT
           DISPLAY "Obtido:           " OBT-TEXTO
           IF OBT-TEXTO = ESP-PERT
               SET CONFERE TO TRUE
           ELSE
               SET NAO-CONFERE TO TRUE
           END-IF
           PERFORM VEREDITO-ESPERADO.

       PERT-MOSTRAR.
           PERFORM PERTENCE
           IF ACHOU
               MOVE "SIM" TO TEXTO-SN
           ELSE
               MOVE "NAO" TO TEXTO-SN
           END-IF
           DISPLAY "x em " FUNCTION TRIM(TITULO) ": " TEXTO-SN.

       CENARIO-1.
           DISPLAY " "
           DISPLAY "=== CENARIO 1: conjuntos comuns ==="
           PERFORM CARREGAR-1
           PERFORM ESPERADO-1
           PERFORM EXECUTAR-OPERACOES
           PERFORM PAUSAR.

       CARREGAR-1.
           INITIALIZE CONJUNTO-A CONJUNTO-B CONJUNTO-U
           MOVE 5 TO A-QTD
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 5
               MOVE I TO A-ELEM(I)
           END-PERFORM
           MOVE 4 TO B-QTD
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 4
               COMPUTE B-ELEM(I) = I + 3
           END-PERFORM
           MOVE 10 TO U-QTD
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 10
               MOVE I TO U-ELEM(I)
           END-PERFORM
           MOVE 3 TO PERT-X
           PERFORM MARCAR-DEFINIDOS.

       ESPERADO-1.
           DISPLAY "Entrada: A = {1 2 3 4 5}, B = {4 5 6 7}, "
                   "U = {1..10}, x = 3"
           MOVE SPACES TO ESPERADOS
           MOVE "1 2 3 4 5 6 7" TO ESP-LINHA(1)
           MOVE "4 5" TO ESP-LINHA(2)
           MOVE "1 2 3" TO ESP-LINHA(3)
           MOVE "6 7" TO ESP-LINHA(4)
           MOVE "1 2 3 6 7" TO ESP-LINHA(5)
           MOVE "6 7 8 9 10" TO ESP-LINHA(6)
           MOVE 5 TO ESP-QA
           MOVE 4 TO ESP-QB
           MOVE 10 TO ESP-QU
           MOVE "NAO NAO NAO NAO" TO ESP-INC
           MOVE "SIM NAO" TO ESP-PERT.

       CENARIO-2.
           DISPLAY " "
           DISPLAY "=== CENARIO 2: conjunto vazio (A = {}) ==="
           PERFORM CARREGAR-2
           PERFORM ESPERADO-2
           PERFORM EXECUTAR-OPERACOES
           PERFORM PAUSAR.

       CARREGAR-2.
           INITIALIZE CONJUNTO-A CONJUNTO-B CONJUNTO-U
           MOVE 0 TO A-QTD
           MOVE 3 TO B-QTD
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 3
               MOVE I TO B-ELEM(I)
           END-PERFORM
           MOVE 5 TO U-QTD
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 5
               MOVE I TO U-ELEM(I)
           END-PERFORM
           MOVE 0 TO PERT-X
           PERFORM MARCAR-DEFINIDOS.

       ESPERADO-2.
           DISPLAY "Entrada: A = {}, B = {1 2 3}, "
                   "U = {1..5}, x = 0"
           MOVE SPACES TO ESPERADOS
           MOVE "1 2 3" TO ESP-LINHA(1)
           MOVE "1 2 3" TO ESP-LINHA(4)
           MOVE "1 2 3" TO ESP-LINHA(5)
           MOVE "1 2 3 4 5" TO ESP-LINHA(6)
           MOVE 0 TO ESP-QA
           MOVE 3 TO ESP-QB
           MOVE 5 TO ESP-QU
           MOVE "SIM SIM NAO NAO" TO ESP-INC
           MOVE "NAO NAO" TO ESP-PERT.

       CENARIO-3.
           DISPLAY " "
           DISPLAY "=== CENARIO 3: conjuntos disjuntos ==="
           PERFORM CARREGAR-3
           PERFORM ESPERADO-3
           PERFORM EXECUTAR-OPERACOES
           PERFORM PAUSAR.

       CARREGAR-3.
           INITIALIZE CONJUNTO-A CONJUNTO-B CONJUNTO-U
           MOVE 3 TO A-QTD
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 3
               MOVE I TO A-ELEM(I)
           END-PERFORM
           MOVE 3 TO B-QTD
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 3
               COMPUTE B-ELEM(I) = I + 3
           END-PERFORM
           MOVE 8 TO U-QTD
           PERFORM VARYING I FROM 1 BY 1 UNTIL I > 8
               MOVE I TO U-ELEM(I)
           END-PERFORM
           MOVE 4 TO PERT-X
           PERFORM MARCAR-DEFINIDOS.

       ESPERADO-3.
           DISPLAY "Entrada: A = {1 2 3}, B = {4 5 6}, "
                   "U = {1..8}, x = 4"
           MOVE SPACES TO ESPERADOS
           MOVE "1 2 3 4 5 6" TO ESP-LINHA(1)
           MOVE "1 2 3" TO ESP-LINHA(3)
           MOVE "4 5 6" TO ESP-LINHA(4)
           MOVE "1 2 3 4 5 6" TO ESP-LINHA(5)
           MOVE "4 5 6 7 8" TO ESP-LINHA(6)
           MOVE 3 TO ESP-QA
           MOVE 3 TO ESP-QB
           MOVE 8 TO ESP-QU
           MOVE "NAO NAO NAO NAO" TO ESP-INC
           MOVE "NAO SIM" TO ESP-PERT.

       CENARIO-4.
           DISPLAY " "
           DISPLAY "=== CENARIO 4: iguais, com 0 e vazio ==="
           PERFORM CARREGAR-4
           PERFORM ESPERADO-4
           PERFORM EXECUTAR-OPERACOES
           PERFORM PAUSAR.

       CARREGAR-4.
           INITIALIZE CONJUNTO-A CONJUNTO-B CONJUNTO-U
           MOVE 3 TO A-QTD
           MOVE 0 TO A-ELEM(1)
           MOVE VAZIO-VAL TO A-ELEM(2)
           MOVE 7 TO A-ELEM(3)
           MOVE 3 TO B-QTD
           MOVE VAZIO-VAL TO B-ELEM(1)
           MOVE 7 TO B-ELEM(2)
           MOVE 0 TO B-ELEM(3)
           MOVE 4 TO U-QTD
           MOVE 0 TO U-ELEM(1)
           MOVE VAZIO-VAL TO U-ELEM(2)
           MOVE 7 TO U-ELEM(3)
           MOVE 9 TO U-ELEM(4)
           MOVE VAZIO-VAL TO PERT-X
           PERFORM MARCAR-DEFINIDOS.

       ESPERADO-4.
           DISPLAY "Entrada: A = {0 vazio 7}, B = {vazio 7 0}, "
                   "U = {0 vazio 7 9}, x = vazio"
           MOVE SPACES TO ESPERADOS
           MOVE "0 V 7" TO ESP-LINHA(1)
           MOVE "0 V 7" TO ESP-LINHA(2)
           MOVE "9" TO ESP-LINHA(6)
           MOVE 3 TO ESP-QA
           MOVE 3 TO ESP-QB
           MOVE 4 TO ESP-QU
           MOVE "SIM NAO SIM NAO" TO ESP-INC
           MOVE "SIM SIM" TO ESP-PERT.

       SIMNAO.
           IF TMP = 1
               MOVE "SIM" TO TEXTO-SN
           ELSE
               MOVE "NAO" TO TEXTO-SN
           END-IF.

       VEREDITO-ESPERADO.
           ADD 1 TO CONF-TOTAL
           IF CONFERE
               ADD 1 TO CONF-OK
               DISPLAY "  Esperado x obtido: OK"
           ELSE
               DISPLAY "  Esperado x obtido: DIVERGENCIA"
           END-IF.

       CARREGAR-ESPERADO.
           INITIALIZE ESPERADO
           MOVE 1 TO PTR
           PERFORM UNTIL PTR > 60
               MOVE SPACES TO TOKEN
               UNSTRING ESP-LINHA(IDX-OP) DELIMITED BY ALL SPACE
                   INTO TOKEN WITH POINTER PTR
               END-UNSTRING
               IF TOKEN NOT = SPACES
                   ADD 1 TO ESP-QTD
                   IF TOKEN = "V"
                       MOVE VAZIO-VAL TO ESP-ELEM(ESP-QTD)
                   ELSE
                       COMPUTE ESP-ELEM(ESP-QTD) =
                               FUNCTION NUMVAL(TOKEN)
                   END-IF
               END-IF
           END-PERFORM.

       EXIBIR-ESPERADO.
           DISPLAY "Esperado (a mao) = " WITH NO ADVANCING
           IF ESP-QTD = 0
               DISPLAY "{} (vazio)" WITH NO ADVANCING
           ELSE
               DISPLAY "{ " WITH NO ADVANCING
               PERFORM VARYING I FROM 1 BY 1 UNTIL I > ESP-QTD
                   MOVE ESP-ELEM(I) TO ELEM-MOSTRAR
                   PERFORM FORMATAR-ELEM
                   DISPLAY FUNCTION TRIM(TEXTO-ELEM) " "
                           WITH NO ADVANCING
               END-PERFORM
               DISPLAY "}" WITH NO ADVANCING
           END-IF
           MOVE ESP-QTD TO QTD-EDIT
           DISPLAY "  |E| = " FUNCTION TRIM(QTD-EDIT).

       CONFERIR-ESPERADO.
           PERFORM CARREGAR-ESPERADO
           SET CONFERE TO TRUE
           IF R-QTD NOT = ESP-QTD
               SET NAO-CONFERE TO TRUE
           ELSE
               PERFORM VARYING K FROM 1 BY 1
                       UNTIL K > R-QTD OR NAO-CONFERE
                   SET NAO-ACHOU TO TRUE
                   PERFORM VARYING L FROM 1 BY 1
                           UNTIL L > ESP-QTD OR ACHOU
                       IF ESP-ELEM(L) = R-ELEM(K)
                           SET ACHOU TO TRUE
                       END-IF
                   END-PERFORM
                   IF NAO-ACHOU
                       SET NAO-CONFERE TO TRUE
                   END-IF
               END-PERFORM
           END-IF
           PERFORM EXIBIR-ESPERADO
           PERFORM VEREDITO-ESPERADO.

       CONFERIR-CARDINAL.
           MOVE ESP-QA TO QTD-EDIT
           DISPLAY "Esperado (a mao): |A| = "
                   FUNCTION TRIM(QTD-EDIT) WITH NO ADVANCING
           MOVE ESP-QB TO QTD-EDIT
           DISPLAY ", |B| = " FUNCTION TRIM(QTD-EDIT)
                   WITH NO ADVANCING
           MOVE ESP-QU TO QTD-EDIT
           DISPLAY ", |U| = " FUNCTION TRIM(QTD-EDIT)
           SET CONFERE TO TRUE
           IF A-QTD NOT = ESP-QA
              OR B-QTD NOT = ESP-QB
              OR U-QTD NOT = ESP-QU
               SET NAO-CONFERE TO TRUE
           END-IF
           PERFORM VEREDITO-ESPERADO.

       CONFERIR-INCLUSAO.
           PERFORM VERIFICAR-A-EM-B
           MOVE INCLUSO-FLAG TO TMP
           PERFORM SIMNAO
           MOVE TEXTO-SN TO S1
           IF INCLUSO AND A-QTD < B-QTD
               MOVE 1 TO TMP
           ELSE
               MOVE 0 TO TMP
           END-IF
           PERFORM SIMNAO
           MOVE TEXTO-SN TO S2
           PERFORM VERIFICAR-B-EM-A
           MOVE INCLUSO-FLAG TO TMP
           PERFORM SIMNAO
           MOVE TEXTO-SN TO S3
           IF INCLUSO AND B-QTD < A-QTD
               MOVE 1 TO TMP
           ELSE
               MOVE 0 TO TMP
           END-IF
           PERFORM SIMNAO
           MOVE TEXTO-SN TO S4
           MOVE SPACES TO OBT-TEXTO
           STRING S1 " " S2 " " S3 " " S4
                  DELIMITED BY SIZE INTO OBT-TEXTO
           DISPLAY "Inclusao (A c= B | A c B | B c= A | B c A)"
           DISPLAY "Esperado (a mao): " ESP-INC
           DISPLAY "Obtido:           " OBT-TEXTO
           IF OBT-TEXTO = ESP-INC
               SET CONFERE TO TRUE
           ELSE
               SET NAO-CONFERE TO TRUE
           END-IF
           PERFORM VEREDITO-ESPERADO.
