using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Caching.Distributed;
using Microsoft.IdentityModel.Clients.ActiveDirectory;
using System;

namespace Luju.Learn.Auth.Oidc.WebApp.Authorization.TokenCaches
{
    internal class DistributedTokenCache : TokenCache
    {
        private readonly IDistributedCache cache;
        private readonly string cacheKey;

        public DistributedTokenCache(IDistributedCache cache, ITokenCacheKeyProvider cacheKeyProvider)
        {
            this.cacheKey = cacheKeyProvider.Key;
            this.cache = cache;

            BeforeAccess = OnBeforeAccess;
            AfterAccess = OnAfterAccess;
        }

        private void OnBeforeAccess(TokenCacheNotificationArgs args)
        {
            try
            {
                var userTokenCachePayload = cache.Get(cacheKey);
                if (userTokenCachePayload != null)
                {
                    Deserialize(userTokenCachePayload);
                }
            } catch (Exception)
            {
                // TODO: Exception Handling. Occurs for example when Redis is not available RedisConnectionException
            }
        }

        private void OnAfterAccess(TokenCacheNotificationArgs args)
        {
            if (HasStateChanged)
            {
                var cacheOptions = new DistributedCacheEntryOptions
                {
                    AbsoluteExpirationRelativeToNow = TimeSpan.FromDays(14)
                };

                try
                {
                    cache.Set(cacheKey, Serialize(), cacheOptions);

                    HasStateChanged = false;
                } catch (Exception)
                {
                    // TODO: Exception Handling. Occurs for example when Redis is not available RedisConnectionException
                }
            }
        }
        
    }
}
