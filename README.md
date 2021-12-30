# backup-smb-to-windows V1.1

Faça backup de um HD Windows completo de forma automatizada, ignorando pastas inúteis e poupando espaço no seu servidor SMB (ou HD externo).
Esse Script foi escrito para agilizar processos de backup de um HD Windows a partir do Linux. Isso pode ser muito útil quando você precisa de um backup completo, mas seu Windows não inicia, ou antes de uma formatação completa, ou ao trocar de HD, ou outros casos.

## Modo de uso

Antes de tudo, configure seu servidor SMB ou seu HD extero na linha comentada no código.
O comando "quiet" pode ser adicionado no final do comando para que sejam exibidos apenas erros na tela.
Após configurado, digite: `sudo ./copy.sh ano-mes-dia-nomeDoComputador sdxx` (O comando `sudo` só será necessário se você não estiver como **root**)

Exemplo: `./copy.sh 2021-12-31-escritorio sda2` para um backup com bastante informação, e `./copy.sh 2021-12-31-escritorio sda2 quiet` para um backup silencioso.

# Novidades:

## 1.1

- Adicionado arquivo de log de erros "registro de erro" para validar a integridade dos dados após verificação de uso de espaço do disco de origem;
- Permite mais de um backup ao mesmo tempo na mesma máquina.
