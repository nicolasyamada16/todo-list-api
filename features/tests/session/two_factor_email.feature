# language: pt

Funcionalidade: Usuários conseguirem fazer autenticação com dois fatores usando o email
Como um usuário da aplicação eu quero acessar a plataforma por credenciais seguras e usando o email para validação de login

Contexto:
  Dado um usuário da aplicação 

Cenário: Usuário tenta autenticar usando informações válidas, logo, deve receber um email para validar a autenticação
  e então enviar o código recebido junto ao email
  Dado uma credencial válida de login
  Quando ele clica no botão para fazer o login com dois fatores
  Então deve ter recebido o email com o código de verificação
  Quando ele clica para verificar o código
  Então o usuário deve ter um token válido

Cenário: Usuário tenta autenticar usando informações válidas, logo, deve receber um email para validar a autenticação
  e então enviar o código inválido
  Dado uma credencial válida de login
  Quando ele clica no botão para fazer o login com dois fatores
  Então deve ter recebido o email com o código de verificação
  Dado um código inválido de login
  Quando ele clica para verificar o código
  Então o usuário deve receber um erro de código inválido