import sys

perfis, usuarios = {}, {}


def permissoes(u):
    return set().union(*(perfis[p] for p in usuarios[u]))


def executar(cmd, a):
    if cmd == "perfil":
        perfis[a[0]] = set(a[1:])
        if len(perfis[a[0]]) != len(a) - 1:
            print("  permissões repetidas ignoradas")
        return perfis[a[0]]
    if cmd == "usuario":
        if not all(p in perfis for p in a[1:]):
            raise KeyError(a)
        usuarios[a[0]] = a[1:]
        return permissoes(a[0])
    if cmd == "pode":
        return a[1] in permissoes(a[0])
    if cmd == "permissoes":
        return permissoes(a[0])
    if cmd == "contido":
        return perfis[a[0]] <= perfis[a[1]]
    if cmd == "contido_proprio":
        return perfis[a[0]] < perfis[a[1]]
    if cmd == "quem":
        return {u for u in usuarios if a[0] in permissoes(u)}
    raise ValueError(cmd)


if sys.stdin.isatty():
    print("Comandos: perfil P perms | usuario U perfis | pode U perm | permissoes U | contido P Q | contido_proprio P Q | quem perm")
    print("Opcional: '= esperado' ao fim da linha confere o resultado. Ctrl-D encerra.")
for linha in sys.stdin:
    linha = linha.strip()
    if not linha:
        continue
    if not sys.stdin.isatty():
        print(">", linha)
    corpo, _, esperado = linha.partition("=")
    try:
        cmd, *args = corpo.split()
        r = executar(cmd, args)
    except (KeyError, IndexError, ValueError):
        print("  erro: comando inválido ou nome inexistente")
        continue
    if isinstance(r, bool):
        r = {"sim" if r else "nao"}
        texto = next(iter(r))
    else:
        texto = "{" + ", ".join(sorted(r)) + "}"
    print(" ", texto)
    esp = esperado.split()
    if esp:
        ok = r == (set() if esp == ["vazio"] else set(esp))
        print(f"  esperado: {' '.join(esp)} -> {'OK' if ok else 'DIVERGENCIA'}")
