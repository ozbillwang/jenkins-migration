# Jenkins Migration.

### manage new certificates and keystore

```
$ bash ./generate.sh jenkins.local.internal
$ ls CERT*
jenkins.local.internal.cnf	jenkins.local.internal.csr	jenkins.local.internal.key

$ cd CERT* 
$ openssl req -text -noout -verify -in jenkins.local.internal.csr
```

### reference
https://www.sslshopper.com/article-most-common-openssl-commands.html
