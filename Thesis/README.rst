========================
LaTeX sources for thesis
========================

This thesis is based upon Laursen's XeLaTeX thesis template, which can be found
at bitbucket.org <https://bitbucket.org/_laursen/laursens-xelatex-thesis-template/>`_.

Most of this readme is from the readme included in the template mentioned above,
but adjusted to fit my needs.

Requirements
============

Standard (>2014) TeX Live package including XeLaTeX and Biblatex.

Fonts
-----
The template uses the sans serif font `TeX Gyre Adventor
<http://www.ctan.org/tex-archive/fonts/tex-gyre>`_, which is contained in TeXLive and MiKTeX installation
by default so no extra setup is necessary.

Note that `Neo Sans <http://www.monotype.co.uk/neosans/>`_ font (DTU's main font) is the ultimative font
for headings. A similar font called Neo Sans Intel is also a good alternative which typically contains
more symbols. If the Neo Sans (Intel) font are installed on your system (un)comment the respective lines
in ``preamble/fonts.tex``.

Usage
=====

Manual typesetting
------------------

Run the following for manual typesetting the document::

 xelatex Thesis.tex
 biber Thesis.bcf
 xelatex Thesis.tex
 xelatex Thesis.tex

make(file)
----------

With the templates comes a ``Makefile`` using ``latexmk`` for easy compiling. There are two ways to use make either by::

 make

or the ``auto`` mode which automatic updates the pdf if \*.tex or \*.bib files are changed::

 make auto

To clean up project run::

 make clean

TextMate
--------
If using TextMate simply press "⌘R".

Remember to run Biblatex too.

TexStudio
--------
Open preferences and set

* Under "Editor" set "Editor Font Encoding" to "UFT8"
* Under "Build" set "Default Compiler" to "XeLaTeX"

Texmaker
--------

Setup
,,,,,

Open Preferences and ensure under "Editor" that "Editor Font Encoding" is set to::

 UTF-8

In Preferences under "Quick Build" change it to "User" and the following.

* For Windows users::
 ???
* For Mac users::
 "/usr/texbin/xelatex" -synctex=1 -interaction=nonstopmode %.tex|"/usr/texbin/biber" %.bcf|"/usr/texbin/xelatex" -synctex=1 -interaction=nonstopmode %.tex|"/usr/texbin/xelatex" -synctex=1 -interaction=nonstopmode %.tex|open %.pdf

Typesetting
,,,,,,,,,,,

Simply press "Quick Build". This will run all necessary commands including setting up your bibliography if there are any changes to it.

If the bibliography is not changed only ``xelatex`` needs to run one single time. You can therefore select XeLaTeX from the run menu instead of the default in Quick build.

