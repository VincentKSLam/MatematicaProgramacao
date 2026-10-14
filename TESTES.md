# Casos de teste

## Parte 1 — Teoria dos Conjuntos (COBOL)

Todos os testes abaixo foram executados com o programa compilado (`cobc -x -o conjuntos main.cob`). Cada log é uma **sessão interativa real**, com o que foi digitado aparecendo após cada pergunta. O menu foi omitido dos logs apenas para encurtar.

### Resumo

| Caso | Exigência coberta | Resultado |
|---|---|---|
| T1 | Conjunto vazio | ✅ conforme o esperado |
| T2 | Conjuntos iguais | ✅ conforme o esperado |
| T3 | Conjuntos disjuntos | ✅ conforme o esperado |
| T4 | Elementos repetidos na entrada | ✅ conforme o esperado |
| T5 | Zero × elemento vazio × conjunto vazio | ✅ conforme o esperado |
| T6 | Avisos, limite de capacidade e entradas inválidas | ✅ conforme o esperado |
| Opção 14 | 4 cenários com conferência automática contra o esperado calculado à mão | ✅ 36 de 36 OK |

O "esperado" de cada caso foi calculado à mão antes da execução e comparado com a saída.

### T1 — Conjunto vazio

**Cobre:** Conjunto vazio.

**Entrada:** A = {} (vazio), B = {1 2 3}.

**Esperado (à mão):** A ∪ B = {1 2 3}; A ∩ B = {}; A − B = {}; B − A = {1 2 3}; A △ B = {1 2 3}; A ⊆ B = SIM e A ⊂ B = SIM (o vazio está contido em qualquer conjunto); B ⊆ A = NAO.

**Reproduzir** (sem o eco do teclado, a saída aparece sem os números digitados):

```bash
printf '1\n0\n2\n3\n1\n2\n3\n4\n7\n8\n9\n10\n11\n6\n0\n' | ./conjuntos
```

<details>
<summary>Log da sessão</summary>

```text
Opcao: 1
Quantos elementos (max 20)? 0

Opcao: 2
Quantos elementos (max 20)? 3
(Digite V para o elemento vazio)
Elemento 1: 1
Elemento 2: 2
Elemento 3: 3

Opcao: 4

A = {} (vazio)  |A| = 0
B = { 1 2 3 }  |B| = 3
U = {} (vazio)  |U| = 0

Opcao: 7

A uniao B = { 1 2 3 }  |R| = 3

Opcao: 8

A inter B = {} (vazio)  |R| = 0

Opcao: 9

A - B = {} (vazio)  |R| = 0

Opcao: 10

B - A = { 1 2 3 }  |R| = 3

Opcao: 11

A dif. simetrica B = { 1 2 3 }  |R| = 3

Opcao: 6

A esta contido em B (A c= B): SIM
A esta contido em B (propria): SIM
B esta contido em A (B c= A): NAO
B esta contido em A (propria): NAO

Opcao: 0
```

</details>

### T2 — Conjuntos iguais

**Cobre:** Conjuntos iguais.

**Entrada:** A = {1 2 3}, B = {3 2 1} (digitado em outra ordem).

**Esperado (à mão):** A ∪ B = A ∩ B = {1 2 3}; A − B = {}; A △ B = {}; A ⊆ B = SIM e B ⊆ A = SIM, mas ⊂ = NAO nos dois sentidos (A = B).

**Reproduzir** (sem o eco do teclado, a saída aparece sem os números digitados):

```bash
printf '1\n3\n1\n2\n3\n2\n3\n3\n2\n1\n4\n7\n8\n9\n11\n6\n0\n' | ./conjuntos
```

<details>
<summary>Log da sessão</summary>

