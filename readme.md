# SplunkDocker

Provisiona rapidamente uma instância do **Splunk Enterprise 9.4.0** em um container Docker, já com:

- usuário admin inicial
- usuário padrão adicional
- Splunk Web com **HTTPS** na porta `8000`
- portas de ingestão de logs:
  - `1514` (TCP / UDP)
  - `1515` (TCP / UDP)
  - `9997` (Splunk TCP)
  - `8088` (HTTP Event Collector – HEC)
- volumes persistentes para dados e apps

> ⚠️ **Atenção:** este repositório contém credenciais e token de exemplo em `docker-compose.yml`.  
> **Troque tudo antes de usar em qualquer ambiente real** e evite commitar senhas/tokens válidos em repositórios públicos.

---

## Arquivos principais

- `docker-compose.yml`  
  Define o serviço `splunk`, portas, volumes e variáveis de ambiente necessárias para configurar o Splunk.

- `Dockerfile`  
  Constrói uma imagem baseada em `debian:latest` e baixa o pacote:
  - `splunk-9.4.0-6b4ebe426ca6-linux-amd64.tgz`

- `entrypoint.sh`  
  Script de inicialização que:
  - cria o usuário admin a partir das variáveis de ambiente
  - habilita HTTPS no Splunk Web
  - configura entradas de dados (TCP/UDP 1514, 1515, HEC, 9997)
  - inicia o Splunk aceitando a licença
  - cria um usuário adicional com papel `user`

- `deploy_ubuntu.sh`  
  Script helper para **Ubuntu** que instala Docker e Docker Compose (se necessário) e sobe o ambiente com Docker Compose.

---

## Pré-requisitos

Para usar o repositório diretamente:

- Sistema baseado em **Debian/Ubuntu**
- `docker`
- `docker-compose` (v1 ou v2)
- Pelo menos **2 GB de RAM livre**

Se você usar `deploy_ubuntu.sh`, ele mesmo tenta instalar:

- `docker.io`
- `docker-compose`

via `apt`.

---

## Configuração

As principais variáveis de ambiente são definidas em `docker-compose.yml`:

```yaml
environment:
  - SPLUNK_ADMIN=admin
  - SPLUNK_ADMIN_PASSWORD=Admin@mudar123
  - USER=user
  - PASSWORD_USER=User@mudar123
  - TOKEN_HEC=e21685ff-1bdb-44b6-9bd0-afd6872a49a6
  - SOURCETYPE_1514_UDP=change_me
  - SOURCETYPE_1514_TCP=change_me
  - SOURCETYPE_1515_UDP=change_me
  - SOURCETYPE_1515_TCP=change_me
