FROM alpine
RUN apk add --no-cache \
  openssh-client \
  ca-certificates \
  bash 
RUN mkdir /code
COPY ./set_passwordless_ssh.sh /code
RUN chmod 755 /code/set_passwordless_ssh.sh
CMD /code/set_passwordless_ssh.sh