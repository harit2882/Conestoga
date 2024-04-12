// See https://aka.ms/new-console-template for more information

//Part 2: Enhanced Grocery Kiosk Program with Loops

try
{
    string addItem = "yes";

    while (addItem == "yes")
    {
        Console.WriteLine("Please enter a fruit or vegetable:");
        string fruitName = Console.ReadLine()!;

        Console.WriteLine("\nHow many {0}s did you purchase:", fruitName);
        int fruitQuantity = int.Parse(Console.ReadLine()!);

        Console.WriteLine("\nHow much did the {0}s weigh, in total:", fruitName);
        double fruitWeight = double.Parse(Console.ReadLine()!);

        double avgWeight = fruitWeight / fruitQuantity;

        Console.WriteLine(
            "\nI purchased {0} {1} with average weight of {2} lbs",
            fruitQuantity,
            fruitName,
            Math.Round(avgWeight, 2)
        );

        Console.WriteLine("\nDo you want to enter another item? (yes/no):");
        addItem = Console.ReadLine()!;
    }
}
catch (Exception e)
{
    Console.WriteLine(e);
}
