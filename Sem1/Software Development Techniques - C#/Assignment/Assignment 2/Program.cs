/* Assignment 2: Create a C# Console application that is a reservation system for a car rental company.
The company provides services for three different types of customers: Regular, Premium, and VIP.*/

using System.Dynamic;
using System.Text.RegularExpressions;

class Service
{
    public List<string> additionalServicesList = new List<string>
    {
        "1. Regular - GPS Navigation - $9.99/day",
        "2. Premium - Child Car Seat - $14.99/day",
        "3. VIP - Chauffeur Service - $99.99/day"
    };
    public List<string> carRentalServiceList = new List<string>
    {
        "1. Economy Car Rental - $29.99/day",
        "2. Standard Car Rental - $49.99/day",
        "3. Luxury Car Rental - $79.99/day"
    };

    public List<string> validCustomerTypes = new List<string> { "premium", "regular", "vip" };
}

class Customer
{
    public Customer() { }

    public Customer(
        string customerId,
        string customerName,
        int customerPhoneNo,
        string customerType,
        string carRentalService,
        string additionalServices
    )
    {
        this.customerId = customerId;
        this.customerName = customerName;
        this.customerPhoneNo = customerPhoneNo;
        this.customerType = customerType;
        this.carRentalService = carRentalService;
        this.additionalServices = additionalServices;
    }

    public string? customerId { get; set; }
    public string? customerName;
    public int customerPhoneNo;
    public string? customerType;
    public string? carRentalService;
    public string? additionalServices;
}

class Reservation : Service
{
    public List<Customer> listOfResevation = new List<Customer>();

    public void displayOption()
    {
        Console.WriteLine(
            "Choose an option below:\n1. Create a reservation \n2. List all reservations\n3. Clear all reservations\n4. Exit the program"
        );
    }

    private bool IsValidCustomerId(string id)
    {
        string pattern = @"^[a-zA-Z0-9]{6}$";
        Regex regex = new Regex(pattern);
        return regex.IsMatch(id);
    }

    //Create new custome for reservation
    public void createResrvation()
    {
        try
        {
            Customer newCustomer = new Customer();

            Console.WriteLine("Enter customer information:");

            //Custome Id input and validation
            Console.Write("Customer ID (6 digit alphanumeric): ");
            do
            {
                newCustomer.customerId = Console.ReadLine();
                newCustomer.customerId = newCustomer.customerId!.Trim();

                if (!IsValidCustomerId(newCustomer.customerId))
                {
                    Console.WriteLine("Please, Enter valid input");
                }
            } while (!IsValidCustomerId(newCustomer.customerId));

            //Customer Name as Input
            Console.Write("Name: ");
            newCustomer.customerName = Console.ReadLine();

            //Custome Phone Number input and validation
            Console.Write("Phone Number(10 digit number only): ");
            bool isValidPhoneNumber = true;
            do
            {
                isValidPhoneNumber = int.TryParse(
                    Console.ReadLine(),
                    out newCustomer.customerPhoneNo
                );

                if (!(isValidPhoneNumber || newCustomer.customerPhoneNo.ToString().Length == 8))
                {
                    Console.WriteLine("Please, Enter valid input");
                }
            } while (!(isValidPhoneNumber || newCustomer.customerPhoneNo.ToString().Length == 8));

            //Custome Type input and validation
            Console.Write("Customer Type (Regular, Premium, VIP) :");
            do
            {
                newCustomer.customerType = Console.ReadLine();
                newCustomer.customerType = newCustomer.customerType!.Trim();
                newCustomer.customerType = newCustomer.customerType.ToLower();

                if (!validCustomerTypes.Contains(newCustomer.customerType))
                {
                    Console.WriteLine("Please, Enter valid input");
                }
            } while (!validCustomerTypes.Contains(newCustomer.customerType));

            //Assigning additional service to cutomer according to cutomer type
            if (newCustomer.customerType == "regular")
            {
                newCustomer.additionalServices = "GPS Navigation";
            }
            else if (newCustomer.customerType == "premium")
            {
                newCustomer.additionalServices = "Child Car Seat";
            }
            else
            {
                newCustomer.additionalServices = "Chauffeur Service";
            }

            //Custome Car Type Service input and validation
            Console.WriteLine(
                "Choose the number corresponding to the car type the customer wants: \n"
            );

            foreach (var item in carRentalServiceList)
            {
                Console.WriteLine("{0}", item);
            }

            bool isValidCarService = true;
            int carServiceNumber;
            do
            {
                isValidCarService = int.TryParse(Console.ReadLine(), out carServiceNumber);

                if (!isValidCarService || !(new[] { 1, 2, 3 }.Contains(carServiceNumber)))
                {
                    Console.WriteLine("Please, Enter valid input");
                }
            } while (!isValidCarService || !(new[] { 1, 2, 3 }.Contains(carServiceNumber)));

            //Assigning value to car rental service type
            if (carServiceNumber == 1)
            {
                newCustomer.carRentalService = "Economy";
            }
            else if (carServiceNumber == 2)
            {
                newCustomer.carRentalService = "Standard";
            }
            else
            {
                newCustomer.carRentalService = "Luxury";
            }

            // Asking for additional service
            Console.WriteLine(
                "\nDoes the customer want this additional service?\n {0}",
                newCustomer.additionalServices
            );

            do
            {
                newCustomer.additionalServices = Console.ReadLine();
                newCustomer.additionalServices = newCustomer.additionalServices!.Trim();
                newCustomer.additionalServices = newCustomer.additionalServices.ToLower();

                if (!new[] { "yes", "no" }.Contains(newCustomer.additionalServices))
                {
                    Console.WriteLine("Please, Enter valid input: ");
                }
                else
                {
                    Console.WriteLine("Thank you! The reservation was successful.");
                    listOfResevation.Add(newCustomer);
                }
            } while (!new[] { "yes", "no" }.Contains(newCustomer.additionalServices));
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            return;
        }
    }

