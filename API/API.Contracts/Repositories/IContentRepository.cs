using API.Entities.Dedicated.Content;
using API.Entities.Enums;

namespace API.Contracts.Repositories
{
    public interface IContentRepository
    {
        public Task<ContentResponse?> GetContentBySlug(ContentRequest request);
    }
}
