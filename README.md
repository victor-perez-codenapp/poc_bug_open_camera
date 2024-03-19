# Instruções para Build do Projeto

Para construir o projeto, siga os seguintes passos no terminal:

**Observação:** É necessário ter FVM, Flutter e Dart configurados no ambiente da máquina.

1. `fvm use 3.16.6`
2. `fvm flutter pub get`
3. `fvm flutter run`

## Entendendo a POC:

1. **Botão Portrait:** Coloca a tela em modo retrato.
2. **Botão Landscape:** Coloca a tela em modo paisagem.
3. **Botão Validação Selfie:** Inicializa e abre o SDK da Unico para validação facial por selfie.

## Algumas Observações:

1. Os callbacks geram snackbars personalizadas e loggers para facilitar a depuração.
2. Para simular o erro `onErrorUnico` durante o carregamento do SDK, na tela de loading screen (tela branca com um círculo no meio), é necessário ficar alterando a orientação do dispositivo com o objetivo de forçar a mudança de orientação de tela enquanto carrega. Como o aplicativo está bem leve nessa versão, é mais difícil simular o erro, mas ele pode ocorrer.
