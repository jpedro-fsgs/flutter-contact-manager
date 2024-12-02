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

## 🎨 Capturas de Tela

<table style="table-layout: fixed; width: 100%; text-align: center;">
  <tr>
    <td style="width: 33%; vertical-align: top;">
      <figure>
        <img src="assets/screenshots/add_contact_page.png" alt="Adicionar Contato" width="200" style="display: block; margin: auto;"/>
        <figcaption>Adicionar Contato</figcaption>
      </figure>
    </td>
    <td style="width: 33%; vertical-align: top;">
      <figure>
        <img src="assets/screenshots/contact_list.png" alt="Lista de Contatos" width="200" style="display: block; margin: auto;"/>
        <figcaption>Lista de Contatos</figcaption>
      </figure>
    </td>
    <td style="width: 33%; vertical-align: top;">
      <figure>
        <img src="assets/screenshots/contact_page.png" alt="Detalhes do Contato" width="200" style="display: block; margin: auto;"/>
        <figcaption>Detalhes do Contato</figcaption>
      </figure>
    </td>
  </tr>
  <tr>
    <td style="width: 33%; vertical-align: top;">
      <figure>
        <img src="assets/screenshots/edit_contact_page.png" alt="Editar Contato" width="200" style="display: block; margin: auto;"/>
        <figcaption>Editar Contato</figcaption>
      </figure>
    </td>
    <td style="width: 33%; vertical-align: top;">
      <figure>
        <img src="assets/screenshots/feedback_popup.png" alt="Popup de Feedback" width="200" style="display: block; margin: auto;"/>
        <figcaption>Popup de Feedback</figcaption>
      </figure>
    </td>
    <td style="width: 33%; vertical-align: top;">
      <figure>
        <img src="assets/screenshots/intl.png" alt="Internacionalização" width="200" style="display: block; margin: auto;"/>
        <figcaption>Internacionalização</figcaption>
      </figure>
    </td>
  </tr>
  <tr>
    <td style="width: 33%; vertical-align: top;">
      <figure>
        <img src="assets/screenshots/remove_confirmation.png" alt="Confirmação de Remoção" width="200" style="display: block; margin: auto;"/>
        <figcaption>Confirmação de Remoção</figcaption>
      </figure>
    </td>
    <td style="width: 33%; vertical-align: top;">
      <figure>
        <img src="assets/screenshots/search_name.png" alt="Buscar por Nome" width="200" style="display: block; margin: auto;"/>
        <figcaption>Buscar por Nome</figcaption>
      </figure>
    </td>
    <td style="width: 33%; vertical-align: top;">
      <figure>
        <img src="assets/screenshots/search_number.png" alt="Buscar por Número" width="200" style="display: block; margin: auto;"/>
        <figcaption>Buscar por Número</figcaption>
      </figure>
    </td>
  </tr>
</table>

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
- [x] Implementar internacionalização.
- [x] Implementar busca na lista de contatos.
- [x] Adicionar imagem ao contato:
  - [x] Opção de escolher imagem da galeria.
  - [x] Exibir uma imagem padrão para contatos sem foto.
  - [x] Opção de ver foto.
- [x] Validar campos ao adicionar ou editar contatos:
  - [x] Nome e telefone obrigatórios.
  - [x] Verificar formato de email válido.
- [x] Botão para Ligação e SMS.
- [x] Botão para enviar Email.

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
