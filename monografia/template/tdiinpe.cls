%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tdAgriRSLabInpe.cls
% Classe AgriRSLab - INPE para teses e dissertacoes e outras publicações
%
%*     Laboratório de Sensoriamento Remoto Agrícola(AgriRSLab)                  *% 
%*     Instituto de Pesquisas Espaciais (INPE)                                  *% 
%*     Ao reusar o tdAgriRSLabInpe.cls por favor, mencione o documento original *%
%*     e a classe tdiinpe.cls, desenvolvido pelo MCTI/INPE, da qual ele deriva. *%
%
% Mantenedor e Desenvolvedor atual:
% Luiz Gabriel da Silva (luiz.gabriel@inpe.br)

% ----- Identificacao:
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{./template/tdiinpe}[2022/10/11 v1.38]

% modificaçoes em relação a classe TDIINPE versão 2022/10/11 v1.38
%------------------------------------
% 26 de Outubro de 2023
% - Inclusão de uma opção para elaboração de monografias para exames de qualificação e proposta de tese, necessários ao programa de Pós-graduação em Sensoriamento Remoto (PGSER)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\usepackage{ifpdf} 

%%% Criando uma variável para definir se a cópia é digital ou não %%%
\newif\ifdigitalcopy
\digitalcopyfalse % Por padrão, não é uma cópia digital


%%% Checa se foi chamado o comando htlatex para gerar documento em html
\newif\ifHTML
  \ifx\HCode\undefined
      \HTMLfalse\typeout{===================tex4ht-false}
  \else
      \HTMLtrue\typeout{===================tex4ht-true}
 \fi

%%%%%%%%%% Classe base
\LoadClass[12pt,twoside,onecolumn,openright,a4paper]{report} %% essencial

\RequirePackage{titlesec}% needed for \titleformat and \titlespacing - acrescentado por gjfb em 2009-10-11
\RequirePackage{titletoc}% needed for \titlecontents - acrescentado por gjfb em 2009-10-11

\RequirePackage[overload]{textcase} %% para poder deixar algum texto em minúscula no título usando \NoCaseChange{}
\RequirePackage{ifthen} %% essencial %% operador de condicionais
\RequirePackage{calc} %% essencial %% operações matemáticas

\ifpdf
  \RequirePackage[pdftex]{graphicx} %% essencial %% para inserir figuras
  \RequirePackage[pdftex]{graphics}
\else
  \RequirePackage{epic,eepic}
  \RequirePackage[dvips]{epsfig}
  \RequirePackage[dvips]{graphics}
  \RequirePackage[dvips]{graphicx}
% Os tres pacotes abaixo sao necessarios para a inclusao de figuras (codigos) utilizando o LatexDraw
% informacoes em: http://latexdraw.sourceforge.net/
  \RequirePackage[usenames,dvipsnames]{pstricks}
  \RequirePackage{pst-grad} % For gradients
  \RequirePackage{pst-plot} % For axes
\fi

\RequirePackage{color} %% essencial %% aplicar cores no texto
\RequirePackage[utf8]{inputenc} %% essencial

\RequirePackage{float}	%% acrescentado por gjfb em 2012-10-19 seguindo recomendação do Fabio Dall Cortivo

\RequirePackage{babel} %% essencial %% docs em vários idiomas

\RequirePackage{hyphenat} %% essencial %% hifenização
\RequirePackage{array} %% essencial %% variante para arranjos e tabelas 
\RequirePackage{setspace} %% essencial %% define espaços entre linhas no texto
\RequirePackage{bigdelim} %% essencial %% para uso de tabelas
\RequirePackage{multirow} %% essencial %% para uso de tabelas
\RequirePackage{supertabular} %% essencial %% para uso de tabelas
\RequirePackage{tabularx} %% essencial %% para uso de tabelas
\RequirePackage{longtable} %% essencial %% para uso de tabelas
\RequirePackage{lastpage} %% cuidado com o uso do endfloat %% dá o num. de pág. total do doc.
\RequirePackage{lscape} %% essencial %% página em orientação paisagem (landscape)
\RequirePackage{rotate} %% essencial %% roda floats (figuras, tabelas)
\RequirePackage[hang,small]{caption2}
\RequirePackage{amsmath,amssymb,amsthm} %% essencial %% para linguagem matemática

\RequirePackage{subfigure} %% essencial %% fazer subfiguras
\RequirePackage[subfigure]{tocloft} %% faz sumários e listas - needed for \cftchapindent
\RequirePackage{makeidx} %% essencial %% faz o ÍNDICE
\RequirePackage{eso-pic}
\newif\ifcalligra
\IfFileExists{calligra.sty} %% carrega fonte estilo caligráfico, se houver
{\RequirePackage{calligra} \calligratrue}{\calligrafalse}

%% opcoes de cores
\definecolor{gray}{rgb}{0.4,0.4,0.4}
\definecolor{bblue}{rgb}{0,0,.4} %% tom azul mais escuro

%% Ativa bibliografia explicita (abnt-verbatim-entry) no formato bibtex
%% incompatível com o backref.sty por enquanto (ou um ou outro)
\gdef\@ativapbr{true} %% true or false : ativa pagebackref
\ifHTML\gdef\@ativapbr{false}\fi
\RequirePackage[debug,pagebackref=\@ativapbr,breaklinks,bookmarksopen=true,colorlinks=true,linkcolor=bblue,citecolor=bblue,urlcolor=bblue,filecolor=bblue,bookmarksnumbered=true,hyperindex=true,verbose=true]{hyperref} %% essential %% gera pdf/dvi com links	% opção a4paper retirada em 2010-10-07 por gjfb por não ser mais usada pelo pacote hyperref

\ifpdf
  \RequirePackage{ae} %% essencial %% fontes para pdf
\else
  \RequirePackage[T1]{fontenc}
\fi

\usepackage{lmodern}	% permite o copiar/colar com acentuação a partir do pdf

\DeclareOption*{} %% para tirar warnings de options passadas pela classe tdiinpe para report

\DeclareOption{SemImagens}{
	\typeout{-------------->Opcao: SemImagens}
	\Gin@drafttrue
}

\DeclareOption{SemVinculoColorido}{%
	\typeout{-------------->Opcao: SemVinculoColorido}
	\def\@linkcolor{black}
	\def\@anchorcolor{black}
	\def\@citecolor{black}
	\def\@urlcolor{black}
}

%%% default for this documentclass = Tese ou Dissertação

\gdef\@docSemFormatacaoCapitulo{true}
\gdef\@includeFCNotasOrientadorTD{true}
\gdef\@includeFC{true}
\gdef\@includeFA{true}


%%% Acrescentado por lgs em 2023-06-01
%% Opcoes para incluir elementos de publicacao
\gdef\@includeFR{true} % Incluir folha de rosto
\gdef\@includeTU{true} % Incluir termos de uso
\gdef\@includeInfoEd{true} % Incluir informacoes de editoracao (verso da capa)
\gdef\@includeDocURL{true} % Incluir URL do documento
%%%

\gdef\@INPECopyright{false}	% acrescentado por gjfb em 2013-05-22
\gdef\@CCBY{false}	% acrescentado por gjfb em 2014-06-08
\gdef\@CCBYSA{false}	% acrescentado por gjfb em 2014-06-08
\gdef\@CCBYND{false}	% acrescentado por gjfb em 2014-06-08
\gdef\@CCBYNC{false}	% acrescentado por gjfb em 2013-05-22
\gdef\@CCBYNCSA{false}	% acrescentado por gjfb em 2013-05-22
\gdef\@CCBYNCND{false}	% acrescentado por gjfb em 2014-06-08
\gdef\@GPLv3{false}	% acrescentado por gjfb em 2015-06-10

\gdef\@folhaembranco{true}
\gdef\@tipocitacao{alf}
\gdef\@printserieinpe{true}
\gdef\@logoinpe{false}	% acrescentado por gjfb em 2010-06-21 - default is LogoGoverno


\DeclareOption{PublicacaoDissOuTese}{%
	\typeout{-------------->Opcao: PublicacaoDissOuTese}
% see default above
}

\DeclareOption{PublicacaoArtigoOuRelatorio}{%
	\typeout{-------------->Opcao: PublicacaoArtigoOuRelatorio}
	\gdef\@includeFCNotasOrientadorTD{false}
	\gdef\@includeFC{false}
	\gdef\@includeFA{false}
	\gdef\@folhaembranco{false}
	\gdef\@docSemFormatacaoCapitulo{true}
	\let\include\input
}

\DeclareOption{PublicacaoProposta}{%
	\typeout{-------------->Opcao: PublicacaoProposta}
	\gdef\@includeFCNotasOrientadorTD{false}
	\gdef\@includeFC{false}
	\gdef\@includeFA{false}
	\gdef\@folhaembranco{true}
	\gdef\@printserieinpe{false}
	\gdef\@docSemFormatacaoCapitulo{true}  
}

%%% Acrescentado por lgs em 2023-06-01
%% Define opcao para eleaboracao de exame ou proposta
%% Semelhante a opcao PublicacaoProposta, porem sem elementos de publicacao
\DeclareOption{ExamePropostaOuQualificacao}{%
	\typeout{-------------->Opcao: ExamePropostaOuQualificacao}
	\gdef\@includeFCNotasOrientadorTD{false}
	\gdef\@includeFR{false}
	\gdef\@includeFC{false}
	\gdef\@includeFA{false}
	\gdef\@includeTU{false}
	\gdef\@includeInfoEd{false}
	\gdef\@includeDocURL{false}
	\gdef\@folhaembranco{true}
	\gdef\@printserieinpe{false}
	\gdef\@docSemFormatacaoCapitulo{true}  
}
%%%

\DeclareOption{PublicacaoLivro}{%
	\typeout{-------------->Opcao: PublicacaoLivro}
	\gdef\@includeFCNotasOrientadorTD{false}
	\gdef\@includeFC{true}
	\gdef\@includeFA{false}
	\gdef\@folhaembranco{true}
	\gdef\@docSemFormatacaoCapitulo{false}	% com capítulo  
}

