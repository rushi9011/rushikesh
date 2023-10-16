public async Task<PaginationResponse<UsersOnCategoryDto>> SearchCategoryUsersAsync(SearchUsersOnCategoryByCategoryIdRequest request, CancellationToken cancellationToken)
    {
        /*int skip = 0;
        int pageNumber = 1;
        int pageSize = 10;

        if (request.PageNumber <= 0)
        {
            pageNumber = 1;
        }
        else
        {
            pageNumber = request.PageNumber;
        }

        if (request.PageSize <= 0)
        {
            pageSize = 10;
        }
        else
        {
            pageSize = request.PageSize;
        }

        if (request.PageNumber > 1)
        {
            skip = (pageNumber - 1) * pageSize;
        }*/

        // return query
        //    .Take(filter.PageSize)
        //    .OrderBy(filter.OrderBy);

        var usersList =
            await _db.UserCategory
            .AsNoTracking()
            .Where(x => request.CategoryIds.Contains(x.CategoryId))
            .ProjectToType<UsersOnCategoryDto>()
            .GroupBy(x => x.UserId)
            .Select(x => x.First())
            .ToListAsync(cancellationToken);

        /*usersList =
              usersList
              .Take(pageSize)
              .Skip(skip);*/

        /*if (request.OrderBy != null)
        {
            if (request.OrderBy.Contains("firstname"))
            {
                usersList =
                        usersList
                        .Take(pageSize)
                        .Skip(skip)
                        .OrderBy(x => x.);
            }
        }
        else
        {
        }*/

        var user = _userManager.Users.Where(x => usersList.Select(y => y.UserId).Contains(x.Id));

        var list = usersList.Select(x => new UsersOnCategoryDto
        {
            UserId = x.UserId,
            UserName = user.Where(u => x.UserId == u.Id).Select(u => u.UserName).FirstOrDefault(),
            FirstName = user.Where(u => x.UserId == u.Id).Select(u => u.FirstName).FirstOrDefault(),
            LastName = user.Where(u => x.UserId == u.Id).Select(u => u.LastName).FirstOrDefault(),
            Email = user.Where(u => x.UserId == u.Id).Select(u => u.Email).FirstOrDefault(),
        }).ToList();

        int usersListCount = usersList.Count();

        return new PaginationResponse<UsersOnCategoryDto>(list, usersListCount, request.PageNumber, request.PageSize);
    }
	
	
	[HttpPost("CategoryUsers")]
    [ProducesResponseType(200)]
    [ProducesResponseType(404)]
    [ProducesResponseType(400)]
    [ProducesResponseType(401)]
    [ProducesResponseType(500)]
    [MustHavePermission(FSHAction.Search, FSHResource.Categories)]
    [OpenApiOperation("Search Users By CategoryIds using available filters.", "")]
    public Task<PaginationResponse<UsersOnCategoryDto>> SearchAsync(SearchUsersOnCategoryByCategoryIdRequest request, CancellationToken cancellationToken)
    {
        return _userService.SearchCategoryUsersAsync(request, cancellationToken);
    }
	
	 Task<PaginationResponse<UsersOnCategoryDto>> SearchCategoryUsersAsync(SearchUsersOnCategoryByCategoryIdRequest request, CancellationToken cancellationToken)

public class UsersOnCategoryDto : IDto
{
    public string UserId { get; set; } = default!;
    public string? UserName { get; set; }
    public string? FirstName { get; set; }
    public string? LastName { get; set; }
    public string? Email { get; set; }

}




{
  "advancedSearch": {
    "fields": ["field1"],
    "keyword": "search item"
  },
  "keyword": "search item",
  "pageNumber": 10,
  "pageSize": 20,
  "orderBy": ["column1", "column2"],
  "categoryIds": [
    "a4c37e44-69b9-4d84-8e10-87724d17a62a",
    "38efb1cf-103f-498e-8946-929c00f9b879",
    "7c123573-78a1-4a9b-bc3c-df5f2ce8ed89"
  ]
}



public async Task<PaginationResponse<UsersOnCategoryDto>> SearchCategoryUsersAsync(SearchUsersOnCategoryByCategoryIdRequest request, CancellationToken cancellationToken)
{
    // Query to get user categories based on provided CategoryIds
    var userCategoriesQuery = _db.UserCategory
        .Where(x => request.CategoryIds.Contains(x.CategoryId))
        .AsNoTracking();

    // Retrieve users with user category data
    var usersWithCategories = await userCategoriesQuery
        .GroupBy(x => x.UserId)
        .Select(g => new
        {
            UserId = g.Key,
            Categories = g.ToList()
        })
        .ToListAsync(cancellationToken);

    // Query to get user data based on the matching users
    var userQuery = _userManager.Users
        .Where(u => usersWithCategories.Any(uc => uc.UserId == u.Id));

    // Apply additional filtering, sorting, or pagination if needed
    // For example, if you want to order the results by a specific property:
    // userQuery = userQuery.OrderBy(u => u.FirstName);

    // Fetch the users
    var users = await userQuery.ToListAsync(cancellationToken);

    // Create UsersOnCategoryDto objects with combined user and user category information
    var result = usersWithCategories
        .Select(uc => new UsersOnCategoryDto
        {
            UserId = uc.UserId,
            UserName = users.First(u => u.Id == uc.UserId).UserName,
            FirstName = users.First(u => u.Id == uc.UserId).FirstName,
            LastName = users.First(u => u.Id == uc.UserId).LastName,
            Email = users.First(u => u.Id == uc.UserId).Email,
            // Additional properties from UserCategory, e.g., CategoryIds
            // CategoryIds = uc.Categories.Select(c => c.CategoryId.ToString()).ToList()
        })
        .ToList();

    // Total user count
    int usersCount = result.Count;

    // You can add pagination here if needed
    /*
    int skip = (request.PageNumber - 1) * request.PageSize;
    var paginatedResult = result.Skip(skip).Take(request.PageSize).ToList();
    return new PaginationResponse<UsersOnCategoryDto>(paginatedResult, usersCount, request.PageNumber, request.PageSize);
    */

    return new PaginationResponse<UsersOnCategoryDto>(result, usersCount, request.PageNumber, request.PageSize);
}


