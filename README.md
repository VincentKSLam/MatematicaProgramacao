# Teoria dos Conjuntos em COBOL e Python

Trabalho de implementação de operações da teoria dos conjuntos em **COBOL**, sem usar operadores prontos de conjunto (a linguagem nem os possui): tudo é feito com laços (`PERFORM VARYING`) e condicionais (`IF`/`EVALUATE`), e depois validado contra resultados calculados à mão.

A **Parte 1** (teoria dos conjuntos) é em COBOL. A **Parte 2** (conjuntos numéricos) e o **mini-projeto** (controle de acesso por perfis) são em Python, a linguagem mais curta para esses problemas.

## Status

| Parte | Situação |
|---|---|
| Parte 1 — Teoria dos Conjuntos (básico) | ✅ Implementada, testada e documentada (este README) |
| Parte 2 — Conjuntos Numéricos (intermediário) | ✅ Implementada, testada e documentada (este README) |
| Mini-projeto — Controle de acesso por perfis (opção 2) | ✅ Implementado, testado e documentado (este README) |

## Parte 1 — como compilar e executar

Requer [GnuCOBOL](https://gnucobol.sourceforge.io/) 3.x (testado com 3.1.2).

```bash
cobc -x -o conjuntos main.cob
./conjuntos
```

O programa é um menu interativo:

| Opção | Ação |
|---|---|
| 1 / 2 | Informar o conjunto A / B |
| 3 | Informar o universo U (exige A e B definidos) |
| 4 | Exibir A, B e U com suas cardinalidades |
| 5 | Testar pertinência (x ∈ A e x ∈ B) |
| 6 | Testar inclusão (⊆ e ⊂, nos dois sentidos) |
| 7 | União |
| 8 | Interseção |
| 9 / 10 | Diferença A − B / B − A |
| 11 | Diferença simétrica |
| 12 | Cardinalidade |
| 13 | Complemento de A em relação a U |
| 14 | Executar os exemplos obrigatórios (4 cenários com conferência automática contra o esperado à mão) |
| 0 | Sair |

Ao digitar elementos, use números inteiros de -9999 a 9999, ou **`V`** para o elemento vazio ∅.

## Decisões de projeto (Parte 1)

**1. Representação de um conjunto.** COBOL não tem tipo conjunto nem listas dinâmicas. Cada conjunto é um grupo com um **contador** e uma **tabela de tamanho fixo** (`OCCURS`). Só as posições de 1 até o contador têm significado, e todos os laços vão até o contador, nunca até a capacidade. Capacidades: **A e B com 20 elementos; U e `RESULTADO` com 40**. O 40 vem do pior caso da união: |A ∪ B| ≤ |A| + |B| = 20 + 20.

**2. Um conjunto não tem elementos repetidos.** As rotinas `INSERIR-A/B/U` verificam se o elemento já existe antes de gravar. Um elemento repetido é avisado e ignorado, e **não consome vaga**: o programa continua pedindo até completar a quantidade informada de elementos distintos. (Esse comportamento foi corrigido após um teste que mostrou o repetido gastando uma das vagas.)

**3. Limite de capacidade.** Se o usuário pedir mais elementos do que a capacidade (20 ou 40), o programa avisa que não é possível e pergunta de novo. A inserção ainda tem uma segunda proteção contra estourar a tabela.

**4. Conjunto vazio ≠ elemento vazio ≠ zero.** São três coisas diferentes:

- `{}` é o conjunto sem elementos (contador = 0), exibido como `{} (vazio)`.
- `0` é um elemento numérico comum.
- `∅` é o conjunto vazio **usado como elemento**, que pode estar dentro de outro conjunto, como em `{ 0 ∅ 7 }`.

COBOL não tem `null` para números, então o elemento ∅ é representado por um **valor reservado (99999)** dentro da própria tabela. Assim, todas as comparações (`=`) funcionam sem tratamento especial. Por isso os campos de elemento têm 5 dígitos (`S9(5)`), e a entrada do usuário é limitada a ±9999, o que garante que ninguém digite o valor reservado. A entrada é lida como texto e validada (`FUNCTION TEST-NUMVAL`): texto inválido, fora da faixa ou Enter em branco são rejeitados e pedidos de novo.

**5. A pertinência é a base de tudo.** O parágrafo `PERTENCE` responde "x ∈ conjunto?". As demais operações são definidas a partir dele, como na definição matemática:

| Operação | Definição usada no código |
|---|---|
| A ∪ B | copia A; de B entra só o que **não** está no resultado |
| A ∩ B | x ∈ A **e** x ∈ B |
| A − B | x ∈ A **e** x ∉ B |
| A △ B | (A − B) ∪ (B − A) |
| Aᶜ (em U) | x ∈ U **e** x ∉ A |
| A ⊆ B | para **todo** x ∈ A, x ∈ B (o laço para no primeiro contraexemplo) |
| A ⊂ B | A ⊆ B **e** \|A\| < \|B\| |

Como os conjuntos não têm repetidos, A ⊆ B com o mesmo tamanho significa A = B, e por isso a inclusão própria exige tamanho estritamente menor. O conjunto vazio está contido em qualquer conjunto sem tratamento especial: o laço não executa nenhuma vez, e a inclusão fica verdadeira.

**6. O universo U contém A e B automaticamente.** O complemento só faz sentido se A ⊆ U. Para garantir isso, o programa **exige A e B antes de U** (com aviso) e, ao definir U, copia para ele os elementos de A e B; o usuário só informa os **extras**. Se A ou B forem refeitos depois, o U é atualizado com os novos elementos. Elementos que saíram de A continuam em U, o que é coerente: U só precisa conter A e B, não ser exatamente a união.

**7. Não há comparação com uma "solução nativa".** O enunciado pede comparar com a solução nativa da linguagem, mas COBOL não possui operadores nem funções de conjunto, então não existe o que comparar. Uma "versão nativa" feita com `SEARCH` seria só outra busca em tabela dentro de laços também escritos à mão, e comparar um laço com outro laço apenas confirmaria que o mesmo algoritmo foi escrito duas vezes. Por isso o programa mostra apenas a implementação manual e a valida de forma independente: cada cenário carrega em tabela os resultados **esperados, calculados à mão**, e o próprio programa os compara com o obtido (como conjuntos, sem depender da ordem de apresentação), exibindo um placar no fim. O conferidor foi testado: ao alterar de propósito dois valores esperados, ele acusou `DIVERGENCIA` nos pontos exatos e o placar caiu. Se uma comparação com solução nativa de verdade for exigida, ela precisa ser feita em outra linguagem que tenha conjuntos (como o `set` do Python), fora do COBOL.

## Exemplos de execução (Parte 1)

A opção 14 do menu carrega quatro cenários e roda **todas** as operações em cada um, mostrando para cada operação o resultado do programa, o esperado calculado à mão e o veredito (`OK` ou `DIVERGENCIA`). Os logs completos estão abaixo.

| # | Cenário | A | B | U |
|---|---|---|---|---|
| 1 | Conjuntos comuns | {1 2 3 4 5} | {4 5 6 7} | {1..10} |
| 2 | **Conjunto vazio** | {} | {1 2 3} | {1..5} |
| 3 | **Conjuntos disjuntos** | {1 2 3} | {4 5 6} | {1..8} |
| 4 | **Conjuntos iguais**, com 0 e ∅ | {0 ∅ 7} | {∅ 7 0} | {0 ∅ 7 9} |

Resultado final da execução: **36 de 36 OK**

<details>
<summary>Cenário 1 — conjuntos comuns (log completo)</summary>

```text
=== CENARIO 1: conjuntos comuns ===
Entrada: A = {1 2 3 4 5}, B = {4 5 6 7}, U = {1..10}, x = 3

--- Saida do programa ---

A = { 1 2 3 4 5 }  |A| = 5
B = { 4 5 6 7 }  |B| = 4
U = { 1 2 3 4 5 6 7 8 9 10 }  |U| = 10

A uniao B = { 1 2 3 4 5 6 7 }  |R| = 7
Esperado (a mao) = { 1 2 3 4 5 6 7 }  |E| = 7
  Esperado x obtido: OK

A inter B = { 4 5 }  |R| = 2
Esperado (a mao) = { 4 5 }  |E| = 2
  Esperado x obtido: OK

A - B = { 1 2 3 }  |R| = 3
Esperado (a mao) = { 1 2 3 }  |E| = 3
  Esperado x obtido: OK

B - A = { 6 7 }  |R| = 2
Esperado (a mao) = { 6 7 }  |E| = 2
  Esperado x obtido: OK

A dif. simetrica B = { 1 2 3 6 7 }  |R| = 5
Esperado (a mao) = { 1 2 3 6 7 }  |E| = 5
  Esperado x obtido: OK

Complemento de A = { 6 7 8 9 10 }  |R| = 5
Conferencia |A| + |Ac| = |U|: OK
Esperado (a mao) = { 6 7 8 9 10 }  |E| = 5
  Esperado x obtido: OK

|A| = 5
|B| = 4
|U| = 10
Esperado (a mao): |A| = 5, |B| = 4, |U| = 10
  Esperado x obtido: OK

A esta contido em B (A c= B): NAO
A esta contido em B (propria): NAO
B esta contido em A (B c= A): NAO
B esta contido em A (propria): NAO
Inclusao (A c= B | A c B | B c= A | B c A)
Esperado (a mao): NAO NAO NAO NAO
Obtido:           NAO NAO NAO NAO
  Esperado x obtido: OK

Pertinencia de x = 3
x em A: SIM
x em B: NAO
Esperado (a mao): SIM NAO
Obtido:           SIM NAO
  Esperado x obtido: OK
```

</details>

<details>
<summary>Cenário 2 — conjunto vazio (log completo)</summary>

```text
=== CENARIO 2: conjunto vazio (A = {}) ===
Entrada: A = {}, B = {1 2 3}, U = {1..5}, x = 0

--- Saida do programa ---

A = {} (vazio)  |A| = 0
B = { 1 2 3 }  |B| = 3
U = { 1 2 3 4 5 }  |U| = 5

A uniao B = { 1 2 3 }  |R| = 3
Esperado (a mao) = { 1 2 3 }  |E| = 3
  Esperado x obtido: OK

A inter B = {} (vazio)  |R| = 0
Esperado (a mao) = {} (vazio)  |E| = 0
  Esperado x obtido: OK

A - B = {} (vazio)  |R| = 0
Esperado (a mao) = {} (vazio)  |E| = 0
  Esperado x obtido: OK

B - A = { 1 2 3 }  |R| = 3
Esperado (a mao) = { 1 2 3 }  |E| = 3
  Esperado x obtido: OK

A dif. simetrica B = { 1 2 3 }  |R| = 3
Esperado (a mao) = { 1 2 3 }  |E| = 3
  Esperado x obtido: OK

Complemento de A = { 1 2 3 4 5 }  |R| = 5
Conferencia |A| + |Ac| = |U|: OK
Esperado (a mao) = { 1 2 3 4 5 }  |E| = 5
  Esperado x obtido: OK

|A| = 0
|B| = 3
|U| = 5
Esperado (a mao): |A| = 0, |B| = 3, |U| = 5
  Esperado x obtido: OK

A esta contido em B (A c= B): SIM
A esta contido em B (propria): SIM
B esta contido em A (B c= A): NAO
B esta contido em A (propria): NAO
Inclusao (A c= B | A c B | B c= A | B c A)
Esperado (a mao): SIM SIM NAO NAO
Obtido:           SIM SIM NAO NAO
  Esperado x obtido: OK

Pertinencia de x = 0
x em A: NAO
x em B: NAO
Esperado (a mao): NAO NAO
Obtido:           NAO NAO
  Esperado x obtido: OK
```

</details>

<details>
<summary>Cenário 3 — conjuntos disjuntos (log completo)</summary>

```text
=== CENARIO 3: conjuntos disjuntos ===
Entrada: A = {1 2 3}, B = {4 5 6}, U = {1..8}, x = 4

--- Saida do programa ---

A = { 1 2 3 }  |A| = 3
B = { 4 5 6 }  |B| = 3
U = { 1 2 3 4 5 6 7 8 }  |U| = 8

A uniao B = { 1 2 3 4 5 6 }  |R| = 6
Esperado (a mao) = { 1 2 3 4 5 6 }  |E| = 6
  Esperado x obtido: OK

A inter B = {} (vazio)  |R| = 0
Esperado (a mao) = {} (vazio)  |E| = 0
  Esperado x obtido: OK

A - B = { 1 2 3 }  |R| = 3
Esperado (a mao) = { 1 2 3 }  |E| = 3
  Esperado x obtido: OK

B - A = { 4 5 6 }  |R| = 3
Esperado (a mao) = { 4 5 6 }  |E| = 3
  Esperado x obtido: OK

A dif. simetrica B = { 1 2 3 4 5 6 }  |R| = 6
Esperado (a mao) = { 1 2 3 4 5 6 }  |E| = 6
  Esperado x obtido: OK

Complemento de A = { 4 5 6 7 8 }  |R| = 5
Conferencia |A| + |Ac| = |U|: OK
Esperado (a mao) = { 4 5 6 7 8 }  |E| = 5
  Esperado x obtido: OK

|A| = 3
|B| = 3
|U| = 8
Esperado (a mao): |A| = 3, |B| = 3, |U| = 8
  Esperado x obtido: OK

A esta contido em B (A c= B): NAO
A esta contido em B (propria): NAO
B esta contido em A (B c= A): NAO
B esta contido em A (propria): NAO
Inclusao (A c= B | A c B | B c= A | B c A)
Esperado (a mao): NAO NAO NAO NAO
Obtido:           NAO NAO NAO NAO
  Esperado x obtido: OK

Pertinencia de x = 4
x em A: NAO
x em B: SIM
Esperado (a mao): NAO SIM
Obtido:           NAO SIM
  Esperado x obtido: OK
```

</details>

<details>
<summary>Cenário 4 — conjuntos iguais, com 0 e ∅ (log completo)</summary>

```text
=== CENARIO 4: iguais, com 0 e vazio ===
Entrada: A = {0 vazio 7}, B = {vazio 7 0}, U = {0 vazio 7 9}, x = vazio

--- Saida do programa ---

A = { 0 ∅ 7 }  |A| = 3
B = { ∅ 7 0 }  |B| = 3
U = { 0 ∅ 7 9 }  |U| = 4

A uniao B = { 0 ∅ 7 }  |R| = 3
Esperado (a mao) = { 0 ∅ 7 }  |E| = 3
  Esperado x obtido: OK

A inter B = { 0 ∅ 7 }  |R| = 3
Esperado (a mao) = { 0 ∅ 7 }  |E| = 3
  Esperado x obtido: OK

A - B = {} (vazio)  |R| = 0
Esperado (a mao) = {} (vazio)  |E| = 0
  Esperado x obtido: OK

B - A = {} (vazio)  |R| = 0
Esperado (a mao) = {} (vazio)  |E| = 0
  Esperado x obtido: OK

A dif. simetrica B = {} (vazio)  |R| = 0
Esperado (a mao) = {} (vazio)  |E| = 0
  Esperado x obtido: OK

Complemento de A = { 9 }  |R| = 1
Conferencia |A| + |Ac| = |U|: OK
Esperado (a mao) = { 9 }  |E| = 1
  Esperado x obtido: OK

|A| = 3
|B| = 3
|U| = 4
Esperado (a mao): |A| = 3, |B| = 3, |U| = 4
  Esperado x obtido: OK

A esta contido em B (A c= B): SIM
A esta contido em B (propria): NAO (A = B)
B esta contido em A (B c= A): SIM
B esta contido em A (propria): NAO (B = A)
Inclusao (A c= B | A c B | B c= A | B c A)
Esperado (a mao): SIM NAO SIM NAO
Obtido:           SIM NAO SIM NAO
  Esperado x obtido: OK

Pertinencia de x = ∅
x em A: SIM
x em B: SIM
Esperado (a mao): SIM SIM
Obtido:           SIM SIM
  Esperado x obtido: OK

```

</details>

Os casos de teste interativos da Parte 1 (conjunto vazio, iguais, disjuntos, **elementos repetidos na entrada**, zero × vazio, avisos e entradas inválidas) e os da Parte 2 e do mini-projeto estão em [TESTES.md](TESTES.md).

## Limitações conhecidas (Parte 1)

- Capacidade fixa (20/20/40 elementos) e elementos inteiros de -9999 a 9999 (mais o ∅).
- Não há comparação com solução nativa, porque COBOL não possui operações de conjunto (ver decisão 7). A validação é contra resultados calculados à mão.
- A opção 4 mostra um universo ainda não informado como `{} (vazio)`; a opção 12 (cardinalidade) distingue "não definido".

## Parte 2 — Conjuntos Numéricos (Python)

Classificador de números: dado um inteiro, fração, decimal ou raiz, informa a quais conjuntos (ℕ, ℤ, ℚ, 𝕀, ℝ) ele pertence e justifica. Identifica dízimas periódicas e calcula a fração geratriz. O bônus gera os primos até n (crivo de Eratóstenes) e lista os divisores de um número.

### Como executar

Requer Python 3.8 ou superior (testado com 3.12) e um terminal com UTF-8 para os símbolos ℕ ℤ ℚ 𝕀 ℝ.

```bash
python3 conjuntos_numericos.py 7 -5 3/4 '0.(3)' 'sqrt(2)'   # entradas como argumentos
python3 conjuntos_numericos.py                              # modo interativo (Ctrl-D encerra)
```

Formatos de entrada:

| Entrada | Exemplo |
|---|---|
| Inteiro | `7`, `-5` |
| Fração | `3/4` |
| Decimal exato | `2.5` (a vírgula também é aceita) |
| Dízima periódica | `0.(3)`, `2.1(45)` (o período fica entre parênteses) |
| Raiz | `sqrt(2)`, `raiz 2` ou `√2` |
| Bônus | `primos 30`, `divisores 36` |

### Decisões de projeto (Parte 2)

**1. Python em vez de COBOL.** Esta parte depende de texto e de números racionais, que o COBOL trata com muito trabalho. Em Python, `fractions.Fraction` e `math.isqrt` resolvem o essencial, e o programa inteiro tem 85 linhas.

**2. Aritmética exata.** Todo racional é guardado como `Fraction`, sem ponto flutuante. Assim `2.5` é exatamente 5/2, e uma fração como `6/3` é simplificada para 2 automaticamente.

**3. Critérios de classificação.**

| Conjunto | Critério usado |
|---|---|
| ℕ | inteiro não negativo (o **zero está incluído**, convenção usada no Brasil) |
| ℤ | a fração irredutível tem denominador 1 |
| ℚ | qualquer razão de inteiros: inteiros, frações, decimais exatos e dízimas periódicas |
| 𝕀 | raiz √n com n inteiro que **não** é quadrado perfeito |
| ℝ | ℚ ∪ 𝕀, então todo número aceito pertence a ℝ |

**4. Dízimas periódicas e fração geratriz.** Há dois caminhos:

- *Entrada em notação de período* (`I.N(P)`, com parte inteira I, parte não periódica N e período P): a geratriz é (IN P − IN) / (10^|N| × (10^|P| − 1)), simplificada. Em `2.1(45)`: (2145 − 21) / (10 × 99) = 2124/990 = 118/55.
- *Qualquer fração ou decimal*: a expansão decimal é feita por divisão longa, guardando os restos já vistos. Quando um resto se repete, os dígitos a partir dele formam o período. Assim `1/3` vira `0.(3)` e `1/7` vira `0.(142857)`. Para toda dízima periódica o programa mostra também a fração geratriz.

Como a expansão volta a produzir a mesma notação (118/55 → `2.1(45)`), os dois caminhos se conferem entre si.

**5. Só raízes são irracionais.** √n é racional se e somente se n é quadrado perfeito, e isso é testado de forma exata com `isqrt`. Já um decimal digitado, como `1.41421356`, tem finitos dígitos e portanto é racional; o programa não tem como provar que ele aproxima um irracional. Por isso 𝕀 só é alcançado por `sqrt(n)` com n não quadrado perfeito. Constantes como π e e não são aceitas, pois exigiriam conhecimento simbólico.

**6. Bônus.** O crivo de Eratóstenes marca os múltiplos de cada número a partir de i², só até √n. Os divisores são os d de 1 a |n| com n mod d = 0.

**7. Entrada inválida.** Texto que não é número (`abc`), divisão por zero (`1/0`) e comandos mal formados mostram "entrada inválida" e o programa continua.

### Exemplos de execução (Parte 2)

Cobrem os cinco tipos exigidos: **inteiro negativo** (`-5`), **fração** (`3/4`), **decimal exato** (`2.5`), **dízima periódica** (`0.(3)`, `2.1(45)`) e **raiz irracional** (`sqrt(2)`), além de uma raiz exata (`sqrt(16)`), uma fração que é inteira (`6/3`) e o bônus.

```bash
python3 conjuntos_numericos.py 7 -5 3/4 2.5 1/3 '0.(3)' '2.1(45)' 'sqrt(2)' 'sqrt(16)' 6/3 -7/2 'primos 30' 'divisores 36'
```

<details>
<summary>Log completo (13 entradas)</summary>

```text
7
  pertence a: ℕ, ℤ, ℚ, ℝ
  não pertence a: 𝕀
  justificativa: 7 é inteiro; decimal 7
-5
  pertence a: ℤ, ℚ, ℝ
  não pertence a: ℕ, 𝕀
  justificativa: -5 é inteiro negativo, logo não é natural; decimal -5
3/4
  pertence a: ℚ, ℝ
  não pertence a: ℕ, ℤ, 𝕀
  justificativa: 3/4 não é inteiro, mas é razão de inteiros; decimal 0.75
2.5
  pertence a: ℚ, ℝ
  não pertence a: ℕ, ℤ, 𝕀
  justificativa: 5/2 não é inteiro, mas é razão de inteiros; decimal 2.5
1/3
  pertence a: ℚ, ℝ
  não pertence a: ℕ, ℤ, 𝕀
  justificativa: 1/3 não é inteiro, mas é razão de inteiros; decimal 0.(3) (dízima periódica, fração geratriz 1/3)
0.(3)
  pertence a: ℚ, ℝ
  não pertence a: ℕ, ℤ, 𝕀
  justificativa: 1/3 não é inteiro, mas é razão de inteiros; decimal 0.(3) (dízima periódica, fração geratriz 1/3)
2.1(45)
  pertence a: ℚ, ℝ
  não pertence a: ℕ, ℤ, 𝕀
  justificativa: 118/55 não é inteiro, mas é razão de inteiros; decimal 2.1(45) (dízima periódica, fração geratriz 118/55)
sqrt(2)
  pertence a: 𝕀, ℝ
  não pertence a: ℕ, ℤ, ℚ
  justificativa: √2 não é quadrado perfeito, logo não é razão de inteiros
sqrt(16)
  pertence a: ℕ, ℤ, ℚ, ℝ
  não pertence a: 𝕀
  justificativa: √16 = 4 (quadrado perfeito); 4 é inteiro; decimal 4
6/3
  pertence a: ℕ, ℤ, ℚ, ℝ
  não pertence a: 𝕀
  justificativa: 2 é inteiro; decimal 2
-7/2
  pertence a: ℚ, ℝ
  não pertence a: ℕ, ℤ, 𝕀
  justificativa: -7/2 não é inteiro, mas é razão de inteiros; decimal -3.5
primos 30 -> [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
divisores 36 -> [1, 2, 3, 4, 6, 9, 12, 18, 36]
```

</details>

### Limitações conhecidas (Parte 2)

- Irracionais só por `√n` com n inteiro não negativo; não há π, e, raízes de frações nem raízes de outros índices.
- Raiz de número negativo não é aceita (não é um número real) e resulta em "entrada inválida".
- `divisores 0` devolve lista vazia, embora todo inteiro divida 0. Para um número negativo, são listados os divisores positivos de |n|.

## Mini-projeto — Controle de acesso por perfis (Python)

Opção 2 do mini-projeto: as permissões são conjuntos, e o programa verifica quem pode o quê usando subconjuntos e união de perfis.

### Como executar

Requer Python 3.8 ou superior (testado com 3.12).

```bash
python3 controle_acesso.py < cenarios/cenario1.txt   # roda um cenário pronto
python3 controle_acesso.py                           # modo interativo (Ctrl-D encerra)
```

Comandos (um por linha):

| Comando | Efeito |
|---|---|
| `perfil P perm1 perm2 ...` | define (ou redefine) o perfil P como o conjunto de permissões |
| `usuario U perfil1 perfil2 ...` | atribui perfis ao usuário U, substituindo a lista anterior |
| `pode U perm` | U tem a permissão? (`sim`/`nao`) |
| `permissoes U` | todas as permissões de U (união dos perfis dele) |
| `contido P Q` | P ⊆ Q? |
| `contido_proprio P Q` | P ⊂ Q? (P ⊆ Q e P ≠ Q) |
| `quem perm` | quais usuários têm a permissão |

Ao fim de qualquer linha, `= resultado` informa o **esperado calculado à mão**: o programa imprime o que calculou e compara (`OK` ou `DIVERGENCIA`). Resultados que são conjuntos são comparados sem depender da ordem, e `vazio` representa o conjunto vazio.

### Decisões de projeto (mini-projeto)

**1. Opção 2.** Foi a escolha mais direta: permissões, perfis e usuários são conjuntos, e as perguntas do enunciado (quem pode o quê, subconjuntos, união de perfis) são exatamente pertinência, inclusão e união da Parte 1.

**2. Conjuntos nativos do Python.** A restrição de não usar operadores prontos era da Parte 1. Aqui o enunciado não a repete, então foram usados `set`, `in`, `<=`, `<` e a união. O programa tem 59 linhas.

**3. Modelo.** Um dicionário guarda cada perfil como conjunto de permissões, e outro guarda para cada usuário a **lista de nomes de perfis**. As permissões do usuário **não são copiadas**: são calculadas na hora como a união dos perfis dele. Por isso redefinir um perfil muda o acesso de todos que o possuem.

**4. Perguntas e a teoria.**

| Pergunta | Conjuntos |
|---|---|
| O usuário U pode X? | X ∈ ⋃ perfis(U) |
| Quais permissões U tem? | ⋃ perfis(U) |
| O perfil P cabe em Q? | P ⊆ Q |
| P é estritamente menor que Q? | P ⊂ Q (P ⊆ Q e P ≠ Q) |
| Quem pode X? | { U : X ∈ ⋃ perfis(U) } |

**5. Casos especiais.** O perfil vazio é um conjunto vazio, e ∅ ⊆ Q para qualquer Q, mas ∅ ⊄ ∅ de forma estrita. Um usuário sem perfis tem a união vazia. Permissões repetidas na definição de um perfil colapsam (com aviso), e atribuir o mesmo perfil duas vezes não muda o resultado, pois a união é idempotente.

**6. Atribuições e erros.** `usuario` substitui a lista anterior de perfis, e recusa perfil inexistente (o usuário não fica criado pela metade). Nome inexistente, comando desconhecido ou falta de argumentos mostram "erro: comando inválido ou nome inexistente", e o programa continua.

**7. Esperado à mão no próprio cenário.** Cada cenário traz o resultado esperado, calculado à mão, ao lado de cada comando, e o programa o compara com o obtido. O conferidor foi testado: ao trocar dois esperados de propósito, ele acusou `DIVERGENCIA` nos dois.

### Exemplos de execução (mini-projeto)

Três cenários de uso, cada um com os resultados esperados (à mão) ao fim das linhas. Nas 33 conferências, todas deram `OK`. As linhas que começam com `>` são os comandos digitados.

| Cenário | Arquivo | O que mostra |
|---|---|---|
| 1 | `cenarios/cenario1.txt` | pertinência (`pode ana apagar = nao`), união de perfis (bruno: editor + auditor) e `quem` |
| 2 | `cenarios/cenario2.txt` | hierarquia leitor ⊆ editor ⊆ admin, auditor ⊄ editor, e eva passando a escrever ao somar o perfil editor |
| 3 | `cenarios/cenario3.txt` | perfis **iguais**, **disjuntos**, **vazio** e permissão **repetida** na entrada |

<details>
<summary>Cenário 1 — pertinência e união de perfis (log completo)</summary>

```text
> perfil leitor ler
  {ler}
> perfil editor ler escrever
  {escrever, ler}
> perfil auditor ler exportar
  {exportar, ler}
> perfil admin ler escrever apagar exportar
  {apagar, escrever, exportar, ler}
> usuario ana editor
  {escrever, ler}
> usuario bruno editor auditor
  {escrever, exportar, ler}
> usuario carla admin
  {apagar, escrever, exportar, ler}
> usuario davi
  {}
> pode ana apagar = nao
  nao
  esperado: nao -> OK
> pode ana escrever = sim
  sim
  esperado: sim -> OK
> permissoes bruno = ler escrever exportar
  {escrever, exportar, ler}
  esperado: ler escrever exportar -> OK
> permissoes davi = vazio
  {}
  esperado: vazio -> OK
> pode davi ler = nao
  nao
  esperado: nao -> OK
> quem exportar = bruno carla
  {bruno, carla}
  esperado: bruno carla -> OK
> quem apagar = carla
  {carla}
  esperado: carla -> OK
```

</details>

<details>
<summary>Cenário 2 — subconjuntos e troca de perfis (log completo)</summary>

```text
> perfil leitor ler
  {ler}
> perfil editor ler escrever
  {escrever, ler}
> perfil auditor ler exportar
  {exportar, ler}
> perfil admin ler escrever apagar exportar
  {apagar, escrever, exportar, ler}
> contido leitor editor = sim
  sim
  esperado: sim -> OK
> contido editor admin = sim
  sim
  esperado: sim -> OK
> contido admin editor = nao
  nao
  esperado: nao -> OK
> contido auditor editor = nao
  nao
  esperado: nao -> OK
> contido_proprio editor admin = sim
  sim
  esperado: sim -> OK
> contido editor editor = sim
  sim
  esperado: sim -> OK
> contido_proprio editor editor = nao
  nao
  esperado: nao -> OK
> usuario eva auditor = ler exportar
  {exportar, ler}
  esperado: ler exportar -> OK
> pode eva escrever = nao
  nao
  esperado: nao -> OK
> usuario eva auditor editor = ler escrever exportar
  {escrever, exportar, ler}
  esperado: ler escrever exportar -> OK
> pode eva escrever = sim
  sim
  esperado: sim -> OK
```

</details>

<details>
<summary>Cenário 3 — casos especiais: iguais, disjuntos, vazio e repetido (log completo)</summary>

```text
> perfil leitor ler
  {ler}
> perfil editor ler escrever
  {escrever, ler}
> perfil suporte escrever ler ler = ler escrever
  permissões repetidas ignoradas
  {escrever, ler}
  esperado: ler escrever -> OK
> perfil financeiro faturar pagar
  {faturar, pagar}
> perfil convidado = vazio
  {}
  esperado: vazio -> OK
> contido editor suporte = sim
  sim
  esperado: sim -> OK
> contido suporte editor = sim
  sim
  esperado: sim -> OK
> contido_proprio editor suporte = nao
  nao
  esperado: nao -> OK
> contido editor financeiro = nao
  nao
  esperado: nao -> OK
> contido financeiro editor = nao
  nao
  esperado: nao -> OK
> contido convidado editor = sim
  sim
  esperado: sim -> OK
> contido_proprio convidado editor = sim
  sim
  esperado: sim -> OK
> contido convidado convidado = sim
  sim
  esperado: sim -> OK
> contido_proprio convidado convidado = nao
  nao
  esperado: nao -> OK
> usuario fabio financeiro editor = faturar pagar ler escrever
  {escrever, faturar, ler, pagar}
  esperado: faturar pagar ler escrever -> OK
> usuario gui convidado = vazio
  {}
  esperado: vazio -> OK
> pode gui ler = nao
  nao
  esperado: nao -> OK
> quem ler = fabio
  {fabio}
  esperado: fabio -> OK
```

</details>

### Limitações conhecidas (mini-projeto)

- Não há herança entre perfis: a inclusão (`contido`) só é consultada, e não concede permissões automaticamente.
- Os dados ficam só em memória durante a execução (nada é gravado em arquivo).
- Não há comando para remover perfis ou usuários, e os nomes não podem ter espaços nem o caractere `=`.

## Estrutura do repositório

```
.
├── main.cob                  # Parte 1 (COBOL)
├── conjuntos_numericos.py    # Parte 2 (Python)
├── controle_acesso.py        # mini-projeto (Python)
├── cenarios/                 # cenários do mini-projeto
│   ├── cenario1.txt
│   ├── cenario2.txt
│   └── cenario3.txt
├── README.md                 # este arquivo
└── TESTES.md                 # casos de teste com logs das três partes
```
