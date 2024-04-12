using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Text.Json;
using System.Collections;

namespace Project.Pages;

public class PersonList : PageModel
{
    public List<Person> personList = new List<Person>();
    private readonly ILogger<PersonList> _logger;

    public PersonList(ILogger<PersonList> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
        string fileName = "Person.json";
        string jsonDeserializeString = System.IO.File.ReadAllText(fileName);
        List<Person> deserializedPeopleList = JsonSerializer.Deserialize<List<Person>>(
            jsonDeserializeString
        )!;
        personList = deserializedPeopleList;
    }
}
