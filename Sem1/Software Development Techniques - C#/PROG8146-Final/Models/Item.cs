public class Item
{
    // Class Variables
    public int ItemNumber { get; set; }
    public string? ItemName { get; set; }
    public double Cost { get; set; }
    public int Quantity { get; set; }

    //Default Constructor
    public Item() { }

    // ParaMeterized Constructor
    public Item(int itemNumber, string? itemName, double cost, int quantity)
    {
        ItemNumber = itemNumber;
        ItemName = itemName;
        Cost = cost;
        Quantity = quantity;
    }
}
