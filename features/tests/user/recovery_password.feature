# language: pt

Funcionalidade: Usuários conseguirem solicitar uma nova senha na plataforma
Como um usuário da aplicação eu quero poder me cadastrar na plataforma

Contexto:
  Dado um usuário da aplicação 

Cenário: Usuário tenta solicitar uma nova senha com informações válidas então deve receber um email
  Dado informações válidas para solicitar uma nova senha
  Quando ele clica no botão para solicitar nova senha
  Então o usuário deve receber um email

Cenário: Usuário tenta solicitar uma nova senha com informações inválidas então não deve receber um email
  Dado informações inválidas para solicitar uma nova senha
  Quando ele clica no botão para solicitar nova senha
  Então o usuário não deve receber um email