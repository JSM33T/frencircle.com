using API.Contracts.Repositories;
using API.Contracts.Services;
using API.Entities.Dedicated.Content;
using API.Entities.Shared;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;

namespace API.Base.Controllers.Dedicated
{
    [Route("api/content")]
    [ApiController]
    public class ContentController : FoundationController
    {
        private readonly IContentRepository _contetnRepo;
        public ContentController(IOptionsMonitor<Jsm33tConfig> config, ILogger<FoundationController> logger, IHttpContextAccessor httpContextAccessor, ICommonService commonService,IContentRepository contentRepository) : base(config, logger, httpContextAccessor, commonService)
        {
            _contetnRepo = contentRepository;
        }


        [HttpPost]
        public async Task<IActionResult> Contact(ContentRequest request)
        {
            return await ExecuteActionAsync(async () =>
            {
                APIResponse<ContentResponse> apiResponse = new(StatusCodes.Status200OK, "Success", null, []);

                 apiResponse.Data = await _contetnRepo.GetContentBySlug(request) ?? null;

                if (apiResponse.Data == null)
                {
                    return new(StatusCodes.Status404NotFound, "Content not found", null, []);
                }
                await Task.Delay(2000);
                return (apiResponse);

            }, "Contact method");
        }
    }
}
