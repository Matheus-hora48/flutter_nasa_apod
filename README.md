# 🚀 NASA APOD Viewer

Este é um aplicativo Flutter que exibe a "Imagem Astronômica do Dia" (APOD) fornecida pela NASA. Ele utiliza a arquitetura **Clean Architecture** com separação de camadas (Domain, Data e Presentation), gerenciamento de estado com **Bloc**, e implementação de testes utilizando **Mockito** e **bloc_test**.

## Funcionalidades Principais

- 🖼️ Exibição da imagem ou vídeo do dia com informações relevantes como título, descrição e data.
- 📅 Seleção de data específica para buscar a APOD de um dia anterior.
- 🎥 Suporte a mídias dinâmicas (imagem ou player de vídeo).
- ⭐ Sistema de favoritos, permitindo salvar APODs localmente.
- 📂 Tela separada para visualização dos favoritos.
- 🎨 Interface responsiva com suporte a temas claro e escuro.
- ⚡ Cache de imagens para otimização de desempenho.

---

## 🛠️ Arquitetura

O projeto segue a **Clean Architecture**, com as seguintes camadas:

### **Domain**
- Contém as **entidades**, **casos de uso** e **contratos dos repositórios**.
- Exemplo:
  - Entidade: `Apod` (representa os dados da APOD).
  - Caso de Uso: `GetApodByDate`.

### **Data**
- Contém as implementações dos **repositórios** e a lógica para acessar a API ou o armazenamento local.
- Utiliza **Dio** para requisições HTTP e **SharedPreferences** para persistência local.

### **Presentation**
- Contém os **Blocs** para gerenciamento de estado e as **interfaces de usuário (UI)**.
- Implementado com o pacote **flutter_bloc** para separação entre lógica de negócios e apresentação.

---

## 🔌 Gerenciamento de Dependências

O projeto utiliza **GetIt** para injeção de dependência, permitindo fácil configuração e escalabilidade.

---

## 📦 Tecnologias e Pacotes Utilizados

- **Dio**: Requisições HTTP.
- **flutter_bloc**: Gerenciamento de estado.
- **cached_network_image**: Cache de imagens para otimização.
- **youtube_player_flutter**: Player para vídeos incorporados.
- **SharedPreferences**: Armazenamento local de dados.
- **bloc_test**: Testes de blocos.
- **Mockito**: Mocking de dependências.
- **build_runner**: Geração de código para testes com Mockito.

---

## ▶️ Como Executar o Projeto

### Pré-requisitos
- 🛠️ Flutter SDK mais recente.
- 🔑 Chave de API da NASA obtida em [NASA API](https://api.nasa.gov/).

### Passos
1. Clone o repositório:
   ```bash
   git clone https://github.com/Matheus-hora48/flutter_nasa_apod.git
   ```
2. Instale as dependências:
   ```bash
   flutter pub get
   ```
3. Execute o aplicativo:
   ```bash
   flutter run
   ```

---

## 🗂️ Estrutura do Projeto

```
lib/
├── core/                  # Constantes, temas, configurações.
├── data/                  # Implementações de repositórios, models e serviços.
├── domain/                # Entidades e casos de uso.
├── presentation/          # Blocs, telas e widgets.
└── main.dart              # Ponto de entrada da aplicação.
```

---

## Testes

Os testes foram implementados com **bloc_test** e **Mockito**:

### Configuração dos Testes
1. Geração de mocks:
   ```bash
   flutter pub run build_runner build
   ```
2. Execução dos testes:
   ```bash
   flutter test
   ```

### Testes Implementados
- ✅ Testes unitários dos casos de uso e repositórios.
- ✅ Testes de blocos para verificar os estados emitidos em diferentes cenários.

---

## 📜 Licença

Este projeto é licenciado sob a licença MIT. Consulte o arquivo LICENSE para mais detalhes.
