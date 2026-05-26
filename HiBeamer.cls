\NeedsTeXFormat{LaTeX2e}[2021-11-15]
\ProvidesClass{HiBeamer}[2026-05-21 v1.0 Chinese Math/Physics Beamer Template]

% ==========================================
% 模块一：类声明与基础配置
% ==========================================
\RequirePackage{l3keys2e}

\ExplSyntaxOn
\bool_new:N \g__highend_random_quote_bool
\int_new:N \g__highend_quote_seed_int
\bool_new:N \g__highend_handout_bool
\bool_new:N \g__highend_show_nav_bool
\bool_new:N \g__highend_dark_mode_bool

\keys_define:nn { highendbeamer } {
  randomquote .bool_set:N = \g__highend_random_quote_bool,
  randomquote .default:n = true,
  randomquote .initial:n = true,           % 默认开启随机
  quoteseed .int_set:N = \g__highend_quote_seed_int,
  quoteseed .initial:n = -1,               % 默认无种子 (真随机)
  handout .bool_set:N = \g__highend_handout_bool,
  handout .default:n = true,
  handout .initial:n = false,
  shownav .bool_set:N = \g__highend_show_nav_bool,
  shownav .default:n = true,
  shownav .initial:n = true,               % 默认显示上下页按钮
  darkmode .bool_set:N = \g__highend_dark_mode_bool,
  darkmode .default:n = true,
  darkmode .initial:n = true,              % 默认深色模式（黑板风格）
}
\ProcessKeysOptions { highendbeamer }       % 处理传入的选项

\newif\ifhighendshownav
\bool_if:NT \g__highend_show_nav_bool { \highendshownavtrue }
\newif\ifhighenddarkmode
\bool_if:NT \g__highend_dark_mode_bool { \highenddarkmodetrue }

% --- 讲义模式处理 ---
\bool_if:NT \g__highend_handout_bool {
  % 1. 将 handout 选项传递给 beamer，压平所有 overlay 动画
  \PassOptionsToClass{handout}{beamer}
}


\PassOptionsToClass{aspectratio=169, 10pt, t}{beamer}
\LoadClass[fontset=none]{ctexbeamer}


% --- 讲义模式布局设置 ---

\bool_if:NT \g__highend_handout_bool {

  \RequirePackage{pgfpages}

  % === 请根据需要取消注释以下布局之一 ===

  % 布局 A：2 on 1 (纵向A4，左侧幻灯片，右侧留白做笔记，最推荐)
  %\pgfpagesuselayout{2~on~1}[a4paper, border~shrink=5mm]

  % 布局 B：4 on 1 (横向A4，4张幻灯片，纯省纸)
  \pgfpagesuselayout{4~on~1}[a4paper, landscape, border~shrink=5mm]

  % 布局 C：2 on 1 带横线笔记区 (需要较新版本的 pgfpages)
  % \pgfpagesuselayout{2 on 1}[a4paper, border shrink=5mm]
  % \pgfpageslogicalpageoptions{1}{border code=\pgfusepath{stroke}}
  % \pgfpageslogicalpageoptions{2}{border code=\pgfusepath{stroke}, center=\pgfpoint{0.5\paperwidth}{0.5\paperheight}}
  % (注：自动画横线较复杂，通常建议用布局A手动写笔记)
}
\ExplSyntaxOff

\RequirePackage{xcolor}
\RequirePackage{tikz}
\RequirePackage{tcolorbox}
\RequirePackage{booktabs}
\RequirePackage{colortbl}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{etoolbox}
\RequirePackage{fontspec}
\RequirePackage{mathtools}
\RequirePackage{unicode-math}
\RequirePackage{csvsimple}


\tcbuselibrary{skins,breakable}
\usetikzlibrary{calc,positioning,arrows.meta}

%解决中文带圈数字的显示问题
\xeCJKsetcharclass{`①}{`⑩}{1}
%解决罗码数字的显示问题
\xeCJKsetcharclass{`Ⅰ}{`Ⅹ}{1}

