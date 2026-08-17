#define MyAppName "Celeris Client"
#define MyAppVersion "0.1.0"
#define MyAppPublisher "Celeris"
#define MyAppExeName "Celeris.Client.exe"

[Setup]
AppId={{D094CC65-6027-4FA5-91D6-1219B8CA3435}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={autopf}\Celeris Client
DefaultGroupName=Celeris Client
DisableProgramGroupPage=yes
OutputDir=..\artifacts
OutputBaseFilename=Celeris-Client-Setup-{#MyAppVersion}
SetupIconFile=..\src\Celeris.Client\Assets\app.ico
UninstallDisplayIcon={app}\{#MyAppExeName}
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
PrivilegesRequired=admin
CloseApplications=yes
RestartApplications=no

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Tasks]
Name: "desktopicon"; Description: "Criar um atalho na área de trabalho"; GroupDescription: "Atalhos adicionais:"; Flags: unchecked

[Files]
Source: "..\publish\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\Celeris Client"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\Celeris Client"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Executar o Celeris Client"; Flags: nowait postinstall skipifsilent
