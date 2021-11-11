# backup-smb-to-windows

Faça backup de um HD Windows completo de forma automatizada, ignorando pastas inúteis e poupando espaço no seu servidor SMB (ou HD externo).
Esse Script foi escrito para agilizar processos de backup de um HD Windows a partir do Linux. Isso pode ser muito útil quando você precisa de um backup completo, mas seu Windows não inicia, ou antes de uma formatação completa, ou ao trocar de HD, ou outros casos.

## Modo de uso

Antes de tudo, configure seu servidor SMB ou seu HD extero na linha comentada no código.
Após configurado, digite: `sudo ./copy.sh ano-mes-dia-nomeDoComputador sdxx` (O comando `sudo` só será necessário se você não estiver como **root**)

Exemplo: `./copy.sh 2021-12-31-escritorio sda2`
