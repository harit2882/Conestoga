// See https://aka.ms/new-console-template for more information

//LAB 4 : Write a simple Grocery Kiosk program.
public class GroceryKiosk
{
    public static void Main(string[] args)
    {
        Item item = new Item();
        int quantity;
        double weight;

        Console.Write("Please enter a fruit or vegetable: ");
        item.name = Console.ReadLine()!;

        Console.Write("\nHow many {0}s did you purchase: ", item.name);
        if (int.TryParse(Console.ReadLine(), out quantity))
        {
            item.quantity = quantity;
        }
        else
        {
            Console.WriteLine("Invalid Input, Try Again");
            return;
        }

        Console.Write("\nHow much did the {0}s weigh, in total: ", item.name);
        if (double.TryParse(Console.ReadLine(), out weight))
        {
            item.weight = weight;
        }
        else
        {
            Console.WriteLine("Invalid Input, Try Again");
            return;
        }

        item.finalOutput();
    }
}

class Item
{
    public string? name { get; set; }
    public int quantity { get; set; }
    public double weight { get; set; }

    public double findAverage()
    {
        return weight / quantity;
    }

    public void finalOutput()
    {
        Console.WriteLine(
            "{0} {1} with average weight of {2} lbs",
            quantity,
            name,
            Math.Round(findAverage(), 2)
        );
    }
}
