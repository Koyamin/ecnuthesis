%%
%% File `ecnudoc.cls',
%% 
%%     Copyright (C) 2021--2026 by Koyamin <contact@koyamin.com>
%%----------------------------------------------------------------
%% 
%%     This work may be distributed and/or modified under the
%%     conditions of the LaTeX Project Public License, either
%%     version 1.3c of this license or (at your option) any later
%%     version. The latest version of this license is in:
%% 
%%       http://www.latex-project.org/lppl.txt
%% 
%%     and version 1.3 or later is part of all distributions of
%%     LaTeX version 2005/12/01 or later.
%% 
\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\GetIdInfo $Id: ecnuthesis.dtx 0.4 2026-04-20 15:00:00Z Koyamin <contact@koyamin.com>$
  {Documentation class for ecnuthesis}
\ProvidesExplClass{ecnudoc}
  {\ExplFileDate}{\ExplFileVersion}{\ExplFileDescription}
\LoadClass[a4paper,full]{l3doc}
\RequirePackage{xparse}
\RequirePackage[UTF8, heading, scheme=chinese]{ctex}
\RequirePackage{
  geometry,
  caption,
  graphicx,
  listings,
  unicode-math,
  xcolor,
  enumitem,
  siunitx,
  metalogo,
  booktabs,
}
\geometry{
  left   = 1.85 in,
  right  = 0.85 in,
  top    = 1.25 in,
  bottom = 1.00 in
}
\RequirePackage[toc]{multitoc}
\setmainfont[
  Extension      = .otf,
  UprightFont    = *-regular,
  BoldFont       = *-bold,
  ItalicFont     = *-italic,
  BoldItalicFont = *-bolditalic,
]{texgyrepagella}
\setsansfont[
  Extension      = .otf,
  UprightFont    = *-regular,
  BoldFont       = *-bold,
  ItalicFont     = *-italic,
  BoldItalicFont = *-bolditalic,
]{texgyreheros}
\setmonofont[
  Extension      = .otf,
  UprightFont    = *btl,
  BoldFont       = *tb,
  ItalicFont     = *bto,
  BoldItalicFont = *tx,
  HyphenChar     = None
]{cmun}
\ctexset {
  section = {
    name        = {第,节},
    format+     = \raggedright,
  },
  paragraph = {
    runin         = false,
  }
}
\definecolor{color-ecnu-red}{RGB}{164,31,53}
\definecolor{color-ecnu-dark-gray}{RGB}{85,87,89}
\definecolor{color-ecnu-bronze}{RGB}{134,117,77}
\definecolor{color-ecnu-light-gray}{RGB}{142,144,144}
\definecolor{color-ecnu-pink}{RGB}{255,99,125}
\definecolor{color-ecnu-purple}{RGB}{170,123,201}
\definecolor{color-ecnu-blue}{RGB}{64,180,229}
\definecolor{color-ecnu-teal}{RGB}{34,211,197}
\definecolor{color-ecnu-lime}{RGB}{207,219,0}
\definecolor{color-ecnu-orange}{RGB}{255,184,25}
\ifxetex
  \let\ecnudocverbaddon\xeCJKVerbAddon
  \def\ecnudisableecglue{\xeCJKsetup{CJKecglue}}
  \def\ecnuplainps{\xeCJKsetup{PunctStyle=plain}}
  \appto\meta@font@select{\ifinner\ecnudisableecglue\fi}
\else
  \let\ecnudocverbaddon\relax
  \let\ecnuplainps\relax
  \def\ecnudisableecglue{\ltjsetparameter{autoxspacing=false}}
  \appto\meta@font@select{\ecnudisableecglue}
\fi
\AtBeginEnvironment{syntax}
  {
    \linespread{1.05}
    \ecnuplainps
    \ecnudisableecglue
  }

\DeclareDocumentEnvironment{arguments}{}
  {\enumerate[label={\texttt{\#\arabic*:~}}, labelsep=0pt, nolistsep]}
  {\endenumerate}
\AtBeginEnvironment { syntax }
  {
    \char_set_catcode_active:N \|
    \char_set_active_eq:NN \| \orbar
    \char_set_catcode_active:N \(
    \char_set_active_eq:NN \( \defaultvalaux
  }
% 抑制首段的 parskip
\ctex_patch_cmd_once:NnnnTF \__codedoc_function_descr_start:w
  { }
  { \noindent }
  { \skip_vertical:n { -\parskip } \noindent }
  { \iow_term:n { *** ~ SUCCESS ~ *** } }
  { \iow_term:n { *** ~ FAIL ~ *** } }
% l3doc 会在 function 环境的 syntax 和 descr 盒子中间加上 medskipamount 的距离。
% 但是若 syntax 盒子为空（未使用 syntax 环境），就会显得不好看。
% 此时通过将 medskipamount 设置为零来修正。若盒子非空，则将 parskip 还回去
\ctex_preto_cmd:NnnTF \__codedoc_function_assemble:
  { }
  { \__ecnudoc_fix_yoffset: }
  { \iow_term:n { *** ~ SUCCESS ~ *** } }
  { \iow_term:n { *** ~ FAIL ~ *** } }
\cs_new_protected_nopar:Npn \__ecnudoc_fix_yoffset:
  {
    \box_if_empty:NTF \g__codedoc_syntax_box
      { \skip_zero:N \medskipamount }
      { \skip_add:Nn \medskipamount { \parskip } }
  }
% 不显示 macro 环境最后的 “(End definition for ...)”
\cs_set_eq:NN \__codedoc_macro_end_style:n \use_none:n
% 不对 \cs 和 \tn 等编索引。用于目录、索引等
\DeclareDocumentCommand \StopSpecialIndexModule { }
  {
    \cs_set_eq:NN
      \__codedoc_special_index_module:nnnnN \use_none:nnnnn
  }
\tl_map_inline:nn { \actualchar \encapchar \levelchar }
  { \exp_args:Nx \DoNotIndex { \bslash \tl_to_str:N #1 } }
% 目录中禁止对 \cs 和 \tn 等的索引
\AtBeginDocument{%
  \addtocontents{toc}{\StopSpecialIndexModule}}
% 调整索引外观。来自 ctex 宏集的 ctxdoc 文档类。
\IndexPrologue{%
  \section{\indexname}%
  \textit{意大利体的数字表示对应索引项出现的页码；
    带下划线的数字表示定义对应索引项的代码行号；
    其他则表示使用对应索引项的代码行号。}}
\def\IndexLayout{%
  \newgeometry{
    left   = 0.85 in,
    right  = 0.85 in,
    top    = 1.25 in,
    bottom = 1.00 in}%
  \setlength\IndexMin{0.5\textheight}%
  \ctexset{section/numbering=false}%
  \StopSpecialIndexModule}
\def\indexname{代码索引}
% implementation 部分的代码字体
\cs_set_protected:Npn \MacroFont
  {
    \linespread { 1.05 }
    \small
    \fontseries { \mddefault }
    \fontshape  { \updefault }
    \ttfamily
    \ecnudocverbaddon
  }
\ctex_preto_cmd:NnnTF \__codedoc_typeset_functions:
  { }
  { \MacroFont }
  { \iow_term:n { *** ~ SUCCESS ~ *** } }
  { \iow_term:n { *** ~ FAIL ~ *** } }
\ctex_patch_cmd_once:NnnnTF \__codedoc_macro_init:
  { }
  { \hbox:n }
  { \MacroFont \hbox:n }
  { \iow_term:n { *** ~ SUCCESS ~ *** } }
  { \iow_term:n { *** ~ FAIL ~ *** } }
\ctex_patch_cmd_once:NnnnTF \__codedoc_macro_dump:
  { }
  { \hbox_unpack_drop:N }
  { \MacroFont \hbox_unpack_drop:N }
  { \iow_term:n { *** ~ SUCCESS ~ *** } }
  { \iow_term:n { *** ~ FAIL ~ *** } }
\cs_set_protected:Npn \__codedoc_macro_typeset_one:nN #1#2
  {
    \vbox_set:Nn \l__codedoc_macro_box
      {
        \MacroFont
        \vbox_unpack_drop:N \l__codedoc_macro_box
        \hbox_set:Nn \l_tmpa_box
          { \__codedoc_print_macroname:nN {#1} #2 }
        \dim_set:Nn \l_tmpa_dim { \marginparwidth - \labelsep }
        \dim_compare:nNnT { \box_wd:N \l_tmpa_box } > \l_tmpa_dim
          {
            \box_resize_to_wd_and_ht:Nnn \l_tmpa_box
              { \l_tmpa_dim }
              { \box_ht:N \l_tmpa_box }
          }
        \hbox_overlap_left:n
          {
            \box_use:N \l_tmpa_box
            \skip_horizontal:n { \marginparsep - \labelsep }
          }
      }
    \int_incr:N \l__codedoc_macro_int
  }
\cs_set_protected:Npn \__codedoc_print_macroname:nN #1#2
  {
    \strut
    \__codedoc_get_hyper_target:eN
      {
        \exp_not:n {#1}
        \bool_if:NT #2 { \tl_to_str:n {TF} }
      }
      \l__codedoc_tmpa_tl
    \cs_if_exist:cTF { r@ \l__codedoc_tmpa_tl }
      { \exp_args:NNo \label@hyperref [ \l__codedoc_tmpa_tl ] }
      { \use:n }
      {
        \tl_set:Nn \l__codedoc_tmpa_tl {#1}
        \tl_replace_all:NVn \l__codedoc_tmpa_tl
          \c_catcode_other_space_tl
          { \fontspec_visible_space: }
        \__codedoc_print_macroname_aux:on
          \l__codedoc_tmpa_tl { \bool_if:NT #2 { \__codedoc_typeset_TF: } }
      }
  }
\RequirePackage { hyperref }
\hypersetup{
  unicode     = true,
  colorlinks  = true,
  citecolor   = color-ecnu-teal!60!black,
  linkcolor   = color-ecnu-red!25!red,
  urlcolor    = color-ecnu-pink,
  pdflang     = zh-CN,
  pdftitle    = {ecnuthesis: 华东师范大学学位论文模板},
  pdfauthor   = {Koyamin},
}
\def\UrlAlphabet{%
  \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j%
  \do\k\do\l\do\m\do\n\do\o\do\p\do\q\do\r\do\s\do\t%
  \do\u\do\v\do\w\do\x\do\y\do\z\do\A\do\B\do\C\do\D%
  \do\E\do\F\do\G\do\H\do\I\do\J\do\K\do\L\do\M\do\N%
  \do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V\do\W\do\X%
  \do\Y\do\Z}
\def\UrlDigits{\do\1\do\2\do\3\do\4\do\5\do\6\do\7\do\8\do\9\do\0}
\g@addto@macro{\UrlBreaks}{\UrlOrds}
\g@addto@macro{\UrlBreaks}{\UrlAlphabet}
\g@addto@macro{\UrlBreaks}{\UrlDigits}
% 不对下列各项添加索引
\DoNotIndex{\begin,\end,
  \a,\b,\c,\d,\e,\f,\g,\h,\i,\j,\k,\l,\m,
  \n,\o,\p,\q,\r,\s,\t,\u,\v,\w,\x,\y,\z,
  \A,\B,\C,\D,\E,\F,\G,\H,\I,\J,\K,\L,\M,
  \N,\O,\P,\Q,\R,\S,\T,\U,\V,\W,\X,\Y,\Z,
  \0,\1,\2,\3,\4,\5,\6,\7,\8,\9}
% 部分命令之后的标记，表明这些命令为本科生毕业论文与博士、硕士学位论文专用。
% 此处的 exp 和 rexp 分别源自 LaTeX3 中的
% “expandable”和“restricted-expandable”。
\newcommand*\exptarget{\Hy@raisedlink{\hypertarget{expstar}{}}}
\newcommand*\rexptarget{\Hy@raisedlink{\hypertarget{rexpstar}{}}}
\newcommand*\expstar{%
  \hyperlink{expstar}{\textsuperscript{\rmfamily\scshape UG}}}
\newcommand*\rexpstar{%
  \hyperlink{rexpstar}{\textsuperscript{\rmfamily\scshape PG}}}
\cs_set_eq:NN \__codedoc_typeset_exp:  \expstar
\cs_set_eq:NN \__codedoc_typeset_rexp: \rexpstar
% syntax 中的选项及命令选项。
% @aux 结尾的命令用于定义使用 () 的简写形式。
\def\defaultval#1{\textbf{\textup{#1}}}
\def\defaultvalaux#1){\defaultval{#1}}
% syntax 中的选项分隔符，以及 true 或 false
% 选项的几种快捷方式。
\def\orbar{\textup{\textbar}}
\def\TF{true\orbar false}
\def\TTF{\defaultval{true}\orbar false}
\def\TFF{true\orbar\defaultval{false}}
% 选项名
\DeclareDocumentCommand\opt{m}{\texttt{#1}}
% <key> = <value> 型选项
\DeclareDocumentCommand\kvopt{mm}
  {\texttt{#1\breakablethinspace=\breakablethinspace#2}}
% \env{syntax} 中高亮显示键名
\DeclareDocumentCommand\OPTKEY{m}
  {\textcolor{color-ecnu-red}{#1}}
\DeclareDocumentCommand\CFG{m}
  {\textcolor{color-ecnu-red}{#1}}
\DeclareDocumentCommand\CFGKEY{m}
  {\textcolor{color-ecnu-red}{#1}}
\DeclareDocumentCommand\TNi{m}
  {\textcolor{color-ecnu-blue!70!violet}{\tn{#1}}}
\DeclareDocumentCommand\TNii{m}
  {\textcolor{color-ecnu-bronze!70!color-ecnu-red}{\tn{#1}}}
\DeclareDocumentCommand\ENV{m}
  {\textcolor{color-ecnu-orange!70!color-ecnu-red}{#1}}
\DeclareDocumentCommand\BEV{m}
  {\TNi{begin}\{\ENV{#1}\}}
\DeclareDocumentCommand\EEV{m}
  {\TNi{end}\{\ENV{#1}\}}
% 定义若干代码样式
\lstdefinestyle{style@base}{
  basicstyle        = \small\ttfamily\color{color-ecnu-dark-gray!55!black},
  columns           = flexible,
  keepspaces        = true,
  lineskip          = 0 pt,
  framerule         = 1 pt,
  framesep          = 3 pt,
  xleftmargin       = 4 pt,
  breaklines        = true,
  showspaces        = false,
  showstringspaces  = false,
  gobble            = 4,
  escapeinside      = {(*}{*)},
  backgroundcolor   = \color{color-ecnu-light-gray!5},
  stringstyle       = \color{green!40!black!100},
  commentstyle      = \slshape\color{color-ecnu-light-gray!70}
}
\lstdefinestyle{style@shell}{
  style     = style@base,
  frame     = l,
  rulecolor = \color{color-ecnu-red},
  language  = bash,
}
\lstdefinestyle{style@latex}{
  style       = style@base,
  frame       = l,
  rulecolor   = \color{color-ecnu-red},
  language    = [LaTeX]TeX,
  alsoletter  = {*, -},
  texcsstyle  = *\color{color-ecnu-blue!70!violet},
  texcsstyle  = *[2]\color{color-ecnu-bronze!70!color-ecnu-red},
  texcsstyle  = *[3]\color{red!40!black},
  emphstyle   = [1]\color{color-ecnu-orange!70!color-ecnu-red},
  emphstyle   = [2]\color{color-ecnu-red!70},
  emphstyle   = [3]\color{color-ecnu-red!70},
}
\lstnewenvironment{latexcode}[1][]{%
  \lstset{style=style@latex, #1}}{}
\lstnewenvironment{shellcode}[1][]{%
  \lstset{style=style@shell, #1}}{}
\def\breakablethinspace{\hskip 0.16667em\relax}
% 定义列表样式
\setlist{noitemsep,topsep=\smallskipamount}
\setlist[enumerate]{
  topsep=0pt,
  parsep=0pt,
  itemsep=0pt
}
\setlist[itemize]{
  topsep=0pt,
  parsep=0pt,
  itemsep=0pt
}
\newlist{optdesc}{description}{3}
\setlist[optdesc]{%
  font          = \mdseries\small\ttfamily,
  align         = right,
  listparindent = \parindent,
  labelsep      = \marginparsep,
  labelindent   = -\marginparsep,
  leftmargin    = 0pt,
}
\endinput
%%
%% End of file `ecnudoc.cls'.
