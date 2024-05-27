FROM mambaorg/micromamba:1.5.8
COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yaml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes
USER mambauser
COPY --chmod=755 run.sh /tapis/run.sh
COPY --chown=$MAMBA_USER:$MAMBA_USER main.py /tapis/
ENV PATH="/opt/conda/bin:${PATH}"
ENV PATH "/code:$PATH"
ENTRYPOINT [ "/tapis/run.sh" ]
