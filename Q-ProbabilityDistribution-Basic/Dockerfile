# Usage:
# docker build -t pandoc . && docker run -it --volume "$PWD:/publish" pandoc
FROM pandoc/latex:latest

RUN tlmgr option repository http://mirror.ctan.org/systems/texlive/tlnet
RUN tlmgr update --self --all
RUN tlmgr install \
    bxjscls \
    luatexja \
    collection-langjapanese \
    ctex \
    type1cm \
    selnolig \
    ipaex

RUN mkdir /publish
WORKDIR /work
COPY ds_exam.md /input/
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["pandoc /input/ds_exam.md -o /publish/ds_exam.pdf \
    -V classoption=pandoc \
    -V documentclass=ltjsarticle \
    -V luatexjapresetoptions=ipaex \
    --pdf-engine=lualatex"]