```text
Opcao: 1
Quantos elementos (max 20)? 3
(Digite V para o elemento vazio)
Elemento 1: 1
Elemento 2: 2
Elemento 3: 3

Opcao: 2
Quantos elementos (max 20)? 3
(Digite V para o elemento vazio)
Elemento 1: 3
Elemento 2: 2
Elemento 3: 1

Opcao: 4

A = { 1 2 3 }  |A| = 3
B = { 3 2 1 }  |B| = 3
U = {} (vazio)  |U| = 0

Opcao: 7

A uniao B = { 1 2 3 }  |R| = 3

Opcao: 8

A inter B = { 1 2 3 }  |R| = 3

Opcao: 9

A - B = {} (vazio)  |R| = 0

Opcao: 11

A dif. simetrica B = {} (vazio)  |R| = 0

Opcao: 6

A esta contido em B (A c= B): SIM
A esta contido em B (propria): NAO (A = B)
B esta contido em A (B c= A): SIM
B esta contido em A (propria): NAO (B = A)

Opcao: 0
```

</details>

### T3 — Conjuntos disjuntos

**Cobre:** Conjuntos disjuntos.

**Entrada:** A = {1 2 3}, B = {4 5 6}, U com os extras 7 e 8.

**Esperado (à mão):** A ∪ B = {1 2 3 4 5 6}; A ∩ B = {}; A − B = {1 2 3}; B − A = {4 5 6}; A △ B = {1 2 3 4 5 6} (igual à união); complemento de A em U = {4 5 6 7 8}.

**Reproduzir** (sem o eco do teclado, a saída aparece sem os números digitados):

```bash
printf '1\n3\n1\n2\n3\n2\n3\n4\n5\n6\n3\n2\n7\n8\n4\n7\n8\n9\n10\n11\n13\n0\n' | ./conjuntos
```

<details>
<summary>Log da sessão</summary>

```text
Opcao: 1
Quantos elementos (max 20)? 3
(Digite V para o elemento vazio)
Elemento 1: 1
Elemento 2: 2
Elemento 3: 3

Opcao: 2
Quantos elementos (max 20)? 3
(Digite V para o elemento vazio)
Elemento 1: 4
Elemento 2: 5
Elemento 3: 6

Opcao: 3
U ja recebeu os elementos de A e B (6 no total).
Quantos elementos EXTRAS (max 34)? 2
(Digite V para o elemento vazio)
Elemento 1: 7
Elemento 2: 8

Opcao: 4

A = { 1 2 3 }  |A| = 3
B = { 4 5 6 }  |B| = 3
U = { 1 2 3 4 5 6 7 8 }  |U| = 8

Opcao: 7

A uniao B = { 1 2 3 4 5 6 }  |R| = 6

Opcao: 8

A inter B = {} (vazio)  |R| = 0

Opcao: 9

A - B = { 1 2 3 }  |R| = 3

Opcao: 10

B - A = { 4 5 6 }  |R| = 3

Opcao: 11

A dif. simetrica B = { 1 2 3 4 5 6 }  |R| = 6

Opcao: 13

Complemento de A = { 4 5 6 7 8 }  |R| = 5
Conferencia |A| + |Ac| = |U|: OK

Opcao: 0
```

</details>

### T4 — Elementos repetidos na entrada

**Cobre:** Elementos repetidos na entrada.

**Entrada:** A pedindo 4 elementos e digitando 1, 2, **2**, 3, **3**, 4; B pedindo 3 elementos e digitando 3, 4, **4**, 5; extras de U digitando **1** (já está em U), 9, 10.

**Esperado (à mão):** Cada repetido é avisado e ignorado **sem consumir vaga**: A = {1 2 3 4}, B = {3 4 5}, U = {1 2 3 4 5 9 10}, com cardinalidades 4, 3 e 7.

**Reproduzir** (sem o eco do teclado, a saída aparece sem os números digitados):

```bash
printf '1\n4\n1\n2\n2\n3\n3\n4\n2\n3\n3\n4\n4\n5\n3\n2\n1\n9\n10\n4\n12\n0\n' | ./conjuntos
```

<details>
<summary>Log da sessão</summary>

