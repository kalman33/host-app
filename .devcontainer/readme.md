# VsCode - Devcontainers

Lien vers le teplmate vscode : https://git.sf.intra.laposte.fr/guilde-dev-outils-internes/vscode-devcontainers

# Construction du projet en mode devContainer

Vous devez taper la commande suivante (dans un terminal bash) avant d'ouvrir votre projet en mode devContainer (à faire uniquement lors de la première construction du projet). 

```
winpty docker login outils-0001410-docker-release.dlu.pop.sf.intra.laposte.fr -u <idRH> -p <token-artifactory>
```

Vous trouverez la valeur des variables <idRH> et <token-artifactory> dans les variables d'environnement respectives DISFE_USER et DISFE_PASSWORD respectivement.

## Plugins

Pour TSLint il suffit d’activer le fait qu’il utilise TSLint dans le workspace avec 
ctrl+shit+p > TSLint : manage workspace library execution > Enable workspace library execution

## Erreurs ConnectionTimeout/SocketTimeout lors des appels CMP
nous avions des exceptions de type ConnectionTimeout/SocketTimeout  qui apparaissaient dans les logs aléatoirement au bout de quelques minutes d’utilisation lors des appels de Q5C vers CMP.
Pour résoudre le problème il suffit de positionner dans c:\Users\<ID RH>\AppData\Roaming\Docker\settings.json le paramètre vpnKitMaxPortIdleTime à 0 au lieu de 300.
vpnKitMaxPortIdleTime  permet de désactiver ou de prolonger le délai d'inactivité de la connexion réseau. 
En redémarrant Docker, le problème disparait.

## Erreur curl: (35) error:1408F10B:SSL routines:ssl3_get_record:wrong version number / Unsupported or unrecognized SSL message
Lors de la récupération maven ou npm nous avions l'erreur "ssl3_get_record:wrong version number" sur npm et "Unsupported or unrecognized SSL message" sur maven.
Pour corriger le problème il suffit de positionner dans c:\Users\<ID RH>\AppData\Roaming\Docker\settings.json les paramètres
"vpnKitTransparentProxy": false,
"vpnkitCIDR": "192.168.65.0/28",

En redémarrant Docker, le problème disparait.