% ==========================================
% 模块二：色彩与字体定义
% ==========================================
\ifhighenddarkmode
  % --- 深色模式（黑板风格）---
  \definecolor{PrimaryNavy}{HTML}{78AAD4}
  \definecolor{AccentGold}{HTML}{DFC585}
  \definecolor{AlertTerra}{HTML}{ED8A84}
  \definecolor{InfoTeal}{HTML}{66C6BA}
  \definecolor{SuppBlue}{HTML}{88B4D6}
  \definecolor{BGCoolGray}{HTML}{2E3338}
  \definecolor{TextDark}{HTML}{D2D4D6}
  \definecolor{LightGray}{HTML}{868B91}
  \definecolor{BGImp}{HTML}{363130}
  \definecolor{BGWarn}{HTML}{342628}
  \definecolor{BGTeal}{HTML}{283230}
  \definecolor{BGBlue}{HTML}{262E36}
  \definecolor{BGDark}{HTML}{1A1D22}
  \definecolor{NavBtnBg}{HTML}{3E4349}
  \definecolor{GridColor}{HTML}{3D4247}
\else
  % --- 浅色模式（原版）---
  \definecolor{PrimaryNavy}{HTML}{1A2A40}
  \definecolor{AccentGold}{HTML}{C5A065}
  \definecolor{AlertTerra}{HTML}{C75C5C}
  \definecolor{InfoTeal}{HTML}{2A9D8F}
  \definecolor{SuppBlue}{HTML}{3A6EA5}
  \definecolor{BGCoolGray}{HTML}{F5F7FA}
  \definecolor{TextDark}{HTML}{333333}
  \definecolor{LightGray}{HTML}{CCCCCC}
  \definecolor{BGImp}{HTML}{FDF6E3}
  \definecolor{BGWarn}{HTML}{FDF0F0}
  \definecolor{BGTeal}{HTML}{E8F6F3}
  \definecolor{BGBlue}{HTML}{EBF5FB}
  \definecolor{GridColor}{HTML}{EBEEF0}
\fi

\usefonttheme{professionalfonts}

% 西文字体与数学字体
\setsansfont{TeX Gyre Heros}
\setmainfont{TeX Gyre Pagella}
\setmathfont{TeX Gyre Pagella Math}


% 中文字体 (需系统安装思源字体)
\setCJKmainfont {Source Han Serif CN}[BoldFont=Source Han Serif CN Bold]
\setCJKsansfont {Source Han Serif CN}
\setCJKmonofont {Source Han Serif CN}

\setbeamerfont{title}{family=\sffamily,series=\bfseries,size=\Large}
\setbeamerfont{frametitle}{family=\sffamily,series=\bfseries,size=\normalsize}
\setbeamerfont{section in head/foot}{size=\scriptsize,family=\sffamily}
\setbeamerfont{footnote}{size=\footnotesize}

% --- 深色模式：Beamer 色彩系统（类加载时设置，确保优先级） ---
\ExplSyntaxOn
\bool_if:NT \g__highend_dark_mode_bool
  {
    \setbeamercolor{normal~text}{fg=TextDark,bg=BGDark}
    \setbeamercolor{background~canvas}{bg=BGDark}

    \setbeamercolor{structure}{fg=TextDark}
    \setbeamercolor{local~structure}{parent=structure}
    \setbeamercolor{item~projected}{fg=TextDark}
    \setbeamercolor{itemize~item}{fg=TextDark}
    \setbeamercolor{itemize~subitem}{fg=TextDark}
    \setbeamercolor{itemize~subsubitem}{fg=TextDark}
    \setbeamercolor{enumerate~item}{fg=TextDark}
    \setbeamercolor{enumerate~subitem}{fg=TextDark}
    \setbeamercolor{enumerate~subsubitem}{fg=TextDark}
    \setbeamercolor{description~item}{fg=TextDark}

    \AtBeginDocument{ \pagecolor{BGDark} }
    \AddToHook{begindocument/end}{
      \color{TextDark}
      \let\default@color\current@color
    }
  }
\ExplSyntaxOff

% ==========================================
% 模块三：骨架与导航定制
% ==========================================

% --- 诗词数据结构与逻辑 (LaTeX3 环境) ---
\ExplSyntaxOn
\seq_new:N \g__highend_quotes_seq
\tl_new:N \g__highend_quote_author_tl
\tl_new:N \g__highend_quote_work_tl
\tl_new:N \g__highend_quote_content_tl
\int_new:N \g__highend_quote_counter_int

