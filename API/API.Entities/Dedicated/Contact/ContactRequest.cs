namespace API.Entities.Dedicated.Contact
{
    public class ContactRequest
    {
        public int Id { get; set; }
        public int FrenId { get; set; } = 0;
        public string Origin { get; set; }
        public required string Message { get; set; }
    }
}
