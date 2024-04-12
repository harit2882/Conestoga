using System;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Text.Json;
using LAB_7.Models;

namespace LAB_7.Pages
{
    public class BookDetails : PageModel
    {
        public BookModel book = new BookModel();
        private readonly ILogger<BookDetails> _logger;
        public BookDetails (ILogger<BookDetails> logger)
        {
            _logger = logger;
        }

        public void OnGet (BookModel book)
        {
            this.book = book;
        }
    }
}

