# language: pt

Funcionalidade: Usuários conseguirem acessar a plataforma
  Para manter o acesso a aplicacao segura
  Como um usuário da aplicação eu quero acessar a plataforma me autenticando através do google

  Cenário: Usuário tenta fazer login na aplicação através do google
    informando um código de autorização válido então deve se autenticar
    Dado um código de autorização validado pelo google
    Quando ele tenta logar com o google informando um com código de autorização "válido"
    Então o usuário deve ter um token válido

  Cenário: Usuário tenta fazer login na aplicação através do google
    informando um código de autorização inválido então não deve se autenticar
    Dado um código de autorização invalidado pelo google
    Quando ele tenta logar com o google informando um com código de autorização "inválido"
    Então o usuário deve receber um erro de falha de login com o google
