% !Mode:: "TeX:UTF-8"
% 常州大学硕士论文：依据原Word段落属性与PDF成稿校准；不是学校正式规范。
% origin坐标统一为纸张左上角、单位bp；不以字形墨迹底代替baseline。
\NeedsTeXFormat{LaTeX2e}[2022-06-01]
\ProvidesClass{研究生大论文模板}[2026/10/30 Baseline-based graduate thesis template]
\LoadClass[a4paper,12pt,fontset=none]{ctexart}
\RequirePackage{iftex}
\ifXeTeX\else
  \ClassError{研究生大论文模板}{请使用 XeLaTeX 编译}{本类依赖Windows中文字体及fontspec。}
\fi
\RequirePackage{geometry}
% 全文只设置一次版心。texttop=85.08；textleft/right=85.08/524.52。
\geometry{a4paper,left=85.08bp,textwidth=439.44bp,top=85.08bp,
  bottom=70.92bp,headheight=14bp,headsep=20bp,footskip=20bp}
\RequirePackage{fontspec,xeCJK}
\setmainfont{Times New Roman}
\setsansfont{Arial}
\setmonofont{Courier New}
% 原稿常规黑体标题使用mdseries；仅封面、摘要标题、一级目录等原稿加粗角色
% 使用AutoFakeBold映射，与Word同样区分常规字重和加粗字重。
\setCJKmainfont[AutoFakeBold=2.15,ItalicFont=KaiTi]{SimSun}
\setCJKfamilyfont{zhsong}[AutoFakeBold=2.15,ItalicFont=KaiTi]{SimSun}
\setCJKfamilyfont{zhhei}[AutoFakeBold=2.15]{SimHei}
\setCJKfamilyfont{zhkai}[BoldFont=KaiTi]{KaiTi}
\setCJKfamilyfont{zhfang}[AutoFakeBold=2.15]{FangSong}
\providecommand{\songti}{\CJKfamily{zhsong}}
\providecommand{\heiti}{\CJKfamily{zhhei}}
\providecommand{\kaishu}{\CJKfamily{zhkai}}
\providecommand{\fangsong}{\CJKfamily{zhfang}}
\RequirePackage{amsmath,amssymb}
% 原Word数学对象使用Times/Symbol/MTExtra；此处Termes Math仅为近似，非相同字体。
\RequirePackage{unicode-math}
\setmathfont{texgyretermes-math.otf}
% 仅参考Manuscript.tex的cas-sc默认数学字号：10pt，一级/二级上下标7pt/5pt。
% 正文仍为12bp；数学字体、公式编号与显示公式间距保持原设置。
\DeclareMathSizes{12bp}{10pt}{7pt}{5pt}
\RequirePackage{graphicx,eso-pic}
\graphicspath{{Fig/}{figure/}{figures/}{images/}}
\RequirePackage{etoolbox}
\RequirePackage{booktabs,array,longtable,multirow,threeparttable}
\RequirePackage{caption,subcaption,float}
\RequirePackage{enumitem,setspace,indentfirst}
\RequirePackage[numbers,square,sort&compress]{natbib}
\setcitestyle{super,square}
\RequirePackage[hidelinks,bookmarksnumbered,bookmarksopen,hypertexnames=false]{hyperref}
\RequirePackage{bookmark}

