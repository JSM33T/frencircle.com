using API.Entities.Dedicated.Contact;
using API.Entities.Enums;

namespace API.Contracts.Repositories
{
    public interface IMessageRepository
    {
        /// <summary>
        /// Retrieves user details by ID.
        /// </summary>
        Task<DBResult> AddContactMessage(ContactRequest request);
    }
}
