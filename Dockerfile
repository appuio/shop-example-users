# extend alpine
FROM alpine:3.5

# create new user with id 1001 and add to root group
RUN adduser -S 1001 -G root && \
  mkdir -p /app/var && \
  chown -R 1001:root /app

# expose port 4000
EXPOSE 4000

# environment variables
ENV HOME /app
ENV VERSION 0.0.1

# install ncurses-libs
# it seems to be a runtime dependency
RUN set -x && \
  apk --update --no-cache add \
    ncurses-libs \
    postgresql-client

# change to the application root
WORKDIR /app

# inject the entrypoint
COPY entrypoint.sh /app/entrypoint.sh

# make the entrypoint group executable
RUN chown 1001:0 /app/entrypoint.sh && \
  chmod g+x /app/entrypoint.sh
  
# switch to user 1001 (non-root)
USER 1001

# copy the release into the runtime container
COPY _build/prod/rel/docs_users/releases/${VERSION}/docs_users.tar.gz /app/docs_users.tar.gz

# extract the release
RUN tar xvzf docs_users.tar.gz && \
  rm -rf docs_users.tar.gz && \
  chmod -R g+w /app

# define the custom entrypoint
# this will wait for postgres to be up
# and execute /app/docs_users $@ subsequently
ENTRYPOINT ["/app/entrypoint.sh"]

# run the release in foreground mode
# such that we get logs to stdout/stderr
CMD ["/app/bin/docs_users", "foreground"]
