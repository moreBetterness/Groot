using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(groot.Startup))]
namespace groot
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
