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

Antes de gerar uma versão distribuível, execute os testes automatizados:

```powershell
dotnet test Celeris.Client.slnx
```

Os testes atuais cobrem política de navegação, isolamento lógico das sessões e compartilhamento de sessão entre guias.

## Compilação e publicação

### Compilação Release

Restaure as dependências e compile a solução em modo Release:

```powershell
dotnet restore Celeris.Client.slnx
dotnet build Celeris.Client.slnx --configuration Release
```

Os arquivos compilados serão gerados em:

```text
src\Celeris.Client\bin\Release\net10.0-windows\
```

O executável não pode estar aberto durante a compilação. Caso o build informe que `Celeris.Client.exe` está sendo usado por outro processo, feche todas as janelas do Client ou encerre o processo antes de tentar novamente:

```powershell
Get-Process Celeris.Client -ErrorAction SilentlyContinue | Stop-Process
```

### Publicação dependente do .NET

Gera uma pasta menor para computadores que já possuem o .NET Desktop Runtime 10 instalado:

```powershell
dotnet publish src\Celeris.Client\Celeris.Client.csproj `
  --configuration Release `
  --runtime win-x64 `
  --self-contained false `
  --output publish
```

### Publicação independente do .NET

Inclui o runtime do .NET e gera um pacote maior, sem exigir uma instalação separada do .NET Desktop Runtime:

```powershell
dotnet publish src\Celeris.Client\Celeris.Client.csproj `
  --configuration Release `
  --runtime win-x64 `
  --self-contained true `
  -p:PublishSingleFile=true `
  --output publish
```

Nos dois casos, o resultado será gravado em `publish\`. O Microsoft WebView2 Evergreen Runtime continua sendo necessário no computador de destino.

Para evitar arquivos antigos de uma publicação anterior, remova ou renomeie a pasta `publish\` antes de gerar uma nova versão.

### Publicação em arquivo único

Para incorporar também as bibliotecas nativas do .NET no executável:

```powershell
dotnet publish src\Celeris.Client\Celeris.Client.csproj `
  --configuration Release `
  --runtime win-x64 `
  --self-contained true `
  -p:PublishSingleFile=true `
  -p:IncludeNativeLibrariesForSelfExtract=true `
  -p:DebugType=None `
  -p:DebugSymbols=false `
  --output publish-single
```

Os arquivos `appsettings.json`, `favorites.json` e `Assets\logo.png` permanecem externos para que endereço, produtos e identidade visual possam ser alterados sem recompilar o Client.

## Criação do instalador

O projeto inclui o script `installer\Celeris.Client.iss` para gerar um instalador Windows com o [Inno Setup](https://jrsoftware.org/isinfo.php).

O instalador:

- instala o Client em `Program Files\Celeris Client`;
- cria um atalho no menu Iniciar;
- oferece um atalho opcional na área de trabalho;
- registra o ícone e o desinstalador no Windows;
- solicita o fechamento do Client quando necessário durante uma atualização;
- inclui os arquivos configuráveis da pasta de publicação.

### 1. Instalar o Inno Setup

Instale pelo Windows Package Manager:

```powershell
winget install --id JRSoftware.InnoSetup --exact
```

Feche e reabra o terminal após a instalação para atualizar o `PATH`.

### 2. Gerar os arquivos para o instalador

Na raiz do repositório, gere uma publicação independente do .NET:

```powershell
dotnet publish src\Celeris.Client\Celeris.Client.csproj `
  --configuration Release `
  --runtime win-x64 `
  --self-contained true `
  -p:PublishSingleFile=true `
  -p:IncludeNativeLibrariesForSelfExtract=true `
  -p:DebugType=None `
  -p:DebugSymbols=false `
  --output publish
```

### 3. Compilar o instalador

Localize o compilador do Inno Setup. O `winget` pode instalá-lo para o usuário atual ou para todos os usuários:

```powershell
$isccCandidates = @(
  "$env:LOCALAPPDATA\Programs\Inno Setup 6\ISCC.exe",
  "$env:ProgramFiles\Inno Setup 6\ISCC.exe",
  "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe"
)

$iscc = $isccCandidates |
  Where-Object { Test-Path -LiteralPath $_ } |
  Select-Object -First 1

if (-not $iscc) {
  throw "ISCC.exe não encontrado. Reinstale o Inno Setup ou verifique o local da instalação."
}

& $iscc installer\Celeris.Client.iss
```

Na instalação padrão por usuário, o caminho normalmente será:

```text
%LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe
```

O instalador será gerado em:

```text
artifacts\Celeris-Client-Setup-0.1.0.exe
```

Para alterar a versão e o nome do arquivo, edite `MyAppVersion` no início de `installer\Celeris.Client.iss` antes da compilação.

### Requisito do WebView2

O instalador do Client não incorpora atualmente o Microsoft WebView2 Evergreen Runtime. Em computadores sem o runtime, instale-o antes de executar o Client. O runtime pode ser obtido na [página oficial do Microsoft WebView2](https://developer.microsoft.com/microsoft-edge/webview2/).

Para implantação em rede hospitalar ou ambiente sem acesso à internet, utilize o instalador Evergreen Standalone e distribua-o pelo mecanismo corporativo de software da instituição.

## Status do projeto

O Celeris Client está em desenvolvimento ativo.

O núcleo de navegação, guias, sessões isoladas, favoritos, pesquisa, temas e política de origens já possui implementação funcional. Novos recursos serão adicionados priorizando segurança, estabilidade, usabilidade e integração com o ecossistema Celeris.

## Projeto relacionado

- [Celeris](https://github.com/bjmvictor/Celeris) — plataforma de gestão e atendimento assistencial multiempresa.

## Licença

A licença do Celeris Client será definida antes da primeira distribuição oficial.
