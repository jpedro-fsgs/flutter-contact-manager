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
  - [ ] Imagem de perfil
- [x] Criar funcionalidade para **editar contato**:
  - [x] Permitir alteração de nome, telefone, email e imagem.
- [x] Criar funcionalidade para **excluir contato** com confirmação:
  - [x] Modal ou diálogo para confirmar exclusão.
- [x] Implementar **lista de contatos**:
  - [x] Mostrar contatos ordenados por nome (padrão).
  - [ ] Opção para ordenar por: Nome, Telefone ou Data de Criação.

#### **Melhorias de Experiência do Usuário**
- [ ] Implementar internacionalização.
- [ ] Implementar busca na lista de contatos (por nome ou telefone).
- [ ] Adicionar imagem ao contato:
  - [ ] Opção de escolher imagem da galeria ou tirar foto.
  - [ ] Exibir uma imagem padrão para contatos sem foto.
- [x] Validar campos ao adicionar ou editar contatos:
  - [x] Nome e telefone obrigatórios.
  - [x] Verificar formato de email válido.
  - [ ] Tamanho máximo da imagem.

#### **Design e Interface**
- [x] Criar layout responsivo para diferentes tamanhos de tela.
- [x] Adicionar feedback visual:
  - [x] Mensagens de sucesso (ex.: "Contato adicionado com sucesso").
  - [ ] Mensagens de erro (ex.: "Erro ao salvar o contato").
- [x] Adicionar ícones para ações (editar, excluir, adicionar).

#### **Tarefas Técnicas**
- [x] Criar banco de dados local com **sqflite**:
  - [ ] Tabela para armazenar contatos com campos: ID, Nome, Telefone, Email, Imagem, Data de Criação.
- [x] Implementar funções CRUD (Create, Read, Update, Delete).
- [ ] Testar persistência de dados ao reiniciar o app.
- [ ] Testar performance com uma lista grande de contatos.

#### **Testes**
- [x] Testar funcionalidade de adicionar contato.
- [ ] Testar edição e exclusão de contatos.
- [ ] Testar ordenação e busca na lista.
- [ ] Testar validação de campos.
