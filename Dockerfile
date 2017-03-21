# extend centos
FROM centos:7.3.1611

# workaround for missing locale
ENV LC_ALL en_US.UTF-8

# create new user with id 1001 and add to root group
RUN useradd -r -u 1001 -g 0 default && \
    mkdir -p /app && \
    chown -R 1001:0 /app

# expose port 4000
EXPOSE 4000

# change to the application root
WORKDIR /app

# switch to user 1001 (non-root)
USER 1001

# specify the current version of the application
ENV VERSION 0.0.1

# copy the release into the runtime container
COPY _build/prod/rel/docs_users/releases/${VERSION}/docs_users.tar.gz /app/docs_users.tar.gz

# extract the release
RUN set -x && \
    tar xvzf docs_users.tar.gz && \ 
    rm -rf docs_users.tar.gz && \
    chmod -R g+w /app

# run the release in foreground mode
# such that we get logs to stdout/stderr
CMD ["/app/bin/docs_users", "foreground"]
