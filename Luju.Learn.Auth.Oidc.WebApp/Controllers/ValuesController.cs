using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Net.Http;
using System.Net.Http.Headers;
using Newtonsoft.Json;
using Microsoft.AspNetCore.Authentication.OpenIdConnect;
using Luju.Learn.Auth.Oidc.WebApp.Authorization;

namespace Luju.Learn.Auth.Oidc.WebApp.Controllers
{
    [Produces("application/json")]
    [Route("api/Values")]
    public class ValuesController : Controller
    {
        IAccessTokenManager _tokenManager;
        public ValuesController(IAccessTokenManager authMgr)
        {
            this._tokenManager = authMgr;
        }

        private const string ValuesApiBaseAddress = "https://localhost:44378";
        // GET: FirstApi
        [HttpGet]
        public async Task<IActionResult> Get()
        {
            List<string> values = new List<string>();

            try
            {
                string accessToken = await _tokenManager.AcquireAccessTokenAsync(HttpContext);
                //
                // Retrieve the user's To Do List.
                //
                HttpClient client = new HttpClient();
                HttpRequestMessage request = new HttpRequestMessage(HttpMethod.Get, ValuesApiBaseAddress + "/api/values");
                request.Headers.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);
                HttpResponseMessage response = await client.SendAsync(request);

                //
                // Return the To Do List in the view.
                //
                if (response.IsSuccessStatusCode)
                {
                    List<String> responseElements = new List<String>();
                    JsonSerializerSettings settings = new JsonSerializerSettings();
                    String responseString = await response.Content.ReadAsStringAsync();
                    responseElements = JsonConvert.DeserializeObject<List<String>>(responseString, settings);
                    foreach (String responseElement in responseElements)
                    {
                        values.Add(responseElement);
                    }

                    return Ok(values);
                }
                else
                {
                    //
                    // If the call failed with access denied, then drop the current access token from the cache, 
                    //     and show the user an error indicating they might need to sign-in again.
                    //
                    if (response.StatusCode == System.Net.HttpStatusCode.Unauthorized)
                    {
                        _tokenManager.RemoveExistingTokens(HttpContext);

                        ViewBag.ErrorMessage = "UnexpectedError";

                    }
                }
            }
            catch (Exception ee)
            {
                if (HttpContext.Request.Query["reauth"] == "True")
                {
                    //
                    // Send an OpenID Connect sign-in request to get a new set of tokens.
                    // If the user still has a valid session with Azure AD, they will not be prompted for their credentials.
                    // The OpenID Connect middleware will return to this controller after the sign-in response has been handled.
                    //
                    return new ChallengeResult(OpenIdConnectDefaults.AuthenticationScheme);
                }

                //
                // The user needs to re-authorize.  Show them a message to that effect.
                //
                /*TodoItem newItem = new TodoItem();
                newItem.Title = "(Sign-in required to view to do list.)";
                itemList.Add(newItem);
                ViewBag.ErrorMessage = "AuthorizationRequired";
                return View(itemList);*/
            }


            //
            // If the call failed for any other reason, show the user an error.
            //
            return View("Error");
        }
    }
}