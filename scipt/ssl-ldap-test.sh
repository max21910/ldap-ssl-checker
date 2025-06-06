#!/bin/bash

# ldap-ssl-checker.sh - Vérifie la connexion SSL/TLS à un serveur LDAP

# Affiche l'aide
usage() {
    echo "Usage: $0 <hostname> [port]"
    echo ""
    echo "Arguments :"
    echo "  <hostname>  Adresse IP ou FQDN du serveur LDAP (obligatoire)"
    echo "  [port]      Port LDAP SSL (optionnel, par défaut 636)"
    echo ""
    echo "Exemple :"
    echo "  $0 ldap.example.com"
    echo "  $0 ldap.example.com 636"
    exit 1
}

# Vérifie les paramètres
if [ -z "$1" ]; then
    usage
fi

LDAP_SERVER="$1"
LDAP_PORT="${2:-636}"

# Test SSL connection avec OpenSSL
echo "🔌 Test de la connexion SSL à $LDAP_SERVER:$LDAP_PORT..."
openssl s_client -connect "${LDAP_SERVER}:${LDAP_PORT}" -showcerts < /dev/null > /tmp/ldap_ssl_output 2>/dev/null

# Vérifie si openssl a réussi
if grep -q "CONNECTED" /tmp/ldap_ssl_output; then
    echo "✅ Connexion SSL réussie à $LDAP_SERVER:$LDAP_PORT"
else
    echo "❌ Échec de la connexion SSL à $LDAP_SERVER:$LDAP_PORT"
    exit 2
fi

# Vérifie la validité du certificat
echo "📅 Vérification de la validité du certificat..."
openssl s_client -connect "${LDAP_SERVER}:${LDAP_PORT}" -servername "${LDAP_SERVER}" < /dev/null 2>/dev/null | \
    openssl x509 -noout -dates

echo "✅ Test SSL terminé."

# Nettoyage
rm -f /tmp/ldap_ssl_output