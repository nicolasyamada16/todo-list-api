# language: pt

Funcionalidade: Usuários conseguirem solicitar uma nova senha na plataforma
Como um usuário da aplicação eu quero poder me cadastrar na plataforma

Contexto:
  Dado um usuário criado e autenticado

Cenário: Usuário tenta alterar sua senha com dados válidos
  Dado informações válidas para alterar sua senha
  Quando ele clica no botão para alterar a senha
  Então a senha do usuário deve ser alterada

Cenário: Usuário tenta alterar sua senha com dados inválidos
  Dado informações inválidas para alterar sua senha
  Quando ele clica no botão para alterar a senha
  Então a senha do usuário não deve ser alterada