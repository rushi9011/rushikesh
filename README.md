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
