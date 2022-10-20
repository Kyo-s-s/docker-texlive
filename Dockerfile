FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    texlive-lang-japanese \
    texlive-latex-extra \
    ghostscript \
    git \
    curl

RUN git clone https://github.com/h-kitagawa/plistings.git \
    && mv /plistings/plistings.sty /usr/share/texlive/texmf-dist/tex/latex/listings \
    && mktexlsr

RUN curl -OL http://tug.ctan.org/tex-archive/macros/latex/contrib/algorithms.zip \
    && unzip algorithms.zip \
    && cd algorithms \
    && latex algorithms.ins \
    && cd .. \
    && mv algorithms /usr/share/texlive/texmf-dist/tex/latex/ \
    && mktexlsr

RUN curl -OL http://tug.ctan.org/tex-archive/macros/latex/contrib/algorithmicx.zip \
    && unzip algorithmicx.zip \
    && mv algorithmicx /usr/share/texlive/texmf-dist/tex/latex/algorithms \
    && mktexlsr

WORKDIR /workdir
