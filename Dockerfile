FROM alpine:3.17.2
LABEL maintainer="github.com/asabhi6776"

# Adding user and changing user
RUN adduser abhishek;echo 'abhishek:password' | chpasswd

######### Installing required packages and Kube ##########
RUN apk add curl wget zsh openssl bash git tmux unzip --no-cache

RUN curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod +x get_helm.sh && ./get_helm.sh

######## Installing rclone ############
RUN curl https://rclone.org/install.sh | bash

######## Sudo configuration ###########
RUN set -ex && apk --no-cache add sudo
RUN echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel
RUN adduser abhishek wheel

# RUN echo "venom-alpine" > /etc/hostname
# RUN hostname venom-alpine

######## Zsh configuration ############
RUN sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd

USER abhishek
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

RUN sed -i 's/_THEME=\"robbyrussell\"/_THEME=\"agnoster\"/g' ~/.zshrc
RUN sed -i '/^plugins=/ s/)$/ git tmux common-aliases zsh-syntax-highlighting jsontools)/' ~/.zshrc
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

WORKDIR /home/abhishek
COPY assets/script.sh script.sh
ENTRYPOINT [ "/bin/bash", "script.sh" ]
