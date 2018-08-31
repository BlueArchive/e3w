FROM scratch
COPY build/e3w /
COPY static /static
COPY conf/config.default.ini /conf/config.default.ini
WORKDIR /
ENTRYPOINT [ "/e3w" ]

