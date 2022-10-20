FROM archlinux:base-20221009.0.92802

RUN pacman -Syu --noconfirm

RUN pacman -S texlive-langjapanese \
    texlive-latexextra \
    ghostscript \
    git \
    curl \
    unzip --noconfirm

RUN git clone https://github.com/h-kitagawa/plistings.git \
    && mv /plistings/plistings.sty /usr/share/texmf-dist/tex/latex/listings/ \
    && mktexlsr

RUN curl -OL http://tug.ctan.org/tex-archive/macros/latex/contrib/algorithms.zip \ 
    && unzip algorithms.zip \
    && cd algorithms \
    && latex algorithms.ins \
    && cd .. \
    && mv algorithms /usr/share/texmf-dist/tex/latex/ \
    && mktexlsr

RUN curl -OL http://tug.ctan.org/tex-archive/macros/latex/contrib/algorithmicx.zip \
    && unzip algorithmicx.zip \
    && mv algorithmicx /usr/share/texmf-dist/tex/latex/ \
    && mktexlsr

WORKDIR /workdir
