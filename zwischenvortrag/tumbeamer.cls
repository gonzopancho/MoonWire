%
% tumbeamer.cls
%

%----------------------------------------------------------------------
% Identify class
%
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{tumbeamer}%
    [2016/04/28 v0.2 %
    tumbeamer.cls presentation class based on beamer.cls]

%----------------------------------------------------------------------
% Class options
%
\newif\iftumbeamer@lecture%
\DeclareOption{beamer}{\tumbeamer@lecturefalse}%
\DeclareOption{lecture}{\tumbeamer@lecturetrue}%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{beamer}}%
\DeclareOption*{\PassOptionsToPackage{\CurrentOption}{tumlang}}%
\ExecuteOptions{beamer}%
\ProcessOptions\relax


% switch between darker and normal tumblue
\def\tumbeamer@basecolor{TUMBlue}
\newlength{\tumbeamer@logoheight}
\iftumbeamer@lecture
	\setlength{\tumbeamer@logoheight}{4mm}
\else
	\setlength{\tumbeamer@logoheight}{4.5mm}
\fi
\def\tumbeamer@sep{\quad--\quad}

\LoadClass{beamer}
\RequirePackage{tumcolor}
\RequirePackage{tumcontact}
\RequirePackage{tumlang}
\RequirePackage{xparse}
\RequirePackage{totcount}
\RequirePackage{caption}

%----------------------------------------------------------------------
% Setup font sizes
%
\iftumbeamer@lecture
	\renewcommand{\huge}{\fontsize{13}{15}\selectfont}
	\renewcommand{\LARGE}{\fontsize{11}{15}\selectfont}
	\renewcommand{\Large}{\fontsize{9}{13}\selectfont}
	\renewcommand{\large}{\fontsize{8}{11}\selectfont}
	\renewcommand{\normalsize}{\fontsize{7}{9}\selectfont}
	\renewcommand{\small}{\fontsize{6}{9}\selectfont}
	\renewcommand{\footnotesize}{\fontsize{5}{7}\selectfont}
	\renewcommand{\scriptsize}{\fontsize{4}{6}\selectfont}
	\renewcommand{\tiny}{\fontsize{3}{4}\selectfont}
\else
%	\renewcommand{\huge}{\fontsize{15}{17}\selectfont}
%	\renewcommand{\LARGE}{\fontsize{13}{17}\selectfont}
%	\renewcommand{\Large}{\fontsize{11}{15}\selectfont}
%	\renewcommand{\large}{\fontsize{10}{13}\selectfont}
%	\renewcommand{\normalsize}{\fontsize{9}{11}\selectfont}
%	\renewcommand{\small}{\fontsize{8}{11}\selectfont}
%	\renewcommand{\footnotesize}{\fontsize{7}{9}\selectfont}
%	\renewcommand{\scriptsize}{\fontsize{6}{8}\selectfont}
%	\renewcommand{\tiny}{\fontsize{5}{6}\selectfont}
\fi
\let\Tiny=\tiny

