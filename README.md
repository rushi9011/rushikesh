using Microsoft.AspNetCore.Components.Routing;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using UserApplication.Data;
using UserApplication.Migrations;
using UserApplication.Models;
using PageSections = UserApplication.Models.PageSections;

namespace UserApplication.Controllers
{
    public class PageSectionController : Controller
    {


        private readonly UserApplicationContext _context;

        public PageSectionController(UserApplicationContext context)
        {
            _context = context;
        }

        // GET: Users
        public async Task<IActionResult> Index()
        {
            return _context.PageSection != null ?
                        View(await _context.PageSection.ToListAsync()) :
                        Problem("Entity set 'UserApplicationContext.User'  is null.");
        }

        // Action to display the form for creating a new page
        public IActionResult Create()
        {
            return View();
        }

        // Action to handle the creation of a new page
        [HttpPost]
        public IActionResult Create(PageSections page)
        {
            if (ModelState.IsValid)
            {
                _context.PageSection.Add(page);
                _context.SaveChanges();
                return RedirectToAction(nameof(Index));
            }

            return View(page);
        }


        // Action to display the page editor
        public IActionResult Edit(int id)
        {
            PageSections page = _context.PageSection.Find(id);
            return View(page);
        }

        // Action to save the edited page to the database
        [HttpPost]
        public IActionResult Edit(PageSections page)
        {
            if (ModelState.IsValid)
            {
                _context.PageSection.Update(page);
                _context.SaveChanges();
                Publish(page.Id);
                return RedirectToAction("Index"); // Redirect to the page listing
            }
            return View(page);
        }

        // Action to publish the page to the file system
        public IActionResult Publish(int id)
        {
            PageSections page = _context.PageSection.Find(id);

            // Create an HTML file with the page content
            string htmlContent = $@"
       <!DOCTYPE html>
        <html lang=""en"">
        <head>
            <meta charset=""UTF-8"">
            <meta name=""viewport"" content=""width=device-width, initial-scale=1.0"">
            <title>Your Page Title</title>
            <script src=""https://cdn.ckeditor.com/ckeditor5/40.2.0/classic/ckeditor.js""></script>
            <style>
                body {{
                    margin: 0;
                    padding: 0;
                    font-family: Arial, sans-serif;
                }}

                header, footer {{
                    background-color: #333;
                    color: white;
                    text-align: center;
                    padding: 20px;
                }}

                section {{
                    display: flex;
                    justify-content: space-between;
                }}

                aside {{
                    width: 10%;
                    background-color: #f2f2f2;
                    padding: 10px;
                }}

                main {{
                    flex: 1;
                    padding: 210px; /* Adjusted padding for better appearance */
                }}

                #htmlEditor {{
                    width: 100%;
                    height: 300px;
                }}
            </style>
        </head>
        <body>
            <header>

                <h1>{page.Header}</h1>
               
            </header>

            <section>
                <aside>
                    <h2>{page.Left}</h2>                  

                </aside>

                <main>
                    <h2>{page.Center}</h2>
                    <!-- Add main content here -->
                </main>

                <aside>
                    <h2>{page.Right}</h2>                   
                    <!-- Add right sidebar content here -->
                </aside>
            </section>

            <footer>
                <p>{page.Footer}</p>
            </footer>           
        </body>
        </html>";


            // Save the HTML content to a file (you might want to specify a unique file name)
            string filePath = $"wwwroot/pages/{id}.html";
            System.IO.File.WriteAllText(filePath, htmlContent);

            return RedirectToAction("Index"); // Redirect to the page listing
        }
    }
}


-----------------------------------------------------------------
@model IEnumerable<UserApplication.Models.PageSections>

@{
    ViewData["Title"] = "Index";
}

@*@{
    Layout = "~/Views/Shared/_MasterLayout.cshtml";
}*@

<h1>Index</h1>

<p>
    <a asp-action="Create">Create New</a>
</p>
<table class="table">
    <thead>
        <tr>
            <th>
                @Html.DisplayNameFor(model => model.Header)
            </th>
            <th>
                @Html.DisplayNameFor(model => model.Footer)
            </th>
            <th>
                @Html.DisplayNameFor(model => model.Center)
            </th>
            <th>
                @Html.DisplayNameFor(model => model.Left)
            </th>
            <th>
                @Html.DisplayNameFor(model => model.Right)
            </th>
            <th></th>
        </tr>
    </thead>
    <tbody>
@foreach (var item in Model) {
        <tr>
            <td>
                @Html.DisplayFor(modelItem => item.Header)
            </td>
                <td>
                    @Html.DisplayFor(modelItem => item.Footer)
                </td>
                <td>
                    @Html.DisplayFor(modelItem => item.Center)
                </td>
                 <td>
                @Html.DisplayFor(modelItem => item.Left)
            </td>
                <td>
                    @Html.DisplayFor(modelItem => item.Right)
                </td>
              
            <td>
                <a asp-action="Edit" asp-route-id="@item.Id">Edit</a> |
                <a asp-action="Delete" asp-route-id="@item.Id">Delete</a>
                   
            </td>
        </tr>
}
    </tbody>
</table>




