# extend alpine
FROM alpine:3.5

# create new user with id 1001 and add to root group
RUN adduser -S 1001 -G root && \
  mkdir -p /app && \
  chown 1001:root /app

# expose port 4000
EXPOSE 4000

# environment variables
ENV VERSION 0.0.1

# switch to user 1001 (non-root)
USER 1001

# copy the release into the runtime container
COPY _build/prod/rel/docs_users/releases/${VERSION}/docs_users.tar.gz /app/docs_users.tar.gz

# change to the application root
WORKDIR /app

# extract the release
RUN tar xvzf docs_users.tar.gz

# run the release in foreground mode
# such that we get logs to stdout/stderr
CMD ["/app/bin/docs_users", "foreground"]
