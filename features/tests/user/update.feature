# language: pt

Funcionalidade: Usuários cadastrados devem conseguir atualizar suas informações na plataforma
  Como um usuário autenticado eu quero poder alterar minhas informações do cadastro

  Cenário: Usuário autenticado tenta alterar seus dados com
    informações válidas então deve dar sucesso
    Dado um usuário autenticado
    E informações válidas para atualizar um usuário
    Quando o usuário tenta atualizar suas informações
    Então as informações do usuário devem ser atualizadas

  Cenário: Usuário autenticado tenta alterar seus dados com
    informações inválidas então deve dar erro
    Dado um usuário autenticado
    E informações inválidas para atualizar um usuário
    Quando o usuário tenta atualizar suas informações
    Então as informações do usuário não devem ser atualizadas
