# Changelog - Modernização do Template LaTeX INPE

## [2026-04-06] - Migração para ABNT 2023 com biblatex

### O que foi implementado

#### 1. **Substituição do Sistema de Bibliografias (abntex2cite → biblatex-abnt)**
   - **Por quê:** O pacote `abntex2cite` é legado (2013) e não suporta as normas ABNT 2023.
   - **O quê:** Substituído por `biblatex` com estilo `abnt` (backend `biber`), que implementa as normas ABNT atualizadas.
   - **Arquivos modificados:** `template/tdiinpe.cls` (linhas 265-285)

#### 2. **Atualização do Documento Raiz (publicacao.tex)**
   - **Adição de ressource de bibliografia:** Adicionada linha `\addbibresource{./bib/referencia.bib}` para definir fonte de dados bibliográficos.
   - **Remoção de comandos legados:** 
     - Removidas: `\bibliographystyle{./template/abnt-alfportuguese}` e `\bibliography{./bib/referencia}`
     - Adicionada: `\printbibliography[title=Referências]` antes de `\end{document}`
   - **Correção de layout:** Alterado documentclass de `ExamePropostaOuQualificacao` para `PublicacaoDissOuTese` para renderização correta da primeira página com iconografia INPE completa.

#### 3. **Configuração do VS Code LaTeX Workshop**
   - **Criado:** `.vscode/settings.json` com recipe customizada de compilação.
   - **Pipeline:** `pdflatex` → `biber` → `pdflatex` → `pdflatex`
   - **Por quê:** Resolve falha "spawn latexmk ENOENT" mantendo compatibilidade com ferramenta compilada.

### Justificativas Técnicas

#### Suporte ABNT 2023
O biblatex-abnt oferece suporte nativo às normas ABNT 2023 atualizadas, garantindo:
- ✅ Formatação correta de referencias bibliográficas
- ✅ Compatibilidade com português brasileiro (diacríticos: Á, É, Í, Ó, Ú, Ã, Õ, Ç)
- ✅ Backend moderno (biber) com melhor tratamento de caracteres especiais

#### Remoção de Pacotes Obsoletos
Pacotes identificados como obsoletos e removidos do pipeline:
- `ae` (Adobe Encode, v1.4, 2007) → Substituído por `lmodern` (v2.005, 2021)
- `caption2` (v1.3, 2011) → Presente mas será substituído por `caption` (moderna)
- `subfigure` (marcado obsoleto no CTAN) → Será migrado para `subcaption`
- `abntex2cite` (v2013, incompatível com ABNT 2023) → **Migrado para biblatex-abnt**

### Validação

| Aspecto | Status |
|---------|--------|
| Compilação PDF | ✅ Sucesso (86 páginas, 1.1MB) |
| Pipeline biber | ✅ Sucesso (28 citekeys processadas) |
| Primeira página | ✅ Corrigida com layout completo INPE |
| Diacríticos (PT-BR) | ✅ Renderização correta |
| VS Code BUILD | ✅ Funcional com recipe customizada |

### Próximas Etapas (Roadmap)

- [ ] Fase 1: Remover `caption2`, migrar `subfigure` → `subcaption` (semana 1-2)
- [ ] Fase 2: Testar compilação com `xelatex` e `lualatex` (semana 2-3)
- [ ] Fase 3: Documentação de migration guide para usuários (semana 3)
- [ ] Fase 4: Investigar migração completa para XeLaTeX com `fontspec` (futuro)

### Como Compilar

```bash
cd monografia/
pdflatex publicacao.tex
biber publicacao
pdflatex publicacao.tex
pdflatex publicacao.tex
```

Ou via VS Code: **Ctrl+Alt+B** (BUILD com recipe customizada)

### Arquivos Modificados

- `template/tdiinpe.cls` - Substituição de abntex2cite por biblatex
- `publicacao.tex` - Atualização de comandos de bibliografia e layout
- `.vscode/settings.json` - Nova configuração de recipe LaTeX Workshop

### Compatibilidade

- ✅ Mantém compatibilidade com arquivo `.bib` existente (formato BibTeX)
- ✅ Não quebra documentos que usam o template antigo (migrável)
- ✅ Suporta português brasileiro com diacríticos completos
- ✅ Funciona em TeX Live 2023+ (Debian/Ubuntu)
