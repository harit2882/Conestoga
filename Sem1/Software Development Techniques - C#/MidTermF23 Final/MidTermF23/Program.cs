// See https://aka.ms/new-console-template for more information
//Create a C# Console program that simulates an inventory management system for a small bookstore.

using System.Globalization;
using System.Threading.Tasks.Dataflow;

class Book
{
    //Default Empty Constructor
    public Book() { }

    // Parameterized Constructor to add hardcore
    public Book(string bookTitle, string bookAuthor, int bookQuantity, double bookPrice)
    {
        this.bookTitle = bookTitle;
        this.bookAuthor = bookAuthor;
        this.bookQuantity = bookQuantity;
        this.bookPrice = bookPrice;
    }

    public string? bookTitle;
    public string? bookAuthor;
    public int bookQuantity;
    public double bookPrice;
}

class BookStore
{
    protected string? bookStoreName;
    protected string? bookStoreAddress;
    protected List<Book> bookStoreInventory = new List<Book>();
    protected string? bookStoreOwnerFName;
    protected string? bookStoreOwnerLName;

    public BookStore(
        string bookStoreName,
        string bookStoreAddress,
        string bookStoreOwnerFName,
        string bookStoreOwnerLName
    )
    {
        this.bookStoreName = bookStoreName;
        this.bookStoreAddress = bookStoreAddress;
        this.bookStoreOwnerFName = bookStoreOwnerFName;
        this.bookStoreOwnerLName = bookStoreOwnerLName;
    }
}

class BookStoreServices : BookStore
{
    public BookStoreServices(
        string bookStoreName,
        string bookStoreAddress,
        string bookStoreOwnerFName,
        string bookStoreOwnerLName
    )
        : base(bookStoreName, bookStoreAddress, bookStoreOwnerFName, bookStoreOwnerLName)
    {
        // Displaying Information Of Store At The Begining Of The Program
        Console.WriteLine("Book Store Name: {0}", bookStoreName);
        Console.WriteLine("Book Store Address: {0}", bookStoreAddress);
        Console.WriteLine("Owner Name: {0} {1}", bookStoreOwnerFName, bookStoreOwnerLName);
    }

    // Display Menu For Selecting BookStore Service - Add, Delete, Display Book
    public void displayMenu()
    {
        Console.WriteLine(
            "\n1. Add a new book to the inventory\n2. Display all books\n3. Delete an individual book\n4. Clear Inventory\n5. Exit the program."
        );
        Console.WriteLine("---------------------------------------");
    }

    // Function For Adding Hardcoded Book To Inventory
    public void addHardCodeBook(Book book)
    {
        bookStoreInventory.Add(book);
    }

    // Function To Add New Book To The Inventory
    public void addNewBook()
    {
        try
        {
            Book book = new Book();

            Console.WriteLine("\nAdding new book : ");
            Console.Write("\nBook Title : ");
            book.bookTitle = Console.ReadLine();

            Console.Write("Book Author : ");
            book.bookAuthor = Console.ReadLine();

            Console.Write("Book Quantity : ");
            bool isValidQuantity = true;
            // Validating input for quantity and ask till the right input
            do
            {
                isValidQuantity = int.TryParse(Console.ReadLine(), out book.bookQuantity);

                if (!isValidQuantity)
                {
                    Console.Write("Please, Enter Quantity in Number: ");
                }
            } while (!isValidQuantity);

            Console.Write("Book Price : ");
            bool isValidPrice = true;
            // Validating input for quantity and ask till the right input
            do
            {
                isValidPrice = double.TryParse(Console.ReadLine(), out book.bookPrice);

                if (!isValidPrice)
                {
                    Console.Write("Please, Enter valid input for price : ");
                }
            } while (!isValidPrice);
            bookStoreInventory.Add(book);

            // Displaying All Book After Adding New Book To Inventory
            Console.WriteLine("\nBooks in Inventory : ");
            for (var i = 0; i < bookStoreInventory.Count; i++)
            {
                Console.WriteLine("  {0}. {1}", i + 1, bookStoreInventory[i].bookTitle);
            }
        }
        catch (Exception e)
        {
            Console.WriteLine("Error in Adding Book : {0}", e);
        }
    }

