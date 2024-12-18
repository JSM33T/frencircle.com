using API.Entities.Dedicated;
using API.Entities.Dedicated.Contact;
using FluentValidation;

namespace API.Validators
{
    public class ContactRequestValidator : AbstractValidator<ContactRequest>
    {
        public ContactRequestValidator()
        {
            RuleFor(m => m.Message)
                .NotEmpty()
                .WithMessage("Message is required.")
                .Length(1, 155)
                .WithMessage("First name must be between 1 and 50 characters.");
        }
    }
}
