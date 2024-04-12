public class Person
{
    // Class Variables
    public string? FirstName { get; set; }
    public string? LastName { get; set; }
    public DateTime? DateOfBirth { get; set; }
    public string? Address { get; set; }
    public string? City { get; set; }
    public string? Country { get; set; }
    public string? Province { get; set; }

    //Default Constructor
    public Person() { }

    // ParaMeterized Constructor
    public Person(
        string firstName,
        string lastName,
        DateTime dateOfBirth,
        string address,
        string city,
        string country,
        string province
    )
    {
        FirstName = firstName;
        LastName = lastName;
        DateOfBirth = dateOfBirth;
        Address = address;
        City = city;
        Country = country;
        Province = province;
    }
}