```text
Opcao: 1
Quantos elementos (max 20)? 4
(Digite V para o elemento vazio)
Elemento 1: 1
Elemento 2: 2
Elemento 3: 2
Elemento repetido, ignorado.
Elemento 3: 3
Elemento 4: 3
Elemento repetido, ignorado.
Elemento 4: 4

Opcao: 2
Quantos elementos (max 20)? 3
(Digite V para o elemento vazio)
Elemento 1: 3
Elemento 2: 4
Elemento 3: 4
Elemento repetido, ignorado.
Elemento 3: 5

Opcao: 3
U ja recebeu os elementos de A e B (5 no total).
Quantos elementos EXTRAS (max 35)? 2
(Digite V para o elemento vazio)
Elemento 1: 1
Elemento repetido, ignorado.
Elemento 1: 9
Elemento 2: 10

Opcao: 4

A = { 1 2 3 4 }  |A| = 4
B = { 3 4 5 }  |B| = 3
U = { 1 2 3 4 5 9 10 }  |U| = 7

Opcao: 12

|A| = 4
|B| = 3
|U| = 7

Opcao: 0
```

</details>

### T5 — Zero × elemento vazio × conjunto vazio

**Cobre:** Zero × ∅ × {}.

**Entrada:** A = {0, ∅} (o `V` digitado é o elemento ∅), B = {} (nenhum elemento).

**Esperado (à mão):** A é exibido como `{ 0 ∅ }` com |A| = 2, e B como `{} (vazio)` com |B| = 0. ∅ ∈ A e 0 ∈ A, e nenhum dos dois pertence a B. B ⊆ A = SIM e B ⊂ A = SIM.

**Reproduzir** (sem o eco do teclado, a saída aparece sem os números digitados):

```bash
printf '1\n2\n0\nV\n2\n0\n4\n5\nV\n5\n0\n6\n0\n' | ./conjuntos
```

<details>
<summary>Log da sessão</summary>

```text
Opcao: 1
Quantos elementos (max 20)? 2
(Digite V para o elemento vazio)
Elemento 1: 0
Elemento 2: V

Opcao: 2
Quantos elementos (max 20)? 0

Opcao: 4

A = { 0 ∅ }  |A| = 2
B = {} (vazio)  |B| = 0
U = {} (vazio)  |U| = 0

Opcao: 5
Elemento x (numero ou V para vazio): V
∅ pertence a A
∅ NAO pertence a B

Opcao: 5
Elemento x (numero ou V para vazio): 0
0 pertence a A
0 NAO pertence a B

Opcao: 6

A esta contido em B (A c= B): NAO
A esta contido em B (propria): NAO
B esta contido em A (B c= A): SIM
B esta contido em A (propria): SIM

Opcao: 0
```

</details>

### T6 — Avisos e entradas inválidas

**Cobre:** Validação de entrada.

**Entrada:** Sessão nova: definir U e calcular a união antes de informar A e B; pedir 25 elementos (máximo 20); digitar `abc`, Enter em branco e `12345` onde se espera um elemento.

**Esperado (à mão):** Avisos pedindo A e B primeiro; recusa de 25 elementos; cada entrada inválida é rejeitada e pedida de novo, até chegar um valor válido. Resultado: A = {7 8 9}.

**Reproduzir** (sem o eco do teclado, a saída aparece sem os números digitados):

```bash
printf '3\n7\n1\n25\n3\nabc\n\n12345\n7\n8\n9\n4\n0\n' | ./conjuntos
```

<details>
<summary>Log da sessão</summary>