% avoid token not allowed in pdf warnings
\pdfstringdefDisableCommands{\def\kern#1{}}

%----------------------------------------------------------------------
% Setup figure captions
%
\DeclareCaptionLabelFormat{tumbeamer}{%
	\footnotesize%
	\textcolor{\tumbeamer@basecolor}{#1 #2:}\hskip1ex}%
\captionsetup{%
	font=footnotesize,
	labelsep=none,
	labelformat=tumbeamer,
}

%----------------------------------------------------------------------
% Configure beamer templates
%
\beamertemplatenavigationsymbolsempty
\usetheme{default}
\usefonttheme{professionalfonts}

\setbeamersize{%
	text margin left=\tumbeamer@logoheight,
	text margin right=\tumbeamer@logoheight,
}

% Set margins before/after math mode environments
\setlength{\abovedisplayskip}{1ex}
\setlength{\belowdisplayskip}{1ex}
\setlength{\abovedisplayshortskip}{.5ex}
\setlength{\belowdisplayshortskip}{.5ex}
\setlength{\topsep}{.5ex}
\setlength{\partopsep}{.5ex}

\setlength{\footnotesep}{0pt}
\setlength{\textfloatsep}{0pt}
\setlength{\floatsep}{0pt}
\setlength{\intextsep}{0pt}
\setlength{\belowcaptionskip}{0pt}
\setlength{\parskip}{1ex}
\renewenvironment{center}
	{\setlength{\parskip}{1ex}\par\nopagebreak\centering}
	{\par\noindent}
\newcommand{\justify}{%
	\setlength{\leftskip}{0pt}%
	\setlength{\rightskip}{0pt}%
	\setlength{\parfillskip}{0pt plus 1fil}%
}
\AtBeginDocument{\justify}
\let\tumbeamer@origitem\item
\renewcommand{\item}{%
	\@ifnextchar <{\tumbeamer@item@angle}{%
		\@ifnextchar [{\tumbeamer@item@bracket}{%
			\tumbeamer@origitem\justify%
		}%
	}%
}%
\def\tumbeamer@item@angle<#1>{%
	\@ifnextchar [{\tumbeamer@item@anglebracket<#1>}{%
		\tumbeamer@origitem<#1>\justify%
	}%
}%
\def\tumbeamer@item@bracket[#1]{\tumbeamer@origitem[#1]\justify}
\def\tumbeamer@item@anglebracket<#1>[#2]{\tumbeamer@origitem<#1>[#2]\justify}

\setbeamerfont{frametitle}{size=\Large}
\setbeamerfont{framesubtitle}{size=\small}
%\setbeamerfont{footnote}{size=\footnotesize}
\setbeamerfont{footline}{size=\scriptsize}
\setbeamerfont{footnote}{size=\tiny}

\iftumbeamer@lecture
	\setbeamercolor{structure}{fg=\tumbeamer@basecolor}
\else
	\setbeamercolor{structure}{fg=black}
\fi

\setbeamertemplate{itemize items}[circle]

\setbeamertemplate{frametitle}{\insertframetitle}

\defbeamertemplate{headline}{tumheadline}{%
	\vspace*{\tumbeamer@logoheight}%
	\hspace*{\tumbeamer@logoheight}{\Large\strut}%
	\TUMheader[\tumbeamer@basecolor]{\tumbeamer@logoheight}%
	\hspace*{\tumbeamer@logoheight}%
	\vspace{\tumbeamer@logoheight}%
	\Large%FIXME
	\vspace{-\baselineskip}%
	\vspace{1em}%
}%

\defbeamertemplate{footline}{tumfootline}{%
	\hspace{\tumbeamer@logoheight}%
	\hfill\insertshortauthor\tumbeamer@sep\insertshorttitle%
	\makebox[2.897\tumbeamer@logoheight]{%
		\hfill\bfseries\insertframenumber\hspace{\tumbeamer@logoheight}%
	}%
	\vspace{\tumbeamer@logoheight}%
	\vspace{-\baselineskip}%
}%

\defbeamertemplate{headline}{lectureheadline}{%
	\vspace*{\tumbeamer@logoheight}%
	\hspace*{\tumbeamer@logoheight}{\Large\strut}%
	\ifnum\c@part<0%
		\TUMheader[\tumbeamer@basecolor]{\tumbeamer@logoheight}%
	\else%
		\ifnum\c@section=0%
		\textcolor{\tumbeamer@basecolor}{%
			\Large\chaptername~\thepart: \insertpart%
		}%
		\else%
			\ifnum\c@subsection=0%
				\textcolor{\tumbeamer@basecolor}{\Large\insertsection}%
			\else%
				\textcolor{\tumbeamer@basecolor}{\large\insertsubsection}%
			\fi%
		\fi%
		\hfill%
		\TUMLogo[\tumbeamer@basecolor]{\tumbeamer@logoheight}%
	\fi%
	\hspace*{\tumbeamer@logoheight}%
	\vspace{\tumbeamer@logoheight}%
	\Large%FIXME
	\vspace{-\baselineskip}%
	\vspace{1em}%
	%FIXME
	\vspace{-\baselineskip}\vspace{1ex}%
}%

\defbeamertemplate{footline}{lecturefootline}{%
	\hspace{\tumbeamer@logoheight}%
	\hfill\chaptername~\thepart: \insertpart%
	\ifnum\c@section=0%
	\else%
		\tumbeamer@sep\insertsection%
	\fi%
	\makebox[2.897\tumbeamer@logoheight]{%
		\hfill\insertframenumber\hspace{\tumbeamer@logoheight}%
	}%
	\vspace{\tumbeamer@logoheight}%
	\vspace{-\baselineskip}%
}%

\iftumbeamer@lecture
	\setbeamertemplate{headline}[lectureheadline]
	\setbeamertemplate{footline}[lecturefootline]
\else
	\setbeamertemplate{headline}[tumheadline]
	\setbeamertemplate{footline}[tumfootline]
\fi


\@addtoreset{section}{part}
\@addtoreset{subsection}{section}
\iftumbeamer@lecture
	\setcounter{part}{-1}
	\@addtoreset{framenumber}{part}
	\renewcommand{\insertframenumber}{\arabic{part}-\arabic{framenumber}}
\fi

%----------------------------------------------------------------------
% Document commands
%

\def\thelecture{}
\def\theshortlecture{}
\def\themodule{}
\def\thesemester{}
\def\thelecturer{}
\def\tumbeamer@assistants{}
\ifdefined\chairhead
	\def\thelecturer{\chairhead}
\fi

\DeclareDocumentCommand{\lecture}{O {} m}{%
	\edef\theshortlecture{#1}%
	\edef\thelecture{#2}%
}

\DeclareDocumentCommand{\module}{m}{%
	\edef\themodule{#1}%
}

\DeclareDocumentCommand{\semester}{m}{%
	\edef\thesemester{#1}%
}

\DeclareDocumentCommand{\lecturer}{m}{%
	\edef\thelecturer{#1}%
}

\newcounter{tumbeamer@assistants@cnt}
\regtotcounter{tumbeamer@assistants@cnt}

\DeclareDocumentCommand{\assistants}{m}{%
	\def\tumbeamer@assistants{#1}
	\setcounter{tumbeamer@assistants@cnt}{0}
	\foreach \b in \tumbeamer@assistants {%
		\stepcounter{tumbeamer@assistants@cnt}
	}
	\edef\theassistantscount{\thetumbeamer@assistants@cnt}
}

\DeclareDocumentCommand{\theassistants}{o}{%
	\setcounter{tumbeamer@assistants@cnt}{1}
	\foreach \b in \tumbeamer@assistants {%
		\IfNoValueTF{#1}{%
			\ifnum\thetumbeamer@assistants@cnt>1%
				,\ %
			\fi
			\b%
		}{%
			\ifnum\thetumbeamer@assistants@cnt=#1%
				\b%
			\fi%
		}%
		\stepcounter{tumbeamer@assistants@cnt}%
	}
}

\DeclareDocumentCommand{\paragraph}{s m}{%
	\textbf{#2}%
	\IfBooleanTF #1{}{\smallskip\\}%
}

%----------------------------------------------------------------------
% Special frames
%
\DeclareDocumentCommand{\tumbeamer@beamer@titleframe}{}{
	\setbeamertemplate{footline}{}
	\begin{frame}[c]
		\centering%
		\Large%
		\strut\textcolor{\tumbeamer@basecolor}{\inserttitle}%
		\\[1ex]
		\footnotesize%
		\insertsubtitle%
		\normalsize%
		\\[4ex]%
		\bfseries\strut\insertauthor\normalfont%
		\\[2ex]%
		\footnotesize%
		%\today%
		\insertdate%
		\\[4ex]%
		\ifdefined\departmentname%
			\ifdefined\chairname%
				\chairname\\%
			\fi%
			\departmentname\\%
		\fi%
		\TUMname\\%
	\end{frame}
	\setbeamertemplate{footline}[tumfootline]
}

\DeclareDocumentCommand{\tumbeamer@beamer@contentframe}{}{
%	\begin{frame}
%		\frametitle{\contentsname}
%		\tableofcontents
%	\end{frame}
}


\DeclareDocumentCommand{\tumbeamer@lecture@titleframe}{}{%
	\setbeamertemplate{footline}{}%
	\begin{frame}[c]%
		\centering%
		\color{\tumbeamer@basecolor}%
		\LARGE%
		\strut\thelecture%
		\ifx\theshortlecture\empty\else%
			\ (\theshortlecture)%
		\fi%
		\\[1ex]%
		\large%
		\strut\ifx\themodule\empty\else%
			\themodule{}%
			\ifx\thesemester\empty\else%
				\ --\ %
			\fi%
		\fi%
		\ifx\thesemester\empty\else%
			\thesemester%
		\fi%
		\\[4ex]%
		\color{black}%FIXME choose beamer default fg color
		\bfseries\strut\thelecturer\normalfont%
		\\[4ex]%
		\strut\theassistants%
		\\[4ex]%
		\normalsize%
		\ifdefined\departmentname%
			\ifdefined\chairname%
				\chairname\\%
			\fi%
			\departmentname\\%
		\fi%
		\TUMname\\%
	\end{frame}%
	\setbeamertemplate{footline}[lecturefootline]%
}

\DeclareDocumentCommand{\tumbeamer@lecture@partframe}{}{%
	\begin{frame}[allowframebreaks]%
		\def\vfill{\vspace{1.5em}}%
		\let\tumbeamer@origbeamer@sectionintoc\beamer@sectionintoc%
		\def\beamer@sectionintoc{%
			\penalty-1000\tumbeamer@origbeamer@sectionintoc%
		}%
		\tableofcontents%
	\end{frame}%
}

\newcount\tumbeamer@c@section@save
\DeclareDocumentCommand{\tumbeamer@lecture@sectionframe}{}{%
	\tumbeamer@c@section@save\c@section%
	\begin{frame}%
		\tableofcontents[currentsection,hideothersubsections]%
		\global\c@section 0%
	\end{frame}%
	\c@section\tumbeamer@c@section@save%
}


\let\tumbeamer@origdocument\document%
\iftumbeamer@lecture%
	\def\document{\tumbeamer@origdocument\tumbeamer@lecture@titleframe}%

	\let\tumbeamer@origpart\part%
	\renewcommand{\part}[1]{%
		\tumbeamer@origpart{#1}\tumbeamer@lecture@partframe%
	}

	\let\tumbeamer@origsection\section
	\renewcommand{\section}[1]{%
		\tumbeamer@origsection{#1}\tumbeamer@lecture@sectionframe%
	}
\else%
	\def\document{%
		\tumbeamer@origdocument\tumbeamer@beamer@titleframe%
		\tumbeamer@beamer@contentframe%
	}%
\fi%

\endinput
