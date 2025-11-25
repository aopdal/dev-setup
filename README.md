# GærneArnes nettverksskole

## 🎓 Opplæringsmiljø for Nettverkskonsulenter

Dette er et **praktisk opplæringsmiljø** for nettverkskonsulenter som trenger trening i DevOps-basert drift og nettverksautomasjon. Repoet balanserer pedagogikk med sikkerhet og introduserer moderne DevOps-praksis på en tilgjengelig måte.

### 🎯 Målgruppe
Nettverkskonsulenter som ønsker å:
- Lære nettverksautomasjon med Ansible
- Forstå Infrastructure as Code (IaC)
- Jobbe med moderne DevOps-verktøy
- Få hands-on erfaring i et trygt lab-miljø

### 🛡️ Sikkerhet & Lab-miljø

Dette er et **opplæringsmiljø** med bevisste trade-offs for pedagogikk:

✅ **Production-ready praksis du lærer:**
- Secret management med LastPass CLI og Ansible Vault
- Pre-commit hooks for automatisk kvalitetskontroll
- Conventional Commits og semantic versioning
- CI/CD med GitHub Actions
- Infrastructure as Code

⚠️ **Lab-konfigurasjoner (IKKE for produksjon):**
- SSH host key checking deaktivert (for enkelt lab-oppsett)
- Passwordless sudo i container (trygt i isolert miljø)
- Debug playbooks inkludert (pedagogisk verktøy)
- Unpinned dependencies (får nyeste versjoner)

**📚 Les mer:** Se `docs/security-assessment.md` for full security review og produksjonsvei.

---

## 🚀 Kom i gang

For å sette opp utviklingsmiljøet på din Windows 11 maskin så følg oppsettet i [dev-environment](docs/dev-environment.md).

Dette oppsettet er laget for å forenkle deling av kode mest mulig. Og ikke minst at kjøremiljøet skal være enkelt å holde konsistent fra PC til PC.

## Fordeler ved bruk av DevContainer

DevContainers gir deg et konsistent og isolert utviklingsmiljø med flere viktige fordeler:

### Konsistens på tvers av maskiner
- Alle utviklere jobber i nøyaktig samme miljø, uavhengig av operativsystem
- Eliminerer "det funker på min maskin"-problemer
- Identisk oppsett mellom Windows, Mac og Linux

### Enkel onboarding
- Nye teammedlemmer er klare til å kode på minutter
- Ingen tidkrevende manuell installasjon av verktøy og avhengigheter
- Komplett miljø definert i kodefiler som kan versjonshåndteres

### Isolasjon og sikkerhet
- Prosjektavhengigheter holdes separert fra vertsmaskinen
- Ingen konflikt mellom ulike versjoner av Python, Node.js eller andre verktøy
- Trygt å teste nye pakker uten å påvirke systemet ditt

### Reproduserbarhet
- Miljøet er definert som kode (Infrastructure as Code)
- Lett å gjenskape eksakt samme oppsett når som helst
- Perfekt for testing og feilsøking

### Fleksibilitet
- Raskt å bytte mellom ulike prosjekter med forskjellige krav
- Støtte for tilpasninger per prosjekt
- Kan lett integreres med CI/CD-pipelines

## Alternativ: Python Virtual Environment (venv)

Dersom det ikke er mulig å bruke Docker eller DevContainers, er Python's innebygde `venv` et godt alternativ for å isolere prosjektavhengigheter.

### Hva er venv?
`venv` er et innebygd Python-verktøy som skaper et isolert miljø for Python-pakker. Dette gjør at hvert prosjekt kan ha sine egne avhengigheter uten å påvirke andre prosjekter eller systemets Python-installasjon.

### Oppsett av venv

**Opprett et virtuelt miljø:**

```bash
python -m venv .venv
```

**Aktiver miljøet:**

```bash
# Windows
.venv\Scripts\activate

# Linux/Mac
source .venv/bin/activate
```

