using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace Assignment_3.Pages;

public class PostPersonInfo : PageModel
{
    // Person Object to Recieve the Person information
    public Person person = new Person();
    private readonly ILogger<PostPersonInfo> _logger;

    public PostPersonInfo(ILogger<PostPersonInfo> logger)
    {
        _logger = logger;
    }

    public void OnGet() { }

    public IActionResult OnPost(Person person)
    {
        // Send data to Person Added page on save button of form
        return RedirectToPage("PersonAdded", person);
    }
}
