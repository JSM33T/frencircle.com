using API.Contracts.Repositories;
using API.Contracts.Services;
using API.Entities.Dedicated;
using API.Entities.Dedicated.Contact;
using API.Entities.Enums;
using API.Entities.Shared;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace API.Base.Controllers.Dedicated
{
    [Route("api/contact")]
    [ApiController]
    [AllowAnonymous]
    public class ContactController : FoundationController
    {
        private readonly IMessageRepository _messageRepo;
       
        public ContactController(
            IOptionsMonitor<Jsm33tConfig> config, 
            ILogger<FoundationController> logger, 
            IHttpContextAccessor httpContextAccessor, 
            ICommonService commonService,
            IMessageRepository messageRepository) : base(config, logger, httpContextAccessor, commonService)
        {
            _messageRepo = messageRepository;
        }

        [HttpPost]
        public async Task<IActionResult> Contact(ContactRequest request)
        {
            return await ExecuteActionAsync(async () =>
            {
                APIResponse<bool> apiResponse = new(400, "Error", false, []);

                DBResult res = await _messageRepo.AddContactMessage(request);

                if (res == DBResult.Conflict)
                {
                    return new(StatusCodes.Status409Conflict, "Message already exists", false, []);
                }

                else if (res == DBResult.Success)
                {
                    apiResponse = new(StatusCodes.Status200OK, "Message sent", false, []);
                }
                else
                {
                    apiResponse = new(StatusCodes.Status500InternalServerError, "Something went wrong", false, []);
                }

                return (apiResponse);

            }, "Contact method");
        }

    }
}
