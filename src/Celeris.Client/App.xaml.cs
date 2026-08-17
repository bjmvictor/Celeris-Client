using System.Windows; using Celeris.Client.Configuration;
namespace Celeris.Client;
public partial class App : Application { protected override void OnStartup(StartupEventArgs e) { base.OnStartup(e); try { new MainWindow(ConfigurationLoader.Load(AppContext.BaseDirectory)).Show(); } catch (Exception ex) { MessageBox.Show($"Não foi possível iniciar.\n\n{ex.Message}", "Celeris", MessageBoxButton.OK, MessageBoxImage.Error); Shutdown(1); } } }
