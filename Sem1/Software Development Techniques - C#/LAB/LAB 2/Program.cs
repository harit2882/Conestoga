// See https://aka.ms/new-console-template for more information

// Write a simple Grocery Kiosk program.


try{
Console.WriteLine("Please enter a fruit or vegetable:");
String fruitName = Console.ReadLine()!;

Console.WriteLine("\nHow many {0}s did you purchase:",fruitName);
int fruitQuantity = Convert.ToInt32(Console.ReadLine());

Console.WriteLine("\nHow much did the {0}s weigh, in total:",fruitName);
double fruitWeight = Convert.ToDouble(Console.ReadLine());

double avgWeight = fruitWeight / fruitQuantity;

Console.WriteLine("\nI purchased {0} {1} with average weight of {2} lbs",fruitQuantity,fruitName,avgWeight);

}catch(Exception e){
    Console.WriteLine("Error ==> {0}",e);
}

