// See https://aka.ms/new-console-template for more information

//Part 1: Loop Practice: Calculating Sum and Average
class SumAndAverage{

    static void Main(string[] args){

        string? noOfValueString;
        int noOfValue;
        bool isNoValid = true;

        // Loop iterate till it gets the valid input for number of Value
        do{
            
            Console.WriteLine("How many numbers would you like to enter for sum and average : ");
            noOfValueString = Console.ReadLine();
            noOfValue = 0;
            isNoValid = int.TryParse(noOfValueString,out noOfValue);
            if(!isNoValid){
                Console.WriteLine("Please, Enter valid Number");
            }

        }while(!isNoValid);

        decimal sum = 0;
        decimal avg; 

        //Loop iterate for enter number of input
        for(int i=0;i<noOfValue;i++){

            string? valueString;
            decimal value;

            // To Check given input is valid or not
            bool isValid = true;

            do{

                if(isValid){
                    Console.WriteLine("\nPlease enter a number :");
                }else{
                    Console.WriteLine("\nPlease enter valid a number :");
                }

                valueString = Console.ReadLine();
                value = 0;
                isValid = decimal.TryParse(valueString,out value);

            }while(!isValid);

            // Calculate the sum and average of enterd number
            sum += value;
            avg = sum / (i+1);

            // Print the sum and average of Currunt inputed number
            Console.WriteLine("\nCurrent Sum: {0}, Average: {1}",sum,Math.Round(avg,4));
            
        }
    }
}
