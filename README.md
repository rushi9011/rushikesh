[HttpPost("CategoryUsers")]
[ProducesResponseType(200)]
[ProducesResponseType(404)]
[ProducesResponseType(400)]
[ProducesResponseType(401)] // Ensure proper status codes for authentication errors
[ProducesResponseType(500)]
[Authorize] // Use the [Authorize] attribute for authentication
[MustHavePermission(FSHAction.Search, FSHResource.Categories)]
[OpenApiOperation("Search Users By CategoryIds using available filters.", "")]
public async Task<IActionResult> SearchAsync(SearchUsersOnCategoryByCategoryIdRequest request, CancellationToken cancellationToken)
{
    try
    {
        // Your custom authorization logic (MustHavePermission) should be executed here.

        // If you reach this point, the user is authenticated and authorized.
        var result = await _userService.SearchCategoryUsersAsync(request, cancellationToken);
        return Ok(result);
    }
    catch (UnauthorizedAccessException)
    {
        return Unauthorized("Authentication Failed."); // Provide a more detailed error message.
    }
    catch (ForbiddenAccessException)
    {
        return Forbid("You are not authorized to access this resource."); // Provide a more detailed error message.
    }
    catch (Exception ex)
    {
        return StatusCode(500, "An error occurred: " + ex.Message); // Handle other exceptions accordingly.
    }
}
