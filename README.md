## pyWebTor

Chat web simples escrito em Flask que carrega um server na rede TOR, que pode ser acessado pelo navegador Tor Browser.

### Comando para criar/levantar o container
```
docker-compose up -d
```


### Checar a URL para acesso na rede TOR.
```
docker exec -it pywebtor cat /var/lib/tor/web/hostname
```
