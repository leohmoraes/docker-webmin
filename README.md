phpMyAdmin
==========


1. Build: `docker build --rm -t webmin .`

1. Copy `env.list.template` to `env.list` and update

1. Run:

```
docker run -t -i -p 83:80  \
-h webmin --restart="on-failure:10" \
--link beservices:beservices --name webmin webmin \
/bin/bash -c "supervisord; export > /env; bash"
```

1. Disconnect with `ctrl-p` `ctrl-q`
