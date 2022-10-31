FROM archlinux:base-20221009.0.92802

ARG USER_ID=1000
RUN useradd -m -u ${USER_ID} docker

RUN pacman -Syyu --noconfirm \
    texlive-langjapanese \
    texlive-latexextra \
    perl-yaml-tiny \
    perl-file-homedir \
    perl-unicode-linebreak \
    ghostscript \
    git \
    curl \
    unzip

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

RUN curl -OL https://www.ctan.org/tex-archive/macros/latex/contrib/thmbox.zip \
    && unzip thmbox.zip \
    && cd thmbox \
    && latex thmbox.ins \
    && latex thmbox.dtx \
    && cd .. \
    && mv thmbox /usr/share/texmf-dist/tex/latex/ \
    && mktexlsr
 

WORKDIR /home/docker
