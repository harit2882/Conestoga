// See https://aka.ms/new-console-template for more information


/* Assignment 1 ==> Create a C# console application for a grocery billing system that allows customers to select items, 
apply a loyalty card discount, and calculate the final cost with tax. */

class Assignment1{

    static void Main(string[] args) {

        // Grocery Item List
        List<Item> items = new List<Item>
        {
            new Item("Apple",1.00),
            new Item("Banana",0.50),
            new Item("Milk",2.50),
            new Item("Bread",2.00),
            new Item("Eggs",1.75),

        };

        bool isLoyaltyCard = false;
        double subTotal = 0;
        double total = 0;
        double discount = 0;
        double tax = 0;

        // Displaying Student Information
        Console.WriteLine("Name: Harit Thoriya\nStudent Number: 8953007\nEmai: thoriyaharit@gmail.com\n\n");

        //Displaying All Grocery Items
        Console.WriteLine("Available Grocery Items:");
        foreach(Item item in items){

            Console.WriteLine("{0} - $ {1}",item.name,Math.Round(item.price,2));
        }

        Console.WriteLine();


        //Getting Input For Quantity of Each Item
        foreach(Item item in items){

            bool isValid = true;
            int quantity;
            
            do {

                if(isValid){
                    Console.Write("Enter the quantity of {0} (0 for none): ",item.name);
                }else{
                    Console.Write("Enter valid input for quantity of {0} (0 for none): ",item.name);
                }

                //Validating Input of Quantity of Item. If not, then ask again for valid input 
                isValid = int.TryParse(Console.ReadLine(),out quantity);
                item.quantity = quantity;
            
            } while(!isValid);
        }

        //Getting Input For Loyalty Card With Validation 
        bool isValidInput = true;
        string? loyalty;
        do {

            if(isValidInput){
                Console.Write("\nDo you have a loyalty card? (yes/no):");
            }else{
                Console.Write("\nEnter Valid Input (yes/no):");
            }

            
            loyalty = Console.ReadLine();

            // Input for loyalty is not null and is yes or no
            if(loyalty != null && (loyalty.Trim().ToLower() == "yes" || loyalty.Trim().ToLower() == "y"))
            {
                isLoyaltyCard = true;
                isValidInput = true;
            }else if(loyalty != null && (loyalty.Trim().ToLower() == "no" || loyalty.Trim().ToLower() =="n"))
            {
                isLoyaltyCard = false;
                isValidInput = true;
            }else{
                isValidInput = false;
            }

        } while (!isValidInput);


        //Displaying Receipt for selected items
        Console.WriteLine("\nReceipt:");
        foreach(Item item in items.Where(i => i.quantity > 0)){
            Console.WriteLine("{0} x{1}",item.name,item.quantity);
            subTotal += (item.quantity * item.price);
        }

        
        //Logic for calculating subtotal, discount, tax and total
        if(isLoyaltyCard){
            discount = subTotal/10;
        }
        total = subTotal;
        total -= discount;
        tax = total * 0.13;
        total += tax;


        // Displaying subtotal, discount, tax and total cost
        Console.WriteLine("\nSubtotal: ${0}\nDiscount: ${1}\nTax (13%): ${2}\nTotal cost: ${3}",
        Math.Round(subTotal,2),Math.Round(discount,2),Math.Round(tax,2),Math.Round(total,2));

    }
}

class Item{
    public string name { get; set;}
    public double price{ get; set; }
    public int quantity{ get; set; }

    public Item(string name,double price){
        this.name = name;
        this.price = price;
    }

}
