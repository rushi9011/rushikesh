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
