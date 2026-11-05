FROM mcr.microsoft.com/mssql/server:2022-latest

COPY sql /opt/omop/sql
COPY fmt /opt/omop/fmt
COPY scripts /opt/omop/scripts
# load-vocab and cdm-indexes on PATH, for `<engine> exec <container> load-vocab`
ENV PATH="/opt/omop/scripts:${PATH}"

EXPOSE 1433
ENV ACCEPT_EULA=Y
ENV MSSQL_PID=Developer
ENV SQLCMDSERVER=localhost
ENV SQLCMDUSER=SA
ENV SQLCMDLOGINTIMEOUT=120

VOLUME /var/opt/mssql
CMD ["/bin/bash", "/opt/omop/scripts/entrypoint.sh"]