**Installer pakker:**

```bash
pip install mkdocs
# eller fra en requirements.txt fil
pip install -r requirements.txt
```

**Deaktiver miljøet når du er ferdig:**

```bash
deactivate
```

### Fordeler med venv

- **Enkelt oppsett**: Ingen ekstra programvare utover Python kreves
- **Lett å bruke**: Enkel å aktivere og deaktivere
- **Isolasjon av pakker**: Hver prosjekt har sine egne avhengigheter
- **Portabelt**: Fungerer på Windows, Mac og Linux
- **Lav overhead**: Ingen containerisering, bruker maskinen direkte

### Ulemper sammenlignet med DevContainer

- **Ikke fullstendig isolasjon**: Systemverktøy og operativsystem påvirker fremdeles miljøet
- **Krever manuell oppsett**: Må installere Python og andre verktøy selv
- **Mindre konsistent**: Kan fortsatt få forskjeller mellom maskiner
- **Bare for Python**: Andre språk og verktøy må håndteres separat

### Når bør du bruke venv?

- Når Docker ikke er tilgjengelig eller tillatt
- For enkle Python-prosjekter
- Når du jobber alene og ikke trenger full konsistens
- For rask prototyping og testing

---

## 📚 Dokumentasjon

Alle guider er på norsk og dekker:

### Kom i gang
- [Dev Environment Setup](docs/dev-environment.md) - Installasjon av Docker og VS Code
- [Docker Vedlikehold](docs/docker-vedlikehold.md) - Vedlikehold og troubleshooting

### Ansible & Secrets
- [Ansible Vault Guide](docs/ansible-vault-guide.md) - Håndtering av hemmeligheter med LastPass
- [Security Assessment](docs/security-assessment.md) - Full security review (lab vs. produksjon)
- [Critical Fixes](docs/CRITICAL-FIXES.md) - Viktige sikkerhetspunkter

### Git & Automation
- [Git Basics](docs/git-basics.md) - Grunnleggende Git-kommandoer
- [Pre-commit Guide](docs/pre-commit-guide.md) - Automatisk kodekvalitet
- [Conventional Commits](docs/conventional-commits.md) - Commit-format og versjonering
- [GitHub Actions Deploy](docs/github-actions-deploy.md) - CI/CD deployment
- [GitHub Branch Protection](docs/github-branch-protection.md) - Branch protection setup

---

## 🔐 Sikkerhetspraksis

### ✅ Hva er implementert (production-ready)
- **LastPass CLI**: Sikker lagring av vault password
- **Ansible Vault**: Krypterte variabler i Git
- **Pre-commit hooks**: Automatisk linting og validation
- **Comprehensive .gitignore**: Beskytter mot credential leaks
- **Branch protection**: PAT-basert CI/CD

### ⚠️ Før produksjon
Disse endringene MÅ gjøres før produksjonsbruk:

```bash
# 1. Aktiver SSH host key checking
# Rediger ansible.cfg:
host_key_checking = True

# 2. Fjern debug playbooks
rm -rf playbooks/debug/

# 3. Pin dependencies
# Rediger Dockerfile:
FROM python:3.12.7-slim@sha256:...

# Rediger requirements.txt til eksakte versjoner:
ansible==11.1.0
mkdocs-material==9.5.3
```

Se `docs/security-assessment.md` for komplett checklist.

---

## 🤝 Bidra

Dette er et opplæringsprosjekt. Forbedringer og tilbakemeldinger er velkomne!

1. Fork repoet
2. Opprett en feature branch (`git checkout -b feature/ny-funksjon`)
3. Bruk conventional commits (`git commit -m 'feat: legg til ny guide'`)
4. Push til din branch (`git push origin feature/ny-funksjon`)
5. Åpne en Pull Request

Pre-commit hooks vil automatisk validere koden din.

---

## 📄 Lisens

Se [LICENSE](LICENSE) for detaljer.