    //Function For Displaying All Book In Inventory
    public void displayAllBook()
    {
        Console.WriteLine("\nDisplaying All Book In Inventory :");

        double totalInventoryPrice = 0;

        if (bookStoreInventory.Count > 0)
        {
            int i = 1;
            foreach (var book in bookStoreInventory)
            {
                //Displaying Book Information
                Console.WriteLine("\n{0}.", i);
                i++;
                Console.WriteLine(" Book Title : {0}", book.bookTitle);
                Console.WriteLine(" Book Author : {0}", book.bookAuthor);
                Console.WriteLine(" Book Quantity : {0}", book.bookQuantity);
                Console.WriteLine(
                    " Book Price per Unit : {0}",
                    book.bookPrice.ToString("C", CultureInfo.CurrentCulture)
                );

                // Calculate And Display Price Of Book Quantity
                double sumOfBookPrice = book.bookPrice * book.bookQuantity;
                Console.WriteLine(
                    " Sum of Book's price : {0}",
                    sumOfBookPrice.ToString("C", CultureInfo.CurrentCulture)
                );

                // Calculate The Price Of All The Books In Inventory
                totalInventoryPrice = totalInventoryPrice + sumOfBookPrice;
            }

            // Displaying All Book Price
            Console.WriteLine(
                "\nTotal All Book Price : {0}",
                totalInventoryPrice.ToString("C", CultureInfo.CurrentCulture)
            );
        }
        else
        {
            Console.WriteLine("No Book In Inventory");
        }
    }

    // Deleting Individual Book From The Inventory By Book Number
    public void deleteBook()
    {
        try
        {
            if (bookStoreInventory.Count > 0)
            {
                Console.WriteLine("Delete Book : ");

                // Displaying Book List
                for (var i = 0; i < bookStoreInventory.Count; i++)
                {
                    Console.WriteLine("  {0}. {1}", i + 1, bookStoreInventory[i].bookTitle);
                }

                // Getting Input From The User To Delete Book And Validating Input
                Console.Write("Enter book number that you want to delete : ");
                bool isValidBookNumber = true;
                int bookNumber;
                do
                {
                    isValidBookNumber = int.TryParse(Console.ReadLine(), out bookNumber);

                    if (!(isValidBookNumber || bookNumber < bookStoreInventory.Count))
                    {
                        Console.Write("Please, Enter valid number : ");
                    }
                    else
                    {
                        // Deleting Book From Inventory
                        bookStoreInventory.RemoveAt(bookNumber - 1);
                    }
                } while (!(isValidBookNumber || bookNumber < bookStoreInventory.Count));

                Console.WriteLine("Book has been deleted");

                // Displaying Book List After Deleting Book From Inventory
                for (var i = 0; i < bookStoreInventory.Count; i++)
                {
                    Console.WriteLine("  {0}. {1}", i + 1, bookStoreInventory[i].bookTitle);
                }
            }
            else
            {
                Console.WriteLine("No Book In Inventory");
            }
        }
        catch (Exception)
        {
            Console.WriteLine("Error in Deleting : Enter Book Number From Given List Of Book ");
        }
    }

    //Deleting All Book From Inventory
    public void clearInventory()
    {
        bookStoreInventory.Clear();
        Console.WriteLine("All Books from inventory have been deleted successfully");
    }
}

class MainClass
{
    public static void Main(string[] args)
    {
        BookStoreServices bookStore = new BookStoreServices(
            "BuyBooks",
            "123 XYZ street",
            "Harit",
            "Thoriya"
        );

        Book book1 = new Book("Death", "Sadhguru", 10, 25);
        Book book2 = new Book("Karma", "Sadhguru", 5, 30);
        Book book3 = new Book("Half Girlfriend", "Chetan Bhagat", 20, 20);

        // Adding HardCode Book Information To Inventory
        bookStore.addHardCodeBook(book1);
        bookStore.addHardCodeBook(book2);
        bookStore.addHardCodeBook(book3);

        //Displaing Bookstore Service Option Untill User Exit The Program
        while (true)
        {
            // Function To Display Menu
            bookStore.displayMenu();

            // Validating Selected Input
            int selectedOption;
            bool isValidOption = true;
            do
            {
                Console.Write("\nChoose Option From Menu : ");
                isValidOption = int.TryParse(Console.ReadLine(), out selectedOption);
                if (!isValidOption)
                {
                    Console.WriteLine("Please, Enter valid input");
                }
            } while (!isValidOption);

            switch (selectedOption)
            {
                case 1:
                    bookStore.addNewBook();
                    Console.WriteLine("---------------------------------------");
                    break;
                case 2:
                    bookStore.displayAllBook();
                    Console.WriteLine("---------------------------------------");
                    break;
                case 3:
                    bookStore.deleteBook();
                    Console.WriteLine("---------------------------------------");
                    break;
                case 4:
                    bookStore.clearInventory();
                    Console.WriteLine("---------------------------------------");
                    break;
                case 5:
                    Console.WriteLine("Program has been exited");
                    return;
                default:
                    Console.WriteLine("Invalid Input");
                    break;
            }
        }
    }
}
