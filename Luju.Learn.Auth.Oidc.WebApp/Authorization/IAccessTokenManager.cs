using Microsoft.AspNetCore.Authentication.OpenIdConnect;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Http;
using System.Threading.Tasks;

namespace Luju.Learn.Auth.Oidc.WebApp.Authorization
{
    public interface IAccessTokenManager
    {
        OpenIdConnectOptions ConnectionOptions { get; }
        Task<string> AcquireAccessTokenAsync(HttpContext context);
        void RemoveExistingTokens(HttpContext context);

    }
}
