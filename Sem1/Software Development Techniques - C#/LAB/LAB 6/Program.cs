// LAB 6 : Create a program that uses Interfaces

interface IPerson : IComparable<Person>
{
    string FirstName { get; set; }
    string LastName { get; set; }
    DateTime Birthday { get; set; }
    void CalculateAge();
}

class Person : IPerson
{
    string firstName;
    string lastName;
    DateTime birthDay;
    int age;

    public Person(string FirstName, string LastName, DateTime Birthday)
    {
        this.firstName = FirstName;
        this.lastName = LastName;
        this.birthDay = Birthday;

        CalculateAge();

        Console.WriteLine("\nName : {0} {1}", firstName, lastName);
        Console.WriteLine("Birthday : {0}", birthDay.ToString("dd MMMM yyyy"));
        Console.WriteLine("Age : {0}", age);
    }

    public string FirstName
    {
        get => firstName;
        set => firstName = value;
    }
    public string LastName
    {
        get => lastName;
        set => lastName = value;
    }
    public DateTime Birthday
    {
        get => birthDay;
        set => birthDay = value;
    }

    public void CalculateAge()
    {
        age = DateTime.Today.Year - birthDay.Year;
    }

    public int CompareTo(Person? person)
    {

        if (person!=null && this.age == person.age )
        {
            return 0;
        }else{
            return -1;
        }
        
    }
}

class MainClass
{
    static void Main(string[] args)
    {
        Person person1 = new Person(
            "Harit",
            "Thoriya",
            new DateTime(year: 2000, month: 08, day: 28)
        );

        Person person2 = new Person(
            "Pankaj",
            "Valani",
            new DateTime(year: 2000, month: 08, day: 28)
        );

        Person person3 = new Person(
            "Ramandeep",
            "Singh",
            new DateTime(year: 2001, month: 09, day: 27)
        );

        Console.WriteLine(person1.CompareTo(person2) == 0 ? "\n{0} and {1} Have A Same Age" : "{0} and {1} Don't Have Same Age",person1.FirstName,person2.FirstName);

        Console.WriteLine(person2.CompareTo(person3) == 0 ? "\n{0} and {1} Have A Same Age" : "{0} and {1} Don't Have Same Age",person2.FirstName,person3.FirstName);

        Console.WriteLine(person1.CompareTo(person3) == 0 ? "\n{0} and {1} Have A Same Age" : "{0} and {1} Don't Have Same Age",person1.FirstName,person3.FirstName);


    }

}
