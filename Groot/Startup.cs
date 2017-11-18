using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Groot.Startup))]
namespace Groot
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
