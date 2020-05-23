FROM python:3 AS tflint
WORKDIR /opt/tflint
RUN wget https://github.com/terraform-linters/tflint/releases/download/v0.16.1/tflint_linux_amd64.zip && \
    unzip tflint_linux_amd64.zip -d /usr/bin/ && rm tflint_linux_amd64.zip

FROM golang:1.14

COPY --from=hashicorp/terraform:0.12.25 /bin/terraform /bin/
COPY --from=cytopia/terraform-docs /usr/local/bin/terraform-docs /bin/
COPY --from=tflint /usr/bin/tflint /bin/


RUN terraform --version && terraform-docs --version && tflint --version
