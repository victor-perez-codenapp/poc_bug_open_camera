Para buildar o projeto, siga esses passos no terminal:

Obs: Necessario ter FVM, Flutter e Dart no ambiente da maquina.

1 - fvm use 3.16.6
2 - fvm flutter pub get
3 - fvm flutter run

Entendendo a POC:

1 - Botão Portrait: Tela em modo retrato.
2 - Botão Landscape: Tela em modo paisagem.
3 - Botão Validação Selfie: Inicialização e abertura do sdk da Unico para validação facial por selfie.

Algumas observações:

1 - Os callbacks geram snackbars personalizadas e loggers para facilitar depuração.
2 - Para simular o erro onErrorUnico, no carregamento do sdk, na tela de loading screen (tela branca com um circulo no meio), é necessario ficar virando o celular com o objetivo de forçar a mudança de orientação de tela enquanto carrega. Como o app esta bem leve nessa versão, é mais dificil simular o erro, mas ele acontece.
