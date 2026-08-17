using Celeris.Client.Navigation; using Celeris.Client.Sessions; using Celeris.Client.Tabs;
namespace Celeris.Client.Tests;
public sealed class CoreTests
{
 [Fact] public void AllowlistRequiresExactHttpsOrigin() { var p = new NavigationPolicy(["https://celeris.local"]); Assert.True(p.IsInternal(new("https://celeris.local/a"))); Assert.False(p.IsInternal(new("https://evil.celeris.local"))); Assert.False(p.IsInternal(new("http://celeris.local"))); }
 [Fact] public void SessionsHaveIsolatedProfiles() { var m = new SessionManager(); var a = m.CreateSession(); var b = m.CreateSession(); Assert.NotEqual(a.ProfileName, b.ProfileName); Assert.NotEqual(a.Color, b.Color); }
 [Fact] public void TabsShareTheirSession() { var s = new SessionManager().CreateSession(); var m = new TabManager(); m.CreateTab(s, new("https://celeris.local")); m.CreateTab(s, new("https://celeris.local/a")); Assert.All(m.GetTabsForSession(s.Id), t => Assert.Same(s, t.Session)); }
}