% 在文档开始时自动读取同目录下的 quotes.csv
\AtBeginDocument {
  \file_if_exist:nT { quotes.csv } {
    \csvreader[head=false, separator=tab]{quotes.csv}{} {
      \seq_put_right:Nx \g__highend_quotes_seq { \csvcoli ||| \csvcolii ||| \csvcoliii }
    }
  }
  % 如果用户提供了种子，则在文档开头设置伪随机种子 (保证每次编译顺序一致)
  \int_compare:nT { \g__highend_quote_seed_int > -1 } {
    \sys_gset_rand_seed:n { \g__highend_quote_seed_int }
  }
}

% 获取诗句的核心逻辑
\cs_new_protected:Nn \__highend_get_quote:
  {
    \seq_if_empty:NF \g__highend_quotes_seq
      {
        \int_incr:N \g__highend_quote_counter_int
        \bool_if:NTF \g__highend_random_quote_bool
          {
            % 随机模式
            \int_set:Nn \l_tmpa_int { \seq_count:N \g__highend_quotes_seq }
            \int_set:Nn \l_tmpb_int { \int_rand:nn { 1 } { \l_tmpa_int } }
          }
          {
            % 顺序模式 (循环播放)
            \int_set:Nn \l_tmpb_int {
              \int_mod:nn { \g__highend_quote_counter_int - 1 } { \seq_count:N \g__highend_quotes_seq } + 1
            }
          }
        \tl_set:Nx \l_tmpa_tl { \seq_item:Nn \g__highend_quotes_seq { \l_tmpb_int } }
        \seq_set_split:NnV \l_tmpa_seq { ||| } { \l_tmpa_tl }
        \tl_gset:Nx \g__highend_quote_author_tl { \seq_item:Nn \l_tmpa_seq { 1 } }
        \tl_gset:Nx \g__highend_quote_work_tl { \seq_item:Nn \l_tmpa_seq { 2 } }
        \tl_gset:Nx \g__highend_quote_content_tl { \seq_item:Nn \l_tmpa_seq { 3 } }
      }
  }

% 封装成普通命令供 TikZ 调用，避免空格冲突
\NewDocumentCommand \highendgetquote {} { \__highend_get_quote: }
\NewDocumentCommand \highendshowquote {} {
  \tl_if_empty:NF \g__highend_quote_content_tl {
    \raggedleft
    \tl_use:N \g__highend_quote_content_tl \par
    {\footnotesize —— \tl_use:N \g__highend_quote_author_tl
     \tl_if_empty:NF \g__highend_quote_work_tl { ⋅ \tl_use:N \g__highend_quote_work_tl}}\par
  }
}
\ExplSyntaxOff

\setbeamersize{text margin left=1cm,text margin right=1cm}
\setbeamercovered{transparent=15}
\setbeamertemplate{navigation symbols}{}
\setbeamertemplate{headline}{}

% --- 页面底层导航按钮（TikZ 绘制, 不影响任何原有排版） ---
\ExplSyntaxOn
\bool_if:NT \g__highend_show_nav_bool
  {
    \bool_if:NTF \g__highend_dark_mode_bool
      { \tl_const:Nn \c__highend_nav_btn_fill_tl { NavBtnBg } }
      { \tl_const:Nn \c__highend_nav_btn_fill_tl { LightGray!25 } }
    \addtobeamertemplate{background~canvas}{}{%
      \begin{tikzpicture}[remember~picture,~overlay]
        \ifnum\c@page>1
          \node[anchor=south~west,~inner~sep=0.4cm]
               at~(current~page.south~west)
            {%
              \hyperlink{page.\the\numexpr\c@page-1\relax}{%
                \tikz[baseline=0pt]{
                  \node[rounded~corners=3pt,~fill=\c__highend_nav_btn_fill_tl,~inner~sep=5pt,
                        font=\sffamily\bfseries]{\LARGE\strut$\blacktriangleleft$};
                }%
              }%
            };
        \fi
        \node[anchor=south~east,~inner~sep=0.4cm]
             at~(current~page.south~east)
          {%
            \hyperlink{page.\the\numexpr\c@page+1\relax}{%
              \tikz[baseline=0pt]{
                \node[rounded~corners=3pt,~fill=\c__highend_nav_btn_fill_tl,~inner~sep=5pt,
                      font=\sffamily\bfseries]{\LARGE\strut$\blacktriangleright$};
              }%
            }%
          };
      \end{tikzpicture}%
    }
  }
\ExplSyntaxOff