\DeclareOption{SemFormatacaoCapitulo}{%
	\typeout{-------------->Opcao: SemFormatacaoCapitulo}
	\gdef\@docSemFormatacaoCapitulo{true}
}

\DeclareOption{SemFolhaAprovacao}{%
	\typeout{-------------->Opcao: SemFolhaAprovacao}
	\gdef\@includeFA{false}
}

\DeclareOption{INPECopyright}{%
	\typeout{-------------->Opcao: INPECopyright}
	\gdef\@INPECopyright{true}
}

\DeclareOption{CCBY}{%
	\typeout{-------------->Opcao: CCBY}
	\gdef\@CCBY{true}
}

\DeclareOption{CCBYSA}{%
	\typeout{-------------->Opcao: CCBYSA}
	\gdef\@CCBYSA{true}
}

\DeclareOption{CCBYND}{%
	\typeout{-------------->Opcao: CCBYND}
	\gdef\@CCBYND{true}
}

\DeclareOption{CCBYNC}{%
	\typeout{-------------->Opcao: CCBYNC}
	\gdef\@CCBYNC{true}
}

\DeclareOption{CCBYNCSA}{%
	\typeout{-------------->Opcao: CCBYNCSA}
	\gdef\@CCBYNCSA{true}
}

\DeclareOption{CCBYNCND}{%
	\typeout{-------------->Opcao: CCBYNCND}
	\gdef\@CCBYNCND{true}
}

\DeclareOption{GPLv3}{%
	\typeout{-------------->Opcao: GPLv3}
	\gdef\@GPLv3{true}
}

\DeclareOption{CitacaoNumerica}{%
	\typeout{-------------->Opcao: CitacaoNumerica}
	\gdef\@tipocitacao{num}
}

\DeclareOption{LogoINPE}{% acrescentado por gjfb em 2010-06-21
	\typeout{-------------->Opcao: LogoINPE}
	\gdef\@logoinpe{true}
}

\ProcessOptions

