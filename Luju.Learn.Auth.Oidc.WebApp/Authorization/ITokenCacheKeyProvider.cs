using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Luju.Learn.Auth.Oidc.WebApp.Authorization
{
    public interface ITokenCacheKeyProvider
    {
        string Key { get; }
        string UserId { get; }
    }
}