    public void listAllReservation()
    {
        try
        {
            for (int i = 0; i < listOfResevation.Count; i++)
            {
                Console.WriteLine("Reservation {0}:", i + 1);
                Console.WriteLine("Customer ID: {0}", listOfResevation[i].customerId);
                Console.WriteLine("Name: {0}", listOfResevation[i].customerName);
                Console.WriteLine("Phone Number: {0}", listOfResevation[i].customerPhoneNo);
                Console.WriteLine(
                    "Customer Type: {0}",
                    listOfResevation[i].customerType!.ToUpper()
                );
                Console.WriteLine("Car Type: {0}", listOfResevation[i].carRentalService);
                Console.WriteLine(
                    "Additional Service: {0}\n\n",
                    listOfResevation[i].additionalServices
                );
            }
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            return;
        }
    }

    public void clearAllReservation()
    {
        listOfResevation.Clear();
        Console.WriteLine("All Reservation has been Cleared");
    }

    public void exitProgram()
    {
        return;
    }
}

class MainClass
{
    public static void Main(string[] args)
    {
        Reservation reservation = new Reservation();

        Customer customer1 = new Customer(
            "ABC123",
            "Harit",
            1234567890,
            "premium",
            "Luxury",
            "yes"
        );

        Customer customer2 = new Customer(
            "XYZ123",
            "Pankaj",
            0987654321,
            "regular",
            "Standard",
            "yes"
        );

        Customer customer3 = new Customer("MSD123", "Raj", 1234509876, "premium", "Economy", "no");

        reservation.listOfResevation.Add(customer1);
        reservation.listOfResevation.Add(customer2);
        reservation.listOfResevation.Add(customer3);

        reservation.displayOption();

        int selectedOption;
        // To Check given input is valid or not
        bool isValidOption = true;
        do
        {
            isValidOption = int.TryParse(Console.ReadLine(), out selectedOption);
            if (!isValidOption)
            {
                Console.WriteLine("Please, Enter valid input");
            }
        } while (!isValidOption);

        switch (selectedOption)
        {
            case 1:
                reservation.createResrvation();
                break;
            case 2:
                reservation.listAllReservation();
                break;
            case 3:
                reservation.clearAllReservation();
                break;
            case 4:
                reservation.exitProgram();
                break;
            default:
                Console.WriteLine("Invalid Input");
                break;
        }
    }
}
