import re, sys
from fractions import Fraction
from math import isqrt

TODOS = ["ℕ", "ℤ", "ℚ", "𝕀", "ℝ"]


def decimal(f):
    """Expansão decimal de f por divisão longa; o período vai entre parênteses."""
    inteira, r = divmod(abs(f.numerator), f.denominator)
    digs, vistos = [], {}
    while r and r not in vistos:
        vistos[r] = len(digs)
        r *= 10
        digs.append(str(r // f.denominator))
        r %= f.denominator
    if r:
        i = vistos[r]
        frac = "".join(digs[:i]) + "(" + "".join(digs[i:]) + ")"
    else:
        frac = "".join(digs)
    return ("-" if f < 0 else "") + str(inteira) + ("." + frac if frac else "")


def classificar(s):
    nota = ""
    m = re.fullmatch(r"(?:sqrt|raiz|√)\s*\(?\s*(\d+)\s*\)?", s)
    if m:
        n = int(m[1])
        k = isqrt(n)
        if k * k != n:
            return ["𝕀", "ℝ"], f"√{n} não é quadrado perfeito, logo não é razão de inteiros"
        s, nota = str(k), f"√{n} = {k} (quadrado perfeito); "
    m = re.fullmatch(r"(-?)(\d+)\.(\d*)\((\d+)\)", s)
    if m:
        sinal, i, a, p = m.groups()
        f = Fraction(int(i + a + p) - int(i + a), 10 ** len(a) * (10 ** len(p) - 1))
        f = -f if sinal else f
    else:
        f = Fraction(s)
    d = decimal(f)
    pert = ["ℚ", "ℝ"]
    if f.denominator == 1:
        pert.insert(0, "ℤ")
        porque = f"{f} é inteiro"
        if f >= 0:
            pert.insert(0, "ℕ")
        else:
            porque += " negativo, logo não é natural"
    else:
        porque = f"{f} não é inteiro, mas é razão de inteiros"
    porque += f"; decimal {d}"
    if "(" in d:
        porque += f" (dízima periódica, fração geratriz {f})"
    return pert, nota + porque


def primos(n):
    c = [True] * (n + 1)
    for i in range(2, isqrt(n) + 1):
        if c[i]:
            c[i * i::i] = [False] * len(c[i * i::i])
    return [i for i in range(2, n + 1) if c[i]]


def divisores(n):
    return [d for d in range(1, abs(n) + 1) if n % d == 0]


if len(sys.argv) < 2:
    print("Digite: inteiro, a/b, decimal (2.5), dízima (0.(3)), sqrt(n), 'primos n' ou 'divisores n'. Ctrl-D encerra.")
for linha in sys.argv[1:] or sys.stdin:
    linha = linha.strip()
    try:
        cmd, _, arg = linha.partition(" ")
        if cmd == "primos":
            print(linha, "->", primos(int(arg)))
        elif cmd == "divisores":
            print(linha, "->", divisores(int(arg)))
        else:
            pert, porque = classificar(linha)
            nao = [c for c in TODOS if c not in pert]
            print(f"{linha}\n  pertence a: {', '.join(pert)}\n  não pertence a: {', '.join(nao)}\n  justificativa: {porque}")
    except (ValueError, ZeroDivisionError):
        print(linha, "-> entrada inválida")
