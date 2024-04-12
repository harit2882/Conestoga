// See https://aka.ms/new-console-template for more information

class Customer:Service{


    public string? custFirstName;
    public string? custLastName;
    public string? custEmail;
    public List<string> custServices = new List<string>();
    public int numberOfServices;
    public DateTime custAppointmentTime;
    public double totalCost;

    public Customer(){}

    public Customer(string custFirstName, string custLastName, string custEmail, List<string> custServices, int numberOfServices, DateTime custAppointmentTime, double totalCost)
    {
        this.custFirstName = custFirstName;
        this.custLastName = custLastName;
        this.custEmail = custEmail;
        this.custServices = custServices;
        this.numberOfServices = numberOfServices;
        this.custAppointmentTime = custAppointmentTime;
        this.totalCost = totalCost;
    }

    public void getCustomerServices(){

        Console.Write("Services : ");

        foreach (var item in services)
        {
            Console.WriteLine("\n{0} - ${1}", item.Key, item.Value);
        }

        Console.Write("\n Enter Numbers of service you want (1 to 3): ");
        int.TryParse(Console.ReadLine(), out numberOfServices);
    

        Console.WriteLine("Numbers of servise = {0}", numberOfServices);

        for (int i=0;i<numberOfServices;i++){
            int serviceNumber;
            bool isValid = true;

            Console.Write("Select {0} service : ",i+1);

            do {
                
                isValid = int.TryParse(Console.ReadLine(),out serviceNumber);

                if(isValid){
                    switch(serviceNumber){
                    case 1:
                        custServices.Add(services.ElementAt(0).Key);
                        totalCost = totalCost + services.ElementAt(0).Value;
                        break;
                    case 2:
                        custServices.Add(services.ElementAt(1).Key);
                            totalCost = totalCost + services.ElementAt(1).Value;
                            break;
                    case 3:
                        custServices.Add(services.ElementAt(2).Key);
                            totalCost = totalCost + services.ElementAt(2).Value;
                            break;
                    default:
                        isValid = false;
                        break;
                }}

                if (!isValid)
                {
                    Console.WriteLine("Please, Enter valid input in Number (1,2,3)");
                }

            } while (!isValid);
            
        }

        
    }

}

class Service{

    public Dictionary<string, double> services = new Dictionary<string, double>(){
        {"1. Hair Cut",4.99},
        {"2. Hair Colour",5.99},
        {"3. Shampoo / Wash",6.99},
    };

}

class Schedule{

    protected DateTime startTime;
    protected DateTime endTime;

    public Schedule(DateTime startTime,DateTime endTime){
        this.startTime = startTime;
        this.endTime = endTime;
    }
}

class Appointment : Schedule{


    public List<Customer> listOfAppointment = new List<Customer>();
    public Appointment(DateTime startTime, DateTime endTime) : base(startTime,endTime){

    }


    public void displayOptions(){
        Console.WriteLine("1. List all appointments.");
        Console.WriteLine("2. Create an Appointment.");
        Console.WriteLine("3. Reset Schedule");
        Console.WriteLine("4. Exit the program.");
    }

    public void createAppoinment(){

        Customer customer = new Customer();

        Console.Write("First Name : ");
        customer.custFirstName = Console.ReadLine();

        Console.Write("\nLast Name : ");
        customer.custLastName = Console.ReadLine();

        Console.Write("\nEmail Name : ");
        customer.custEmail = Console.ReadLine();

        customer.getCustomerServices();

        if(getAppointmentToCustomer(customer.numberOfServices,customer)){
            listOfAppointment.Add(customer);
        }else{
            Console.WriteLine("Sorry No Slot Available.");
        }
    }

    public void showAllAppoinment(){

        int i = 0;

        foreach (var customer in listOfAppointment)
        {
            i++;
            Console.WriteLine("\n\nAppoinment {0}:",i);
            Console.WriteLine("First Name : {0}",customer.custFirstName);
            Console.WriteLine("Last Name : {0}",customer.custLastName);
            Console.WriteLine("Email : {0}",customer.custEmail);
            Console.WriteLine("Appointment Time : {0} to {1} ",customer.custAppointmentTime.ToString("hh:mm tt"), customer.custAppointmentTime.AddHours(customer.numberOfServices).ToString("hh:mm tt"));

            Console.WriteLine("Services : ");

            foreach(var service in customer.custServices){
                Console.WriteLine(" - {0}",service);
            }

            var tax = customer.totalCost * 0.13;
            Console.WriteLine("Sub Total  :   {0}", Math.Round(customer.totalCost, 2));
            Console.WriteLine("Tax        : + {0}", Math.Round(tax, 2));
            Console.WriteLine("Total Cost :   {0}", Math.Round(customer.totalCost+tax, 2));
        }
       


    }

    public void clearAllAppoinment()
    {
        listOfAppointment.Clear();
        startTime = DateTime.Today.AddHours(8);
        endTime = DateTime.Today.AddHours(16);
        Console.WriteLine("All Appoinmnet has been Cleared");
    }

    public void exitProgram()
    {
        return;
    }

    bool getAppointmentToCustomer(int numberOfServices,Customer customer)
    {

        if((endTime.Hour - startTime.Hour) > numberOfServices){
            customer.custAppointmentTime = startTime;
            startTime.AddHours(numberOfServices);

            return true;
        }else{
            return false;
        }
    }


}

class MainClass{

    public static void Main(string[] args){


        Appointment appointment = new Appointment(startTime:DateTime.Today.AddHours(11),endTime:DateTime.Today.AddHours(16));

        Customer customer1 = new Customer(
            "Harit",
            "Thoriya",
            "thoriyaharit@gmail.com",
            new List<string>{ "1. Hair Cut", "3. Shampoo / Wash"},
            2,
            DateTime.Today.AddHours(8),
            11.98
            
        );

        Customer customer2 = new Customer(
            "Pankaj",
            "Valani",
            "pankajvalani@gmail.com",
            new List<string> { "1. Hair Cut" },
            1,
            DateTime.Today.AddHours(10),
            4.99

        );

        appointment.listOfAppointment.Add(customer1);
        appointment.listOfAppointment.Add(customer2);


        appointment.displayOptions();

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
                appointment.showAllAppoinment();
                break;
            case 2:
                appointment.createAppoinment();
                appointment.showAllAppoinment();
                break;
            case 3:
                appointment.clearAllAppoinment();
                break;
            case 4:
                appointment.exitProgram();
                break;
            default:
                Console.WriteLine("Invalid Input");
                break;
        }

    }

}
