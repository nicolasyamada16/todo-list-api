# language: pt

Funcionalidade: Usuários conseguirem se cadastrar na plataforma
  Como um usuário da aplicação eu quero poder me cadastrar na plataforma

  Cenário: Usuário tenta fazer o cadastro na aplicação com informações válidas
    então deve ser cadastrado com sucesso
    Dado informações válidas para cadastro de usuário
    Quando ele clica no botão para fazer o cadastro
    Então o usuário deve ser cadastro com sucesso

  Cenário: Usuário tenta fazer o cadastro na aplicação com informações inválidas
    então não deve ser cadastrado
    Dado informações inválidas para cadastro de usuário
    Quando ele clica no botão para fazer o cadastro
    Então o usuário não deve ser cadastrado na aplicação
