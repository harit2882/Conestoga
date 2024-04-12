using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Text.Json;
using System.Collections;
using System.Xml.Linq;

namespace PROG8146_Final.Pages;

public class ItemsModel : PageModel
{
    public Item item = new Item();
    public List<Item> itemList;
    private readonly ILogger<ItemsModel> _logger;

    public ItemsModel(ILogger<ItemsModel> logger)
    {
        _logger = logger;
    }

    public void OnGet() { }

    public IActionResult OnPostSaveItem()
    {
        try
        {
            string fileName = "Items.json";
            string saveJson = JsonSerializer.Serialize(itemList);
            System.IO.File.WriteAllText(fileName, saveJson);
        }
        catch (Exception e)
        {
            // Handle exceptions if needed
            return BadRequest(e.Message);
        }

        return RedirectToPage();
    }

    public IActionResult OnPost(Item item)
    {
        string fileName = "Items.json";

        if (System.IO.File.Exists(fileName) && itemList == null)
        {
            string existingJson = System.IO.File.ReadAllText(fileName);
            itemList = JsonSerializer.Deserialize<List<Item>>(existingJson) ?? new List<Item>();
            Console.WriteLine("Inside if ");
        }
        else if (itemList == null)
        {
            itemList = new List<Item>();
            Console.WriteLine("Inside else if 1");
        }
        else
        {
            Console.WriteLine("Inside else");
        }

        itemList.Add(item);

        Console.WriteLine(itemList.Count);

        return Partial("ItemList", itemList);
    }

    public IActionResult OnPostLoadItem()
    {
        return RedirectToPage("AddItem");
    }
}