```text
Opcao: 3
Aviso: defina primeiro os conjuntos A e B
(opcoes 1 e 2) antes de definir o universo U.

Opcao: 7
Aviso: defina primeiro A e B (opcoes 1 e 2).

Opcao: 1
Quantos elementos (max 20)? 25
Nao e possivel: o maximo e 20 elementos.
Quantos elementos (max 20)? 3
(Digite V para o elemento vazio)
Elemento 1: abc
Invalido. Digite um numero (-9999 a 9999) ou V para vazio:
Invalido. Digite um numero (-9999 a 9999) ou V para vazio: 12345
Invalido. Digite um numero (-9999 a 9999) ou V para vazio: 7
Elemento 2: 8
Elemento 3: 9

Opcao: 4

A = { 7 8 9 }  |A| = 3
B = {} (vazio)  |B| = 0
U = {} (vazio)  |U| = 0

Opcao: 0
```

</details>

### Exemplos obrigatórios (opção 14)

Os quatro cenários da opção 14 (comum, vazio, disjuntos e iguais com 0 e ∅) têm o log completo no [README.md](README.md#exemplos-de-execução-parte-1). Em cada operação o programa mostra o resultado obtido, o esperado calculado à mão e o veredito. O placar final é **36 de 36 OK**.

## Parte 2 — Conjuntos Numéricos (Python)

Os testes foram executados com `python3 conjuntos_numericos.py`, passando as entradas como argumentos (os comandos para reproduzir estão em cada caso). O "esperado" de cada entrada foi calculado à mão, e a execução só foi aceita depois de conferir, entrada por entrada, o conjunto de pertinência e o valor da justificativa.

### Resumo

| Caso | Exigência coberta | Resultado |
|---|---|---|
| P2-T1 | Inteiro natural, zero e inteiro negativo | ✅ conforme o esperado |
| P2-T2 | Fração; fração que é inteira; fração negativa | ✅ conforme o esperado |
| P2-T3 | Decimal exato, positivo e negativo | ✅ conforme o esperado |
| P2-T4 | Dízima periódica, fração geratriz e dízima que é inteira (1.(9) = 2) | ✅ conforme o esperado |
| P2-T5 | Raiz irracional e raiz exata (quadrado perfeito, inclusive 0) | ✅ conforme o esperado |
| P2-T6 | Entradas inválidas (divisão por zero, texto, raiz de negativo) | ✅ conforme o esperado |
| P2-T7 | Bônus: crivo de Eratóstenes (inclusive n = 1) e divisores | ✅ conforme o esperado |

### P2-T1 — Inteiros: natural, zero e negativo

| Entrada | Pertence a | Por quê (à mão) |
|---|---|---|
| `7` | ℕ, ℤ, ℚ, ℝ | inteiro não negativo |
| `0` | ℕ, ℤ, ℚ, ℝ | zero é inteiro não negativo: está em ℕ (convenção adotada) |
| `-5` | ℤ, ℚ, ℝ | inteiro negativo, fora de ℕ |

**Reproduzir:**

```bash
python3 conjuntos_numericos.py 7 0 -5
```

<details>
<summary>Log da execução</summary>

```text
7
  pertence a: ℕ, ℤ, ℚ, ℝ
  não pertence a: 𝕀
  justificativa: 7 é inteiro; decimal 7
0
  pertence a: ℕ, ℤ, ℚ, ℝ
  não pertence a: 𝕀
  justificativa: 0 é inteiro; decimal 0
-5
  pertence a: ℤ, ℚ, ℝ
  não pertence a: ℕ, 𝕀
  justificativa: -5 é inteiro negativo, logo não é natural; decimal -5
```

</details>

### P2-T2 — Frações, inclusive uma que é inteira

| Entrada | Pertence a | Por quê (à mão) |
|---|---|---|
| `3/4` | ℚ, ℝ | fração não inteira; decimal exato 0,75 |
| `6/3` | ℕ, ℤ, ℚ, ℝ | a fração simplifica para o inteiro 2 |
| `-7/2` | ℚ, ℝ | fração negativa não inteira; decimal exato -3,5 |
| `1/3` | ℚ, ℝ | dízima 0,333…; geratriz 1/3 |

**Reproduzir:**

```bash
python3 conjuntos_numericos.py 3/4 6/3 -7/2 1/3
```

<details>
<summary>Log da execução</summary>

```text
3/4
  pertence a: ℚ, ℝ
  não pertence a: ℕ, ℤ, 𝕀
  justificativa: 3/4 não é inteiro, mas é razão de inteiros; decimal 0.75
6/3
  pertence a: ℕ, ℤ, ℚ, ℝ
  não pertence a: 𝕀
  justificativa: 2 é inteiro; decimal 2
-7/2
  pertence a: ℚ, ℝ
  não pertence a: ℕ, ℤ, 𝕀
  justificativa: -7/2 não é inteiro, mas é razão de inteiros; decimal -3.5
1/3
  pertence a: ℚ, ℝ
  não pertence a: ℕ, ℤ, 𝕀
  justificativa: 1/3 não é inteiro, mas é razão de inteiros; decimal 0.(3) (dízima periódica, fração geratriz 1/3)
```

</details>

### P2-T3 — Decimais exatos

| Entrada | Pertence a | Por quê (à mão) |
|---|---|---|
| `2.5` | ℚ, ℝ | decimal exato, igual a 5/2 |
| `-0.125` | ℚ, ℝ | decimal exato, igual a -1/8 |

**Reproduzir:**

```bash
python3 conjuntos_numericos.py 2.5 -0.125
```

<details>
<summary>Log da execução</summary>

```text
2.5
  pertence a: ℚ, ℝ
  não pertence a: ℕ, ℤ, 𝕀
  justificativa: 5/2 não é inteiro, mas é razão de inteiros; decimal 2.5
-0.125
  pertence a: ℚ, ℝ
  não pertence a: ℕ, ℤ, 𝕀
  justificativa: -1/8 não é inteiro, mas é razão de inteiros; decimal -0.125
```

</details>

### P2-T4 — Dízimas periódicas e fração geratriz

| Entrada | Pertence a | Por quê (à mão) |
|---|---|---|
| `0.(3)` | ℚ, ℝ | geratriz 3/9 = 1/3 |
| `2.1(45)` | ℚ, ℝ | (2145 − 21) / (10 × 99) = 2124/990 = 118/55 |
| `-0.(3)` | ℚ, ℝ | geratriz -1/3 |
| `1.(9)` | ℕ, ℤ, ℚ, ℝ | 1,999… = 2: a dízima é um inteiro (e natural) |
| `1/7` | ℚ, ℝ | período de 6 dígitos: 142857 |

**Reproduzir:**

```bash
python3 conjuntos_numericos.py '0.(3)' '2.1(45)' '-0.(3)' '1.(9)' 1/7
```

<details>
<summary>Log da execução</summary>

```text
0.(3)
  pertence a: ℚ, ℝ
  não pertence a: ℕ, ℤ, 𝕀
  justificativa: 1/3 não é inteiro, mas é razão de inteiros; decimal 0.(3) (dízima periódica, fração geratriz 1/3)
2.1(45)
  pertence a: ℚ, ℝ
  não pertence a: ℕ, ℤ, 𝕀
  justificativa: 118/55 não é inteiro, mas é razão de inteiros; decimal 2.1(45) (dízima periódica, fração geratriz 118/55)
-0.(3)
  pertence a: ℚ, ℝ
  não pertence a: ℕ, ℤ, 𝕀
  justificativa: -1/3 não é inteiro, mas é razão de inteiros; decimal -0.(3) (dízima periódica, fração geratriz -1/3)
1.(9)
  pertence a: ℕ, ℤ, ℚ, ℝ
  não pertence a: 𝕀
  justificativa: 2 é inteiro; decimal 2
1/7
  pertence a: ℚ, ℝ
  não pertence a: ℕ, ℤ, 𝕀
  justificativa: 1/7 não é inteiro, mas é razão de inteiros; decimal 0.(142857) (dízima periódica, fração geratriz 1/7)
```

</details>

### P2-T5 — Raízes: irracionais e exatas

| Entrada | Pertence a | Por quê (à mão) |
|---|---|---|
| `sqrt(2)` | 𝕀, ℝ | 2 não é quadrado perfeito: irracional |
| `sqrt(16)` | ℕ, ℤ, ℚ, ℝ | 16 é quadrado perfeito: √16 = 4 |
| `sqrt(0)` | ℕ, ℤ, ℚ, ℝ | 0 é quadrado perfeito: √0 = 0 |
| `√3` | 𝕀, ℝ | 3 não é quadrado perfeito: irracional (símbolo √ aceito) |
| `raiz 5` | 𝕀, ℝ | 5 não é quadrado perfeito: irracional (palavra raiz aceita) |

**Reproduzir:**

```bash
python3 conjuntos_numericos.py 'sqrt(2)' 'sqrt(16)' 'sqrt(0)' '√3' 'raiz 5'
```

<details>
<summary>Log da execução</summary>

```text
sqrt(2)
  pertence a: 𝕀, ℝ
  não pertence a: ℕ, ℤ, ℚ
  justificativa: √2 não é quadrado perfeito, logo não é razão de inteiros
sqrt(16)
  pertence a: ℕ, ℤ, ℚ, ℝ
  não pertence a: 𝕀
  justificativa: √16 = 4 (quadrado perfeito); 4 é inteiro; decimal 4
sqrt(0)
  pertence a: ℕ, ℤ, ℚ, ℝ
  não pertence a: 𝕀
  justificativa: √0 = 0 (quadrado perfeito); 0 é inteiro; decimal 0
√3
  pertence a: 𝕀, ℝ
  não pertence a: ℕ, ℤ, ℚ
  justificativa: √3 não é quadrado perfeito, logo não é razão de inteiros
raiz 5
  pertence a: 𝕀, ℝ
  não pertence a: ℕ, ℤ, ℚ
  justificativa: √5 não é quadrado perfeito, logo não é razão de inteiros
```

</details>

### P2-T6 — Entradas inválidas

**Esperado (à mão):** cada entrada é rejeitada com "entrada inválida", e o programa continua e processa as seguintes. `sqrt(-2)` é rejeitada porque raiz de número negativo não é real.

**Reproduzir:**

```bash
python3 conjuntos_numericos.py 1/0 abc 'sqrt(-2)' 1..5 'primos x'
```

<details>
<summary>Log da execução</summary>

```text
1/0 -> entrada inválida
abc -> entrada inválida
sqrt(-2) -> entrada inválida
1..5 -> entrada inválida
primos x -> entrada inválida
```

</details>

### P2-T7 — Bônus: crivo de Eratóstenes e divisores

| Entrada | Esperado (à mão) |
|---|---|
| `primos 30` | os 10 primos até 30: 2, 3, 5, 7, 11, 13, 17, 19, 23, 29 |
| `primos 1` | lista vazia (1 não é primo) |
| `primos 2` | [2] |
| `primos 100` | os 25 primos até 100, terminando em 97 |
| `divisores 36` | 1, 2, 3, 4, 6, 9, 12, 18, 36 (9 divisores) |
| `divisores 1` | [1] |
| `divisores 13` | [1, 13] (13 é primo) |
| `divisores -12` | os divisores positivos de 12: 1, 2, 3, 4, 6, 12 |

**Reproduzir:**

```bash
python3 conjuntos_numericos.py 'primos 30' 'primos 1' 'primos 2' 'primos 100' 'divisores 36' 'divisores 1' 'divisores 13' 'divisores -12'
```

<details>
<summary>Log da execução</summary>

```text
primos 30 -> [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
primos 1 -> []
primos 2 -> [2]
primos 100 -> [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
divisores 36 -> [1, 2, 3, 4, 6, 9, 12, 18, 36]
divisores 1 -> [1]
divisores 13 -> [1, 13]
divisores -12 -> [1, 2, 3, 4, 6, 12]
```

</details>


## Mini-projeto — Controle de acesso por perfis (Python)

Os testes foram executados com `python3 controle_acesso.py`, digitando os comandos. Ao fim de cada linha, `= ...` é o **resultado esperado, calculado à mão**, e o programa o compara com o obtido (`OK` ou `DIVERGENCIA`). Os três cenários de uso (exemplos obrigatórios) estão no [README.md](README.md#exemplos-de-execução-mini-projeto).

### Resumo

| Caso | Exigência coberta | Resultado |
|---|---|---|
| M-T1 | Conjunto vazio | ✅ conforme o esperado |
| M-T2 | Conjuntos iguais | ✅ conforme o esperado |
| M-T3 | Conjuntos disjuntos | ✅ conforme o esperado |
| M-T4 | Elementos repetidos na entrada | ✅ conforme o esperado |
| M-T5 | Tratamento de erros | ✅ conforme o esperado |
| M-T6 | Efeito de alterações | ✅ conforme o esperado |
| Cenários 1 a 3 | Três cenários de uso, incluindo vazio, iguais, disjuntos e repetido | ✅ 33 conferências OK |

### M-T1 — Conjunto vazio: perfil sem permissões e usuário sem perfil

**Cobre:** Conjunto vazio.

**O que se espera (à mão):** O perfil `convidado` é o conjunto vazio, e `davi` não tem perfil algum. Ninguém tem `ler`. O vazio está contido em si mesmo, mas não de forma estrita.

**Entrada** (o `= ...` ao fim da linha é o esperado à mão):

```bash
python3 controle_acesso.py <<'EOF'
perfil convidado = vazio
usuario gui convidado = vazio
usuario davi = vazio
pode gui ler = nao
permissoes davi = vazio
quem ler = vazio
contido convidado convidado = sim
contido_proprio convidado convidado = nao
EOF
```

<details>
<summary>Log da execução</summary>

```text
> perfil convidado = vazio
  {}
  esperado: vazio -> OK
> usuario gui convidado = vazio
  {}
  esperado: vazio -> OK
> usuario davi = vazio
  {}
  esperado: vazio -> OK
> pode gui ler = nao
  nao
  esperado: nao -> OK
> permissoes davi = vazio
  {}
  esperado: vazio -> OK
> quem ler = vazio
  {}
  esperado: vazio -> OK
> contido convidado convidado = sim
  sim
  esperado: sim -> OK
> contido_proprio convidado convidado = nao
  nao
  esperado: nao -> OK
```

</details>

### M-T2 — Perfis iguais (mesmas permissões em outra ordem)

**Cobre:** Conjuntos iguais.

**O que se espera (à mão):** `a` e `b` têm as mesmas permissões digitadas em ordem diferente: ⊆ nos dois sentidos, ⊂ falso, e somar os dois perfis não aumenta o acesso.

**Entrada** (o `= ...` ao fim da linha é o esperado à mão):

```bash
python3 controle_acesso.py <<'EOF'
perfil a x y z
perfil b z y x
contido a b = sim
contido b a = sim
contido_proprio a b = nao
contido_proprio b a = nao
usuario u a b = x y z
EOF
```

<details>
<summary>Log da execução</summary>

```text
> perfil a x y z
  {x, y, z}
> perfil b z y x
  {x, y, z}
> contido a b = sim
  sim
  esperado: sim -> OK
> contido b a = sim
  sim
  esperado: sim -> OK
> contido_proprio a b = nao
  nao
  esperado: nao -> OK
> contido_proprio b a = nao
  nao
  esperado: nao -> OK
> usuario u a b = x y z
  {x, y, z}
  esperado: x y z -> OK
```

</details>

### M-T3 — Perfis disjuntos

**Cobre:** Conjuntos disjuntos.

**O que se espera (à mão):** `a` e `b` não têm nada em comum: nenhum cabe no outro, e a união de perfis soma as permissões (2 + 1 = 3).

**Entrada** (o `= ...` ao fim da linha é o esperado à mão):

```bash
python3 controle_acesso.py <<'EOF'
perfil a x y
perfil b z
contido a b = nao
contido b a = nao
usuario u a b = x y z
usuario v a = x y
quem x = u v
quem z = u
EOF
```

<details>
<summary>Log da execução</summary>

```text
> perfil a x y
  {x, y}
> perfil b z
  {z}
> contido a b = nao
  nao
  esperado: nao -> OK
> contido b a = nao
  nao
  esperado: nao -> OK
> usuario u a b = x y z
  {x, y, z}
  esperado: x y z -> OK
> usuario v a = x y
  {x, y}
  esperado: x y -> OK
> quem x = u v
  {u, v}
  esperado: u v -> OK
> quem z = u
  {u}
  esperado: u -> OK
```

</details>

### M-T4 — Permissões e perfis repetidos na entrada

**Cobre:** Elementos repetidos na entrada.

**O que se espera (à mão):** Permissões repetidas na definição do perfil viram uma só (com aviso), e atribuir o mesmo perfil duas vezes a um usuário não muda o resultado, porque a união é idempotente.

**Entrada** (o `= ...` ao fim da linha é o esperado à mão):

```bash
python3 controle_acesso.py <<'EOF'
perfil p ler ler escrever escrever ler = ler escrever
usuario u p p = ler escrever
permissoes u = ler escrever
EOF
```

<details>
<summary>Log da execução</summary>

```text
> perfil p ler ler escrever escrever ler = ler escrever
  permissões repetidas ignoradas
  {escrever, ler}
  esperado: ler escrever -> OK
> usuario u p p = ler escrever
  {escrever, ler}
  esperado: ler escrever -> OK
> permissoes u = ler escrever
  {escrever, ler}
  esperado: ler escrever -> OK
```

</details>

### M-T5 — Comandos inválidos e nomes inexistentes

**Cobre:** Tratamento de erros.

**O que se espera (à mão):** Cada uma das cinco primeiras linhas é rejeitada com mensagem de erro (usuário inexistente, perfil inexistente, perfis inexistentes em `contido`, comando desconhecido e falta de argumentos), e o programa continua: a última linha funciona normalmente.

**Entrada** (o `= ...` ao fim da linha é o esperado à mão):

```bash
python3 controle_acesso.py <<'EOF'
pode zed ler
usuario x inexistente
contido a b
foo bar
pode
perfil ok ler = ler
EOF
```

<details>
<summary>Log da execução</summary>

```text
> pode zed ler
  erro: comando inválido ou nome inexistente
> usuario x inexistente
  erro: comando inválido ou nome inexistente
> contido a b
  erro: comando inválido ou nome inexistente
> foo bar
  erro: comando inválido ou nome inexistente
> pode
  erro: comando inválido ou nome inexistente
> perfil ok ler = ler
  {ler}
  esperado: ler -> OK
```

</details>

### M-T6 — Mudar um perfil ou os perfis de um usuário

**Cobre:** Efeito de alterações.

**O que se espera (à mão):** O acesso é calculado na hora: redefinir o perfil `p` muda o acesso de quem o tem, e `usuario u` sem perfis substitui a lista anterior e zera o acesso.

**Entrada** (o `= ...` ao fim da linha é o esperado à mão):

```bash
python3 controle_acesso.py <<'EOF'
perfil p ler
usuario u p
pode u escrever = nao
perfil p ler escrever
pode u escrever = sim
usuario u
permissoes u = vazio
EOF
```

<details>
<summary>Log da execução</summary>

```text
> perfil p ler
  {ler}
> usuario u p
  {ler}
> pode u escrever = nao
  nao
  esperado: nao -> OK
> perfil p ler escrever
  {escrever, ler}
> pode u escrever = sim
  sim
  esperado: sim -> OK
> usuario u
  {}
> permissoes u = vazio
  {}
  esperado: vazio -> OK
```

</details>

