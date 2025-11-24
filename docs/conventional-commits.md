# Conventional Commits og Versjonshåndtering

## Oversikt

Dette prosjektet bruker [Conventional Commits](https://www.conventionalcommits.org/) for strukturerte commit-meldinger og automatisk release-håndtering via GitHub Actions.

## Hva er Conventional Commits?

Conventional Commits er en konvensjon for å skrive commit-meldinger som er maskinlesbare og menneskeforståelige. Dette gjør det mulig å automatisk generere changelogs og håndtere semantisk versjonering.

## Commit-melding format

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Typer (type)

| Type | Beskrivelse | Versjonsbump |
|------|-------------|--------------|
| `feat` | Ny funksjonalitet | MINOR (0.x.0) |
| `fix` | Bugfix | PATCH (0.0.x) |
| `docs` | Kun dokumentasjonsendringer | Ingen |
| `style` | Formatering, manglende semikolon, etc. | Ingen |
| `refactor` | Kodeendring som verken fikser bug eller legger til funksjon | Ingen |
| `perf` | Ytelsesforbedrende endring | PATCH |
| `test` | Legge til manglende tester | Ingen |
| `build` | Endringer i build-system eller dependencies | Ingen |
| `ci` | Endringer i CI-konfigurasjon | Ingen |
| `chore` | Andre endringer som ikke påvirker kildekode | Ingen |
| `revert` | Tilbakestiller en tidligere commit | Kontekstuelt |

### Breaking Changes

For å indikere breaking changes:

```
feat!: ny API som endrer eksisterende funksjonalitet

BREAKING CHANGE: API endepunkter er nå versjonert
```

Dette gir en MAJOR versjonsbump (x.0.0).

## Eksempler

### Enkel feature

```bash
git commit -m "feat: legg til lastpass-cli integrasjon"
```

### Feature med scope

```bash
git commit -m "feat(ansible): legg til vault password support"
```

### Bugfix

```bash
git commit -m "fix: rett opp ssh-agent forwarding i devcontainer"
```

### Breaking change

```bash
git commit -m "feat!: endre devcontainer base image til python 3.12

BREAKING CHANGE: Python 3.10 er ikke lenger støttet"
```

### Dokumentasjon

```bash
git commit -m "docs: legg til guide for pre-commit hooks"
```

### Med body og footer

```bash
git commit -m "fix(docker): løs problem med volume permissions

Endret mount-opsjoner for å tillate skrivetilgang
til .ssh katalog.

Fixes #42"
```

## Versjonshåndtering

### VERSION-fil

Prosjektet har en `VERSION`-fil i root som inneholder gjeldende versjon:

```
0.1.0
```

### Semantisk versjonering

Vi følger [Semantic Versioning](https://semver.org/) (SemVer):

**Format:** `MAJOR.MINOR.PATCH`

- **MAJOR**: Inkompatible API-endringer (breaking changes)
- **MINOR**: Ny funksjonalitet (bakoverkompatibel)
- **PATCH**: Bugfixes (bakoverkompatible)

### Oppdatere versjon

Når du skal lage en ny release:

1. **Oppdater VERSION-filen:**

```bash
echo "0.2.0" > VERSION
git add VERSION
git commit -m "chore: bump version to 0.2.0"
```

2. **Opprett og push tag:**

```bash
git tag -a v0.2.0 -m "Release v0.2.0"
git push origin main
git push origin v0.2.0
```

3. **GitHub Actions oppretter automatisk release**

## GitHub Actions Release Workflow

Workflowen (`.github/workflows/release.yml`) kjører automatisk når du pusher en versjonert tag.

### Workflow-steg

1. **Trigger**: Når du pusher en tag som matcher `v*.*.*` (f.eks. `v0.2.0`)
2. **Sjekker ut koden**: Henter full Git-historikk
3. **Ekstraherer versjon**: Fjerner `v` prefix fra tag
4. **Verifiserer VERSION-fil**: Sjekker at VERSION matcher tag
5. **Genererer changelog**: Lister commits siden forrige tag
6. **Oppretter GitHub Release**: Med changelog og release notes

### Hvordan lage en release

```bash
# 1. Oppdater VERSION-fil
echo "1.0.0" > VERSION

# 2. Commit endringen
git add VERSION
git commit -m "chore: bump version to 1.0.0"

# 3. Opprett annotated tag
git tag -a v1.0.0 -m "Release v1.0.0

Major release with following features:
- LastPass integration
- Pre-commit hooks
- Automated deployment
- Comprehensive documentation"

# 4. Push til GitHub
git push origin main
git push origin v1.0.0

# 5. Se release på GitHub
# Gå til: https://github.com/aopdal/dev-setup/releases
```

### Release workflow output

Når workflowen kjører, får du:

- ✅ Automatisk opprettet GitHub Release
- 📋 Changelog basert på commits
- 🏷️ Release notes generert av GitHub
- 🔗 Lenke til release

## Pre-commit Hook for Conventional Commits

Pre-commit sjekker automatisk at commit-meldinger følger Conventional Commits-formatet.

### Hva sjekkes?

- ✅ Type er gyldig (`feat`, `fix`, `docs`, etc.)
- ✅ Format er korrekt (`type: description`)
- ✅ Description starter med liten bokstav
- ✅ Ingen punktum på slutten av description

### Eksempel på validering

```bash
# ✅ Gyldig
$ git commit -m "feat: legg til ny funksjon"

# ❌ Ugyldig - mangler type
$ git commit -m "legg til ny funksjon"
[FAIL] Commit message should be in format 'type: description'

# ❌ Ugyldig - ugyldig type
$ git commit -m "feature: legg til ny funksjon"
[FAIL] Type 'feature' is not allowed

# ❌ Ugyldig - description starter med stor bokstav
$ git commit -m "feat: Legg til ny funksjon"
[FAIL] Description should start with lowercase
```

## Workflow for endringer

### Normal endring

```bash
# 1. Gjør endringer
vim docs/new-guide.md

# 2. Stage endringer
git add docs/new-guide.md

# 3. Commit med Conventional Commits format
git commit -m "docs: legg til guide for xyz"

# Pre-commit kjører automatisk og validerer meldingen

# 4. Push
git push origin main
```

### Forberede release

```bash
# 1. Bestem ny versjon basert på endringer
# - Brukte du feat? → Bump MINOR
# - Brukte du fix? → Bump PATCH
# - Brukte du BREAKING CHANGE? → Bump MAJOR

# 2. Oppdater VERSION
echo "1.1.0" > VERSION

# 3. Commit versjon
git add VERSION
git commit -m "chore: bump version to 1.1.0"

# 4. Lag tag
git tag -a v1.1.0 -m "Release v1.1.0"

# 5. Push alt
git push origin main
git push origin v1.1.0

# 6. GitHub Actions oppretter release automatisk
```

## Beste praksis

### ✅ GJØR:

- **Bruk imperative mood** - "add" ikke "added"
- **Hold description kort** - Under 72 tegn
- **Bruk body for detaljer** - Forklar hvorfor, ikke hva
- **Referrer issues** - `Fixes #123` i footer
- **Én logisk endring per commit** - Lettere å forstå
- **Test før commit** - Kjør `pre-commit run --all-files`

### ❌ IKKE GJØR:

- **Vage meldinger** - "fikset ting", "oppdateringer"
- **Flere endringer i én commit** - Vanskelig å reverter
- **Skip pre-commit** - Med mindre absolutt nødvendig
- **Glem å oppdatere VERSION** - Før du lager tag

## Eksempel på release-historikk

```
v1.0.0 - Major Release
  feat!: migrert til Python 3.12
  feat: lagt til LastPass integrasjon
  feat: implementert pre-commit hooks
  docs: komplett dokumentasjon

v0.2.0 - Minor Release
  feat(ansible): vault password support
  feat(docker): volume mounting improvements
  fix: ssh-agent forwarding issue
  docs: git basics guide

v0.1.1 - Patch Release
  fix: markdownlint konfigurasjon
  fix: devcontainer post-create script

v0.1.0 - Initial Release
  feat: initial devcontainer setup
  docs: development environment guide
```

## Feilsøking

### Problem: Pre-commit avviser commit-melding

```bash
$ git commit -m "added new feature"
[FAIL] Commit message should be in format 'type: description'
```

**Løsning:** Bruk riktig format:

```bash
git commit -m "feat: add new feature"
```

### Problem: VERSION og tag matcher ikke

```bash
❌ Error: VERSION file (0.1.0) does not match tag (0.2.0)
```

**Løsning:** Oppdater VERSION-filen før du lager tag:

```bash
echo "0.2.0" > VERSION
git add VERSION
git commit -m "chore: bump version to 0.2.0"
git tag -a v0.2.0 -m "Release v0.2.0"
```

### Problem: Vil endre commit-melding etter pre-commit

```bash
# Endre siste commit-melding
git commit --amend -m "feat: korrekt melding"
```

## Hurtigreferanse

| Kommando | Beskrivelse |
|----------|-------------|
| `git commit -m "feat: description"` | Feature commit |
| `git commit -m "fix: description"` | Bugfix commit |
| `git commit -m "docs: description"` | Dokumentasjon |
| `git commit -m "feat!: description"` | Breaking change |
| `echo "1.0.0" > VERSION` | Oppdater versjon |
| `git tag -a v1.0.0 -m "msg"` | Opprett annotated tag |
| `git push origin v1.0.0` | Push tag (trigger release) |
| `git tag -d v1.0.0` | Slett lokal tag |
| `git push origin --delete v1.0.0` | Slett remote tag |

## Ytterligere ressurser

- [Conventional Commits spesifikasjon](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)
- [GitHub Releases](https://docs.github.com/en/repositories/releasing-projects-on-github)
- [Keep a Changelog](https://keepachangelog.com/)
