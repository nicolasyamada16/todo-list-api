# language: pt

Funcionalidade: Usuários cadastrados conseguirem visualizar suas informações na plataforma
  Como um usuário autenticado eu quero poder visualizar minhas informações na plataforma

  Cenário: Usuário autenticado tenta visualizar suas informações na plataforma
    então deve dar sucesso
    Dado um usuário autenticado
    Quando o usuário tenta visualizar suas informações
    Então o usuário deve conseguir visualizar suas informações

  Cenário: Usuário não autenticado tenta visualizar suas informações na plataforma
    então deve dar erro
    Dado um usuário da aplicação
    Quando o usuário tenta visualizar suas informações
    Então deve dar erro de falha de autenticação
