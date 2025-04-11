#  📱 a1_mobile

⚠️ Atenção: A API do CrudCrud é temporária e pode expirar após um tempo sem uso. Em caso
de erro 404 ou 401, gere uma nova URL no site do CrudCrud e atualize o baseUrl em api_service.dart.

Projeto Flutter simples para **gerenciamento de usuários** com as funcionalidades de:

- Listar usuários 👀
- Adicionar novos usuários ➕
- Editar dados dos usuários ✏️
- Remover usuários ❌

As informações são consumidas de uma **API REST** hospedada no [CrudCrud](https://crudcrud.com).

---

## 🚀 Tecnologias Utilizadas

- Flutter
- Dart
- HTTP (requisições REST)
- Material Design

---

## ⚙️ Como rodar o projeto

### 1. Clone o repositório

```bash
git clone https://github.com/filipebdias/A1_Mobile.git
cd A1_Mobile

## Instale as dependências
- flutter pub get

## 🚀🌐 API Utilizada
final String baseUrl = 'https://crudcrud.com/api/934a3dc3a16f4985af16ec016508b084/users';