\makeatletter
% 源稿多引用为“[1, 2]”：保留数字压缩，仅把natbib的分隔改为逗号后空格。
% 文献上标独立于数学上下标：源PDF约7.98bp、相对正文基线上移4.5bp。
\newcommand{\thesis@citesuperscript}[1]{%
  \raisebox{4.5bp}{\normalfont\rmfamily\fontsize{7.98bp}{7.98bp}\selectfont #1}}
\patchcmd{\NAT@citesuper}{\textsuperscript}{\thesis@citesuperscript}
  {}{\ClassError{研究生大论文模板}{Cannot adjust natbib citation height}{Check natbib version.}}
\AtBeginDocument{\def\NAT@sep{,\ }}
% ---------- Word段落行距与成稿兼容基线 ----------
% Word单倍不是字号本身；中文/网格采用本稿成稿校准，不冒充通用Word引擎。
\newcommand{\thesis@chineseabstractleading}{27.24bp}% Word14磅、1.5倍、不对齐网格
\newcommand{\thesis@englishabstractleading}{\fpeval{14*2355/2048*1.5}bp}% TNR win/hhea度量
\newcommand{\thesis@tocleading}{23.4bp}% Word12磅、1.5倍、对齐网格
\newcommand{\thesisequationspacing}[2]{%
  \abovedisplayskip=#1bp\relax\belowdisplayskip=#2bp\relax
  \abovedisplayshortskip=#1bp\relax\belowdisplayshortskip=#2bp\relax}
% TeX最小数学支架：首参为支架倍数，后两参为display附加距(bp)。
% 不是Word单倍/1.5倍对象行框等效；实际高对象自然扩展，不裁剪科学内容。
% 与equation一致：有前文时须接同一段，勿先空行/\par；垂直模式启动显示公式
% 会新建空正文行。短/长前行均应通过源码段落衔接修复，不在环境里减20bp。
\NewDocumentEnvironment{thesisequation}{O{1} m m}{%
  \begingroup\thesisequationspacing{#2}{#3}\begin{equation}%
  \vphantom{\rule[-\fpeval{3.6*#1}bp]{0bp}{\fpeval{12*#1}bp}}%
}{\end{equation}\par\endgroup}
% 固定20磅正文；公式段前后默认0，原稿其他公式在局部分组中覆盖。
\renewcommand{\baselinestretch}{1}
\renewcommand{\normalsize}{\@setfontsize\normalsize{12bp}{20bp}%
  \thesisequationspacing{0}{0}}
% 源正文首行逗号后约7.38bp（12bp字框），非全角12bp。
% 同文回归CCT比全角/开明更接近源前四行；这是引擎近似，不是Word算法。
% 摘要/声明保留独立plain覆盖，避免强加正文压缩规则。
\newcommand{\thesis@bodyfont}{\normalfont\songti\normalsize\xeCJKsetup{PunctStyle=CCT}}
\setlength{\parskip}{0pt}
\setlength{\parindent}{24bp}
\setlength{\topskip}{16.02bp}
\raggedbottom
\AtBeginDocument{\thesis@bodyfont\parindent=24bp\parskip=0pt\topskip=16.02bp}
% 只在标题行内部设置noindent；恢复段落状态时显式保留首段缩进。
\newcommand{\thesis@aftertitle}{\@afterindenttrue\@afterheading}
% 页首标题：首个vbox的高度直接等于baseline-texttop，避免topskip/center附加空白。
% #1绝对baseline；#2字体；#3标题（含水平对齐）；#4下一行baseline差。
% 调用方先选定后文baselineskip；短标题保持原基线，长标题用段落盒延展。
\newcommand{\thesis@flowtitle}[4]{%
  \par\nointerlineskip
  \setbox\@tempboxa=\hbox{#2\vrule width0pt height14bp depth0pt #3}%
  \ifdim\wd\@tempboxa>\textwidth
    \setbox\@tempboxa=\vbox{\hsize=\textwidth #2\parindent=0pt
      \rightskip=0pt plus1fil\parfillskip=0pt plus1fil
      \noindent\vrule width0pt height14bp depth0pt #3\par}%
  \else
    \setbox\@tempboxa=\hbox to\textwidth{#2\vrule width0pt height14bp depth0pt #3}%
    \ht\@tempboxa=14bp
  \fi
  \dp\@tempboxa=0pt
  \vbox{\offinterlineskip
    \kern\dimexpr#1bp-85.08bp-14bp\relax
    \box\@tempboxa
  }%
  \nobreak\vskip\dimexpr#4bp-\baselineskip\relax
  \thesis@aftertitle
}
% 固定20bp的标题行strut；连续标题与正文行的baseline均差35.6bp。
\newcommand{\thesis@headingstrut}{\vrule width0pt height14bp depth6bp}
\newcommand{\thesis@sectionfont}[1]{%
  \normalfont\heiti\mdseries\fontsize{#1bp}{20bp}\selectfont
  \thesis@headingstrut}

% ---------- 章、二级、三级标题 ----------
% 章编号后统一固定3.75bp，中英文标题相同，不复现原稿第4章的较宽空白。
% 章是ctexart的section：自定义页首盒，但保留计数、可选短标题、星号、目录与引用。
\RenewDocumentCommand{\section}{s o m}{%
  \clearpage\thesis@bodyfont\parindent=24bp
  \let\thesis@headeroverride\@empty
  \IfBooleanTF{#1}{%
    \def\@currentlabelname{#3}%
    \thesis@flowtitle{116.70}{\normalfont\heiti\mdseries\fontsize{15bp}{20bp}\selectfont}{#3\hfil}{35.6}%
  }{%
    \refstepcounter{section}\def\@currentlabelname{#3}%
    \IfNoValueTF{#2}{\addcontentsline{toc}{section}{\protect\numberline{\thesection}#3}}%
      {\addcontentsline{toc}{section}{\protect\numberline{\thesection}#2}}%
    \IfNoValueTF{#2}{\sectionmark{#3}}{\sectionmark{#2}}%
    \thesis@flowtitle{116.70}{\normalfont\heiti\mdseries\fontsize{15bp}{20bp}\selectfont}%
      {\thesection\hspace{3.75bp}#3\hfil}{35.6}%
  }\ignorespaces
}
% 标准@startsection的正段前距使首段缩进；不用titlespacing*。
\renewcommand{\subsection}{\@startsection{subsection}{2}{0pt}%
  {15.6bp}{15.6bp}{\thesis@sectionfont{14}}}
\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{0pt}%
  {15.6bp}{15.6bp}{\thesis@sectionfont{12}}}
% 中文开头编号后有效空白为半个字号；英文开头保留普通西文空格。
\ExplSyntaxOn
\cs_new_protected:Npn \thesis@numbergap #1#2
  {\exp_args:Ne \__thesis_numbergap:nn {\tl_head:n {#2}} {#1}}
\cs_new_protected:Npn \__thesis_numbergap:nn #1#2
  {\str_if_in:nnTF {ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz} {#1}
    {\space} {\hspace{#2bp}}}
\ExplSyntaxOff
\renewcommand{\@seccntformat}[1]{\csname the#1\endcsname\space}
% @sect取得标题后再决定编号间距，兼容可选短标题及星号标题。
\patchcmd{\@sect}{\protected@edef\@svsec{\@seccntformat{#1}\relax}}%
  {\protected@edef\@svsec{\csname the#1\endcsname\noexpand\thesis@numbergap{\ifnum#2=2 7\else6\fi}{#8}\relax}}%
  {}{\ClassError{研究生大论文模板}{Cannot set heading number gap}{Check LaTeX version.}}
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}
\renewcommand{\thesection}{\arabic{section}}
\renewcommand{\thesubsection}{\thesection.\arabic{subsection}}
\renewcommand{\thesubsubsection}{\thesubsection.\arabic{subsubsection}}

% ---------- 页眉/页码：shipout绝对baseline定位 ----------
% 0空白，1仅页码，2正文页眉+页码。thispagestyle的局部样式同样有效。
\def\thesis@pagekind{1}
\let\thesis@originalempty\ps@empty
\def\ps@empty{\thesis@originalempty\def\thesis@pagekind{0}}
\def\ps@plain{\let\@oddhead\@empty\let\@evenhead\@empty
  \let\@oddfoot\@empty\let\@evenfoot\@empty\def\thesis@pagekind{1}}
\def\ps@thesis{\ps@plain\def\thesis@pagekind{2}}
% 空串恢复自动页眉；覆盖仅在当前章有效，下一章/文后标题自动复位。
\newcommand{\thesisheader}[1]{\def\thesis@headeroverride{#1}}
\let\thesis@headeroverride\@empty
\newcommand{\thesis@headertext}{\ifx\thesis@headeroverride\@empty
  \leftmark\else\thesis@headeroverride\fi}
\newcommand{\thesis@fitheader}{%
  \setbox\@tempboxa=\hbox{\thesis@headertext}%
  \ifdim\wd\@tempboxa>\textwidth
    \ClassWarning{研究生大论文模板}{Header too long; use a short section title or thesisheader}%
    \resizebox{\textwidth}{!}{\box\@tempboxa}%
  \else\box\@tempboxa\fi}
\renewcommand{\sectionmark}[1]{\markboth{\thesection.#1}{}}
\newcommand{\thesis@at}[3]{\put(#1,-#2){\makebox[0pt][l]{#3}}}
% #1左x #2上y #3长度 #4厚度；rule底需下降厚度，故y是横线上缘。
\newcommand{\thesis@rule}[4]{%
  \put(#1,\dimexpr-#2bp-#4bp\relax){\rule{#3bp}{#4bp}}}
\AddToShipoutPictureFG{\AtPageUpperLeft{\setlength{\unitlength}{1bp}%
  \ifnum\thesis@pagekind>0\relax
    \thesis@at{85.08}{790.38}{\makebox[439.44bp][c]{%
      \normalfont\rmfamily\mdseries\fontsize{9bp}{12bp}\selectfont\thepage}}%
  \fi
  \ifnum\thesis@pagekind=2\relax
    \thesis@at{85.08}{53.10}{\makebox[439.44bp][c]{%
      \normalfont\songti\mdseries\fontsize{10.5bp}{12bp}\selectfont\xeCJKsetup{CJKecglue={}}\thesis@fitheader}}%
    \thesis@rule{83.58}{57.12}{442.38}{0.72}%
  \fi
}}
\pagestyle{plain}

% 兼容上一版titletoc写入的旧目录结束标记，下一次编译会自动重建。
\providecommand{\contentsfinish}{}
% ---------- 自动目录：可任意条目数、自然分页，不指定任何页码 ----------
% 逐条固定23.4bp，不再调用会覆盖baselineskip的zihao；每条允许正常分页。
% 目录专用strut高16.02、深7bp（留0.38bp舍入余量，避免触发lineskip）；
% 默认0.7倍支架高16.38会压过topskip，造成续页baseline=101.46。
% 此处高度与topskip同取16.02，得101.10，后续保持23.4bp。
\newcommand{\thesis@tocline}[5]{%
  \ifnum#1>\c@tocdepth\else
    \par\addpenalty{0}\begingroup
      \normalfont\songti\fontsize{12bp}{\thesis@tocleading}\selectfont #3%
      \setbox\strutbox=\hbox{\vrule width0pt height16.02bp depth7bp}%
      % 仅目录右制表位438.84bp（Word约438.85），不改正文版心。
      \leftskip=#2bp\relax\rightskip=24.6bp\parfillskip=-24bp
      \parindent=0pt\parskip=0pt\interlinepenalty=10000
      \def\thesis@tocgap{\ifnum#1=1 3\else6\fi}%
      \def\numberline##1##2{\settowidth{\@tempdima}{##1\thesis@numbergap{\thesis@tocgap}{##2}}%
        \global\hangindent=\@tempdima\global\hangafter=1
        ##1\thesis@numbergap{\thesis@tocgap}{##2}##2}%
      \noindent\strut #4\nobreak
      % 一级同源稿：标题后首点约120bp，点及页码继承粗体；二三级不改。
      \ifnum#1=1 \hspace{1.92bp}\hbox{\rmfamily.}\else\hspace{3bp}\fi
      \leaders\hbox{\rmfamily\fontsize{12bp}{23.4bp}\selectfont.}\hfill
      \nobreak\hbox{#5}\strut\par
      \global\hangindent=0pt\global\hangafter=1
    \endgroup
  \fi
}
\renewcommand{\l@section}[2]{\thesis@tocline{1}{0}{\bfseries}{#1}{#2}}
\renewcommand{\l@subsection}[2]{\thesis@tocline{2}{21}{\mdseries}{#1}{#2}}
\renewcommand{\l@subsubsection}[2]{\thesis@tocline{3}{42}{\mdseries}{#1}{#2}}
\newcommand{\thesistableofcontents}{%
  \clearpage\begingroup\pagestyle{empty}\thispagestyle{empty}%
    \phantomsection\pdfbookmark[1]{目录}{contents}%
    \normalfont\songti\fontsize{12bp}{23.4bp}\selectfont\parskip=0pt\topskip=16.02bp
    \thesis@flowtitle{114.24}{\normalfont\heiti\mdseries\fontsize{16bp}{20bp}\selectfont}%
      {\hfil 目\hspace{16bp}录\hfil}{33.6}%
    \@starttoc{toc}\par\clearpage
  \endgroup
}
\renewcommand{\tableofcontents}{\thesistableofcontents}

% ---------- 图表题、子图与续图 ----------
\DeclareCaptionFont{thesissong}{\normalfont\songti\mdseries\fontsize{10.5bp}{20bp}\selectfont}
\DeclareCaptionFont{thesiscaption}{\normalfont\kaishu\mdseries\fontsize{10.5bp}{20bp}\selectfont}
% 仅改基线，不替换当前字体/表题专用strut。
\DeclareCaptionFont{thesiscaptionsingle}{\baselineskip=12bp\relax}
\DeclareCaptionFont{thesistablecaption}{\normalfont\kaishu\mdseries
  \fontsize{10.5bp}{20bp}\selectfont
  \setbox\strutbox=\hbox{\vrule width0pt height8.4bp depth2.1bp}}
\captionsetup{font=thesiscaption,labelfont=md,textfont=md,labelsep=space,
  justification=centering,singlelinecheck=false,strut=true}
\captionsetup[figure]{position=bottom,aboveskip=0bp,belowskip=7.8bp}
% top模式交换上下skip：Word段前放belowskip。
% 独立末行支架使不同题名的基线到顶线墨迹约4bp；多行仍为20磅。
\captionsetup[table]{position=top,font=thesistablecaption,
  aboveskip=1.9bp,belowskip=7.8bp,strut=true}
\captionsetup[sub]{font=thesiscaption,labelfont=md,textfont=md,
  labelformat=parens,labelsep=space,skip=0bp,list=false}
\renewcommand{\thesubfigure}{\alph{subfigure}}
\renewcommand{\thesubtable}{\alph{subtable}}
% 局部调用（放在figure/table的分组内）；也可直接captionsetup覆盖各项。
\newcommand{\thesiscaptionsingle}{\captionsetup{font+=thesiscaptionsingle}}
% Word段前/段后独立于表题末行strut与1.9bp顶线几何校准。
% table top模式交换skip；figure bottom模式不交换。须在对应浮动环境内调用。
\newcommand{\thesiscaptionparagraphspacing}[2]{%
  \ifdefstring{\@captype}{table}{%
    \captionsetup{belowskip=#1bp,aboveskip=\dimexpr1.9bp+#2bp\relax}%
  }{\captionsetup{aboveskip=#1bp,belowskip=#2bp}}}
\newcommand{\thesiscaptionzeroskip}{\thesiscaptionparagraphspacing{0}{0}}
% 内部单倍行距、段前后距、成稿最小行高分别保存，不用arraystretch替代。
\newcommand{\thesis@cellbefore}{3.1bp}
\newcommand{\thesis@cellafter}{3.1bp}
\newcommand{\thesis@rowminimum}{19.8bp}
\newcommand{\thesistablecompact}{%
  \def\thesis@cellbefore{0bp}\def\thesis@cellafter{0bp}\def\thesis@rowminimum{12bp}}
\newcommand{\thesistablenormal}{%
  \def\thesis@cellbefore{3.1bp}\def\thesis@cellafter{3.1bp}\def\thesis@rowminimum{19.8bp}}
\newcommand{\thesiscaptionstyle}[1]{\captionsetup{#1}}
% caption/subcaption原生ContinuedFloat保留：续图沿用主号及子图计数。
\counterwithin{figure}{section}
\counterwithin{table}{section}
\numberwithin{equation}{section}
\renewcommand{\thefigure}{\thesection-\arabic{figure}}
\renewcommand{\thetable}{\thesection-\arabic{table}}
\renewcommand{\theequation}{\thesection-\arabic{equation}}
\setlength{\heavyrulewidth}{1.5bp}
\setlength{\lightrulewidth}{1bp}
\setlength{\tabcolsep}{5.4bp}
\newcommand{\thesis@tablefont}{\normalfont\songti\mdseries
  \fontsize{10.5bp}{12bp}\selectfont\renewcommand{\arraystretch}{1}%
  \setlength{\aboverulesep}{0bp}\setlength{\belowrulesep}{0bp}%
  \@tempdima=\dimexpr12bp+\thesis@cellbefore+\thesis@cellafter\relax
  \ifdim\@tempdima<\thesis@rowminimum\relax\@tempdima=\thesis@rowminimum\relax\fi
  \advance\@tempdima by -12bp\divide\@tempdima by 2
  \setbox\strutbox=\hbox{\vrule width0pt
    height\dimexpr8.4bp+\@tempdima\relax depth\dimexpr3.6bp+\@tempdima\relax}%
  % array/longtable原生首尾支架保留基线对齐，不能在vtop首部插vskip。
  % 内部自动换行仍12磅；单元格内另起段落时才计段后+段前。
  \appto\@arrayparboxrestore{%
    \baselineskip=12bp\parskip=\dimexpr\thesis@cellbefore+\thesis@cellafter\relax}}
\AtBeginEnvironment{tabular}{\thesis@tablefont}
\AtBeginEnvironment{tabular*}{\thesis@tablefont}
\AtBeginEnvironment{longtable}{\thesis@tablefont}
% 不改写hline/cline/cmidrule，允许保留源稿分组线和局部例外。
\setlist{nosep}
\setlist[enumerate]{leftmargin=24bp}

% ---------- 文后标题与natbib列表 ----------
% 可选参数是纸张左上origin的baseline数值（bp），不是段前vspace。
\NewDocumentCommand{\thesisbacksection}{O{116.70} m}{%
  \clearpage\thesis@bodyfont\parindent=24bp
  \let\thesis@headeroverride\@empty
  \phantomsection\def\@currentlabelname{#2}%
  \addcontentsline{toc}{section}{#2}\markboth{#2}{}%
  \thesis@flowtitle{#1}{\normalfont\heiti\mdseries\fontsize{15bp}{20bp}\selectfont}%
    {\hfil\thesis@backtitletext{#2}\hfil}{35.6}\ignorespaces
}
\renewcommand{\bibsection}{\thesisbacksection[136.68]{参考文献}}
\newcommand{\thesis@backtitletext}[1]{%
  \ifstrequal{#1}{参考文献}{参\hspace{7.5bp}考\hspace{7.5bp}文\hspace{7.5bp}献}{%
  \ifstrequal{#1}{致谢}{致\hspace{15bp}谢}{#1}}}
% 书目独立plain；最小同文试验CCT/plain坐标相同，空白不靠正文压缩继承。
\renewcommand{\bibfont}{\normalfont\songti\mdseries\fontsize{10.5bp}{20bp}\selectfont\frenchspacing\xeCJKsetup{PunctStyle=plain}}
% BST显式分块：消掉行末空格再加入普通词距，避免natbib newblock额外.11em。
% 源中文书目分块及作者逗号后为两词距；西文为一词距，不按条目追坐标。
\newcommand{\thesisbibblock}[1]{%
  \unskip\space\ifstrequal{#1}{zh}{\space}{}\ignorespaces}
\setlength{\bibhang}{21bp}
\setlength{\bibsep}{0pt}
% natbib在bibsection之后才建立list；只改其setup，不在环境开始hook中分页。
% 内容x=85.08+21=106.08；按源稿列表设置，[1]墨迹左缘约79bp。
\renewcommand{\NAT@bibsetnum}[1]{%
  \setlength{\leftmargin}{21bp}\setlength{\rightmargin}{0pt}%
  \setlength{\labelwidth}{27bp}\setlength{\labelsep}{14.88bp}%
  \setlength{\itemindent}{0pt}\setlength{\listparindent}{0pt}%
  \setlength{\topsep}{0pt}\setlength{\partopsep}{0pt}%
  \setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}%
  \def\makelabel##1{\hss\llap{##1}}%
}

% ---------- 论文信息：保留所有旧宏（包括历史拼写） ----------
\newcommand{\thesistitle}[1]{\def\@thesistitle{#1}}
\newcommand{\thesisenglishtitle}[1]{\def\@thesisenglishtitle{#1}}
\newcommand{\thesisid}[1]{\def\@thesisid{#1}}
\newcommand{\thesisauthor}[1]{\def\@thesisauthor{#1}}
\newcommand{\thesisenglishtauthor}[1]{\def\@thesisenglishtauthor{#1}}
\newcommand{\thesissupervisor}[1]{\def\@thesissupervisor{#1}}
\newcommand{\thesismajor}[1]{\def\@thesismajor{#1}}
\newcommand{\thesisresearch}[1]{\def\@thesisresearch{#1}}
\newcommand{\thesisdegree}[1]{\def\@thesisdegree{#1}}
\newcommand{\thesisdate}[1]{\def\@thesisdate{#1}}
\newcommand{\thesisenglishtdiscipline}[1]{\def\@thesisenglishtdiscipline{#1}}
\newcommand{\thesisenglishsupervisor}[1]{\def\@thesisenglishsupervisor{#1}}
\newcommand{\thesisenglishdate}[1]{\def\@thesisenglishdate{#1}}
\let\thesisenglishauthor\thesisenglishtauthor
\let\thesisenglishdiscipline\thesisenglishtdiscipline
\def\@thesistitle{论文题目}\def\@thesisenglishtitle{Thesis Title}
\def\@thesisid{学生学号}\def\@thesisauthor{学生姓名}\def\@thesisenglishtauthor{Your Name}
\def\@thesissupervisor{导师姓名}\def\@thesismajor{专业名称}
\def\@thesisresearch{研究方向}\def\@thesisdegree{学术型学位}
\def\@thesisdate{填写年月}\def\@thesisenglishtdiscipline{Your Major}
\def\@thesisenglishsupervisor{Supervisor Name}\def\@thesisenglishdate{Month, Year}
% 封面可配置项：论文类型与五个信息项名称（默认按原硕士论文）。
\def\@thesistype{硕士学位论文}
\def\@thesislabauthor{研究生姓名}\def\@thesislabsupervisor{指导教师姓名}
\def\@thesislabdegree{申请学位类别}\def\@thesislabmajor{学科、专业名称}
\def\@thesislabresearch{研究方向}
\newcommand{\thesistype}[1]{\def\@thesistype{#1}}
\newcommand{\thesislabauthor}[1]{\def\@thesislabauthor{#1}}
\newcommand{\thesislabsupervisor}[1]{\def\@thesislabsupervisor{#1}}
\newcommand{\thesislabdegree}[1]{\def\@thesislabdegree{#1}}
\newcommand{\thesislabmajor}[1]{\def\@thesislabmajor{#1}}
\newcommand{\thesislabresearch}[1]{\def\@thesislabresearch{#1}}

% ---------- 中文/英文封面：真正 baseline 定位 ----------
% 分散对齐采用“实测字宽 + 等间距”实现，不用 \hfil 拉伸，避免 Underfull 警告。
\ExplSyntaxOn
\box_new:N \l__thesis_dist_box
\dim_new:N \l__thesis_dist_gap_dim
\dim_new:N \l__thesis_typewidth_dim
\int_new:N \l__thesis_dist_cnt_int
\cs_new_protected:Npn \__thesis_distribute:nn #1#2
  {
    \hbox_set:Nn \l__thesis_dist_box {#2}
    \int_set:Nn \l__thesis_dist_cnt_int {\tl_count:n {#2}}
    \int_compare:nNnTF {\l__thesis_dist_cnt_int} > {1}
      {\dim_set:Nn \l__thesis_dist_gap_dim
        {(#1 - \box_wd:N \l__thesis_dist_box)/(\l__thesis_dist_cnt_int-1)}}
      {\dim_zero:N \l__thesis_dist_gap_dim}
    \dim_compare:nNnT {\l__thesis_dist_gap_dim} < {0bp}
      {\dim_zero:N \l__thesis_dist_gap_dim}
    \hbox_to_wd:nn {#1}
      {\tl_map_inline:nn {#2}{##1\hskip\l__thesis_dist_gap_dim}\unskip\hfil}
  }
% 参数先展开再逐字拉开，否则传入的命令宏会被当成单个条目。
\cs_new_protected:Npn \thesis@distribute #1#2
  {\exp_args:Nne \__thesis_distribute:nn {#1} {#2}}
\cs_new_protected:Npn \thesiscoverlabel #1 {\thesis@distribute{133.6bp}{#1}}
% 类型行按可见字形而非尾随空格测量：默认213.07bp、中心304.715bp。
\cs_new_protected:Npn \__thesis_type:n #1
  {
    \int_set:Nn \l__thesis_dist_cnt_int {\tl_count:n {#1}}
    \dim_set:Nn \l__thesis_typewidth_dim
      {\dim_max:nn {213.07bp}
        {25bp*(\int_use:N \l__thesis_dist_cnt_int)
         + 12.61bp*(\int_use:N \l__thesis_dist_cnt_int - 1)}}
    \__thesis_distribute:nn {\l__thesis_typewidth_dim} {#1}
  }
\cs_new_protected:Npn \thesistypelabel #1 {\exp_args:Ne \__thesis_type:n {#1}}
\ExplSyntaxOff
% 旧三参数接口继续有效；横线统一采用原PDF上缘坐标。
\newcommand{\thesiscoverrow}[3]{%
  \thesis@at{134.4}{#1}{\normalfont\fangsong\fontsize{16bp}{16bp}\selectfont\thesiscoverlabel{#2}}%
  \thesis@at{273.48}{#1}{\makebox[186.72bp][c]{\normalfont\fangsong\fontsize{16bp}{16bp}\selectfont #3}}%
  \put(273.48,\dimexpr-#1bp-6.90bp-0.48bp\relax){\rule{207bp}{0.48bp}}%
}
% 英文题首行相对后续行偏右15.06bp；其余中心取原PDF各块实测值。
\newcommand{\thesis@englishcover}{%
  \thispagestyle{empty}%
  \AddToShipoutPictureFG*{\AtPageUpperLeft{\setlength{\unitlength}{1bp}%
    \thesis@at{85.08}{126.30}{\parbox[t]{439.44bp}{%
      \normalfont\rmfamily\bfseries\fontsize{15bp}{31.2bp}\selectfont
      \centering\parindent=0pt\@thesisenglishtitle\par}}%
    \thesis@at{107.148}{229.26}{\makebox[439.44bp][c]{\normalfont\rmfamily\fontsize{15bp}{20bp}\selectfont\spaceskip=7.5bp\relax A Dissertation Submitted to}}%
    \thesis@at{107.151}{260.46}{\makebox[439.44bp][c]{\normalfont\rmfamily\bfseries\fontsize{15bp}{20bp}\selectfont\spaceskip=7.5bp\relax Changzhou University}}%
    \thesis@at{104.18}{305.40}{\makebox[439.44bp][c]{\normalfont\rmfamily\bfseries\fontsize{12bp}{20bp}\selectfont By}}%
    \thesis@at{103.843}{352.50}{\makebox[439.44bp][c]{\normalfont\rmfamily\bfseries\fontsize{15bp}{20bp}\selectfont\spaceskip=7.5bp\relax\@thesisenglishtauthor}}%
    \thesis@at{100.106}{383.70}{\makebox[439.44bp][c]{\normalfont\rmfamily\bfseries\fontsize{15bp}{20bp}\selectfont\spaceskip=7.5bp\relax\@thesisenglishtdiscipline}}%
    \thesis@at{100.063}{497.58}{\makebox[439.44bp][c]{\normalfont\rmfamily\mdseries\fontsize{15bp}{20bp}\selectfont\spaceskip=7.5bp\relax\frenchspacing Dissertation Supervisor: \@thesisenglishsupervisor}}%
    \thesis@at{106.14}{590.82}{\makebox[439.44bp][c]{\normalfont\rmfamily\mdseries\fontsize{14bp}{20bp}\selectfont\@thesisenglishdate}}%
  }}\null\clearpage
}
\newcommand{\makecover}{%
  \clearpage\begingroup\xeCJKsetup{PunctStyle=quanjiao}\pagestyle{empty}\thispagestyle{empty}%
  \AddToShipoutPictureFG*{\AtPageUpperLeft{\setlength{\unitlength}{1bp}%
    \thesis@at{377.52}{124.38}{\normalfont\fangsong\fontsize{14bp}{14bp}\selectfont 学号：}%
    \thesis@at{419.52}{124.38}{\makebox[104.94bp][c]{\normalfont\rmfamily\fontsize{14bp}{14bp}\selectfont\@thesisid}}%
    \thesis@rule{419.52}{125.88}{104.94}{0.66}%
    \thesis@at{232.92}{219.18}{\normalfont\heiti\bfseries\fontsize{26bp}{26bp}\selectfont 常\hspace{13.183bp}州\hspace{13.183bp}大\hspace{13.183bp}学}%
    \thesis@at{304.715}{265.62}{\makebox[0pt][c]{\normalfont\fangsong\bfseries\fontsize{25bp}{25bp}\selectfont\thesistypelabel{\@thesistype}}}%
    \thesis@at{85.08}{370.38}{\parbox[t]{439.44bp}{\centering
      \normalfont\heiti\mdseries\fontsize{22bp}{31.2bp}\selectfont\@thesistitle\par}}%
    \thesiscoverrow{493.56}{\@thesislabauthor}{\@thesisauthor}%
    \thesiscoverrow{524.40}{\@thesislabsupervisor}{\@thesissupervisor}%
    \thesiscoverrow{555.24}{\@thesislabdegree}{\@thesisdegree}%
    \thesiscoverrow{586.14}{\@thesislabmajor}{\@thesismajor}%
    \thesiscoverrow{616.98}{\@thesislabresearch}{\@thesisresearch}%
    \thesis@at{85.08}{696.90}{\makebox[439.44bp][c]{\normalfont\fangsong\fontsize{16bp}{20bp}\selectfont\@thesisdate}}%
  }}\null\clearpage\thesis@englishcover\endgroup
}

% ---------- 声明与授权：默认原文，可替换正文和签名文字 ----------
\newcommand{\thesisdeclaration}[1]{\long\def\thesis@declaration{#1}}
\newcommand{\thesisauthorization}[1]{\long\def\thesis@authorization{#1}}
\newcommand{\thesisconfidentiality}[1]{\long\def\thesis@confidentiality{#1}}
\newcommand{\thesisdeclarationsignature}[1]{\def\thesis@declarationsignature{#1}}
\newcommand{\thesisauthorizationsignature}[1]{\def\thesis@authorizationsignature{#1}}
\newcommand{\thesissupervisorsignature}[1]{\def\thesis@supervisorsignature{#1}}
\thesisdeclaration{本人郑重声明：所呈交的学位论文是本人在导师指导下独立进行的研究工作及取得的研究成果。除文中已经注明引用的内容外，本论文不含任何其他个人或集体已经发表或撰写过的作品成果。对本文的研究做出重要贡献的个人和集体，均已在论文中以明确方式标明。本人已完全意识到本声明的法律结果由本人承担。}
% 默认文字保留源稿内容与留白，使用普通段落自动换行。
\thesisauthorization{本学位论文作者完全了解\hspace*{14bp}常州大学\hspace*{14bp}有关保留、使用学位论文的规定，即：研究生在校攻读学位期间论文工作的知识产权单位属常州大学。学校有权保留并向国家有关部门或机构送交论文的复印件和磁盘，允许论文被查阅和借阅。学校可以公布学位论文的全部或部分内容，可以采用影印、缩印或扫描等复制手段保存、汇编本学位论文。}
\thesisconfidentiality{\xeCJKsetup{PunctStyle=quanjiao}保密论文注释：本学位论文属于保密范围，在\hspace*{35bp}年解密后适用本授权书。非保密论文注释：本学位论文不属于保密范围，适用本授权书。}
\thesisdeclarationsignature{作者签名：\hspace*{56bp}签字日期：\hspace*{28bp}年\hspace*{21bp}月\hspace*{21bp}日}
\thesisauthorizationsignature{学位论文作者签名：\hspace*{63bp}签字日期：\hspace*{35bp}年\hspace*{28bp}月\hspace*{28bp}日}
\thesissupervisorsignature{导师签名：\hspace*{119bp}签字日期：\hspace*{35bp}年\hspace*{28bp}月\hspace*{28bp}日}
\newcommand{\thesis@statementtitle}[2]{%
  \thesis@at{85.08}{#1}{\parbox[t]{439.44bp}{%
    \normalfont\heiti\bfseries\fontsize{18bp}{24bp}\selectfont
    \centering\parindent=36.15bp\indent #2\par}}}
\newcommand{\thesis@statementbody}[5]{%
  \thesis@at{85.08}{#1}{\parbox[t]{439.44bp}{%
    \normalfont\songti\fontsize{14bp}{#2bp}\selectfont\xeCJKsetup{PunctStyle=plain,CJKecglue={}}
    \parskip=0pt#4\parindent=#3bp\relax\indent #5\par}}}
\newcommand{\makeauthorization}{%
  \clearpage\begingroup\xeCJKsetup{PunctStyle=quanjiao}\pagestyle{empty}\thispagestyle{empty}%
  \AddToShipoutPictureFG*{\AtPageUpperLeft{\setlength{\unitlength}{1bp}%
    \thesis@statementtitle{123.839}{常州大学学位论文原创性声明}%
    \thesis@statementbody{160.50}{27.24}{32.22}{}{\thesis@declaration}%
    \thesis@at{134.10}{334.619}{\normalfont\songti\fontsize{14bp}{27.24bp}\selectfont\thesis@declarationsignature}%
    \thesis@rule{204.06}{336.12}{55.98}{0.66}%
    \thesis@statementtitle{400.440}{学位论文版权使用授权的说明}%
    \thesis@statementbody{453.900}{31.2}{28.02}{\raggedright}{\thesis@authorization}%
    \thesis@rule{274.02}{455.76}{70.02}{0.72}%
    \thesis@statementbody{609.902}{31.2}{28.02}{\raggedright}{\thesis@confidentiality}%
    \thesis@rule{391.44}{611.76}{35.04}{0.72}%
    \thesis@at{113.10}{687.66}{\normalfont\songti\fontsize{14bp}{31.2bp}\selectfont\thesis@authorizationsignature}%
    \thesis@rule{239.04}{689.52}{63.06}{0.72}%
    \thesis@at{113.10}{727.68}{\normalfont\songti\fontsize{14bp}{31.2bp}\selectfont\thesis@supervisorsignature}%
    \thesis@rule{183.06}{729.54}{105.00}{0.72}%
  }}\null\clearpage\endgroup
}

% 仅用于原稿逐行展示的样例工具：真实论文直接使用普通段落。
% s在可选缩进之后；带星号是段末，不拉伸字距。行盒可在页间自然拆分。
\NewDocumentCommand{\thesissampleline}{O{0} s m}{%
  \par\begingroup
  \vbox{\hbox to\linewidth{\vrule width0pt height12bp depth0pt\hskip#1bp
    \IfBooleanTF{#2}{#3\hfil}{\begingroup
      \spaceskip=\fontdimen2\font plus 1fill minus 3bp\xspaceskip=0pt
      \xeCJKsetup{CJKglue={\hskip0pt plus 1fill minus .5bp},CJKecglue={}}%
      #3\unskip\endgroup}}}\endgroup
}
% ---------- 摘要：正常可分页文本，不限定摘要页数 ----------
\newenvironment{chineseabstract}{%
  \clearpage\pagenumbering{Roman}\begingroup\pagestyle{plain}\thispagestyle{plain}%
  \normalfont\songti\fontsize{14bp}{\thesis@chineseabstractleading}\selectfont\parindent=28bp\parskip=0pt\emergencystretch=1em\topskip=14.16bp
  \xeCJKsetup{PunctStyle=plain,CJKecglue={}}
  \thesis@flowtitle{122.04}{\normalfont\heiti\bfseries\fontsize{16bp}{20bp}\selectfont}%
    {\hspace*{175.50bp}中\hspace{8bp}文\hspace{8bp}摘\hspace{8bp}要\hfil}{39.54}%
  \ignorespaces
}{\par\clearpage\endgroup}
\newenvironment{englishabstract}{%
  \clearpage\begingroup\pagestyle{plain}\thispagestyle{plain}%
  \normalfont\rmfamily\fontsize{14bp}{\thesis@englishabstractleading}\selectfont\frenchspacing\parindent=14bp\parskip=0pt\emergencystretch=1em\topskip=13.08bp
  \spaceskip=\fontdimen2\font plus7bp minus0bp\xspaceskip=0pt
  \hyphenpenalty=10000\exhyphenpenalty=10000\tolerance=2000\emergencystretch=2em
  \xeCJKsetup{PunctStyle=plain}
  \thesis@flowtitle{121.98}{\normalfont\rmfamily\bfseries\fontsize{16bp}{20bp}\selectfont}%
    {\hfil ABSTRACT\hfil}{38.52}%
  \ignorespaces
}{\par\clearpage\endgroup}
% Word关键词段前0；正文后是一个空段：中文固定20磅，英文1.5倍。
% 用空行盒保留空段语义，关键词本身不再设置段前vspace。
\newcommand{\thesis@abstractblank}[1]{%
  \par\noindent\hbox{\vrule width0pt height0pt depth0pt}\par\nobreak
  \vspace{\dimexpr#1-\baselineskip\relax}}
% 关键词继承对应摘要的行距。
\newcommand{\thesiskeywords}[1]{%
  \thesis@abstractblank{20bp}\begingroup\xeCJKsetup{PunctStyle=plain}%
  \rightskip=-4bp
  \noindent\makebox[54.18bp][l]{{\heiti\bfseries 关键词}{\heiti\bfseries\fontsize{12bp}{27.24bp}\selectfont ：}}{\songti\mdseries #1}\par\endgroup}
\newcommand{\thesisenglishkeywords}[1]{%
  \thesis@abstractblank{\thesis@englishabstractleading}\noindent
  {\rmfamily\bfseries KEY WORDS:}\hspace{5.17bp}{\rmfamily\mdseries #1}\par}
\newcommand{\mainmatter}{%
  \clearpage\pagenumbering{arabic}\setcounter{page}{1}%
  \thesis@bodyfont\parindent=24bp\parskip=0pt\pagestyle{thesis}}
\makeatother
\endinput
