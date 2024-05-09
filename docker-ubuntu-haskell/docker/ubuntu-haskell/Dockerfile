# Edit this line: echo "<your SSH public key>" > /home/haskell/.ssh/authorized_keys

FROM ubuntu:jammy
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install nano openssh-server haskell-platform -y && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    useradd -m -d /home/haskell -s /bin/bash haskell && \
    su - haskell -c "ssh-keygen -t rsa -q -f /home/haskell/.ssh/id_rsa -N ''" && \
    chown -R haskell:haskell "/home/haskell/.ssh" && \
    chmod 700 "/home/haskell/.ssh" && \
    echo "<your SSH public key>" > /home/haskell/.ssh/authorized_keys && \
    chown haskell:haskell "/home/haskell/.ssh/authorized_keys" && \
    chmod 600 "/home/haskell/.ssh/authorized_keys" && \
    mkdir /run/sshd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
