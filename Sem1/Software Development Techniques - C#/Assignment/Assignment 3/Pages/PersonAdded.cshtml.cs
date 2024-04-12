using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System;

namespace Assignment_3.Pages;

public class PersonAdded : PageModel
{
    // To Catch the data send by PersonInfo
    public Person person = new Person();
    private readonly ILogger<PersonAdded> _logger;

    public PersonAdded(ILogger<PersonAdded> logger)
    {
        _logger = logger;
    }

    // Get the data send by Person Info page and assign it to person object of PersonAdded class
    public void OnGet(Person person)
    {
        this.person = person;
    }
}
