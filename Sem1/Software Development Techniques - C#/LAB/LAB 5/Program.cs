// See https://aka.ms/new-console-template for more information

using System.Dynamic;
using System.Reflection.Metadata;

class Animal
{
    public string name;

    public Animal(string name)
    {
        this.name = name;
    }

    public virtual void Examine()
    {
        Console.WriteLine("Examining {0}, a general animal.\n", name);
    }
}

class Mammal : Animal
{
    public bool IsPregnant;

    public Mammal(string name, bool IsPregnant)
        : base(name)
    {
        this.IsPregnant = IsPregnant;
    }

    public override void Examine()
    {
        Console.WriteLine("Examining {0}, a mammal. Pregnant: {1}.\n", name, IsPregnant);
    }
}

class Fish : Animal
{
    bool IsSaltwaterFish;

    public Fish(string name, bool IsSaltwaterFish)
        : base(name)
    {
        this.IsSaltwaterFish = IsSaltwaterFish;
    }

    public override void Examine()
    {
        Console.WriteLine("Examining {0}, a fish. Saltwater: {1}.\n", name, IsSaltwaterFish);
    }
}

class VetClinic
{
    int noOfAppointment;

    public VetClinic(int noOfAppointment)
    {
        this.noOfAppointment = noOfAppointment;
    }

    List<Animal> animals = new List<Animal>();

    public void ScheduleAppointment(Animal animal)
    {
        if (animals.Count() <= noOfAppointment)
        {
            animals.Add(animal);
        }
        else
        {
            Console.WriteLine("There is no appointment is available");
        }
    }

    public void StartAppointments()
    {
        Console.WriteLine("Starting Appointmnets For The Day : ");

        foreach (Animal animal in animals)
        {
            Console.WriteLine("- " + animal.name);
            animal.Examine();
        }
    }
}

class Program
{
    public static void Main(string[] args)
    {
        VetClinic vetClinic = new(10);

        Animal rover = new Mammal("Rover", false);
        vetClinic.ScheduleAppointment(rover);

        Animal whiskers = new Mammal("Whiskers", true);
        vetClinic.ScheduleAppointment(whiskers);

        Animal goldy = new Fish("Goldy", false);
        vetClinic.ScheduleAppointment(goldy);

        Animal bruce = new Fish("Bruce", true);
        vetClinic.ScheduleAppointment(bruce);

        Animal animal = new("General");
        vetClinic.ScheduleAppointment(animal);

        vetClinic.StartAppointments();
    }
}
