using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Text.Json;
using System.Collections;

namespace Project.Pages;

public class PersonInfo : PageModel
{
    // Person Object to Recieve the Person information
    public Person person = new Person();
    private readonly ILogger<PersonInfo> _logger;

    public PersonInfo(ILogger<PersonInfo> logger)
    {
        _logger = logger;
    }

    public void OnGet() { }

    public IActionResult OnPost(Person person)
    {
        ArrayList peopleList;

        string fileName = "Person.json";

        if (System.IO.File.Exists(fileName))
        {
            try
            {
                string existingJson = System.IO.File.ReadAllText(fileName);
                peopleList = JsonSerializer.Deserialize<ArrayList>(existingJson) ?? new ArrayList();
            }
            catch 
            {
                peopleList = new ArrayList();
            }
        }
        else
        {
            peopleList = new ArrayList();
        }

        peopleList.Add(person);

        string updatedJson = JsonSerializer.Serialize(peopleList);

        System.IO.File.WriteAllText(fileName, updatedJson);

        return RedirectToPage("PersonList");
    }
}
