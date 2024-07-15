# language: pt

Funcionalidade: Usuários conseguirem acessar a plataforma
  Para manter o acesso a aplicacao segura
  Como um usuário da aplicação eu quero acessar a plataforma por credenciais seguras

  Contexto:
    Dado um usuário da aplicação

  Cenário: Usuário tenta fazer login na aplicação com credenciais válidas
    então deve se autenticar
    Dado uma credencial válida de login
    Quando ele clica no botão para fazer o login
    Então o usuário deve ter um token válido

  Cenário: Usuário tenta fazer login na aplicação com email inválido
    então não deve se autenticar
    Dado uma credencial com email inválido de login
    Quando ele clica no botão para fazer o login
    Então o usuário deve receber um erro de email ou senha inválida

  Cenário: Usuário tenta fazer login na aplicação com senha inválida
    então não deve se autenticar
    Dado uma credencial com senha inválida de login
    Quando ele clica no botão para fazer o login
    Então o usuário deve receber um erro de email ou senha inválida
