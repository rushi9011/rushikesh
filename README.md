namespace CQ.UserService.Application.Common.Models;

public class PaginationFilter : BaseFilter
{
    public int PageNumber { get; set; }

    public int PageSize { get; set; } = int.MaxValue;

    public string[]? OrderBy { get; set; }
}

public static class PaginationFilterExtensions
{
    public static bool HasOrderBy(this PaginationFilter filter) =>
        filter.OrderBy?.Any() is true;
}

public class BaseFilter
{
    /// <summary>
    /// Column Wise Search is Supported.
    /// </summary>
    public Search? AdvancedSearch { get; set; }

    /// <summary>
    /// Keyword to Search in All the available columns of the Resource.
    /// </summary>
    public string? Keyword { get; set; }
