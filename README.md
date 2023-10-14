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
 public List<DefaultIdType> CategoryIds { get; set; } = default!;
{
  "advancedSearch": {
    "fields": [
      "field1"
    ],
    "keyword": "search item"
  },
  "keyword": "search item",
  "pageNumber": 10,
  "pageSize": 20,
  "orderBy": [
    "column1",
    "column2"   // Add more columns as needed
  ],
  "categoryIds": [
    "id=1",
    "id=2",
    "id=3"       // Add more category IDs as needed
  ]
}

