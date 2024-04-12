using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Text.Json;
using System.Collections;
using System.Xml.Linq;

namespace PROG8146_Final.Pages;

public class AddItemModel : PageModel
{
    public List<Item> itemList;

    public Item item = new Item();
    private readonly ILogger<AddItemModel> _logger;

    public AddItemModel(ILogger<AddItemModel> logger)
    {
        _logger = logger;
    }

    public void OnGet()
    {
        itemList = new List<Item>();

        string fileName = "Items.json";
        string jsonDeserializeString = System.IO.File.ReadAllText(fileName);
        List<Item> deserializedPeopleList = JsonSerializer.Deserialize<List<Item>>(
            jsonDeserializeString
        )!;
        itemList = deserializedPeopleList;
    }

    public IActionResult OnPost(Item myItem)
    {
        string fileName = "Items.json";
        string jsonDeserializeString = System.IO.File.ReadAllText(fileName);
        List<Item> deserializedPeopleList = JsonSerializer.Deserialize<List<Item>>(
            jsonDeserializeString
        )!;
        itemList = deserializedPeopleList;

        var newList = itemList.Where<Item>(i => i.ItemNumber != myItem.ItemNumber);

        try
        {
            string saveJson = JsonSerializer.Serialize(newList);

            System.IO.File.WriteAllText(fileName, saveJson);
        }
        catch (Exception e) { }
        return RedirectToPage();
    }
}
