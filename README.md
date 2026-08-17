# Celeris Client

Aplicação desktop Windows oficial para acesso ao [Celeris](https://github.com/bjmvictor/Celeris), desenvolvida para oferecer uma experiência integrada e segura em ambientes clínicos, hospitalares e administrativos.

O Celeris Client utiliza o Microsoft WebView2 para hospedar a aplicação web, adicionando navegação por guias, múltiplas sessões isoladas, identificação por cores, atalhos configuráveis e integração com o Windows.

## Visão geral

O projeto permite utilizar o Celeris como uma aplicação desktop dedicada, sem depender da interface completa de um navegador convencional.

O Client não replica regras assistenciais ou administrativas. Autenticação, permissões, pacientes, atendimentos, prontuário, prescrições e cadastros permanecem sob responsabilidade exclusiva do Celeris Web.

```text
Celeris Client
    +-- Interface desktop WPF
    +-- Guias e sessões isoladas
    +-- Política de navegação
    +-- Microsoft WebView2
            +-- Celeris Web
```

## Público-alvo

O Celeris Client é direcionado a:

- Hospitais públicos e privados
- Clínicas e policlínicas
- Unidades de pronto atendimento
- Centros médicos e ambulatoriais
- Redes de saúde com múltiplas unidades
- Equipes que utilizam mais de uma sessão do Celeris simultaneamente
- Instituições que desejam disponibilizar o Celeris como aplicação Windows dedicada

## Principais funcionalidades

### Navegação e produtividade

- Navegação por guias com rolagem horizontal
- Criação, fechamento e duplicação de guias
- Controles de voltar, avançar, recarregar e início
- Guia de pesquisa integrada
- Endereço opcional, editável e oculto por padrão
- Modo de tela cheia
- Temas claro, escuro e sincronizado com o Windows
- Atalhos de teclado para operações frequentes

### Múltiplas sessões

- Sessões independentes com perfil WebView2 exclusivo
- Cookies compartilhados somente por guias da mesma sessão
- Isolamento de autenticação e armazenamento entre sessões
- Identificação visual das sessões por cores
- Perfis armazenados no diretório local do usuário

### Produtos e favoritos

- Produtos configuráveis pelo arquivo `favorites.json`
- Nome, endereço, ícone vetorial e estado configuráveis
- Endereços relativos à URL principal ou absolutos
- Inclusão de produtos sem recompilar o Client

### Segurança e governança

- Allowlist de origens autorizadas
- HTTPS obrigatório para destinos remotos
- HTTP permitido somente para loopback em desenvolvimento
- Links externos enviados ao navegador padrão em guias restritas
- DevTools desabilitadas por padrão
- Sem bypass de certificado ou desativação de TLS
- Separação dos dados de navegação entre sessões
- Logs sem armazenamento intencional de tokens, cookies, senhas ou conteúdo clínico

## Ecossistema

O Celeris Client integra o ecossistema de produtos Celeris:

| Produto | Finalidade |
| --- | --- |
| Celeris Central | Gestão administrativa, operacional e integração dos processos |
| Celeris PEP | Prontuário eletrônico e atendimento assistencial |
| Celeris Class | Pré-atendimento e classificação de risco |
| Celeris Totem | Autoatendimento e geração de senhas |
| Celeris Painel | Chamada pública de pacientes e senhas |
| Celeris BI | Indicadores gerenciais e dashboards |
| Celeris Client | Experiência desktop, guias e múltiplas sessões isoladas |

## Evolução planejada

O Celeris Client está em desenvolvimento contínuo. As próximas etapas incluem:

- Restauração de guias e sessões
- Sessões nomeadas e seleção manual de cores
- Reordenação de guias por arrastar e soltar
- Instalador, atualização automática e assinatura digital
- SSO corporativo e bridge oficial com o Celeris Web
- Controle de downloads, impressão e arquivos autorizados
- Integração com scanners e dispositivos hospitalares
- Políticas administrativas, modo quiosque e diagnóstico técnico

## Tecnologias

| Camada | Tecnologia |
| --- | --- |
| Plataforma | Windows 10 ou Windows 11 |
| Linguagem | C# |
| Framework | .NET 10 e WPF |
| Renderização web | Microsoft WebView2 Evergreen |
| Configuração | JSON e Microsoft.Extensions.Configuration |
| Injeção de dependências | Microsoft.Extensions.DependencyInjection |
| Logging | Microsoft.Extensions.Logging |
| Testes | xUnit |

## Desenvolvimento local

Clone o repositório:

```powershell
git clone https://github.com/bjmvictor/Celeris-Client.git
cd Celeris-Client
```

Restaure as dependências:

```powershell
dotnet restore Celeris.Client.slnx
```

Configure `src/Celeris.Client/appsettings.json`:

```json
{
  "BaseUrl": "http://127.0.0.1:8000/",
  "AllowedOrigins": ["http://127.0.0.1:8000"],
  "Browser": {
    "EnableDevTools": false,
    "ShowUrlOption": true
  },
  "FavoritesFile": "favorites.json"
}
```

Execute a aplicação:

```powershell
dotnet run --project src/Celeris.Client
```

Para ambientes remotos, utilize HTTPS em `BaseUrl` e `AllowedOrigins`.

## Configuração de produtos

Os atalhos são definidos em `src/Celeris.Client/favorites.json`:

```json
{
  "Favorites": [
    {
      "Name": "Celeris Totem",
      "Url": "/totem",
      "IconPath": "M4 3 H20 V15 H4 Z M8 21 H16 M12 15 V21",
      "Enabled": true
    }
  ]
}
```

`Url` pode ser relativa à `BaseUrl` ou absoluta. Use `Enabled: false` para ocultar um produto sem removê-lo.

## Identidade visual

| Arquivo | Uso |
| --- | --- |
| `src/Celeris.Client/Assets/logo.png` | Logo da barra superior |
| `src/Celeris.Client/Assets/app.ico` | Ícone do executável, janela e barra de tarefas |

O `.ico` deve preferencialmente conter resoluções de 16 a 256 pixels.

## Testes

```powershell
dotnet test Celeris.Client.slnx
dotnet build Celeris.Client.slnx --configuration Release
```

Os testes atuais cobrem política de navegação, isolamento lógico das sessões e compartilhamento de sessão entre guias.

## Status do projeto

O Celeris Client está em desenvolvimento ativo.

O núcleo de navegação, guias, sessões isoladas, favoritos, pesquisa, temas e política de origens já possui implementação funcional. Novos recursos serão adicionados priorizando segurança, estabilidade, usabilidade e integração com o ecossistema Celeris.

## Projeto relacionado

- [Celeris](https://github.com/bjmvictor/Celeris) — plataforma de gestão e atendimento assistencial multiempresa.

## Licença

A licença do Celeris Client será definida antes da primeira distribuição oficial.
