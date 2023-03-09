FROM alpine:3.17.2
LABEL maintainer="github.com/asabhi6776"

# Adding user and changing user
RUN adduser abhishek;echo 'abhishek:password' | chpasswd
USER abhishek