\setbeamertemplate{frametitle}{%
  \vskip0.1cm
  \leavevmode\hbox to \dimexpr\paperwidth-2cm\relax{%
    \usebeamerfont{frametitle}\textcolor{PrimaryNavy}{\insertframetitle}\hfill
    \usebeamerfont{section in head/foot}\textcolor{LightGray}{\insertsection}%
  }%
  \vskip-7pt
  {\noindent\textcolor{PrimaryNavy}{\rule{\dimexpr\paperwidth-2cm\relax}{0.4pt}}}%
  \vskip-0.2cm
}

\setbeamertemplate{footline}{%
  \hfill
  \raisebox{3pt}{%
    \usebeamerfont{page number in head/foot}\textcolor{LightGray}{\insertframenumber{}~/~\inserttotalframenumber}%
  }%
  \hspace*{1.2cm}%
  \vskip6pt
}

\setbeamertemplate{section in toc}{%
  \leavevmode
  \textcolor{AccentGold}{\raisebox{0.1ex}{\small$\blacktriangleright$}}%
  \hspace{0.5em}{\textbf{\textcolor{PrimaryNavy}{\inserttocsection}}}%
  \par
}
\setbeamertemplate{section in toc shaded}{%
  \leavevmode
  \hspace{1.3em}{\textcolor{LightGray}{\inserttocsection}}%
  \par
}


% --- 大节自动过渡页  ---
\ExplSyntaxOn
\bool_if:NTF \g__highend_dark_mode_bool
  { \def\highend@watermark@opacity{0.20} }
  { \def\highend@watermark@opacity{0.12} }
\ExplSyntaxOff

\AtBeginSection[]{%
  \begingroup
  \setbeamertemplate{headline}{}
  \setbeamertemplate{footline}{}
  \highendgetquote

  \begin{frame}[noframenumbering,plain]
    \vfill
    \begin{columns}[c] % [c] 确保两列垂直居中，这是防止溢出的核心
      % 左侧：巨大数字
      \begin{column}{0.25\textwidth}
        \centering
        \begin{tikzpicture}
          \node[text=PrimaryNavy, opacity=\highend@watermark@opacity,
                font=\sffamily\bfseries, scale=9]{\insertsectionnumber};
        \end{tikzpicture}
      \end{column}
      % 右侧：标题与诗句
      \begin{column}{0.55\textwidth}
        \raggedleft % 整个右列右对齐

        {\sffamily\bfseries\LARGE\color{PrimaryNavy} \insertsection}

        \vspace{3mm}
        % 装饰线：固定宽度6cm（可根据喜好调整为5cm或7cm等）
        {\color{AccentGold}\rule{6cm}{2pt}}

        \vspace{3mm}
        {\rmfamily\small\color{TextDark!40} \highendshowquote}
      \end{column}
    \end{columns}
    \vfill
  \end{frame}
  \endgroup
}

% ==========================================
% 模块四：列表样式定制
% ==========================================
\setbeamertemplate{itemize item}{\textcolor{AccentGold}{\raisebox{0.2ex}{\tiny$\blacksquare$}}}
\setbeamertemplate{itemize subitem}{\textcolor{PrimaryNavy}{\raisebox{0.1ex}{\tiny$\blacktriangleright$}}}
\setbeamertemplate{itemize subsubitem}{\textcolor{PrimaryNavy!40}{\tiny$\bullet$}}

% 关键修复：使用 \insertsubenumlabel 和 \insertsubsubenumlabel
\setbeamertemplate{enumerate item}{\textcolor{PrimaryNavy}{\bfseries\insertenumlabel.}}
\setbeamertemplate{enumerate subitem}{\textcolor{AccentGold}{\bfseries(\insertsubenumlabel)}}
\setbeamertemplate{enumerate subsubitem}{\textcolor{InfoTeal}{\itshape\insertsubsubenumlabel)}}

\setlength{\leftmargini}{1.2em}
\setlength{\leftmarginii}{1.0em}
\setlength{\leftmarginiii}{1.0em}

