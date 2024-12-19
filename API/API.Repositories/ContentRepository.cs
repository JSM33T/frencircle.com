using API.Contracts.Repositories;
using API.Contracts.Services;
using API.Entities.Dedicated.Contact;
using API.Entities.Dedicated.Content;
using API.Entities.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace API.Repositories
{
    public class ContentRepository : IContentRepository
    {

        private readonly IDataService _dataService;
        public ContentRepository(IDataService dataService)
        {
            _dataService = dataService;
        }
        public async Task<ContentResponse?> GetContentBySlug(ContentRequest request)
        {
            var parameters = new
            {
                Slug = request.Slug,
                Type = request.Type
            };


            ContentResponse? resp =  await _dataService.QueryFirstOrDefaultAsync<ContentResponse>("SELECT * FROM tblContent where Slug = @Slug and TypeId = @Type",parameters) ?? null;


            return resp;
        }
       
    }
}