%%% Sistema moderno de Bibliografias com biblatex-abnt (atualizado para normas ABNT 2023) %%%
%% Compatível com múltiplos engines: pdflatex, xelatex, lualatex
%% Backend: biber (processador moderno de referências)
\RequirePackage[
  style=abnt,               % Style oficial ABNT via biblatex-abnt
  backend=biber,            % Backend moderno - precisa: pdflatex ... biber ... pdflatex
  language=portuguese,      % Português brasileiro
  hyperref=true,            % Integração com hyperref para links
  url=true,                 % Mostrar URLs nas referências
  doi=true,                 % Mostrar DOI si disponível
  isbn=true                 % Mostrar ISBN se disponível
]{biblatex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% configuracao das margens 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\normalsize

\RequirePackage[a4paper,left=3.0cm,right=3.0cm,%
top=3cm,bottom=3cm]{geometry}	% acrescentado por gjfb em 2011-12-06

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength{\linha}
\newlength{\baselsdefault}
\newlength{\parsdefault}
\newlength{\baselsinpe}
\newlength{\parsinpe}

\setlength{\linha}{12pt} %! o mesmo valor passado para a classe report
\setlength{\baselsdefault}{\baselineskip}
\setlength{\parsdefault}{\parskip}
\setlength{\baselsinpe}{1.5\linha} %% distancia entre linhas
\setlength{\parsinpe}{\linha}%  distancia a mais entre paragrafos

%setspace
\AtBeginDocument{\setlength{\baselineskip}{\baselsinpe}}
\onehalfspacing
\AtBeginDocument{\setlength{\parskip}{\parsinpe}}
\setlength{\parindent}{0pt}
\frenchspacing %Não põe um espaco adicional após ponto final.
\sloppy %força que todas as linhas fiquem dentro das margens.

%footnoterule 	
\renewcommand{\footnoterule}{\vspace*{-3pt}%
	\rule{3cm}{0.4pt}\vspace*{2.6pt}%
}

% - Define contadores e quais serao numerados:
\setcounter{secnumdepth}{5}
\setcounter{tocdepth}{5}
% limites para o posicionamento de objetos flutuantes
\setcounter{topnumber}{3}
\renewcommand{\topfraction}{0.85}
\setcounter{bottomnumber}{2}
\renewcommand{\bottomfraction}{0.65}
\setcounter{totalnumber}{5}
\renewcommand{\textfraction}{0.15}
\renewcommand{\floatpagefraction}{0.60}

% Distancias entre objetos flutuantes e texto:
\setlength{\floatsep}{\baselsinpe}\addtolength{\floatsep}{\parsinpe}
\setlength{\textfloatsep}{\parsinpe}\addtolength{\textfloatsep}{2\parsinpe}
\setlength{\intextsep}{\baselsinpe}\addtolength{\intextsep}{\parsinpe}

% - Parametros gerais.
\newlength{\seistoques}
\newlength{\lrotulo}
\newlength{\sepitem}
\settowidth{\seistoques}{\ \ \ \ \ \ }
\settowidth{\lrotulo}{xx}
\setlength{\sepitem}{0.5em}
\setlength{\leftmargini}{\seistoques+2\lrotulo}
\setlength{\leftmarginii}{2\lrotulo}
\setlength{\leftmarginiii}{2\lrotulo}
\setlength{\labelsep}{\sepitem}
\setlength{\labelwidth}{\lrotulo}
\setlength{\partopsep}{0pt}
\setlength{\topsep}{0pt}
\setlength{\rightmargin}{0pt}
\setlength{\itemindent}{0pt}
\setlength{\listparindent}{0pt}
\setlength{\parsep}{0pt}
\setlength{\itemsep}{10pt}
\setlength{\LTcapwidth}{\textwidth}

% - Listas enumeradas:
\renewcommand{\theenumi}{\alph{enumi}}
\renewcommand{\theenumii}{\bfseries--}
\renewcommand{\labelenumi}{\theenumi}
\renewcommand{\labelenumii}{\theenumii}

%%%%%%%% Variaveis, dependem de idiomas
\ifthenelse{\equal{\languagename}{brazilian} 
				\or \equal{\languagename}{brazil} 
				\or \equal{\languagename}{portuguese}}{
\AtBeginDocument{
\newcommand{\nomecapa}{CAPA}
\newcommand{\nomeversocapa}{VERSO}
\newcommand{\nomefolhaderosto}{FOLHA DE ROSTO}
\newcommand{\nomeabstract}{ABSTRACT}%
\newcommand{\nomeresumo}{RESUMO}%
\newcommand{\nomekeywords}{Keywords}%
\newcommand{\nomepalavraschave}{Palavras-chave}%
\newcommand{\nomeepigrafe}{EPÍGRAFE}%
\newcommand{\nomededicatoria}{DEDICATÓRIA}%
\newcommand{\nomethank}{AGRADECIMENTOS}%
\newcommand{\nomeglossarios}{GLOSSÁRIO}
\newcommand{\nomeabreviaturasesiglas}{LISTA DE ABREVIATURAS E SIGLAS}
\newcommand{\nomefichacatalografica}{FICHA CATALOGRÁFICA}
\newcommand{\termosdeuso}{TERMOS DE USO}	% acrescentado por gjfb em 2013-10-07
\newcommand{\nomefolhadeaprovacao}{FOLHA DE APROVAÇÃO}
\renewcommand{\refname}{REFERÊNCIAS BIBLIOGRÁFICAS}
\renewcommand{\figurename}{Figura}% %awss
\renewcommand{\tablename}{Tabela}% %awss
\renewcommand{\indexname}{ÍNDICE}%
\newcommand{\nomecontracapa}{CONTRACAPA}%
\renewcommand{\appendixname}{APÊNDICE}
\renewcommand{\contentsname}{SUMÁRIO} %awss
\newcommand{\nomepagina}{Pág.} % gjfb
\renewcommand{\listtablename}{LISTA DE TABELAS} %awss
\renewcommand{\listfigurename}{LISTA DE FIGURAS} %awss
\newcommand{\nomeanexo}{ANEXO}
\newcommand\anexoautorefname{Anexo}%
\newcommand{\listsimbname}{LISTA DE SÍMBOLOS}
\newcommand{\FONTEname}{Fonte}
\newcommand{\avisoDeOriginal}{URL do documento original:}	% acrescentado por gjfb em 2010-05-01
\newcommand{\cardCaption}{Dados Internacionais de Catalogação na Publicação (CIP)}
\newcommand{\PublicadoPor}{Publicado por}
\newcommand{\ConselhoDeEditoracao}{CONSELHO DE EDITORAÇÃO E PRESERVAÇÃO DA PRODUÇÃO INTELECTUAL DO INPE - CEPPII (PORTARIA Nº 176/2018/SEI-INPE)}	% acrescentado por aldf em 2019-04-02
\newcommand{\Presidente}{Presidente}
\newcommand{\Membros}{Membros}
\newcommand{\BibliotecaDigital}{BIBLIOTECA DIGITAL}
\newcommand{\RevisaoNormalizacaoDocumentaria}{REVISÃO E NORMALIZAÇÃO DOCUMENTÁRIA}
\newcommand{\EditoracaoEletronica}{EDITORAÇÃO ELETRÔNICA}
}}{
%%% English definitions %%%
\AtBeginDocument{
\newcommand{\nomecapa}{COVER}	% acrescentado por gjfb em 2010-02-03
\newcommand{\nomeversocapa}{VERSUS}
\newcommand{\nomefolhaderosto}{TITLE PAGE}
\newcommand{\nomeabstract}{RESUMO}%
\newcommand{\nomeresumo}{ABSTRACT}%
\newcommand{\nomekeywords}{Palavras-chave}%
\newcommand{\nomepalavraschave}{Keywords}%
\newcommand{\nomeepigrafe}{EPIGRAPHY}%
\newcommand{\nomededicatoria}{DEDICATORY}%
\newcommand{\nomethank}{ACKNOWLEDGEMENTS}
\newcommand{\nomeglossarios}{GLOSSARY}
\newcommand{\nomeabreviaturasesiglas}{LIST OF ABBREVIATIONS}
\newcommand{\nomefichacatalografica}{INDEX CARD}
\newcommand{\termosdeuso}{TERMS OF USE}	% acrescentado por gjfb em 2013-10-07
\newcommand{\nomefolhadeaprovacao}{APPROVAL TERM}
\renewcommand{\refname}{REFERENCES}
\renewcommand{\figurename}{Figure}	% acrescentado por gjfb em 2010-04-14
\renewcommand{\tablename}{Table}	% acrescentado por gjfb em 2010-04-14
\renewcommand{\indexname}{INDEX}%
\renewcommand{\appendixname}{APPENDIX}
\renewcommand{\contentsname}{CONTENTS} %awss
\newcommand{\nomepagina}{Page} % gjfb
\renewcommand{\listtablename}{LIST OF TABLES} %awss
\renewcommand{\listfigurename}{LIST OF FIGURES} %awss
\newcommand{\nomeanexo}{ANNEX}
\newcommand\anexoautorefname{annex}%
\newcommand{\listsimbname}{LIST OF SYMBOLS}
\newcommand{\FONTEname}{SOURCE}
\newcommand{\avisoDeOriginal}{URL of the original document:}	% acrescentado por gjfb em 2010-05-01
\newcommand{\cardCaption}{Cataloging in Publication Data}
\newcommand{\PublicadoPor}{Published by}
\newcommand{\ConselhoDeEditoracao}{BOARD OF PUBLISHING AND PRESERVATION OF INPE INTELLECTUAL PRODUCTION - CEPPII (PORTARIA Nº 176/2018/SEI-INPE)}	% acrescentado por aldf em 2019-04-02 
\newcommand{\Presidente}{Chairperson}
\newcommand{\Membros}{Members}
\newcommand{\BibliotecaDigital}{DIGITAL LIBRARY}
\newcommand{\RevisaoNormalizacaoDocumentaria}{DOCUMENT REVIEW}
\newcommand{\EditoracaoEletronica}{ELECTRONIC EDITING}
}
}

% se mais de uma opção de copyright, então prevalece a mais restritiva
\ifthenelse{\equal{\@INPECopyright}{true}}{%
% INPE copyright
	\newcommand{\licenca}{Copyright \copyright\ \@date\ do MCTI/INPE.
	Nenhuma parte desta publicação pode ser reproduzida, armazenada em um sistema de recuperação,
	ou transmitida sob qualquer forma ou por qualquer meio, eletrônico, mecânico,
	fotográfico, reprográfico, de microfilmagem ou outros, sem a permissão
	escrita do INPE, com exceção de qualquer material
	fornecido especificamente com o propósito de ser entrado e executado
	num sistema computacional, para o uso exclusivo do leitor da obra.}
	
	\newcommand{\license}{Copyright \copyright\ \@date\ by MCTI/INPE.
	No part of this publication may be reproduced, stored in a retrieval system,
	or transmitted in any form or by any means, electronic, mechanical,
	photocopying, recording, microfilming, or otherwise, without written
	permission from INPE, with the exception of any material
	supplied specifically for the purpose of being entered and executed
	on a computer system, for exclusive use of the reader of the work.}
}{
% Creative Commons
	\ifthenelse{\equal{\@CCBY}{true}}{%
% CC-BY
		\newcommand{\licenca}{\href{http://creativecommons.org/licenses/by/3.0/}{\includegraphics[width=2cm]{./template/CCBY.png}}\par Esta obra foi licenciada sob uma Licença \href{http://creativecommons.org/licenses/by/3.0/deed.pt_BR}{Creative Commons Atribuição 3.0 Não Adaptada}.}	% adicionado por gjfb em 2014-06-08
		\newcommand{\license}{This work is licensed under a \href{http://creativecommons.org/licenses/by/3.0/}{Creative Commons Attribution 3.0 Unported} License.}
	}{
		\ifthenelse{\equal{\@CCBYSA}{true}}{%
% CC-BY-SA
			\newcommand{\licenca}{\href{http://creativecommons.org/licenses/by-sa/3.0/}{\includegraphics[width=2cm]{./template/CCBYSA.png}}\par Esta obra foi licenciada sob uma Licença \href{http://creativecommons.org/licenses/by-nc-sa/3.0/deed.pt_BR}{Creative Commons Atribuição-CompartilhaIgual 3.0 Não Adaptada}.}	% adicionado por gjfb em 2014-06-08
			\newcommand{\license}{This work is licensed under a \href{http://creativecommons.org/licenses/by-sa/3.0/}{Creative Commons Attribution-ShareAlike 3.0 Unported} License.}
		}{
			\ifthenelse{\equal{\@CCBYND}{true}}{%
% CC-BY-ND
				\newcommand{\licenca}{\href{http://creativecommons.org/licenses/by-nd/3.0/}{\includegraphics[width=2cm]{./template/CCBYND.png}}\par Esta obra foi licenciada sob uma Licença \href{http://creativecommons.org/licenses/by-nd/3.0/deed.pt_BR}{Creative Commons Atribuição-SemDerivações 3.0 Não Adaptada}.}	% adicionado por gjfb em 2014-06-08
				\newcommand{\license}{This work is licensed under a \href{http://creativecommons.org/licenses/by-nd/3.0/}{Creative Commons Attribution-NoDerivs 3.0 Unported} License.}
			}{
				\ifthenelse{\equal{\@CCBYNC}{true}}{%
% CC-BY-NC
					\newcommand{\licenca}{\href{http://creativecommons.org/licenses/by-nc/3.0/}{\includegraphics[width=2cm]{./template/CCBYNC.png}}\par Esta obra foi licenciada sob uma Licença \href{http://creativecommons.org/licenses/by-nc/3.0/deed.pt_BR}{Creative Commons Atribuição-NãoComercial 3.0 Não Adaptada}.}	% adicionado por gjfb em 2013-05-29
					\newcommand{\license}{This work is licensed under a \href{http://creativecommons.org/licenses/by-nc/3.0/}{Creative Commons Attribution-NonCommercial 3.0 Unported} License.}
				}{
					\ifthenelse{\equal{\@CCBYNCSA}{true}}{%
% CC-BY-NC-SA
						\newcommand{\licenca}{\href{http://creativecommons.org/licenses/by-nc-sa/3.0/}{\includegraphics[width=2cm]{./template/CCBYNCSA.png}}\par Esta obra foi licenciada sob uma Licença \href{http://creativecommons.org/licenses/by-nc-sa/3.0/deed.pt_BR}{Creative Commons Atribuição-NãoComercial-CompartilhaIgual 3.0 Não Adaptada}.}	% adicionado por gjfb em 2013-05-29
						\newcommand{\license}{This work is licensed under a \href{http://creativecommons.org/licenses/by-nc-sa/3.0/}{Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported} License.}
					}{
						\ifthenelse{\equal{\@CCBYNCND}{true}}{%
% CC-BY-NC-ND
							\newcommand{\licenca}{\href{http://creativecommons.org/licenses/by-nc-nd/3.0/}{\includegraphics[width=2cm]{./template/CCBYNCND.png}}\par Esta obra foi licenciada sob uma Licença \href{http://creativecommons.org/licenses/by-nc-nd/3.0/deed.pt_BR}{Creative Commons Atribuição-NãoComercial-SemDerivações 3.0 Não Adaptada}.}	% adicionado por gjfb em 2014-06-08
							\newcommand{\license}{This work is licensed under a \href{http://creativecommons.org/licenses/by-nc-nd/3.0/}{Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported} License.}
		
						}{
							\ifthenelse{\equal{\@GPLv3}{true}}{%
% GPLv3
% GPLv3.png deve ser uma cópia de: https://gnu.org/graphics/gplv3-88x31.png
								\newcommand{\licenca}{\href{https://gnu.org/licenses/gpl-3.0.en.html}{\includegraphics[width=2cm]{./template/GPLv3.pdf}}\par Esta obra foi licenciada sob uma Licença \href{https://gnu.org/licenses/gpl-3.0.en.html}{GNU General Public License - Versão 3}.}	% adicionado por gjfb em 2015-06-10
								\newcommand{\license}{This work is licensed under a \href{https://gnu.org/licenses/gpl-3.0.en.html}{GNU General Public License - Version 3}.}
		
							}{
% no license
								\newcommand{\licenca}{}
								\newcommand{\license}{}
							}
						}
					}
				}
			}
		}
	}
}

%%% define estilo de numeracao geral no documento
\newcommand{\estilonum}{plain} %% ABNT myheadings
	\markboth{}{}

\renewcommand{\chapter}{
    \ifdigitalcopy % Se for uma cópia digital
        \clearpage % Use apenas clearpage
    \else % Caso contrário, mantenha o comportamento original
        \ifthenelse{\equal{\@folhaembranco}{false}{
		\if@openright\cleardoublepage\else\clearpage\fi %% faz capitulo começar em folha impar (coloca folha em branco)
	}{\vspace{\baselsinpe}}
	\thispagestyle{\estilonum} %% define estilo de num. na pag. das partes 
	\global\@topnum\z@
	\@afterindentfalse
	\secdef\@chapter\@schapter
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
\renewcommand\part{%
	\ifthenelse{\equal{\@folhaembranco}{true}}{
  \if@openright\cleardoublepage\else\clearpage\fi%
	}{}
  \thispagestyle{empty}%
  \if@twocolumn\onecolumn\@tempswatrue\else\@tempswafalse\fi%
  \null\vfil\secdef\@part\@spart}%
  
\newcommand*{\titulo}[1]{\gdef\@titulo{#1}}
\newcommand*{\descriccao}[1]{\gdef\@descriccao{#1}}

\newcommand*{\repositorio}[1]{\gdef\@repositorio{#1}}
\newcommand*{\tipoDaPublicacao}[1]{\gdef\@tipoDaPublicacao{#1}}	% acrescentado por gjfb em 2010-05-01
\newcommand*{\IBI}[1]{\gdef\@IBI{#1}}	% acrescentado por gjfb em 2010-05-01

% \newcommand*{\serieinpe}[1]{\gdef\@serieinpe{#1}}	% comentado por gjfb em 2010-05-01
\newcommand*{\email}[1]{\gdef\@email{#1}}
\newcommand*{\instituicao}[1]{\gdef\@instituicao{#1}}
\newcommand*{\instituicaol}[1]{\gdef\@instituicaol{#1}}
\newcommand*{\instituicaosigla}[1]{\gdef\@instituicaosigla{#1}}
\newcommand*{\instituicaocidade}[1]{\gdef\@instituicaocidade{#1}}

\newcommand*{\tituloverso}[1]{\gdef\@tituloverso{#1}}
\newcommand*{\descriccaoverso}[1]{\gdef\@descriccaoverso{#1}}
\newcommand*{\descriccaoversoA}[1]{\gdef\@descriccaoversoA{#1}}


\newcommand*{\logoInpe}[1]{\gdef\@logoinpe{#1}}	% acrescentado por gjfb em 2010-05-01

% FICHA

\newcommand*{\cutterFICHAC}[1]{\gdef\@cutterFICHAC{#1}}
\newcommand*{\autorUltimoNomeFICHAC}[1]{\gdef\@autorUltimoNomeFICHAC{#1}}
\newcommand*{\autorAbreviadoFICHAC}[1]{\gdef\@autorAbreviadoFICHAC{#1}}	% não usado nesse .cls
\newcommand*{\autorFICHAC}[1]{\gdef\@autorFICHAC{#1}}	% acrescentado por gjfb em 2015-11-16
\newcommand*{\tituloFICHAC}[1]{\gdef\@tituloFICHAC{#1}}
\newcommand*{\paginasFICHAC}[1]{\gdef\@paginasFICHAC{#1}}
\newcommand*{\numeroFICHAC}[1]{\gdef\@numeroFICHAC{#1}}
\newcommand*{\palavraschaveFICHAC}[1]{\gdef\@palavraschaveFICHAC{#1}}
\newcommand*{\numeroCDUFICHAC}[1]{\gdef\@numeroCDUFICHAC{#1}}
\newcommand*{\nomeAtributoOrientadorFICHAC}[1]{\gdef\@nomeAtributoOrientadorFICHAC{#1}}
\newcommand*{\valorAtributoOrientadorFICHAC}[1]{\gdef\@valorAtributoOrientadorFICHAC{#1}}

% Nota da ficha (para TD)

\newcommand*{\tipoTD}[1]{\gdef\@tipoTD{#1}}
\newcommand*{\instituicaoDefesa}[1]{\gdef\@instituicaoDefesa{#1}}
\newcommand*{\anoDefesa}[1]{\gdef\@anoDefesa{#1}}

% FICHA - fim

\newcommand*{\marcaRegistrada}[1]{\gdef\@marcaRegistrada{#1}}	% acrescentado por gjfb em 2014-10-07
\newcommand*{\financiamento}[1]{\gdef\@financiamento{#1}}	% acrescentado por gjfb em 2018-09-21

\newcommand*{\tituloFA}[1]{\gdef\@tituloFA{#1}}
\newcommand*{\cursoFA}[1]{\gdef\@cursoFA{#1}}
\newcommand*{\candidatoOUcandidataFA}[1]{\gdef\@candidatoOUcandidataFA{#1}}
\newcommand*{\dataAprovacaoFA}[1]{\gdef\@dataAprovacaoFA{#1}}
\newcommand*{\membroA}[3]{\gdef\@membroA{#1}\gdef\@membroAP{#2}\gdef\@membroAPC{#3}}
\newcommand*{\membroB}[3]{\gdef\@membroB{#1}\gdef\@membroBP{#2}\gdef\@membroBPC{#3}}
\newcommand*{\membroC}[3]{\gdef\@membroC{#1}\gdef\@membroCP{#2}\gdef\@membroCPC{#3}}
\newcommand*{\membroD}[3]{\gdef\@membroD{#1}\gdef\@membroDP{#2}\gdef\@membroDPC{#3}}
\newcommand*{\membroE}[3]{\gdef\@membroE{#1}\gdef\@membroEP{#2}\gdef\@membroEPC{#3}}
\newcommand*{\membroF}[3]{\gdef\@membroF{#1}\gdef\@membroFP{#2}\gdef\@membroFPC{#3}}
\newcommand*{\membroG}[3]{\gdef\@membroG{#1}\gdef\@membroGP{#2}\gdef\@membroGPC{#3}}

\newcommand{\PBS}[1]{\let\temp=\\#1\let\\=\temp}


%%%%%%%%%% Novos comandos

%\renewcommand{\cite}[1]{\citep{#1}} %testebib

%%%%%%% tira num page de empty pages %%%%%%%%%%
\let\origdoublepage\cleardoublepage
\newcommand{\clearemptydoublepage}{%
    \ifdigitalcopy % Se for uma cópia digital
        \clearpage % Use apenas clearpage
    \else % Caso contrário, mantenha o comportamento original
        \cleardoublepage
        {\pagestyle{empty}\origdoublepage}%
    \fi
}
\let\cleardoublepage\clearemptydoublepage
%se nao ativo, comentar linhas acima e descomentar linhas abaixo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\pretexto}{
    \ifthenelse{\equal{\@folhaembranco}{true}}{
        \clearemptydoublepage %% coloca folha em branco
	}{\vspace{\baselsinpe}}
%  \thispagestyle{empty}
  \thispagestyle{plain}% para colocar paginação no pretexto
}

%%%% Modified by AWSS 10/05/05 begin
%%% incluir Sumario
\newcommand{\includeSumario}{%
	\pagestyle{plain}% para colocar paginação no sumário
	\pretexto%
	
	{\pdfbookmark[0]{\contentsname}{contentsname}}
	
	\tableofcontents%

	\label{numeroDePáginasDoPretexto}	% última página do sumário - usado na ficha catalográfica para indicar o número de páginas do pretexto - acrescentado por gjfb em 2009-09-27
	\pretexto}

%%% incluir Lista de Figuras sem page num no sumario
\newcommand{\includeListaFiguras}{%
%	\pagestyle{empty}
	\pagestyle{plain}% para colocar paginação na lista de figuras
	\refstepcounter{section}
	\pretexto%
	\listoffigures%
%	\addtocontents{lof}{\protect\thispagestyle{empty}}% retirar paginação na primeira página
	\pretexto}

%%% incluir Lista de Tabelas sem page num no sumario
\newcommand{\includeListaTabelas}{%
%	\pagestyle{empty}
	\pagestyle{plain}% para colocar paginação na lista de tabelas
	\refstepcounter{section}
	\pretexto%
	\listoftables%
%	\addtocontents{lot}{\protect\thispagestyle{empty}}% retirar paginação na primeira página
	\pretexto}
% end AWSS

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% define variaveis do caption %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% delimita label do texto no caption, respeitar o espaco
\renewcommand{\captionlabeldelim}{ -} 
%% estilo da fonte do texto no caption, baseado no \captionlabelfont sem negrito
\renewcommand{\captionfont}{\captionlabelfont\mdseries\captionsize} 

%% variaveis temporarias para o comando \FONTE a partir do caption
\newlength{\tempbox}
\newlength{\tempboxA}
\newlength{\tempboxB}
\newlength{\tempboxC}
\newlength{\tempboxD}
\newlength{\tempboxCalc}

\renewcommand\@makecaption[2]{%
  \vskip\abovecaptionskip
  \captionlinewidth\hsize
%  \realcaptionwidth\hsize
  \def\captionlabel{#1}%
  \def\captiontext{#2}%
	\usecaptionstyle{\caption@style}%
  \vskip\belowcaptionskip
%%% label exato do caption respeitando o estilo, incluindo *espaco* depois do delimitador
%%% -> vai gerar o tamanho correto.
	\gdef\tamlabel{\captionlabelfont\captionsize#1\captionlabeldelim\captionfont\space}%%by AWSS
%%% texto exato do caption respeitando o estilo (sem negrito)
	\gdef\tamtexto{\captionfont#2}%%by AWSS
%\typeout{-------------------------------------------------------------------------\@captype}
}

%%% Comando \legenda por gjfb em 2014-01-17
\newlength{\legenda@width}
\newcommand{\legenda}[1]{%
	\gdef\@legenda{#1}
	\settowidth{\legenda@width}{\@legenda}
	\ifthenelse{\legenda@width < \textwidth}{%
		\begin{center}
			\small\@legenda
		\end{center}
	}{
		\small\@legenda
	}
	\gdef\tamtextolegenda{\captionfont#1}
}
%%% Comando \legenda por gjfb em 2014-01-17 - fim

%%% estilo de paragrafo especial para o \FONTE com margem adequada a partir do caption
\def\tamfonte{\captionfont{\FONTEname: }}  %% observe o espaco, ´:´ eh o separador
%%% comando \FONTE

\ifHTML
	\newcommand{\FONTE}[1]{\tamfonte\captionfont#1}
\else
	\newcommand{\FONTE}[1]{%
		\@ifundefined{@captype}{
			\ifthenelse{\tempboxCalc = 0}{
				\settowidth{\tempboxC}{\tamfonte}
				\addtolength{\tempboxCalc}{\tempboxC}
			}
			{\setlength{\tempboxC}{0pt}}
			\begin{list}{\tamfonte}{\leftmargin \tempboxCalc \rightmargin 0pt \labelsep 0pt \labelwidth \tempboxC}
				\item \captionfont#1
			\end{list}
			\setlength{\tempboxC}{0pt}
			\setlength{\tempboxCalc}{0pt}
		}{
			\ifthenelse{\equal{\@captype}{table}}{% table - acrescentado por gjfb em 2014-07-23
				\sbox{\tempbox}{\tamlabel}\setlength{\tempboxA}{\wd\tempbox}
				%\typeout{-------------------------------------------------------A\the\tempboxA}
				\sbox{\tempbox}{\tamtexto}\setlength{\tempboxB}{\wd\tempbox}
				%\typeout{-------------------------------------------------------B\the\tempboxB}
				\setlength{\tempboxCalc}{\linewidth}
				%\typeout{------------------------------------------------------ L\the\tempboxCalc}
				\addtolength{\tempboxCalc}{-\tempboxA}
				%\typeout{------------------------------------------------------ -A\the\tempboxCalc}
				\addtolength{\tempboxCalc}{-\tempboxB}
				%\typeout{------------------------------------------------------ -B\the\tempboxCalc}
				\ifthenelse{\tempboxCalc < 0}{%
					\setlength{\tempboxCalc}{\tempboxA}
				}{%
					\setlength{\tempboxCalc}{\tempboxCalc/2 + \tempboxA}
					%\typeout{------------------------------------------------------ T\the\tempboxCalc}
				}
				\setlength{\tempboxCalc}{0pt}
				\setlength{\tempboxC}{0pt}
				\vspace{24pt}
				
% acrescentado por gjfb em 2016-07-24 para as fontes curtas fiquem centralizadas (mesmo código que para as figuras)					
						\setlength{\tempboxCalc}{\linewidth}
						\settowidth{\tempboxD}{\tamfonte\captionfont#1}
						\addtolength{\tempboxCalc}{-\tempboxD}
						\ifthenelse{\tempboxCalc < 0}{% fonte longa
							\setlength{\tempboxCalc}{0pt}
						}{% fonte curta
							\setlength{\tempboxCalc}{\tempboxCalc/2}
						}
% acrescentado por gjfb em 2016-07-24 para as fontes curtas fiquem centralizadas (mesmo código que para as figuras) - fim	

					\settowidth{\tempboxC}{\tamfonte}
					\addtolength{\tempboxCalc}{\tempboxC}
				\vspace{-8mm}	% acrescentado por gjfb em 2009-10-07
				\begin{list}{\tamfonte}{\leftmargin \tempboxCalc \rightmargin 0pt \labelsep 0pt \labelwidth \tempboxC}
					\settowidth{\tempboxD}{\tamfonte#1}
					%\typeout{-------------------------------------------DDD\the\tempboxD}
					\ifthenelse{\tempboxD > \textwidth}{
						\item \captionfont#1
					}{
						\item \captionfont#1
					}
				\end{list}
				\setlength{\tempboxC}{0pt}
				\setlength{\tempboxCalc}{0pt}
			}
%			%% figure	% comentado por gjfb em 2014-01-17 - para quando o título deve ficar debaixo da figura
			{% figure - new ABNT Norm 14724-2011 - acrescentado por gjfb em 2014-07-23 - para quando o título deve ficar acima da figura - novo código para o alinhamento do fonte com a legenda 
				\setlength{\tempboxA}{0pt}	% acrescentado por gjfb em 2014-07-23 - para quando o título deve ficar acima da figura - novo código para o alinhamento do fonte com a legenda
				\sbox{\tempbox}{\tamtextolegenda}\setlength{\tempboxB}{\wd\tempbox}	% acrescentado por gjfb em 2014-07-23 - para quando o título deve ficar acima da figura - novo código para o alinhamento do fonte com a legenda
				\setlength{\tempboxCalc}{\linewidth}
				\addtolength{\tempboxCalc}{-\tempboxB}
				\ifthenelse{\tempboxCalc < 0}{% legenda longa
					\setlength{\tempboxCalc}{\tempboxA}	% 0pt
				}{% legenda curta
					\ifthenelse{\tempboxB > 0}{% legenda não vazia
						\setlength{\tempboxCalc}{\linewidth}
						\addtolength{\tempboxCalc}{-\tempboxB}
						\setlength{\tempboxCalc}{\tempboxCalc/2 + \tempboxA}
						\vspace{-2mm}
					}{% legenda vazia
%%% cálculo de \tempboxCalc (margem esquerda do fonte) quando a legenda está vazia
						\setlength{\tempboxCalc}{\linewidth}
						\settowidth{\tempboxD}{\tamfonte\captionfont#1}				
						\addtolength{\tempboxCalc}{-\tempboxD}
						\ifthenelse{\tempboxCalc < 0}{% fonte longa
							\setlength{\tempboxCalc}{0pt}
						}{% fonte curta
							\setlength{\tempboxCalc}{\tempboxCalc/2}
						}
%%% cálculo de \tempboxCalc (margem esquerda do fonte) quando a legenda está vazia - fim
						\vspace{-6mm}
					}
				}
				\settowidth{\tempboxC}{\tamfonte}
				\addtolength{\tempboxCalc}{\tempboxC}
				\begin{list}{\tamfonte}{\leftmargin \tempboxCalc \rightmargin 0pt \labelsep 0pt \labelwidth \tempboxC}
					\item \captionfont#1
				\end{list}
				\setlength{\tempboxC}{0pt}
				\setlength{\tempboxCalc}{0pt}
			}
		}
	}
\fi

%%% comando para avisar do inicio do texto do documento
\newcommand{\inicioIntroducao}{%
	\pretexto
	\pagenumbering{arabic}% para começar a contar em arábico a partir da introdução, começando com número 1 - acrescentado por gjfb em 2009-09-14
	\pagestyle{\estilonum}%
}

%%% comando para avisar do inicio do Apêndice

\newcommand{\inicioApendice}{

\titleformat% acrescentado por gjfb em 2009-10-11
	{\chapter}%
	[display]
	{\normalfont\normalsize\bfseries}% the declarations that are applied to the whole title
	{}% the heading number
	{0pt}% the distance between the label and title text
	{}% code executed immediately preceding the heading text
	
\titlespacing{\chapter}{0pt}{-21mm}{0mm}	% 21mm foi encontrado por tentativa e erro - acrescentado por gjfb em 2009-10-11

\titlecontents% acrescentado por gjfb em 2009-10-11
	{chapter}%
	[0cm]
	{\vspace{4mm}}
	{\normalfont\normalsize\bfseries}
	{}
	{\normalfont\normalsize\bfseries\titlerule*[0.82pc]{.}\contentspage}	% acrescentado por gjfb em 2012-10-19

	\setlength{\labelsep}{\sepitem}
	\renewcommand {\chaptername}{\appendixname}
	\addtocontents{toc}{\protect\renewcommand{\protect\chaptername}{\protect\appendixname}}
	\pretexto
	\appendix
}

%%% comando para avisar do inicio do Anexo
%% inserido comando \anexo, ao estilo de \appendix com correcoes locais no hyperref
\newcommand{\inicioAnexo}{%

\titleformat% acrescentado por gjfb em 2009-10-11
	{\chapter}%
	[display]
	{\normalfont\normalsize\bfseries}% the declarations that are applied to the whole title
	{}% the heading number
	{0pt}% the distance between the label and title text
	{}% code executed immediately preceding the heading text
	
\titlespacing{\chapter}{0pt}{-21mm}{0mm}	% 21mm foi encontrado por tentativa e erro - acrescentado por gjfb em 2009-10-11

\titlecontents% acrescentado por gjfb em 2009-10-11
	{chapter}%
	[0cm]
	{\vspace{4mm}}
	{\normalfont\normalsize\bfseries}
	{}
	{\normalfont\normalsize\bfseries\titlerule*[0.82pc]{.}\contentspage}	% acrescentado por gjfb em 2012-10-19

  \setlength{\labelsep}{\sepitem}
  \appendix
  \providecommand\anexoautorefname{anexo}
	\setcounter{chapter}{0}%
	\setcounter{section}{0}%
	\def\Hy@appendixstring{anexo}% %%novo string no *.toc, para fazer o hyperlink funcionar
	\def\anexo{%
  \@ifundefined{chapter}%
    {\gdef\theHsection{\alph{section}}}%
    {\gdef\theHchapter{\alph{chapter}}}%
  \xdef\Hy@chapapp{\Hy@appendixstring}%
}
	\renewcommand{\chaptername}{\nomeanexo}
 	\addtocontents{toc}{\protect\renewcommand{\protect\chaptername}{\protect\nomeanexo}}
	\pretexto
	\anexo 
}

%%% comando para avisar do inicio do Indice
\newcommand{\inicioIndice}{
	\pagestyle{plain}%
	\pretexto
	\printindex
} 

%%%%%%%%%%%%%%%comando para avisar inicio da Contracapa%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\newcommand{\inicioContracapa}{
 \pretexto
}
%%%%%%%%%%%%%%%%%Redefinicoes de comandos

\AtBeginDocument{
%%% codigo para possiveis problemas de caption e float
%%% testar melhor

\pagenumbering{roman}% para usar estilo romano desde a capa porque MakeIndex supõe que a numeração romana precede arábica (não deve começar com arábica se continuar com romana; neste caso o MakeIndex se perde nas referências à páginas arábicas de valores inferiores ao número máximo de páginas romanas) - acrescentado por gjfb em 2011-10-09

\makeatletter
\newcommand{\@ldtable}{}
\let\@ldtable\table
\renewcommand{\table}{%
                 \setlength{\@tempdima}{\abovecaptionskip}%
                 \setlength{\abovecaptionskip}{\belowcaptionskip}%
                 \setlength{\belowcaptionskip}{\@tempdima}%
                 \@ldtable}
\makeatother 
\marcaRegistrada{}	% acrescentado por gjfb em 2014-10-07 
\financiamento{}	% acrescentado por gjfb em 2018-09-21 
}

\renewcommand{\maketitle}{%maketitle
\pagestyle{empty}
\hypersetup{
pdftitle ={\@titulo},
pdfsubject ={\@descriccao},
pdfkeywords ={\@palavraschaveFICHAC},
pdfauthor = {\@author},
}
%%%%%%%%%%%%%%%%%CAPA%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%A CAPA e seu VERSO são obrigatórios nas publicações mas não devem ser somados ao total de páginas na FICHA CATALOGRÁFICA e na contagem para iniciar a paginação do trabalho.

\newlength{\metade@largura}	% acrescentado por gjfb em 2011-12-06
\setlength{\metade@largura}{0.5\linewidth}	% acrescentado por gjfb em 2011-12-06

\begin{titlepage}%
 \pdfbookmark[0]{\nomecapa}{CAPA}
 
 \ifthenelse{\equal{\@logoinpe}{true}}{	% acrescentado por gjfb em 2010-06-21
 	{\raggedright{\includegraphics[width=13.4cm,trim=0 0 0 0,clip]{./template/logo/logoinpe.png}}\par}
 }{
 	{\raggedright{\includegraphics[width=14cm]{./template/logo/logoverno.png}}\par}
 }

 \ifthenelse{\equal{\@printserieinpe}{true}}
 {\ifthenelse{\equal{\@tipoDaPublicacao}{}}{	% acrescentado por gjfb em 2010-05-01
 		\vspace*{\stretch{5}}{\raggedright\normalfont\normalsize\bfseries \@repositorio\par}	% acrescentado por gjfb em 2010-05-01
 	}{	% acrescentado por gjfb em 2010-05-01
		\vspace*{\stretch{5}}{\raggedright\normalfont\normalsize\bfseries \@repositorio-\@tipoDaPublicacao\par}	% acrescentado por gjfb em 2010-05-01
 	}}{}	% acrescentado por gjfb em 2010-05-01
 {\vspace*{\stretch{5}}{\centering\bfseries\large\MakeUppercase\@titulo\par}}
 {\vspace*{\stretch{5}}{\raggedleft\normalfont\normalsize\@author\par}}

 {\vspace*{\stretch{5}}\hspace{\metade@largura}\parbox{\metade@largura}{	% acrescentado por gjfb em 2011-12-06
 	\normalfont\large\@descriccao
 }}
 
%%% Modificado por lgs em 2023-06-01
%% Inclui condição para inclusões de URL do documento e informações de publicação

{\ifthenelse{\equal{\@includeDocURL}{true}}{
	\vspace*{\stretch{5}}{\centering\normalfont\small\avisoDeOriginal \\ <\href{http://urlib.net/\@IBI}{http://urlib.net/\@IBI}>\par}}	% acrescentado por gjfb em 2010-05-01
	{\vspace*{\stretch{5}}}
}
{\vspace*{\stretch{5}}{\centering\normalfont\normalsize\@instituicaosigla \\ 
    \@instituicaocidade  \\ \@date\par}}
%
\ifthenelse{\equal{\@includeInfoEd}{true}}{
    \newpage
    \pdfbookmark[0]{\nomeversocapa}{VERSO}
    {\vspace*{\stretch{0}}{\raggedright\normalfont\normalsize\MakeUppercase\@tituloverso}\par}
    {\vspace*{\stretch{0}}{\@descriccaoverso\par}}
    {\vspace*{\stretch{0}}{\@descriccaoversoA\par}}
}{}
%%%

\end{titlepage}%
%
%%% Modificado por lgs em 2023-06-31
%% Descoloca o camando de início de paginação romana para fora do bloco que define a folha de rosto e
%% inclui condição para impressão da mesma.

% As páginas são contadas em roman a partir da FOLHA DE ROSTO 
    
\pagenumbering{roman}% para usar estilo romano na paginação do pretexto - descomentado por gjfb em 2009-09-14
%\setcounter{page}{1}% este comando não é necessário porque pagenumbering já inicializa a 1
%

\ifthenelse{\equal{\@includeFR}{true}}{ % adicionado por lgs em 2023-06-01
    %%%%%%%%%%%%%%%%%%%%%%FOLHA DE ROSTO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	\pdfbookmark[0]{\nomefolhaderosto}{FOLHA DE ROSTO}

	 \ifthenelse{\equal{\@logoinpe}{true}}{	% acrescentado por gjfb em 2010-06-21
	 	{\raggedright{\includegraphics[width=13.4cm,trim=0 0 0 0,clip]{./template/logo/logoinpe.png}}\par}
	 }{
	 	{\raggedright{\includegraphics[width=14cm]{./template/logo/logoverno.png}}\par}
	 }

	\ifthenelse{\equal{\@printserieinpe}{true}}
	 {\ifthenelse{\equal{\@tipoDaPublicacao}{}}{	% acrescentado por gjfb em 2010-05-01
	 		\vspace*{\stretch{5}}{\raggedright\normalfont\normalsize\bfseries \@repositorio\par}	% acrescentado por 	gjfb em 2010-05-01
	 	}{	% acrescentado por gjfb em 2010-05-01
			\vspace*{\stretch{5}}{\raggedright\normalfont\normalsize\bfseries \@repositorio-\@tipoDaPublicacao\par}	% 	acrescentado por gjfb em 2010-05-01
	 	}}{}	% acrescentado por gjfb em 2010-05-01
	{\vspace*{\stretch{5}}{\centering\bfseries\large\MakeUppercase\@titulo\par}}
	{\vspace*{\stretch{5}}{\raggedleft\normalfont\normalsize\@author\par}}

	 {\vspace*{\stretch{5}}\hspace{\metade@largura}\parbox{\metade@largura}{	% acrescentado por gjfb em 2011-12-06
	 	\normalfont\large\@descriccao
	 }}
	 {\vspace*{\stretch{5}}{\centering\normalfont\small\avisoDeOriginal \\ <\href{http://urlib.net/\@IBI}{http://urlib.	net/\@IBI}>\par}}	% acrescentado por gjfb em 2010-05-01
	{\vspace*{\stretch{5}}{\centering\normalfont\normalsize\@instituicaosigla\\ 
	  \@instituicaocidade\\ \@date\par}}
}{}


\newpage
\pagestyle{plain}%

\ifthenelse{\equal{\@includeFC}{true}}{
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Ficha Catalográfica

	\footnotesize	% used by \settowidth below
	\newlength{\cutter@width}
	\settowidth{\cutter@width}{\@cutterFICHAC}
	\newlength{\oitava@coluna}
	\settowidth{\oitava@coluna}{1234567}
	\newlength{\decimaterceira@coluna}
	\settowidth{\decimaterceira@coluna}{123456789012}
	\newlength{\oitava@colunaminuscutter}
	\setlength{\oitava@colunaminuscutter}{-\cutter@width}
	\advance\oitava@colunaminuscutter\oitava@coluna
	\newlength{\widthminusoitava@coluna}
	\setlength{\widthminusoitava@coluna}{-\oitava@coluna}
	\newlength{\widthminusdecimaterceira@coluna}
	\setlength{\widthminusdecimaterceira@coluna}{-\decimaterceira@coluna}
	\newlength{\card@width}
	\setlength{\card@width}{12.5cm}
	\newlength{\insidecard@width}
	\setlength{\insidecard@width}{.9\card@width}
	\advance\widthminusoitava@coluna\insidecard@width
	\advance\widthminusdecimaterceira@coluna\insidecard@width
	\newlength{\sexta@coluna}
	\settowidth{\sexta@coluna}{12345}
	\newlength{\quarta@coluna}
	\settowidth{\quarta@coluna}{123}
	
	% primeiraLinha - não mais usado
	\newenvironment{primeiraLinha}{%
		\begin{list}{}{%
			\setlength{\leftmargin}{\decimaterceira@coluna}
			\setlength{\labelwidth}{0pt}
			\setlength{\labelsep}{0pt}
			\setlength{\itemindent}{-\decimaterceira@coluna}
		}%
		\item
	}{%
		\end{list}
	}%

% primeiraLinha2 - versão anterior - não usado
	\newenvironment{primeiraLinha2}{%
		\begin{list}{}{%
			\setlength{\labelsep}{0pt}%
			\settowidth{\labelwidth}{1234567}%
			\setlength{\leftmargin}{\labelwidth}%
			\addtolength{\leftmargin}{\labelsep}%
		}%
		\item[1234567\hfill]%
%		\item%
	}{%
		\end{list}
	}
% primeiraLinha - end

	\pdfbookmark[0]{\nomefichacatalografica}{nomefichac}{
		\vspace*{\stretch{1}}{
			\footnotesize{
				\centering{
					{\cardCaption\vspace{-3mm}}
					{\rule{\card@width}{0.2mm}}
					\vspace{10mm}{
						\parbox{\insidecard@width}{%
							\begin{singlespace}%
								{%
									\vspace{-1.0mm}\hspace{\decimaterceira@coluna}\parbox{\widthminusdecimaterceira@coluna}{\hspace{-\sexta@coluna}\@autorUltimoNomeFICHAC.} \par
								}
								{
									\@ifundefined{@autorFICHAC}{
										\vspace{1mm}\parbox[t]{\oitava@coluna}{\@cutterFICHAC\\}\parbox[t]{\widthminusoitava@coluna}{\hspace{\quarta@coluna}\@titulo ~/~\@author.	% acrescentado por gjfb em 2013-10-07, comentado por gjfb em 2015-11-16
										-- \@instituicaocidade~: \@instituicaosigla, \@date.} \par
									}{
										\vspace{1mm}\parbox[t]{\oitava@coluna}{\@cutterFICHAC\\}\parbox[t]{\widthminusoitava@coluna}{\hspace{\quarta@coluna}\@titulo ~/~\@autorFICHAC.	% acrescentado por gjfb em 2015-11-16
										-- \@instituicaocidade~: \@instituicaosigla, \@date.} \par
									}
								}
			 					{
			 						\ifthenelse{\equal{\@tipoDaPublicacao}{}}{	% acrescentado por gjfb em 2010-05-01
			 							\vspace{1mm}\hspace{\oitava@coluna}\hspace{\quarta@coluna}\@paginasFICHAC\ p.\ ;\  (\@repositorio) \par	% acrescentado por gjfb em 2010-05-01 - \scriptsize acrescentado por gjfb em 2010-08-31
			 						}{	% acrescentado por gjfb em 2010-05-01
										\vspace{1mm}\hspace{\oitava@coluna}\hspace{\quarta@coluna}\@paginasFICHAC\ p.\ ;\  \scriptsize(\@repositorio-\@tipoDaPublicacao) \par	% acrescentado por gjfb em 2010-05-01 - \scriptsize acrescentado por gjfb em 2010-08-31
			 						}	% acrescentado por gjfb em 2010-05-01
			 					}
			
								\vspace{5.2mm}
			
								\ifthenelse{\equal{\@includeFCNotasOrientadorTD}{true}}{
									{\vspace{0mm}\hspace{\oitava@coluna}\parbox{\widthminusoitava@coluna}{\hspace{\quarta@coluna}\@tipoTD\ (\@cursoFA) -- \@instituicaoDefesa, \@instituicaocidade, \@anoDefesa.} \par}
									{\vspace{1mm}\hspace{\oitava@coluna}\parbox{\widthminusoitava@coluna}{\hspace{\quarta@coluna}\@nomeAtributoOrientadorFICHAC~: \@valorAtributoOrientadorFICHAC.} \par}
									\vspace{6mm}
								}{}
			
								{\vspace{0mm}\hspace{\oitava@coluna}\parbox{\widthminusoitava@coluna}{\hspace{\quarta@coluna}\@palavraschaveFICHAC}\\ \par}
							\end{singlespace}
							{\raggedleft CDU\ \@numeroCDUFICHAC\\ \par}
						}
						\vspace{1.5mm}
					}
					\rule{\card@width}{0.2mm}
				}
				\par \vspace*{\stretch{1}}
			}
		}
% termos de uso
		\renewcommand{\baselinestretch}{1}
		\footnotesize
		\licenca

		\license
		
		\@marcaRegistrada	% acrescentado por gjfb em 2014-10-07
		
		\@financiamento	% acrescentado por gjfb em 2018-09-21
	}
}	% fim da ficha
{

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Somente os termos de uso - acrescentado por gjfb em 2013-10-07
\ifthenelse{\equal{\@includeTU}{true}}{ % Adicionado por lgs em 2023-06-01 - opção para acrescentar Termos de uso
\pdfbookmark[0]{\termosdeuso}{}{
	\vspace*{\stretch{1}}{
	}

	\renewcommand{\baselinestretch}{1}
	\footnotesize
	\licenca

	\license
	
	\@marcaRegistrada	% acrescentado por gjfb em 2014-10-07
	
	\@financiamento	% acrescentado por gjfb em 2018-09-21
}
}{}
}	% fim dos termos de uso

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%FOLHA DE APROVAÇAO PELA BANCA EXAMINADORA

\normalsize		% retornar para normalsize - acrescentado por gjfb em 2013-12-24

\ifthenelse{\equal{\@includeFA}{true}}{%
	\pretexto
	\pdfbookmark[0]{\nomefolhadeaprovacao}{aprovacao}
	\begin{flushright}
		\normalfont\normalsize\parbox{6.8cm}{\@tituloFA\\\@cursoFA}
	\end{flushright}
	
	\vspace*{\stretch{1}}
	
	\begin{center}
		\resizebox{15.5cm}{!}{
			\begin{tabular}{lp{0.2cm}>{\PBS\raggedleft\hspace{0pt}}p{7cm}}
				\ifthenelse{\equal{\@membroA}{}}{}{%
					{\@membroA} & & \hrulefill   \\
					& & \@membroAP\\
					& & \@membroAPC \\
					& & \\
				}
				\ifthenelse{\equal{\@membroB}{}}{}{%
					{\@membroB} & & \hrulefill \\
					& & \@membroBP \\
					& & \@membroBPC \\
					& & \\
				}
				\ifthenelse{\equal{\@membroC}{}}{}{%
					{\@membroC} & & \hrulefill \\
					& & \@membroCP \\
					& & \@membroCPC \\
					& & \\
				}
				\ifthenelse{\equal{\@membroD}{}}{}{%
					{\@membroD} & & \hrulefill \\
					& & \@membroDP \\
					& & \@membroDPC \\
					& & \\
				}
				\ifthenelse{\equal{\@membroE}{}}{}{%
					{\@membroE} & & \hrulefill \\
					& & \@membroEP \\
					& & \@membroEPC \\
					& & \\
				}
				\ifthenelse{\equal{\@membroF}{}}{}{%
					{\@membroF} & & \hrulefill \\
					& & \@membroFP \\
					& & \@membroFPC \\
					& & \\
				}
				\ifthenelse{\equal{\@membroG}{}}{}{%
					{\@membroG} & & \hrulefill \\
					& & \@membroGP \\
					& & \@membroGPC \\
					& & \\
				}
			\end{tabular}
		}
	\end{center}
	
	\vspace*{\stretch{1}}
	
	
	\begin{flushleft}
		%\normalfont\normalsize{\@candidatoOUcandidataFA:\space\@author}%incluir o comentário dessa linha quando montar publicação que contenha folha de aprovação
		\normalfont\normalsize{}%retirar o comentário dessa linha quando montar publicação que não contenha folha de aprovação
	\end{flushleft}
	
	\vspace*{\stretch{1}}
	
	\begin{flushright}
		%\normalfont\normalsize{\@instituicaocidade, \@dataAprovacaoFA.}%incluir esta linha quando montar trabalho que contem a folha de aprovação
		\normalfont\normalsize{}%retirar esta linha quando montar trabalho que contem a folha de aprovação
	\end{flushright}
}{}
}

%%%%%%%%%%%%%%%%%%%%%%%Iniciais

\newenvironment{epigrafe}{%
	\pretexto
	\pdfbookmark[0]{{\nomeepigrafe}}{nomeepigrafe}
	\begin{center}
		\begin{singlespace}%
			\vspace*{\stretch{1}}
}{
			\vspace*{\stretch{1}}
		\end{singlespace}%
	\end{center}
}

\newenvironment{dedicatoria}{%
	\pretexto
	\pdfbookmark[0]{{\nomededicatoria}}{nomededicatoria}
	\begin{flushright}
		\begin{singlespace}%
			\vspace*{\stretch{1}}
}{
		\end{singlespace}%
	\end{flushright}
}

\newenvironment{agradecimentos}{%
	\pretexto
	\pdfbookmark[0]{{\nomethank}}{nomethank}
		\begin{singlespace}%
			{\centering\normalfont\normalsize\bfseries\MakeUppercase\nomethank\\*[\baselsdefault]\par}%
		\end{singlespace}%
}

\newenvironment{resumo}{%
	\pretexto%
	\pdfbookmark[0]{\nomeresumo}{nomeresumo}
  	\begin{singlespace}%
  		\vspace*{\stretch{1}}%
  		{\centering\normalfont\normalsize\bfseries\MakeUppercase\abstractname\\*[\baselsdefault]}%
}{%
  		\vspace*{\stretch{1}}
	\end{singlespace}%
}

\renewenvironment{abstract}{%
	\pretexto%
	\pdfbookmark[0]{\nomeabstract}{nomeabstract}
  	\begin{singlespace}%
  		{\centering\normalfont\normalsize\bfseries\MakeUppercase\@title\\*}%
  		\vspace*{\stretch{1}}
		{\centering\normalfont\normalsize\bfseries\MakeUppercase\nomeabstract\\*[\baselsdefault]}%
}{%
		\vspace*{\stretch{1}}
	\end{singlespace}%
}

\newcommand{\palavraschave}[1]{%
	\gdef\@palavraschave{#1}
  	\begin{singlespace}%
		\nomepalavraschave: \@palavraschave
	\end{singlespace}%
}
\newcommand{\keywords}[1]{%
	\gdef\@keywords{#1}
  	\begin{singlespace}%
		\nomekeywords: \@keywords	% @palavraschave -> keywords - corrigido por gjfb em 2014-03-20
	\end{singlespace}%
}
\newcommand*{\palavrachave}[1]{%
	\gdef\@palavrachave{#1}%
	\@palavrachave.
}


% Lista de simbolos
\newenvironment{simbolos}{%
\refstepcounter{section}
	\pretexto%
	\pdfbookmark[0]{\listsimbname}{listsimbname}% necessário quando não faz parte da tabela de conteudos - 
	\begin{singlespace}%
		{\centering\normalfont\normalsize\bfseries\MakeUppercase\listsimbname\\*[\baselsdefault]}%
		\vspace{1cm}
		\begin{supertabular}{lll}
}{
		\end{supertabular}
	\end{singlespace}%
	\pretexto%
}

% Lista de abreviaturas e siglas
\newenvironment{abreviaturasesiglas}{%
    \refstepcounter{section}
	\pretexto%
	\pdfbookmark[0]{\nomeabreviaturasesiglas}{nomeabreviaturasesiglas}% necessário quando não faz parte da tabela de conteudos - acrescentado por gjfb em 2009-09-14
	\begin{singlespace}%
		{\centering\normalfont\normalsize\bfseries\MakeUppercase\space\nomeabreviaturasesiglas\\*[\baselsdefault]}%
		\vspace{1cm}
		\begin{longtable}{lll}
    }{
		\end{longtable}
	\end{singlespace}%
	\pretexto%
}

% Glossario
\newenvironment{glossario}{%
  \setlength{\labelsep}{\sepitem}
	\pretexto%
	\thispagestyle{\estilonum}
	\pagestyle{\estilonum}
	\refstepcounter{chapter}
	{\addcontentsline{toc}{chapter}{\nomeglossarios}}
	\begin{singlespace}%
		{\centering\normalfont\normalsize\bfseries\MakeUppercase\nomeglossarios\\*[\baselsdefault]}%
		\vspace{1cm}
		\begin{description}
}{
		\end{description}
	\end{singlespace}%
}


%%%%%%%CHAPTER

\ifthenelse{\equal{\@docSemFormatacaoCapitulo}{true}}{
\renewcommand{\@makechapterhead}[1]{%
  {\normalfont\normalsize\bfseries\MakeUppercase\thechapter\space\space #1\par\nobreak}}
}{%
\renewcommand{\@makechapterhead}[1]{%
  {\centering\normalfont\normalsize\bfseries\MakeUppercase\chaptername\space%
   \thechapter\par\nobreak #1\par\nobreak}}
}

\renewcommand{\@schapter}[1]{%
	\@makeschapterhead{#1}}

\renewcommand{\@makeschapterhead}[1]{%
	{\centering\normalfont\normalsize\bfseries\MakeUppercase #1\par\nobreak}}

%%%%%% - Cabecario das seccoes e subseccoes:

\renewcommand{\section}{%
  \suppressfloats[t]%
  \@startsection{section}{1}{0mm}{0pt}{0.1pt}%
     {\normalfont\normalsize\bfseries}}

\renewcommand{\subsection}{%
  \@startsection{subsection}{2}{0mm}{0pt}{0.1pt}%
     {\normalfont\normalsize\bfseries}}

\renewcommand{\subsubsection}{%
  \@startsection{subsubsection}{3}{0mm}{0pt}{0.1pt}%
     {\normalfont\normalsize\bfseries}}
     
\renewcommand{\paragraph}{%
  \@startsection{paragraph}{4}{0mm}{0pt}{0.1pt}%
     {\normalfont\normalsize\bfseries}}

\renewcommand{\subparagraph}{%
  \@startsection{subparagraph}{5}{0mm}{0pt}{0.1pt}%
     {\normalfont\normalsize\bfseries}}


%%%%%%%%%%%%%%%%%%%% - Sumário:
\setlength{\cftbeforetoctitleskip}{3pt}
\renewcommand{\cfttoctitlefont}{%
	\hfill\normalfont\normalsize\bfseries\MakeUppercase}

\renewcommand{\cftaftertoctitle}{%
	\hfill\mbox{}\\[\parsinpe]\mbox{}\hfill\underline{\normalfont\normalsize\bfseries\nomepagina}% acrescendato por gjfb em 2013-10-29
}

\setlength{\cftaftertoctitleskip}{\parsinpe}

\setlength{\cftbeforepartskip}{\parsinpe}
\setlength{\cftbeforechapskip}{\parsinpe}
\setlength{\cftbeforesecskip}{\parsdefault}
\setlength{\cftbeforesubsecskip}{\parsdefault}
\setlength{\cftbeforesubsubsecskip}{\parsdefault}
\setlength{\cftbeforeparaskip}{\parsdefault}
\setlength{\cftbeforesubparaskip}{\parsdefault}

\setlength{\cftchapindent}{0pt}
\setlength{\cftsecindent}{0pt}
\setlength{\cftsubsecindent}{0pt}
\setlength{\cftsubsubsecindent}{0pt}
\setlength{\cftparaindent}{0pt}
\setlength{\cftsubparaindent}{0pt}

\renewcommand{\cftchapfont}{\normalfont\normalsize\bfseries}%\sc}%\MakeUppercase\chaptername\ }
\renewcommand{\cftpartfont}{\normalfont\normalsize\bfseries}%\sc}%MakeUppercase}

% poe ou nao a palavra capitulo no sumario
\ifthenelse{\equal{\@docSemFormatacaoCapitulo}{true}}{
%% nada faz
}{%
\renewcommand{\cftchappresnum}{\MakeUppercase\chaptername\space}
\renewcommand{\cftpartpresnum}{\MakeUppercase\partname\space}
\newlength{\chaplen}
\newlength{\partlen}
\settowidth{\chaplen}{\normalfont\normalsize\bfseries\cftchappresnum\cftchapaftersnum}
\settowidth{\partlen}{\normalfont\normalsize\bfseries\cftpartpresnum}
\addtolength{\cftchapnumwidth}{\chaplen}
\addtolength{\cftpartnumwidth}{\partlen}
}

% poe linhas pontilhadas nos capitulos do sumario
\renewcommand{\cftchapleader}{\normalfont\bfseries\cftdotfill{\cftsecdotsep}}
\renewcommand{\cftchappagefont}{\normalfont\normalsize\bfseries}
\renewcommand{\cftpartpagefont}{\normalfont\normalsize\bfseries}

\renewcommand{\cftsecfont}{\normalfont\normalsize}
\renewcommand{\cftsecpagefont}{\normalfont\normalsize}

\renewcommand{\cftsubsecfont}{\normalfont\normalsize}
\renewcommand{\cftsubsecpagefont}{\normalfont\normalsize}

\renewcommand{\cftsubsubsecfont}{\normalfont\normalsize}
\renewcommand{\cftsubsubsecpagefont}{\normalfont\normalsize}

\renewcommand{\cftparafont}{\normalfont\normalsize}
\renewcommand{\cftparaaftersnum}{\ -}
\renewcommand{\cftparapagefont}{\normalfont\normalsize}

\renewcommand{\cftsubparafont}{\normalfont\normalsize}
\renewcommand{\cftsubparaaftersnum}{\ -}
\renewcommand{\cftsubparapagefont}{\normalfont\normalsize}

% - Lista de figuras:	

\setlength{\cftbeforeloftitleskip}{0pt}
\renewcommand{\cftloftitlefont}{%
	\hfill\normalfont\normalsize\bfseries\MakeUppercase}
\renewcommand{\cftafterloftitle}{%
	\pdfbookmark[0]{\listfigurename}{listfigurename}% necessário quando não faz parte da tabela de conteudos - acrescentado por gjfb em 2009-09-14
	\hfill\mbox{}\\[\parsinpe]\mbox{}\hfill\underline{\normalfont\normalsize\bfseries\nomepagina}% acrescendato por gjfb em 2013-10-29
}
\setlength{\cftafterloftitleskip}{\parsinpe}
\setlength{\cftbeforefigskip}{-0,09\parsinpe}
\setlength{\cftfigindent}{0pt}
\renewcommand{\cftfigfont}{\normalfont\normalsize}
\renewcommand{\cftfigpagefont}{\normalfont\normalsize}

   
% - Lista de tabelas:

\setlength{\cftbeforelottitleskip}{0pt}
\renewcommand{\cftlottitlefont}{
	\hfill\normalfont\normalsize\bfseries\MakeUppercase}
\renewcommand{\cftafterlottitle}{%
	\pdfbookmark[0]{\listtablename}{listtablename}% necessário quando não faz parte da tabela de conteudos - acrescentado por gjfb em 2009-09-14
	\hfill\mbox{}\\[\parsinpe]\mbox{}\hfill\underline{\normalfont\normalsize\bfseries\nomepagina}% acrescendato por gjfb em 2013-10-29
	}
\setlength{\cftafterlottitleskip}{\parsinpe}
\setlength{\cftbeforetabskip}{-0,09\parsinpe}
\setlength{\cfttabindent}{0pt}
\renewcommand{\cfttabfont}{\normalfont\normalsize}
\renewcommand{\cfttabpagefont}{\normalfont\normalsize}


%%%%%%%%%%%%%%%%%% thebibliography
\renewenvironment{thebibliography}[1]{%
	\chapter*{\refname}
	\refstepcounter{chapter}
	\addcontentsline{toc}{chapter}{\refname}
	\bigskip
  \label{referbiblio}	\flushleft\list{\@biblabel{\@arabic\c@enumiv}}{\settowidth\labelwidth{\@biblabel{#1}}%
		\leftmargin\labelwidth\advance\leftmargin\labelsep%
		\@openbib@code
		\usecounter{enumiv}%
		\let\p@enumiv\@empty%
		\renewcommand\theenumiv{\@arabic\c@enumiv}%
	}%
	\sloppy
   \clubpenalty4000
   \@clubpenalty \clubpenalty
   \widowpenalty4000%
   \sfcode`\.\@m%
} 
{ 	
	\def\@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
	\endlist
}

%%%%%%%%%%%%%%%%%% theindex
\renewenvironment{theindex}{
  \setlength{\labelsep}{\sepitem}
	\thispagestyle{\estilonum}
	\pagestyle{\estilonum}
	\refstepcounter{chapter}
	{\addcontentsline{toc}{chapter}{\indexname}}
	\if@twocolumn
        		\@restonecolfalse
                \else
                	\@restonecoltrue
                \fi
                \@restonecoltrue
                \columnseprule \z@
                \columnsep 35\p@
                \twocolumn[\@makeschapterhead{\indexname}\vspace*{25\p@}]%
                \@mkboth{\MakeUppercase\indexname}{\MakeUppercase\indexname}%
	\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem
}{\if@restonecol\onecolumn\else\clearpage\fi}

%%%%%% Citação (citacao) %%%%%%%%
\newenvironment{citacao}
               {\begin{spacing}{1}\footnotesize\list{}{\leftmargin=4cm \rightmargin=0cm}
               \item\relax}
               {\endlist\end{spacing}\vspace\parskip}

%%%%%% Epígrafe nos Capítulos %%%%%% opcional
\newcommand{\epicap}[2]{
 \vspace{\baselsinpe}
               {\list{}{\listparindent 2em%
                        \itemindent    \listparindent
                        \rightmargin=0cm   \leftmargin=4cm
                       }%
                \item\relax\raggedleft\sffamily\footnotesize\slshape ``#1''
                \\[0.5\parsinpe]\raggedleft\upshape (#2) \par}
               {\endlist}
 \vspace{\baselsinpe}
}

%%%%%% Watermark / Marca d'água %%%%%%
\newcommand{\watermark}[1]{
 \AddToShipoutPicture{%
  \AtTextCenter{%
    \makebox(0,0)[c]{\resizebox{\textwidth}{!}{%
      \rotatebox{45}{\textsf{\textbf{\textcolor[gray]{0.85}{#1}}}}}}%
  }
 }
}
