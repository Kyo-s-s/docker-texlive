FROM ghcr.io/archlinux/archlinux:base-devel

ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID docker \
    && useradd -m -u ${UID} -g ${GID} docker \
    && echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN pacman -Syyu --noconfirm \
    texlive-langjapanese \
    texlive-latexextra \
    texlive-binextra \
    texlive-fontsrecommended \
    texlive-bibtexextra \
    biber \
    noto-fonts-cjk \
    perl-yaml-tiny \
    perl-file-homedir \
    ghostscript \
    git \
    curl \
    unzip \
    nodejs \
    npm \
    fontconfig

RUN mkdir -p /usr/share/texmf-dist/fonts/opentype/haranoaji \
    && cd /tmp \
    && curl -L -o HaranoAjiFonts.zip "https://github.com/trueroad/HaranoAjiFonts/archive/refs/tags/20231009.zip" \
    && unzip HaranoAjiFonts.zip \
    && mv HaranoAjiFonts-20231009/*.otf /usr/share/texmf-dist/fonts/opentype/haranoaji/ \
    && rm -rf HaranoAjiFonts.zip HaranoAjiFonts-20231009 \
    && mktexlsr \
    && fc-cache -f -v \
    && kanji-config-updmap-sys haranoaji

RUN git clone https://github.com/h-kitagawa/plistings.git \
    && mv /plistings/plistings.sty /usr/share/texmf-dist/tex/latex/listings/ \
    && mktexlsr

RUN curl -OL https://ftp.kddilabs.jp/CTAN/macros/latex/contrib/thmbox.zip \
    && unzip thmbox.zip \
    && cd thmbox \
    && latex thmbox.ins \
    && latex thmbox.dtx \
    && cd .. \
    && mv thmbox /usr/share/texmf-dist/tex/latex/ \
    && mktexlsr

RUN curl -OL https://mirrors.ctan.org/macros/latex/contrib/algorithms.zip \
    && unzip algorithms.zip \
    && cd algorithms \
    && latex algorithms.ins \
    && latex algorithms.dtx \
    && cd .. \
    && mv algorithms /usr/share/texmf-dist/tex/latex/ \
    && mktexlsr

RUN  curl -OL https://mirrors.ctan.org/macros/latex/contrib/algorithmicx.zip \
    && unzip algorithmicx.zip \
    && mv algorithmicx /usr/share/texmf-dist/tex/latex/ \
    && mktexlsr

WORKDIR /home/docker
ENV PATH="$PATH:/usr/bin/vendor_perl"
