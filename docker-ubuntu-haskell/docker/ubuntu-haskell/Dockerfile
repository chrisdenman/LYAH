FROM ubuntu:jammy

ARG SSH_PUBLIC_KEY
ARG MY_HOST_USERNAME

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install nano openssh-server haskell-platform -y && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    useradd -m -d /home/haskell -s /bin/bash haskell && \
    echo "cd /home/haskell/learn-you-a-haskell-exercises/solutions/$MY_HOST_USERNAME" >> "/home/haskell/.bashrc" && \
    echo "ghci" >> "/home/haskell/.bashrc" && \
    touch /home/haskell/.hushlogin && \
    su - haskell -c "ssh-keygen -t rsa -q -f /home/haskell/.ssh/id_rsa -N ''" && \
    echo "$SSH_PUBLIC_KEY" > /home/haskell/.ssh/authorized_keys && \
    chown -R haskell:haskell "/home/haskell" && \
    chmod 700 "/home/haskell/.ssh" && \
    chmod 600 "/home/haskell/.ssh/authorized_keys" && \
    mkdir /run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