% ==========================================
% 模块五：区块与环境实现
% ==========================================
\ExplSyntaxOn
\cs_new_protected:Nn \__highend_new_block:nnnnn
  {
    \NewDocumentEnvironment { #1 } { o }
      {
        \begin{tcolorbox}[
          enhanced, boxrule=0pt, leftrule=2pt, arc=0pt, outer~arc=0pt,
          left=3mm, right=3mm, top=2mm, bottom=2mm,
          colback=#4, colframe=#2, colbacktitle=#2, coltitle=#3,
          fonttitle=\sffamily\bfseries,
          title={ \IfValueTF{##1} {##1} {#5} },
          before~upper={ \setlength{\parskip}{0.5em} },
          coltext=TextDark
        ]
      }
      {
        \end{tcolorbox}
      }
  }

\__highend_new_block:nnnnn { thm }  { PrimaryNavy } { white } { BGCoolGray } { Theorem }
\__highend_new_block:nnnnn { defn } { PrimaryNavy } { white } { BGCoolGray } { Definition }
\__highend_new_block:nnnnn { tip }  { InfoTeal }    { white } { BGTeal }    { Tip }
\__highend_new_block:nnnnn { supp } { SuppBlue }    { white } { BGBlue }    { Supplement }

\bool_if:NTF \g__highend_dark_mode_bool
  {
    \__highend_new_block:nnnnn { imp }  { AccentGold }    { white }    { BGImp }              { Important }
    \__highend_new_block:nnnnn { warn } { AlertTerra }    { white }    { BGWarn }             { Warning }
    \__highend_new_block:nnnnn { eg }   { AccentGold }    { white }    { AccentGold!15!BGDark }{ Example }
    \__highend_new_block:nnnnn { ex }   { AlertTerra }    { white }    { BGWarn }             { Exercise }
    \__highend_new_block:nnnnn { memo } { PrimaryNavy!35 } { white }    { BGCoolGray }         { Memo }
  }
  {
    \__highend_new_block:nnnnn { imp }  { AccentGold }    { PrimaryNavy } { BGImp }        { Important }
    \__highend_new_block:nnnnn { warn } { AlertTerra }    { PrimaryNavy } { BGWarn }       { Warning }
    \__highend_new_block:nnnnn { eg }   { AccentGold }    { PrimaryNavy } { AccentGold!8 } { Example }
    \__highend_new_block:nnnnn { ex }   { AlertTerra }    { PrimaryNavy } { BGWarn }       { Exercise }
    \__highend_new_block:nnnnn { memo } { PrimaryNavy!35 } { TextDark }    { BGCoolGray }   { Memo }
  }

\NewDocumentEnvironment { solve } {}
  {
    \begin{tcolorbox}[
      enhanced, boxrule=0pt, leftrule=2pt, arc=0pt, outer~arc=0pt,
      left=3mm, right=3mm, top=2mm, bottom=2mm,
      colback=BGCoolGray, colframe=PrimaryNavy,
      before~upper={ \setlength{\parskip}{0.5em} },
      coltext=TextDark
    ]
    {\bfseries\textcolor{PrimaryNavy}{解：}}
  }
  { \end{tcolorbox} }

\ExplSyntaxOff

% ==========================================
% 模块六：表格与快捷命令
% ==========================================
\tikzset{
  highend-axis/.style={->,>=stealth,PrimaryNavy,line width=1.1pt},
  highend-curve/.style={line width=1.3pt,AccentGold},
  highend-grid/.style={help lines,step=1cm,GridColor,line width=0.6pt,dashed},
  highend-aux/.style={line width=0.5pt,LightGray,dashed}
}

\arrayrulecolor{PrimaryNavy}
\setlength{\heavyrulewidth}{1.2pt}
\setlength{\lightrulewidth}{0.8pt}

\NewDocumentCommand\hl{m}{\textcolor{AccentGold}{\textbf{#1}}}
\NewDocumentCommand\hlwarn{m}{\textcolor{AlertTerra}{\textbf{#1}}}

% ==========================================
% 模块七：图表与公式编号定制
% ==========================================

% --- 图表标题全局样式 ---
\captionsetup{
    font = small,               % 稍小字号
    labelfont = {bf, color=PrimaryNavy}, % 标签加粗且为藏青色
    labelsep = quad,            % 标签与标题文字之间的间距
    skip = 6pt,                 % 标题与图表本体的间距
    figureposition = bottom,    % 图标题在下方
    tableposition = top         % 表标题在上方
}

% --- 中文化标签 ---
\renewcommand{\figurename}{图}
\renewcommand{\tablename}{表}

% --- 强制显示编号 (使用官方模板，最健壮) ---
\setbeamertemplate{caption}[numbered]

% --- 子图子表标题样式 ---
\captionsetup[subfigure]{
    font = footnotesize,
    labelfont = {bf, color=AccentGold}, % 子图标签用哑光金加粗
    labelsep = space,
    %skip = 0pt,
    belowskip = 0pt
}
\captionsetup[subtable]{
    font = footnotesize,
    labelfont = {bf, color=AccentGold},
    labelsep = space,
    %skip = 0pt,
    belowskip = 0pt
}

% --- 公式编号样式 ---
\renewcommand{\theequation}{\textcolor{PrimaryNavy}{\arabic{equation}}}
\newtagform{primarynavy}{\textcolor{PrimaryNavy}{(}}{\textcolor{PrimaryNavy}{)}}
\usetagform{primarynavy}




\RequirePackage{ragged2e}
% beamber 修改了文字的默认对方式
%如在 beamerbaselocalstructure.sty 中修改了列表（enumerate、itemize、description）
%对齐方式改成了 \raggedright
%这就导致了文字较多时右边对不齐

\RenewDocumentCommand{\raggedright}{}{\justifying} %该方法较为暴力，慎用
%\RequirePackage{xpatch}
%\xpatchcmd{\itemize}{\raggedright}{\justifying}{}{}
%\xpatchcmd{\beamer@enum@}{\raggedright}{\justifying}{}{}
%\xpatchcmd{\@@description}{\raggedright}{\justifying}{}{}
%\xapptocmd{\itemize}{\justifying}{}{}
%\xapptocmd{\beamer@enum@}{\justifying}{}{}
%\xapptocmd{\@@description}{\justifying}{}{}

\RequirePackage[bodytextleadingratio=1.4]{zhlineskip} %行间距

\setbeamersize{description width=4em} %设置 description 环境前面的缩进


% ==========================================
% 跨页连续的例题与练习列表 (独立模块)
% ==========================================


% --- 1. 定义全局计数器 ---
\newcounter{highendegcnt}
\newcounter{highendexcnt}

% --- 2. 关键修复：确保 Beamer overlay 动画下计数器不会重复递增 ---
\resetcounteronoverlays{highendegcnt}
\resetcounteronoverlays{highendexcnt}

% --- 3. 定义装饰性标签 (TikZ 节点实现) ---
\NewDocumentCommand{\highendeglabel}{}{%
  \refstepcounter{highendegcnt}%
  \tikz[baseline=(X.base)]{%
    \node[fill=AccentGold!15, draw=AccentGold, line width=0.6pt, rounded corners=2pt, inner sep=2pt, font=\sffamily\bfseries\small\color{PrimaryNavy}] (X) {例~\thehighendegcnt};%
  }%
}

\NewDocumentCommand{\highendexlabel}{}{%
  \refstepcounter{highendexcnt}%
  \tikz[baseline=(X.base)]{%
    \node[fill=AlertTerra!15, draw=AlertTerra, line width=0.6pt, rounded corners=2pt, inner sep=2pt, font=\sffamily\bfseries\small\color{AlertTerra}] (X) {练~\thehighendexcnt};%
  }%
}

\ExplSyntaxOn

% --- 4. 定义列表环境 ---
\NewDocumentEnvironment {ExampleList} {o}
{
  % 局部替换标签模板并调整边距
  \setbeamertemplate{enumerate~item}{\highendeglabel}
  \setlength{\leftmargini}{1cm}
  \setlength{\leftmarginii}{0.6cm}

  \IfNoValueTF {#1}
  {
    \begin{enumerate}
  }
  {
    \str_if_eq:nnTF {#1} {0}
    {
      \begin{enumerate}
      \setcounter{highendegcnt}{0}
    }
    {
      \begin{enumerate}[#1]
    }
  }
}
{
  \end{enumerate}
}

\NewDocumentEnvironment {ExerciseList} {o}
{
  \setbeamertemplate{enumerate~item}{\highendexlabel}
  \setlength{\leftmargini}{1cm}

  \IfNoValueTF {#1}
  {
    \begin{enumerate}
  }
  {
    \str_if_eq:nnTF {#1} {0}
    {
      \begin{enumerate}
      \setcounter{highendexcnt}{0}
    }
    {
      \begin{enumerate}[#1]
    }
  }
}
{
  \end{enumerate}
}

\ExplSyntaxOff


\endinput
