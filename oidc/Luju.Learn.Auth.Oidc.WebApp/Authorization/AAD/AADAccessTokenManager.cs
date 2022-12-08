using System;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authentication.OpenIdConnect;
using Microsoft.IdentityModel.Clients.ActiveDirectory;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.AspNetCore.Builder;
using Microsoft.IdentityModel.Protocols.OpenIdConnect;
using System.Linq;
using Microsoft.Extensions.DependencyInjection;

namespace Luju.Learn.Auth.Oidc.WebApp.Authorization.AAD
{
    public class AADAccessTokenManager : IAccessTokenManager
    {
        private AADConfiguration _config;
        private readonly IServiceProvider _serviceProvider;

        public AADAccessTokenManager(IConfigurationRoot config, IServiceProvider serviceProvider)
        {
            _config = new AADConfiguration();
            config.GetSection("Authentication:AzureAd").Bind(_config);
            _serviceProvider = serviceProvider;
        }

        public OpenIdConnectOptions ConnectionOptions
        {
            get
            {
                return new OpenIdConnectOptions
                {
                    ClientId = _config.ClientId,
                    Authority = _config.Authority,
                    CallbackPath = _config.CallbackPath,
                    ResponseType = OpenIdConnectResponseType.CodeIdToken,
                    GetClaimsFromUserInfoEndpoint = false,
                    Events = new OpenIdConnectEvents
                    {
                        OnAuthorizationCodeReceived = OnAuthorizationCodeReceived,
                    }
                };
            }
        }

        public async Task<string> AcquireAccessTokenAsync(HttpContext context)
        {
            TokenCache tc = _serviceProvider.GetService<TokenCache>();
            string userObjectID = _serviceProvider.GetService<ITokenCacheKeyProvider>().UserId;
            AuthenticationContext authContext = new AuthenticationContext(_config.Authority, tc);
            ClientCredential credential = new ClientCredential(_config.ClientId, _config.ClientSecret);
            AuthenticationResult result = await authContext.AcquireTokenSilentAsync(_config.ApiResourceId, credential, new UserIdentifier(userObjectID, UserIdentifierType.UniqueId));
            return result.AccessToken;
        }

        public async Task OnAuthorizationCodeReceived(AuthorizationCodeReceivedContext context)
        {
            // Acquire a Token for the Graph API and cache it using ADAL.  In the TodoListController, we'll use the cache to acquire a token to the Todo List API
            context.HttpContext.User = context.Ticket.Principal;
            _serviceProvider.GetService<IHttpContextAccessor>().HttpContext = context.HttpContext;
            
            TokenCache tc = _serviceProvider.GetService<TokenCache>();
            ClientCredential clientCred = new ClientCredential(_config.ClientId, _config.ClientSecret);
            AuthenticationContext authContext = new AuthenticationContext(_config.Authority, tc);
            AuthenticationResult authResult = await authContext.AcquireTokenByAuthorizationCodeAsync(
                context.ProtocolMessage.Code, new Uri(context.Properties.Items[OpenIdConnectDefaults.RedirectUriForCodePropertiesKey]), clientCred, "https://graph.windows.net");
            
            // Notify the OIDC middleware that we already took care of code redemption.
            context.HandleCodeRedemption();
            context.HandleResponse();
        }

        public void RemoveExistingTokens(HttpContext context)
        {
            TokenCache tc = _serviceProvider.GetService<TokenCache>();
            var todoTokens = tc.ReadItems().Where(a => a.Resource == _config.ApiResourceId);
            foreach (TokenCacheItem tci in todoTokens)
                tc.DeleteItem(tci);
        }
    }
}
