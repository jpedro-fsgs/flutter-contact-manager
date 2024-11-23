# Aplicativo de Gerenciamento de Contatos

Aplicativo para dispositivos móveis utilizando **Flutter** e o banco de dados local **SQLite (via sqflite)**, implementando as operações de CRUD (Create, Read, Update e Delete) para gerenciar contatos pessoais.

## 📋 Funcionalidades

1. **Tela de Cadastro**:
   - Formulário para adicionar um novo contato, contendo:
     - Nome do contato.
     - Telefone.
     - E-mail.
   - Botão para salvar os dados no banco de dados.

2. **Tela de Listagem**:
   - Exibição de todos os contatos cadastrados.
   - Permite selecionar um contato para:
     - Visualizar os detalhes.
     - Editar informações.
     - Excluir o contato.

3. **Tela de Edição**:
   - Edição dos dados do contato selecionado.
   - Salvamento das alterações no banco de dados.

4. **Funcionalidade de Exclusão**:
   - Confirmação antes de remover permanentemente o contato.

## 🛠️ Tecnologias Utilizadas

- **Flutter**: Framework de desenvolvimento multiplataforma.
- **sqflite**: Biblioteca para integração com SQLite em Flutter.

<!-- ## 🎨 Capturas de Tela

- **Tela de Cadastro**:
![Tela de Cadastro](screenshots/cadastro.png)

- **Tela de Listagem**:
![Tela de Listagem](screenshots/listagem.png)

- **Tela de Edição**:
![Tela de Edição](screenshots/edicao.png) -->

---

### **Checklist do Aplicativo de Gerenciamento de Contatos**

#### **Funcionalidades Básicas**
- [x]  Criar página para **adicionar contato**:
  - [x] Nome completo (obrigatório)
  - [x] Telefone (obrigatório)
  - [x] Email
  - [x] Imagem de perfil
- [x] Criar funcionalidade para **editar contato**:
  - [x] Permitir alteração de nome, telefone, email e imagem.
- [x] Criar funcionalidade para **excluir contato** com confirmação:
  - [x] Modal ou diálogo para confirmar exclusão.
- [x] Implementar **lista de contatos**:
  - [x] Mostrar contatos ordenados por nome.

#### **Melhorias de Experiência do Usuário**
- [ ] Implementar internacionalização.
- [x] Implementar busca na lista de contatos.
- [x] Adicionar imagem ao contato:
  - [x] Opção de escolher imagem da galeria.
  - [x] Exibir uma imagem padrão para contatos sem foto.
  - [x] Opção de ver foto.
- [x] Validar campos ao adicionar ou editar contatos:
  - [x] Nome e telefone obrigatórios.
  - [x] Verificar formato de email válido.

#### **Design e Interface**
- [x] Criar layout responsivo para diferentes tamanhos de tela.
- [x] Adicionar feedback visual:
  - [x] Mensagens de sucesso (ex.: "Contato adicionado com sucesso").
  - [x] Mensagens de erro (ex.: "Erro ao salvar o contato").
- [x] Adicionar ícones para ações (editar, excluir, adicionar).

#### **Tarefas Técnicas**
- [x] Criar banco de dados local com **sqflite**:
  - [x] Tabela para armazenar contatos com campos: ID, Nome, Telefone, Email, Imagem.
- [x] Implementar funções CRUD (Create, Read, Update, Delete).
- [x] Testar persistência de dados ao reiniciar o app.

#### **Testes**
- [x] Testar funcionalidade de adicionar contato.
- [x] Testar edição e exclusão de contatos.
- [x] Testar busca na lista.
- [x] Testar validação de campos.
