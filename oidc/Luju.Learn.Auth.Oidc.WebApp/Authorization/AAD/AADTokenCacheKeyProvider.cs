using Luju.Learn.Auth.Oidc.WebApp.Authorization.TokenCaches;
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Luju.Learn.Auth.Oidc.WebApp.Authorization.AAD
{
    public class AADTokenCacheKeyProvider : ITokenCacheKeyProvider
    {
        private IHttpContextAccessor _httpContextAccessor;
        public AADTokenCacheKeyProvider(IHttpContextAccessor httpContextAccessor)
        {
            this._httpContextAccessor = httpContextAccessor;
        }
                    
        public string Key {
            get
            {
                return $"TokenCache_{UserId}";
            }
        }

        public string UserId
        {
            get
            {
                HttpContext ctx = _httpContextAccessor.HttpContext;
                string userId = (ctx.User.FindFirst("http://schemas.microsoft.com/identity/claims/objectidentifier"))?.Value;
                return userId;
            }
        }
    }
}
