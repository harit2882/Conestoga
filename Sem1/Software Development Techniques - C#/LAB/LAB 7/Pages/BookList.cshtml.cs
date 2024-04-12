using LAB_7.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Net.Http.Headers;
using System.Text.Json;


namespace LAB_7.Pages
{
    public class BookList : PageModel
    {
        private static HttpClient client = new HttpClient();
        private readonly ILogger<BookList> _logger;
        public List<BookModel>? bookList { get; set; }
        public BookList(ILogger<BookList> logger)
        {
            _logger = logger;
        }

        public async Task OnGet()
        {
            try
            {
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                var url = "https://raw.githubusercontent.com/benoitvallon/100-best-books/master/books.json";
                bookList = await GetBookAsync(url);
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }

        private static async Task<List<BookModel>?> GetBookAsync(string path)
        {
            List<BookModel>? books = new List<BookModel>();
            HttpResponseMessage response = await client.GetAsync(path);
            if (response.IsSuccessStatusCode)
            {
                string responseContent = await response.Content.ReadAsStringAsync();
                books = JsonSerializer.Deserialize<List<BookModel>>(responseContent);
            }
            return books;
        }
        public IActionResult OnPost(BookModel book)
        {
            return RedirectToPage("BookDetails",book);
        }
    }
}