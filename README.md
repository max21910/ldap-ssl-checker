# ldap-ssl-checker

`ldap-ssl-checker` is a simple Bash script designed to test and verify SSL/TLS connections to an LDAP server (such as LDAPS on port 636). It checks the availability of the connection and displays certificate details including expiration date.

## 🔍 Features

- ✅ Checks LDAPS connection (port 636)
- 📆 Displays certificate validity and expiration date
- 🛡️ Useful for verifying secure LDAP setup

## 📦 Requirements

- `openssl`


## 🛠️ Usage

```bash
./ldap-ssl-checker.sh <hostname> [port]
```

- `<hostname>`: LDAP server FQDN or IP (e.g., `ldap.example.com` or `192.168.X.X` )
- `[port]`: Optional, default is `636`

### Example

```bash
./ldap-ssl-checker.sh ldap.example.com
```

### Sample Output

```
CONNECTED(00000003)
depth=0 CN=ldap.example.com
verify return:1
notBefore=May 15 08:00:00 2024 GMT
notAfter=May 15 08:00:00 2025 GMT
SSL-Session:
    Protocol  : TLSv1.3
    Cipher    : TLS_AES_256_GCM_SHA384
```

## ⚠️ Notes

- Make sure the LDAP server supports SSL/TLS. (ldaps should be enable or -1 error might occure
- The script does not validate the full certificate chain or CRLs. just the chain between 2 server with self-signed certificate

## 📜 License

MIT License. See the [LICENSE](LICENSE) file for details.
