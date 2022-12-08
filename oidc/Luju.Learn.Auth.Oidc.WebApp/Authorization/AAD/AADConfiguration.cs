using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Luju.Learn.Auth.Oidc.WebApp.Authorization.AAD
{
    public class AADConfiguration
    {
        public string AADInstance { get; set; }
        public string CallbackPath { get; set; }
        public string ClientId { get; set; }
        public string ClientSecret { get; set; }
        public string ApiResourceId { get; set; }
        public string Domain { get; set; }
        public string TenantId { get; set; }
        public string Authority { get { return AADInstance + TenantId; } }
    }
}
