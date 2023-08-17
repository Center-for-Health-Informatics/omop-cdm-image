FROM mcr.microsoft.com/mssql/server:latest
COPY ./init.sql .
COPY ./entrypoint.sh .
EXPOSE 1433
ENV ACCEPT_EULA=Y
ENV SQLCMDSERVER=localhost
ENV SQLCMDUSER=SA
ENV SQLCMDLOGINTIMEOUT=120
CMD /bin/bash ./entrypoint.sh
